package com.ruoyi.common.utils.loadbalance.weightroundrobin;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.locks.ReentrantLock;

import com.ruoyi.common.constant.ApiRedisConstants;
import com.ruoyi.common.utils.RedisUtil;
import com.ruoyi.common.utils.loadbalance.ILoadBanlance;
import com.ruoyi.common.utils.spring.SpringUtils;
import com.ruoyi.project.api.server.domain.ApiServer;

public class WeightedRoundRobin implements ILoadBanlance {
	
	private RedisUtil redisUtil = SpringUtils.getBean(RedisUtil.class);
	private volatile List<WeightRoundRobinServerNode> nodeList = new ArrayList<>() ; // 保存权重
    private ReentrantLock lock = new ReentrantLock() ;
	
    @Override
	public void addServer(ApiServer ...servers) {
    	for (ApiServer server : servers) {
    		WeightRoundRobinServerNode node = new WeightRoundRobinServerNode();
        	node.setCurrentWeight(0);
        	node.setServerName(server.getServerId().toString());
        	node.setWeight(server.getServerWeight());
        	
        	addNode(node);
        }
    	
	}
    
    private void addNode(WeightRoundRobinServerNode ...nodes) {
        for (WeightRoundRobinServerNode node : nodes) {
            nodeList.add(node) ;
        }
    }
    
    @Override
    public ApiServer selectServer(){
        try {
            lock.lock();
            return (ApiServer) redisUtil.hmget(ApiRedisConstants.API_SERVER).get(selectInner().getServerName()) ;
        }finally {
            lock.unlock();
        }
    }

    public WeightRoundRobinServerNode selectInner(){
        int totalWeight = 0 ;
        WeightRoundRobinServerNode maxNode = null ;
        int maxWeight = 0 ;

        for (int i = 0; i < nodeList.size(); i++) {
            WeightRoundRobinServerNode n = nodeList.get(i);
            totalWeight += n.getWeight() ;

            // 每个节点的当前权重要加上原始的权重
            n.setCurrentWeight(n.getCurrentWeight() + n.getWeight());

            // 保存当前权重最大的节点
            if (maxNode == null || maxWeight < n.getCurrentWeight() ) {
                maxNode = n ;
                maxWeight = n.getCurrentWeight() ;
            }
        }
        // 被选中的节点权重减掉总权重
        maxNode.setCurrentWeight(maxNode.getCurrentWeight() - totalWeight);

//        nodeList.forEach(node -> System.out.print(node.getCurrentWeight()));
        return maxNode ;
    }
    
    public static void main(String[] args) {
        /**
         * 假设有三个服务器权重配置如下：
         * server A  weight = 4 ;
         * server B  weight = 3 ;
         * server C  weight = 2 ;
         */
    	WeightRoundRobinServerNode serverA = new WeightRoundRobinServerNode("serverA", 4);
        WeightRoundRobinServerNode serverB = new WeightRoundRobinServerNode("serverB", 3);
        WeightRoundRobinServerNode serverC = new WeightRoundRobinServerNode("serverC", 2);
        
        WeightedRoundRobin smoothWeightedRoundRobin = new WeightedRoundRobin();
        smoothWeightedRoundRobin.addNode(serverA,serverB ,serverC);
        for (int i = 0; i < 9; i++) {
        	WeightRoundRobinServerNode i1 = smoothWeightedRoundRobin.selectInner();
            System.out.println(i1.getServerName());
        }
    }

}

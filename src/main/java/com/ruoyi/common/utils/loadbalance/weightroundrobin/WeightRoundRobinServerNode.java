package com.ruoyi.common.utils.loadbalance.weightroundrobin;

/**
 * 加权轮询的服务器节点
 * <p>Title: WeightRoundRobinServerNode</p>  
 * <p>Description: </p>  
 * @author 陈阳  
 * @date 2019年8月23日
 */
public class WeightRoundRobinServerNode {

	private int weight ;  // 初始权重 （保持不变）
    private String serverName ; // 服务名
	/**
	 * 当前权重
	 */
	private Integer currentWeight;
	
	public WeightRoundRobinServerNode(String string, int i) {
		this.serverName = string;
		this.weight = i;
	}
	
	public WeightRoundRobinServerNode() {
	}

	public int getWeight() {
		return weight;
	}

	public void setWeight(int weight) {
		this.weight = weight;
	}

	public String getServerName() {
		return serverName;
	}

	public void setServerName(String serverName) {
		this.serverName = serverName;
	}

	public Integer getCurrentWeight() {
		if(currentWeight==null) {
			currentWeight = 0;
		}
		return currentWeight;
	}

	public void setCurrentWeight(Integer currentWeight) {
		this.currentWeight = currentWeight;
	}
}

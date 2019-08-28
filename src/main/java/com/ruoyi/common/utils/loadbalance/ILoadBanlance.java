package com.ruoyi.common.utils.loadbalance;

import com.ruoyi.project.api.server.domain.ApiServer;

public interface ILoadBanlance {
	public ApiServer selectServer();
	void addServer(ApiServer ...servers);
}

import './common/env';
import Server from './common/server';
import routes from './routes';

import * as appInsights from 'applicationinsights'
appInsights.setup(process.env.APPINSIGHTS_INSTRUMENTATIONKEY)
    .setAutoDependencyCorrelation(true)
    .setAutoCollectRequests(true)
    .setAutoCollectPerformance(true, true)
    .setAutoCollectExceptions(true)
    .setAutoCollectDependencies(true)
    .setAutoCollectConsole(true)
    .setUseDiskRetryCaching(true)
    .setSendLiveMetrics(true)
    .setDistributedTracingMode(appInsights.DistributedTracingModes.AI_AND_W3C)
    .start();


let client = appInsights.defaultClient;
client.trackEvent({name: "Server started !"});

export default new Server().router(routes).listen(process.env.PORT);
From: Manuel Lauss <mlau@msc-ge.com>
Date: Sun, 18 May 2008 15:52:43 +0200
Subject: [PATCH] au1xmmc: abort requests early if no card is present
Message-ID: <20080518135243.Agj9BllSbpctoj9jGSCZgE5yNnIjYVHeKSzv-BbwqUo@z>

Don't process a request if no card is present.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 drivers/mmc/host/au1xmmc.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index be09a14..0b30582 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -689,6 +689,13 @@ static void au1xmmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	host->mrq = mrq;
 	host->status = HOST_S_CMD;
 
+	/* fail request immediately if no card is present */
+	if (0 == au1xmmc_card_inserted(host)) {
+		mrq->cmd->error = -ETIMEDOUT;
+		au1xmmc_finish_request(host);
+		return;
+	}
+
 	if (mrq->data) {
 		FLUSH_FIFO(host);
 		ret = au1xmmc_prepare_data(host, mrq->data);
-- 
1.5.5.1

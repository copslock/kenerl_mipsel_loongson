Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2007 10:08:22 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:19208 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20040469AbXAWKIR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Jan 2007 10:08:17 +0000
Received: (qmail 5016 invoked by uid 1000); 23 Jan 2007 11:08:14 +0100
Date:	Tue, 23 Jan 2007 11:08:14 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	drzeus-mmc@drzeus.cx
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MMC: au1xmmc R6 response support
Message-ID: <20070123100814.GA5001@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi,

here's a trivial patch which adds R6 reponse support to the au1xmmc
driver. Fixes SD card detection / operation.

---

Add Response type R6 support to the au1xmmc driver; fixes SD card
detection and operation.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>

--- a/drivers/mmc/au1xmmc.c~	2007-01-23 10:52:33.771983000 +0100
+++ b/drivers/mmc/au1xmmc.c	2007-01-23 10:52:33.771983000 +0100
@@ -205,6 +205,9 @@ static int au1xmmc_send_command(struct a
 	case MMC_RSP_R3:
 		mmccmd |= SD_CMD_RT_3;
 		break;
+	case MMC_RSP_R6:
+		mmccmd |= SD_CMD_RT_6;
+		break;
 	}
 
 	switch(cmd->opcode) {

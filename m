Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Oct 2007 20:03:11 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:29711 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20043205AbXJRTDD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Oct 2007 20:03:03 +0100
Received: (qmail 17924 invoked by uid 1000); 18 Oct 2007 21:03:02 +0200
Date:	Thu, 18 Oct 2007 21:03:02 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: [PATCH 2.6.24-rc0] au1xmmc: trivial buildfix
Message-ID: <20071018190302.GA17906@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi,

Fix a trivial error in au1xmmc. 
Not run-tested since there are some rather funky IRQ issues
with this kernel...

--- 

au1xmmc: trivial buildfix

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>

--- linux-2.6.23-git13/drivers/mmc/host/au1xmmc.c.orig	2007-10-18 15:35:25.930405000 +0200
+++ linux-2.6.23-git13/drivers/mmc/host/au1xmmc.c	2007-10-18 15:35:49.150405000 +0200
@@ -212,12 +212,12 @@ static int au1xmmc_send_command(struct a
 	}
 
 	if (data) {
-		if (flags & MMC_DATA_READ) {
+		if (data->flags & MMC_DATA_READ) {
 			if (data->blocks > 1)
 				mmccmd |= SD_CMD_CT_4;
 			else
 				mmccmd |= SD_CMD_CT_2;
-		} else if (flags & MMC_DATA_WRITE) {
+		} else if (data->flags & MMC_DATA_WRITE) {
 			if (data->blocks > 1)
 				mmccmd |= SD_CMD_CT_3;
 			else

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Feb 2006 09:31:32 +0000 (GMT)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:37281 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133374AbWBUJbV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Feb 2006 09:31:21 +0000
Received: from localhost (in-1.mx.triera.net [213.161.0.25])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 6E5B7C0B1;
	Tue, 21 Feb 2006 10:38:18 +0100 (CET)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-1.mx.triera.net (Postfix) with SMTP id 62E101BC084;
	Tue, 21 Feb 2006 10:38:19 +0100 (CET)
Received: from localhost (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id CEEE81A18B0;
	Tue, 21 Feb 2006 10:38:19 +0100 (CET)
Date:	Tue, 21 Feb 2006 10:38:34 +0100
From:	Domen Puncer <domen.puncer@ultra.si>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [patch] au1xmmc: fix mmc_rsp_type typo
Message-ID: <20060221093834.GA5120@domen.ultra.si>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-Virus-Scanned: Triera AV Service
Return-Path: <domen.puncer@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@ultra.si
Precedence: bulk
X-list: linux-mips

Patch that added this suggests mmc_rsp_type should be mmc_resp_type.


Signed-off-by: Domen Puncer <domen.puncer@ultra.si>


 drivers/mmc/au1xmmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.16-rc4.git/drivers/mmc/au1xmmc.c
===================================================================
--- linux-2.6.16-rc4.git.orig/drivers/mmc/au1xmmc.c
+++ linux-2.6.16-rc4.git/drivers/mmc/au1xmmc.c
@@ -195,7 +195,7 @@ static int au1xmmc_send_command(struct a
 
 	u32 mmccmd = (cmd->opcode << SD_CMD_CI_SHIFT);
 
-	switch (mmc_rsp_type(cmd->flags)) {
+	switch (mmc_resp_type(cmd->flags)) {
 	case MMC_RSP_R1:
 		mmccmd |= SD_CMD_RT_1;
 		break;

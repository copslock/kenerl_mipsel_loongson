Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2007 11:30:02 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:40492 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022391AbXEKK36 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2007 11:29:58 +0100
Received: by mo.po.2iij.net (mo30) id l4BAToAo076028; Fri, 11 May 2007 19:29:50 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox30) id l4BATmTg063898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 11 May 2007 19:29:49 +0900 (JST)
Date:	Fri, 11 May 2007 19:29:48 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Pierre Ossman <drzeus@drzeus.cx>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: [PATCH] mmc: au1xmmc command types check from data flags
Message-Id: <20070511192948.38937fd0.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <4643FD2B.8020103@drzeus.cx>
References: <20070511125919.350c53a8.yoichi_yuasa@tripeaks.co.jp>
	<4643F57C.5060409@drzeus.cx>
	<200705110516.l4B5GMQJ053603@mbox33.po.2iij.net>
	<4643FD2B.8020103@drzeus.cx>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Fri, 11 May 2007 07:20:43 +0200
Pierre Ossman <drzeus@drzeus.cx> wrote:

> Yoichi Yuasa wrote:
> > 
> > The commands of au1xmmc controller are different from standard commands. 
> > au1xmmc_send_command() convert standard commands to local commands for au1xmmc host controller,
> > and send local commands to controller.
> > 
> 
> A quick glance at the code seems to suggest it's specifying the type of command.
> And it should be able to figure that out in a more generic way.

Ok, I updated the patch for au1xmmc.c .

This patch has changed command types check from data flags.

MMC_STOP_TRANSMISSION is never passed to au1xmmc_send_command().
SEND_STOP() is used for MMC_STOP_TRANSMISSION.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/mmc/host/au1xmmc.c mips/drivers/mmc/host/au1xmmc.c
--- mips-orig/drivers/mmc/host/au1xmmc.c	2007-05-11 10:27:01.068483750 +0900
+++ mips/drivers/mmc/host/au1xmmc.c	2007-05-11 19:13:11.426283750 +0900
@@ -189,7 +189,7 @@ static void au1xmmc_tasklet_finish(unsig
 static int au1xmmc_send_command(struct au1xmmc_host *host, int wait,
 				struct mmc_command *cmd)
 {
-
+	unsigned int flags;
 	u32 mmccmd = (cmd->opcode << SD_CMD_CI_SHIFT);
 
 	switch (mmc_resp_type(cmd)) {
@@ -213,24 +213,17 @@ static int au1xmmc_send_command(struct a
 		return MMC_ERR_INVALID;
 	}
 
-	switch(cmd->opcode) {
-	case MMC_READ_SINGLE_BLOCK:
-	case SD_APP_SEND_SCR:
-		mmccmd |= SD_CMD_CT_2;
-		break;
-	case MMC_READ_MULTIPLE_BLOCK:
-		mmccmd |= SD_CMD_CT_4;
-		break;
-	case MMC_WRITE_BLOCK:
-		mmccmd |= SD_CMD_CT_1;
-		break;
-
-	case MMC_WRITE_MULTIPLE_BLOCK:
-		mmccmd |= SD_CMD_CT_3;
-		break;
-	case MMC_STOP_TRANSMISSION:
-		mmccmd |= SD_CMD_CT_7;
-		break;
+	flags = cmd->data->flags;
+	if (flags & MMC_DATA_READ) {
+		if (flags & MMC_DATA_MULTI)
+			mmccmd |= SD_CMD_CT_4;
+		else
+			mmccmd |= SD_CMD_CT_2;
+	} else if (flags & MMC_DATA_WRITE) {
+		if (flags & MMC_DATA_MULTI)
+			mmccmd |= SD_CMD_CT_3;
+		else
+			mmccmd |= SD_CMD_CT_1;
 	}
 
 	au_writel(cmd->arg, HOST_CMDARG(host));

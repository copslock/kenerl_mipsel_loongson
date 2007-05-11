Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2007 12:29:25 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:35106 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022470AbXEKL3Y (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2007 12:29:24 +0100
Received: by mo.po.2iij.net (mo30) id l4BBS2LV011597; Fri, 11 May 2007 20:28:02 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox32) id l4BBRwgn020395
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 11 May 2007 20:27:58 +0900 (JST)
Message-Id: <200705111127.l4BBRwgn020395@mbox32.po.2iij.net>
Date:	Fri, 11 May 2007 20:27:58 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	yoichi_yuasa@tripeaks.co.jp, drzeus@drzeus.cx,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] mmc: au1xmmc command types check from data flags
In-Reply-To: <20070511110702.GA16041@roarinelk.homelinux.net>
References: <20070511125919.350c53a8.yoichi_yuasa@tripeaks.co.jp>
	<4643F57C.5060409@drzeus.cx>
	<200705110516.l4B5GMQJ053603@mbox33.po.2iij.net>
	<4643FD2B.8020103@drzeus.cx>
	<20070511192948.38937fd0.yoichi_yuasa@tripeaks.co.jp>
	<20070511110702.GA16041@roarinelk.homelinux.net>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Fri, 11 May 2007 13:07:02 +0200
Manuel Lauss <mano@roarinelk.homelinux.net> wrote:

> Hi Yoichi,
> 
> > --- mips-orig/drivers/mmc/host/au1xmmc.c	2007-05-11 10:27:01.068483750 +0900
> > +++ mips/drivers/mmc/host/au1xmmc.c	2007-05-11 19:13:11.426283750 +0900
> > @@ -189,7 +189,7 @@ static void au1xmmc_tasklet_finish(unsig
> > @@ -213,24 +213,17 @@ static int au1xmmc_send_command(struct a
> >  		return MMC_ERR_INVALID;
> >  	}
> >  
> > -	switch(cmd->opcode) {
> > -	case MMC_READ_SINGLE_BLOCK:
> > -	case SD_APP_SEND_SCR:
> > -		mmccmd |= SD_CMD_CT_2;
> > -		break;
> > -	case MMC_READ_MULTIPLE_BLOCK:
> > -		mmccmd |= SD_CMD_CT_4;
> > -		break;
> > -	case MMC_WRITE_BLOCK:
> > -		mmccmd |= SD_CMD_CT_1;
> > -		break;
> > -
> > -	case MMC_WRITE_MULTIPLE_BLOCK:
> > -		mmccmd |= SD_CMD_CT_3;
> > -		break;
> > -	case MMC_STOP_TRANSMISSION:
> > -		mmccmd |= SD_CMD_CT_7;
> > -		break;
> > +	flags = cmd->data->flags;
> 		^^^^^^^^
> This line oopses the driver on my Au1200
> ->data can be NULL

Thank you testing the patch.

I don't have a db1200.
Please test new one.

> 
> > +	if (flags & MMC_DATA_READ) {
> > +		if (flags & MMC_DATA_MULTI)
> > +			mmccmd |= SD_CMD_CT_4;
> > +		else
> > +			mmccmd |= SD_CMD_CT_2;
> > +	} else if (flags & MMC_DATA_WRITE) {
> > +		if (flags & MMC_DATA_MULTI)
> > +			mmccmd |= SD_CMD_CT_3;
> > +		else
> > +			mmccmd |= SD_CMD_CT_1;
> >  	}
> 
> what about SD_CMD_CT_7?

MMC_STOP_TRANSMISSION is never passed to au1xmmc_send_command().
We don't need to care SD_CMD_CT_7 here.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/mmc/host/au1xmmc.c mips/drivers/mmc/host/au1xmmc.c
--- mips-orig/drivers/mmc/host/au1xmmc.c	2007-05-11 20:15:50.358847000 +0900
+++ mips/drivers/mmc/host/au1xmmc.c	2007-05-11 20:20:36.804748750 +0900
@@ -187,9 +187,8 @@ static void au1xmmc_tasklet_finish(unsig
 }
 
 static int au1xmmc_send_command(struct au1xmmc_host *host, int wait,
-				struct mmc_command *cmd)
+				struct mmc_command *cmd, unsigned int flags)
 {
-
 	u32 mmccmd = (cmd->opcode << SD_CMD_CI_SHIFT);
 
 	switch (mmc_resp_type(cmd)) {
@@ -213,24 +212,16 @@ static int au1xmmc_send_command(struct a
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
@@ -665,6 +656,7 @@ static void au1xmmc_request(struct mmc_h
 {
 
 	struct au1xmmc_host *host = mmc_priv(mmc);
+	unsigned int flags = 0;
 	int ret = MMC_ERR_NONE;
 
 	WARN_ON(irqs_disabled());
@@ -677,11 +669,12 @@ static void au1xmmc_request(struct mmc_h
 
 	if (mrq->data) {
 		FLUSH_FIFO(host);
+		flags = mrq->data->flags;
 		ret = au1xmmc_prepare_data(host, mrq->data);
 	}
 
 	if (ret == MMC_ERR_NONE)
-		ret = au1xmmc_send_command(host, 0, mrq->cmd);
+		ret = au1xmmc_send_command(host, 0, mrq->cmd, flags);
 
 	if (ret != MMC_ERR_NONE) {
 		mrq->cmd->error = ret;

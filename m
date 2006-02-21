Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Feb 2006 10:39:14 +0000 (GMT)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:63406 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133374AbWBUKjF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Feb 2006 10:39:05 +0000
Received: from localhost (in-1.mx.triera.net [213.161.0.25])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 801C2C01C;
	Tue, 21 Feb 2006 11:46:02 +0100 (CET)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-1.mx.triera.net (Postfix) with SMTP id 42D8C1BC085;
	Tue, 21 Feb 2006 11:46:04 +0100 (CET)
Received: from localhost (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id B491F1A18A5;
	Tue, 21 Feb 2006 11:46:04 +0100 (CET)
Date:	Tue, 21 Feb 2006 11:46:19 +0100
From:	Domen Puncer <domen.puncer@ultra.si>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [patch] au1xmmc: fix mmc_rsp_type typo
Message-ID: <20060221104619.GD5120@domen.ultra.si>
References: <20060221093834.GA5120@domen.ultra.si>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221093834.GA5120@domen.ultra.si>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: Triera AV Service
Return-Path: <domen.puncer@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@ultra.si
Precedence: bulk
X-list: linux-mips

On 21/02/06 10:38 +0100, Domen Puncer wrote:
> Patch that added this suggests mmc_rsp_type should be mmc_resp_type.

Ouch, I thought I compile tested.
Here's a fixed version:


There's no mmc_rsp_type

Signed-off-by: Domen Puncer <domen.puncer@ultra.si>

Index: linux-2.6.16-rc4.git/drivers/mmc/au1xmmc.c
===================================================================
--- linux-2.6.16-rc4.git.orig/drivers/mmc/au1xmmc.c
+++ linux-2.6.16-rc4.git/drivers/mmc/au1xmmc.c
@@ -41,6 +41,7 @@
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/protocol.h>
@@ -195,7 +195,7 @@ static int au1xmmc_send_command(struct a
 
 	u32 mmccmd = (cmd->opcode << SD_CMD_CI_SHIFT);
 
-	switch (mmc_rsp_type(cmd->flags)) {
+	switch (mmc_resp_type(cmd)) {
 	case MMC_RSP_R1:
 		mmccmd |= SD_CMD_RT_1;
 		break;

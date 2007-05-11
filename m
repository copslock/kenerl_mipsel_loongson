Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2007 06:16:33 +0100 (BST)
Received: from mo31.po.2iij.NET ([210.128.50.54]:50236 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022119AbXEKFQb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2007 06:16:31 +0100
Received: by mo.po.2iij.net (mo31) id l4B5GOEa010802; Fri, 11 May 2007 14:16:24 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox33) id l4B5GMQJ053603
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 11 May 2007 14:16:22 +0900 (JST)
Message-Id: <200705110516.l4B5GMQJ053603@mbox33.po.2iij.net>
Date:	Fri, 11 May 2007 14:16:22 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Pierre Ossman <drzeus@drzeus.cx>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: [PATCH] mmc: add include <linux/mmc/mmc.h> to au1xmmc.c
In-Reply-To: <4643F57C.5060409@drzeus.cx>
References: <20070511125919.350c53a8.yoichi_yuasa@tripeaks.co.jp>
	<4643F57C.5060409@drzeus.cx>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Fri, 11 May 2007 06:47:56 +0200
Pierre Ossman <drzeus@drzeus.cx> wrote:

> Yoichi Yuasa wrote:
> > Hi,
> > 
> > This patch has fixed the following error about au1xmmc.c .
> > 
> > drivers/mmc/host/au1xmmc.c: In function 'au1xmmc_send_command':
> > drivers/mmc/host/au1xmmc.c:217: error: 'MMC_READ_SINGLE_BLOCK' undeclared (first use in this function)
> > drivers/mmc/host/au1xmmc.c:217: error: (Each undeclared identifier is reported only once
> > drivers/mmc/host/au1xmmc.c:217: error: for each function it appears in.)
> > drivers/mmc/host/au1xmmc.c:218: error: 'SD_APP_SEND_SCR' undeclared (first use in this function)
> > drivers/mmc/host/au1xmmc.c:221: error: 'MMC_READ_MULTIPLE_BLOCK' undeclared (first use in this function)
> > drivers/mmc/host/au1xmmc.c:224: error: 'MMC_WRITE_BLOCK' undeclared (first use in this function)
> > drivers/mmc/host/au1xmmc.c:228: error: 'MMC_WRITE_MULTIPLE_BLOCK' undeclared (first use in this function)
> > drivers/mmc/host/au1xmmc.c:231: error: 'MMC_STOP_TRANSMISSION' undeclared (first use in this function)
> > 
> > Yoichi
> > 
> > Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> > 
> 
> NAK for now. I want an explanation what those opcodes are doing in a host driver.

The commands of au1xmmc controller are different from standard commands. 
au1xmmc_send_command() convert standard commands to local commands for au1xmmc host controller,
and send local commands to controller.

Yoichi

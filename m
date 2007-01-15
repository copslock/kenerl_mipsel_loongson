Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Jan 2007 22:42:25 +0000 (GMT)
Received: from mo30.po.2iij.net ([210.128.50.53]:30980 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S28578739AbXAOWmU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 15 Jan 2007 22:42:20 +0000
Received: by mo.po.2iij.net (mo30) id l0FMg8Q7082440; Tue, 16 Jan 2007 07:42:08 +0900 (JST)
Received: from localhost.localdomain (69.25.30.125.dy.iij4u.or.jp [125.30.25.69])
	by mbox.po.2iij.net (mbox30) id l0FMg650060855
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 16 Jan 2007 07:42:06 +0900 (JST)
Date:	Tue, 16 Jan 2007 07:42:05 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Florian Fainelli <florian.fainelli@int-evry.fr>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: [PATCH] Add support for Cobalt Server front LED
Message-Id: <20070116074205.0428449d.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <200701151936.57738.florian.fainelli@int-evry.fr>
References: <200701151936.57738.florian.fainelli@int-evry.fr>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Mon, 15 Jan 2007 19:36:52 +0100
Florian Fainelli <florian.fainelli@int-evry.fr> wrote:

> Hi all,
> 
> This patch adds support for controlling the front LED on Cobalt Server. It has 
> been tested on Qube 2 with either no default trigger, or the IDE-activity 
> trigger. Both work fine. Please comment and test !
> 
> Thanks
> 
> Florian
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@int-evry.fr>
> 
> diff -urN linux-2.6.19.1/include/asm-mips/mach-cobalt/cobalt.h 
> linux-2.6.19.1.led/include/asm-mips/mach-cobalt/cobalt.h
> --- linux-2.6.19.1/include/asm-mips/mach-cobalt/cobalt.h        2006-12-11 
> 20:32:53.000000000 +0100
> +++ linux-2.6.19.1.led/include/asm-mips/mach-cobalt/cobalt.h    2007-01-15 
> 19:29:07.000000000 +0100
> @@ -97,6 +97,7 @@
>                 (PCI_FUNC (devfn) << 8) | (where)), GT_PCI0_CFGADDR_OFS)
> 
>  #define COBALT_LED_PORT                (*(volatile unsigned char *) 
> CKSEG1ADDR(0x1c000000))
> +#define COBALT_LED_BASE         0xbc000000

You don't need COBALT_LED_BASE.
Because COBALT_LED_PORT is already defined.

Yoichi

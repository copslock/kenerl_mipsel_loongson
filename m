Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jun 2006 07:19:03 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:1863 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8126579AbWFZGSv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Jun 2006 07:18:51 +0100
Received: by mo.po.2iij.net (mo31) id k5Q6ImJT045288; Mon, 26 Jun 2006 15:18:48 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox31) id k5Q6IkLr065883
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 26 Jun 2006 15:18:46 +0900 (JST)
Date:	Mon, 26 Jun 2006 15:18:46 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Kiran Thota <Kiran_Thota@pmc-sierra.com>
Cc:	linux-mips@linux-mips.org, netdev@vger.kernel.org,
	Rajesh_Palani@pmc-sierra.com, ralf@linux-mips.org
Subject: Re: [PATCH 6/6] PMC MSP85x0 gigabit ethernet driver
Message-Id: <20060626151846.39281449.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <C28979E4F697C249ABDA83AC0C33CDF8143EFB@sjc1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
References: <C28979E4F697C249ABDA83AC0C33CDF8143EFB@sjc1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hello Kiran,

On Fri, 23 Jun 2006 19:19:00 -0700
Kiran Thota <Kiran_Thota@pmc-sierra.com> wrote:

>  
> - Based on linux-2.6.12 from http://www.linux-mips.org/pub/linux/mips/kernel/v2.6/linux-2.6.12.tar.gz
> - Rewritten clean driver for PMC MSP85x0 gigabit ethernet driver (planning a rewritten titan driver) \
>   source, Kconfig and makefile. Will remove dependency on TITAN_GE flag with future titan driver.
> 
>  
> Signed-off-by: Kiran Kumar Thota <Kiran_Thota@pmc-sierra.com>
> 
> diff -Naur a/drivers/net/Kconfig b/drivers/net/Kconfig
> --- a/drivers/net/Kconfig	2005-07-11 11:28:10.000000000 -0700
> +++ b/drivers/net/Kconfig	2006-06-22 11:48:21.000000000 -0700
> @@ -2098,7 +2098,7 @@
>  
>  config TITAN_GE
>  	bool "PMC-Sierra TITAN Gigabit Ethernet Support"
> -	depends on PMC_YOSEMITE
> +	depends on PMC_YOSEMITE || PMC_SEQUOIA
>  	help
>  	  This enables support for the the integrated ethernet of
>  	  PMC-Sierra's Titan SoC.
> diff -Naur a/drivers/net/Makefile b/drivers/net/Makefile
> --- a/drivers/net/Makefile	2005-07-11 11:28:10.000000000 -0700
> +++ b/drivers/net/Makefile	2006-06-22 11:48:21.000000000 -0700
> @@ -103,7 +103,8 @@
>  obj-$(CONFIG_GALILEO_64240_ETH) += gt64240eth.o
>  obj-$(CONFIG_MV64340_ETH) += mv64340_eth.o
>  obj-$(CONFIG_BIG_SUR_FE) += big_sur_ge.o
> -obj-$(CONFIG_TITAN_GE) += titan_mdio.o titan_ge.o
> +obj-$(CONFIG_PMC_SEQUOIA) += titan_mdio.o msp85x0_ge.o
> +#obj-$(CONFIG_TITAN_GE) += titan_mdio.o titan_ge.o
>  
>  obj-$(CONFIG_PPP) += ppp_generic.o slhc.o
>  obj-$(CONFIG_PPP_ASYNC) += ppp_async.o

I think that you shold add a new config for msp85x0_ge.

Yoichi

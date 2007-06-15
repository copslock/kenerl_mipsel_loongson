Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2007 02:18:21 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:45114 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20023734AbXFOBST (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2007 02:18:19 +0100
Received: by mo.po.2iij.net (mo30) id l5F1H0d1053653; Fri, 15 Jun 2007 10:17:00 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox302) id l5F1GwYM026693
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 15 Jun 2007 10:16:59 +0900
Date:	Fri, 15 Jun 2007 10:16:58 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Marc St-Jean <stjeanma@pmc-sierra.com>
Cc:	yoichi_yuasa@tripeaks.co.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/12] mips: PMC MSP71xx mips common
Message-Id: <20070615101658.62f62fd7.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <200706142155.l5ELtVY4021526@pasqua.pmc-sierra.bc.ca>
References: <200706142155.l5ELtVY4021526@pasqua.pmc-sierra.bc.ca>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Thu, 14 Jun 2007 15:55:31 -0600
Marc St-Jean <stjeanma@pmc-sierra.com> wrote:

> @@ -823,6 +845,55 @@ config TOSHIBA_RBTX4938
>  
>  endchoice
>  
> +choice
> +	prompt "PMC-Sierra MSP SOC type"
> +	depends on PMC_MSP
> +
> +config PMC_MSP4200_EVAL
> +	bool "PMC-Sierra MSP4200 Eval Board"
> +	select IRQ_MSP_SLP
> +	select HW_HAS_PCI
> +
> +config PMC_MSP4200_GW
> +	bool "PMC-Sierra MSP4200 VoIP Gateway"
> +	select IRQ_MSP_SLP
> +	select HW_HAS_PCI
> +
> +config PMC_MSP7120_EVAL
> +	bool "PMC-Sierra MSP7120 Eval Board"
> +	select SYS_SUPPORTS_MULTITHREADING
> +	select IRQ_MSP_CIC
> +	select HW_HAS_PCI
> +	select USB_MSP71XX
> +
> +config PMC_MSP7120_GW
> +	bool "PMC-Sierra MSP7120 Residential Gateway"
> +	select SYS_SUPPORTS_MULTITHREADING
> +	select IRQ_MSP_CIC
> +	select HW_HAS_PCI
> +	select USB_MSP71XX
> +
> +config PMC_MSP7120_FPGA
> +	bool "PMC-Sierra MSP7120 FPGA"
> +	select SYS_SUPPORTS_MULTITHREADING
> +	select IRQ_MSP_CIC
> +	select HW_HAS_PCI
> +	select USB_MSP71XX
> +
> +endchoice
> +
> +menu "Options for PMC-Sierra MSP chipsets"
> +	depends on PMC_MSP
> +
> +config PMC_MSP_EMBEDDED_ROOTFS
> +	bool "Root filesystem embedded in kernel image"
> +	select MTD
> +	select MTD_BLOCK
> +	select MTD_PMC_MSP_RAMROOT
> +	select MTD_RAM
> +
> +endmenu
> +

This part should be in arch/mips/pmc-sierra/msp71xxx/Kconfig.

>  source "arch/mips/ddb5xxx/Kconfig"
>  source "arch/mips/gt64120/ev64120/Kconfig"
>  source "arch/mips/jazz/Kconfig"
> @@ -886,6 +957,9 @@ config ARC

Yoichi

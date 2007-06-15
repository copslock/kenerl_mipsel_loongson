Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2007 22:53:34 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:57648 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20023859AbXFOVxb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2007 22:53:31 +0100
Received: by mo.po.2iij.net (mo31) id l5FLrSNZ022246; Sat, 16 Jun 2007 06:53:28 +0900 (JST)
Received: from localhost.localdomain (70.27.30.125.dy.iij4u.or.jp [125.30.27.70])
	by mbox.po.2iij.net (po-mbox303) id l5FLrO1d022609
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 16 Jun 2007 06:53:24 +0900
Date:	Sat, 16 Jun 2007 06:53:24 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/12] mips: PMC MSP71xx mips common
Message-Id: <20070616065324.7014ba57.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <4672F858.9060304@pmc-sierra.com>
References: <4672F858.9060304@pmc-sierra.com>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Fri, 15 Jun 2007 13:36:40 -0700
Marc St-Jean <Marc_St-Jean@pmc-sierra.com> wrote:

> Yoichi Yuasa wrote:
> > Hi,
> > 
> > On Thu, 14 Jun 2007 15:55:31 -0600
> > Marc St-Jean <stjeanma@pmc-sierra.com> wrote:
> > 
> >  > @@ -823,6 +845,55 @@ config TOSHIBA_RBTX4938
> >  > 
> >  >  endchoice
> >  > 
> >  > +choice
> >  > +     prompt "PMC-Sierra MSP SOC type"
> >  > +     depends on PMC_MSP
> >  > +
> >  > +config PMC_MSP4200_EVAL
> >  > +     bool "PMC-Sierra MSP4200 Eval Board"
> >  > +     select IRQ_MSP_SLP
> >  > +     select HW_HAS_PCI
> >  > +
> >  > +config PMC_MSP4200_GW
> >  > +     bool "PMC-Sierra MSP4200 VoIP Gateway"
> >  > +     select IRQ_MSP_SLP
> >  > +     select HW_HAS_PCI
> >  > +
> >  > +config PMC_MSP7120_EVAL
> >  > +     bool "PMC-Sierra MSP7120 Eval Board"
> >  > +     select SYS_SUPPORTS_MULTITHREADING
> >  > +     select IRQ_MSP_CIC
> >  > +     select HW_HAS_PCI
> >  > +     select USB_MSP71XX
> >  > +
> >  > +config PMC_MSP7120_GW
> >  > +     bool "PMC-Sierra MSP7120 Residential Gateway"
> >  > +     select SYS_SUPPORTS_MULTITHREADING
> >  > +     select IRQ_MSP_CIC
> >  > +     select HW_HAS_PCI
> >  > +     select USB_MSP71XX
> >  > +
> >  > +config PMC_MSP7120_FPGA
> >  > +     bool "PMC-Sierra MSP7120 FPGA"
> >  > +     select SYS_SUPPORTS_MULTITHREADING
> >  > +     select IRQ_MSP_CIC
> >  > +     select HW_HAS_PCI
> >  > +     select USB_MSP71XX
> >  > +
> >  > +endchoice
> >  > +
> >  > +menu "Options for PMC-Sierra MSP chipsets"
> >  > +     depends on PMC_MSP
> >  > +
> >  > +config PMC_MSP_EMBEDDED_ROOTFS
> >  > +     bool "Root filesystem embedded in kernel image"
> >  > +     select MTD
> >  > +     select MTD_BLOCK
> >  > +     select MTD_PMC_MSP_RAMROOT
> >  > +     select MTD_RAM
> >  > +
> >  > +endmenu
> >  > +
> > 
> > This part should be in arch/mips/pmc-sierra/msp71xxx/Kconfig.
> 
> Hi Yoichi,
> 
> Just to verify, you do mean just the last menu "Options for PMC-Sierra MSP chipsets"?

This part means choice "PMC-Sierra MSP SOC type" and menu "Options for PMC-Sierra MSP chipsets".
arch/mips/au1000/Kconfig is a good reference.

Yoichi

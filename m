Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2007 23:45:14 +0100 (BST)
Received: from father.pmc-sierra.com ([216.241.224.13]:65464 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20024085AbXFOWpM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 15 Jun 2007 23:45:12 +0100
Received: (qmail 21896 invoked by uid 101); 15 Jun 2007 22:44:00 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by father.pmc-sierra.com with SMTP; 15 Jun 2007 22:44:00 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l5FMhskn008914;
	Fri, 15 Jun 2007 15:43:54 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <LGNW6WHX>; Fri, 15 Jun 2007 15:43:54 -0700
Message-ID: <46731626.1000700@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/12] mips: PMC MSP71xx mips common
Date:	Fri, 15 Jun 2007 15:43:50 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 15 Jun 2007 22:43:51.0434 (UTC) FILETIME=[A52EA6A0:01C7AF9E]
user-agent: Thunderbird 1.5.0.12 (X11/20070509)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips



Yoichi Yuasa wrote:
> On Fri, 15 Jun 2007 13:36:40 -0700
> Marc St-Jean <Marc_St-Jean@pmc-sierra.com> wrote:
> 
>  > Yoichi Yuasa wrote:
>  > > Hi,
>  > >
>  > > On Thu, 14 Jun 2007 15:55:31 -0600
>  > > Marc St-Jean <stjeanma@pmc-sierra.com> wrote:
>  > >
>  > >  > @@ -823,6 +845,55 @@ config TOSHIBA_RBTX4938
>  > >  >
>  > >  >  endchoice
>  > >  >
>  > >  > +choice
>  > >  > +     prompt "PMC-Sierra MSP SOC type"
>  > >  > +     depends on PMC_MSP
>  > >  > +
>  > >  > +config PMC_MSP4200_EVAL
>  > >  > +     bool "PMC-Sierra MSP4200 Eval Board"
>  > >  > +     select IRQ_MSP_SLP
>  > >  > +     select HW_HAS_PCI
>  > >  > +
>  > >  > +config PMC_MSP4200_GW
>  > >  > +     bool "PMC-Sierra MSP4200 VoIP Gateway"
>  > >  > +     select IRQ_MSP_SLP
>  > >  > +     select HW_HAS_PCI
>  > >  > +
>  > >  > +config PMC_MSP7120_EVAL
>  > >  > +     bool "PMC-Sierra MSP7120 Eval Board"
>  > >  > +     select SYS_SUPPORTS_MULTITHREADING
>  > >  > +     select IRQ_MSP_CIC
>  > >  > +     select HW_HAS_PCI
>  > >  > +     select USB_MSP71XX
>  > >  > +
>  > >  > +config PMC_MSP7120_GW
>  > >  > +     bool "PMC-Sierra MSP7120 Residential Gateway"
>  > >  > +     select SYS_SUPPORTS_MULTITHREADING
>  > >  > +     select IRQ_MSP_CIC
>  > >  > +     select HW_HAS_PCI
>  > >  > +     select USB_MSP71XX
>  > >  > +
>  > >  > +config PMC_MSP7120_FPGA
>  > >  > +     bool "PMC-Sierra MSP7120 FPGA"
>  > >  > +     select SYS_SUPPORTS_MULTITHREADING
>  > >  > +     select IRQ_MSP_CIC
>  > >  > +     select HW_HAS_PCI
>  > >  > +     select USB_MSP71XX
>  > >  > +
>  > >  > +endchoice
>  > >  > +
>  > >  > +menu "Options for PMC-Sierra MSP chipsets"
>  > >  > +     depends on PMC_MSP
>  > >  > +
>  > >  > +config PMC_MSP_EMBEDDED_ROOTFS
>  > >  > +     bool "Root filesystem embedded in kernel image"
>  > >  > +     select MTD
>  > >  > +     select MTD_BLOCK
>  > >  > +     select MTD_PMC_MSP_RAMROOT
>  > >  > +     select MTD_RAM
>  > >  > +
>  > >  > +endmenu
>  > >  > +
>  > >
>  > > This part should be in arch/mips/pmc-sierra/msp71xxx/Kconfig.
>  >
>  > Hi Yoichi,
>  >
>  > Just to verify, you do mean just the last menu "Options for 
> PMC-Sierra MSP chipsets"?
> 
> This part means choice "PMC-Sierra MSP SOC type" and menu "Options for 
> PMC-Sierra MSP chipsets".
> arch/mips/au1000/Kconfig is a good reference.
> 
> Yoichi
> 

OK, I will move them to arch/mips/pmc-sierra/Kconfig so the PMC_MSP
generic options can be shared with future MSP devices not in the msp71xx
directory.

Marc

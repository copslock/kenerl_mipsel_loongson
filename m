Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Feb 2007 21:16:45 +0000 (GMT)
Received: from mother.pmc-sierra.com ([216.241.224.12]:907 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20039037AbXBWVQk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Feb 2007 21:16:40 +0000
Received: (qmail 27925 invoked by uid 101); 23 Feb 2007 21:15:27 -0000
Received: from unknown (HELO pmxedge2.pmc-sierra.bc.ca) (216.241.226.184)
  by mother.pmc-sierra.com with SMTP; 23 Feb 2007 21:15:27 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge2.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l1NLFQ28030337;
	Fri, 23 Feb 2007 13:15:26 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <FGCPBQ4G>; Fri, 23 Feb 2007 13:15:25 -0800
Message-ID: <45DF5962.1070407@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	David Daney <ddaney@avtrex.com>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/5] mips: PMC MSP71xx mips common
Date:	Fri, 23 Feb 2007 13:15:14 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 23 Feb 2007 21:15:14.0491 (UTC) FILETIME=[B5C588B0:01C7578F]
user-agent: Thunderbird 1.5.0.9 (X11/20061206)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips



David Daney wrote:
> Marc St-Jean wrote:
>  >
>  > Sergei Shtylyov wrote:
>  >> Hello.
>  >>
>  >> Marc St-Jean wrote:
>  >>
>  >>  > [PATCH 2/5] mips: PMC MSP71xx mips common
>  >>
>  >>  > Patch to add mips common support for the PMC-Sierra
>  >>  > MSP71xx devices.
>  >>
>  >>  > These 5 patches along with the previously posted serial patch
>  >>  > will boot the PMC-Sierra MSP7120 Residential Gateway board.
>  >>
>  >>  > Signed-off-by: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
>  >>
>  >>  > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>  >>  > index 5da6b0d..d512389 100644
>  >>  > --- a/arch/mips/Kconfig
>  >>  > +++ b/arch/mips/Kconfig
>  >> [...]
>  >>
>  >>  > +menu "Options for PMC-Sierra MSP chipsets"
>  >>  > +     depends on PMC_MSP
>  >>  > +
>  >>  > +config PMC_MSP_EMBEDDED_ROOTFS
>  >>  > +     bool "Root filesystem embedded in kernel image"
>  >>  > +     select MTD
>  >>  > +     select MTD_BLOCK
>  >>  > +     select MTD_PMC_MSP_RAMROOT
>  >>  > +     select MTD_RAM
>  >>  > +
>  >>
>  >>     Hm, why not just use initramfs?
>  >
>  > I investigated this as part of an earlier thread.  Initramfs
>  > is not a read-only "ROM" fs but a compressed writable fs.
>  > Once expanded it will take more memory.
>  >
>  > To lower memory usage for embedded usage of our devices we've
>  > added a method to embedded cramfs/squashfs file systems into
>  > the kernel image.
>  >
> 
> Why not just run the cramfs/squashfs on a standard mdtblock device?

We and our customers do that as well but it's handy to have a single
RAM-based image to download during early development.

MArc

> 
>  > I've made sure it was unobtrusive and that no linker script
>  > changes, etc. were required.
>  >
>  >
> 

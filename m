Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Feb 2007 20:54:34 +0000 (GMT)
Received: from father.pmc-sierra.com ([216.241.224.13]:20731 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20039038AbXBWUya (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Feb 2007 20:54:30 +0000
Received: (qmail 29267 invoked by uid 101); 23 Feb 2007 20:53:18 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by father.pmc-sierra.com with SMTP; 23 Feb 2007 20:53:18 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l1NKrHhe031577;
	Fri, 23 Feb 2007 12:53:17 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <FGCPBP98>; Fri, 23 Feb 2007 12:53:17 -0800
Message-ID: <45DF5438.1040706@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/5] mips: PMC MSP71xx mips common
Date:	Fri, 23 Feb 2007 12:53:12 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 23 Feb 2007 20:53:13.0239 (UTC) FILETIME=[A23E7A70:01C7578C]
user-agent: Thunderbird 1.5.0.9 (X11/20061206)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips



Sergei Shtylyov wrote:
> Hello.
> 
> Marc St-Jean wrote:
> 
>  > [PATCH 2/5] mips: PMC MSP71xx mips common
> 
>  > Patch to add mips common support for the PMC-Sierra
>  > MSP71xx devices.
> 
>  > These 5 patches along with the previously posted serial patch
>  > will boot the PMC-Sierra MSP7120 Residential Gateway board.
> 
>  > Signed-off-by: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
> 
>  > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>  > index 5da6b0d..d512389 100644
>  > --- a/arch/mips/Kconfig
>  > +++ b/arch/mips/Kconfig
> [...]
> 
>  > +menu "Options for PMC-Sierra MSP chipsets"
>  > +     depends on PMC_MSP
>  > +
>  > +config PMC_MSP_EMBEDDED_ROOTFS
>  > +     bool "Root filesystem embedded in kernel image"
>  > +     select MTD
>  > +     select MTD_BLOCK
>  > +     select MTD_PMC_MSP_RAMROOT
>  > +     select MTD_RAM
>  > +
> 
>     Hm, why not just use initramfs?

I investigated this as part of an earlier thread.  Initramfs
is not a read-only "ROM" fs but a compressed writable fs.
Once expanded it will take more memory.

To lower memory usage for embedded usage of our devices we've
added a method to embedded cramfs/squashfs file systems into
the kernel image.

I've made sure it was unobtrusive and that no linker script
changes, etc. were required.


>  > +config PMC_MSP_UNCACHED
>  > +     bool "Run uncached"
>  > +     select MIPS_UNCACHED
>  > +    
>  > +endmenu
>  > +
> 
>     Erm, was there really a need for separate option?

Are you aware of an existing option to accomplish the same
results? I have not found it.


>  > diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
>  > index 18f56a9..610e169 100644
>  > --- a/arch/mips/kernel/traps.c
>  > +++ b/arch/mips/kernel/traps.c
>  > @@ -70,6 +70,7 @@ extern asmlinkage void handle_reserved(void);
>  >  extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
>  >       struct mips_fpu_struct *ctx, int has_fpu);
>  > 
>  > +void (*board_watchpoint_handler)(struct pt_regs *regs);
>  >  void (*board_be_init)(void);
>  >  int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
>  >  void (*board_nmi_handler_setup)(void);
>  > @@ -860,13 +861,17 @@ asmlinkage void do_mdmx(struct pt_regs *regs)
>  > 
>  >  asmlinkage void do_watch(struct pt_regs *regs)
>  >  {
>  > -     /*
>  > -      * We use the watch exception where available to detect stack
>  > -      * overflows.
>  > -      */
>  > -     dump_tlb_all();
>  > -     show_regs(regs);
>  > -     panic("Caught WATCH exception - probably caused by stack 
> overflow.");
>  > +     if (board_watchpoint_handler) {
>  > +             (*board_watchpoint_handler)(regs);
>  > +     } else {
>  > +             /*
>  > +              * We use the watch exception where available to detect 
> stack
>  > +              * overflows.
>  > +              */
>  > +             dump_tlb_all();
>  > +             show_regs(regs);
>  > +             panic("Caught WATCH exception - probably caused by 
> stack overflow.");
>  > +     }
>  >  }
> 
>     There was no real need for else and massive change, just add return 
> right
> after calling the handler...

Thanks, will do for the next submission.

Marc

Received:  by oss.sgi.com id <S554079AbQKJTST>;
	Fri, 10 Nov 2000 11:18:19 -0800
Received: from gateway-490.mvista.com ([63.192.220.206]:41463 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S554071AbQKJTRx>;
	Fri, 10 Nov 2000 11:17:53 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id eAAJFh320092;
	Fri, 10 Nov 2000 11:15:43 -0800
Message-ID: <3A0C49EA.1E6C79CC@mvista.com>
Date:   Fri, 10 Nov 2000 11:18:02 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: PROPOSAL : machine dependent support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


More and more mips boards are popping and most of them have PCI bus.  I
was looking at having a common PCI code under arch/mips/kernel which
will do the same job which each machine is handling all by itself now. 
It will invoke various machine dependent calls to accomplish the same
job.

Following the MIPS tradition, it seems appropriate to introduce some
struct like mach_pci_ops.  But I think I have a better idea. :-)

So far we already have several variables and data structures in the
similar nature.  (See a complete listing below).  Why don't we lump them
all together into one centralized structure?

OK, I have to be honest - I steal this idea from PPC.  PPC folks have
gone through some what similar phase when they tried to support ever
increasing number of boards in the past two years.  The machine
dependent structure is part of their solution.

I see several benefits :

1. I expect more machine/board abstraction down the road.  Other PCI,
things may include pwoer management, generic I/O interface, accessing
non-volatile storage for system, interrupt management, etc.  This
structure gives a systematic to include those support, rather than each
time investing some ad hoc stuff.

2. Easier to port Linux to a new board.  One central place with most of
the required functions and variables.  (It almost becomes a porting
layer - I said "almost". :-0)  With good and extensive document, I see
the header file is the starting point for anybody who wants to start
porting linux to a new board.

3. It makes the mips-common code easier to write - so my common PCI code
can be added more easily. 

Ok, enough bluffing.  

Specifically, I think I will start with a modest structure (read as
"least amount of work" :-0)

struct mips_mach_depend {
	/* _machine_xxx stuff */
	void 	(*restart)(char *cmd);
	void 	(*power_off)(void);
	void	(*halt)(void);

	/* board_time_init */
	void 	(*time_init)(struct irqaction *irq);

	void 	(*irq_setup)(void);

	/* mips_io_port_base */
	unsigned long 	io_port_base;
};

extern mips_mach_depend mips_md;

I suppose rtc_ops and kbd_ops should be included there as well. 

I will add PCI stuff to it later.

Note that some functions can be NULL, and the mips-generic code will
supply default behavior.  For example, if power_off is not supplied, it
will probably just do a printk, cli() and loop forever.

What do you think?  I will volunteer to do the first phase change for
ALL existing boards so that nothing breaks.

Jun

P.S., I forgot to mention that one HUGE assumption behind this is that I
believe we are going to see 20 to 100 MIPS boards (including SOC,
"pseudo-MIPS', etc) in the coming a couple of years which want to use
Linux.  Certainly anything in this direction will help the proliferation
of Linux MIPS - unless someone think this would make Linux too easy to
port and they would lose the job. :-)  But we always have the option to
introduce bugs....

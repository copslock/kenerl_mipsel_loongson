Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7LHWiq25958
	for linux-mips-outgoing; Tue, 21 Aug 2001 10:32:44 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7LHWf925955
	for <linux-mips@oss.sgi.com>; Tue, 21 Aug 2001 10:32:41 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f7LHbCA29475;
	Tue, 21 Aug 2001 10:37:12 -0700
Message-ID: <3B8299CF.1444A271@mvista.com>
Date: Tue, 21 Aug 2001 10:26:39 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: swang@mmc.atmel.com
CC: linux-mips@oss.sgi.com
Subject: Re: Question on porting Linux...
References: <000701c12529$e1640580$8021690a@huawei.com> <20010815103314.A11966@bacchus.dhis.org> <000b01c1295e$0f2174c0$8021690a@huawei.com> <20010820230755.A11242@dea.linux-mips.net> <001501c129dd$8acebb80$8021690a@huawei.com> <20010821083508.A13302@dea.linux-mips.net> <001201c12a29$57f3b660$8021690a@huawei.com> <20010821131721.F13302@dea.linux-mips.net> <3B827B7C.16A1C763@mmc.atmel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Shuanglin Wang wrote:
> 
> Hi all,
> 
> I'm working on porting Linux to a third-part board. I don't know where to start.
> Can anyone give me some tips?
> By the way, the board doesn't have PCI bus, Interrupt controller, and RTC.  Do
> you think it is possible to port Linux to it?  And how difficult will it be?
> 
> A lot of thanks,
> 

Porting Linux/MIPS generally involves three tasks:

1. CPU support

If your CPU is already supported, then your task is as easy as include the
CONFIG_CPU_XXXX in your config file.

2. board support

This involves several subtasks:

a) hook your board/machines to the system.  Check include/asm/bootinfo.h,
arch/mips/setup.c.

b) prom_init().

c) board setup code (xxx_setup()): fix hardware, set Linux variables, etc

d) interrupt dispatching, time service

e) others

Look under various arch/mips subdirectories.

3) driver code

Serial, ether, etc.

Good luck.

Jun

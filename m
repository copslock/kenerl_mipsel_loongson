Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Feb 2005 17:30:18 +0000 (GMT)
Received: from no-dns-yet.demon.co.uk ([IPv6:::ffff:83.104.11.251]:46361 "EHLO
	exterity.co.uk") by linux-mips.org with ESMTP id <S8225464AbVBYRaC>;
	Fri, 25 Feb 2005 17:30:02 +0000
Received: from [192.168.0.85] ([192.168.0.85]) by exterity.co.uk with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 25 Feb 2005 17:31:20 +0000
Subject: Re: Big Endian au1550
From:	JP Foster <jp.foster@exterity.co.uk>
To:	linux-mips@linux-mips.org
In-Reply-To: <20050224161542.74749.qmail@web203.biz.mail.re2.yahoo.com>
References: <20050224161542.74749.qmail@web203.biz.mail.re2.yahoo.com>
Content-Type: text/plain
Date:	Fri, 25 Feb 2005 17:29:56 +0000
Message-Id: <1109352597.2493.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.5 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Feb 2005 17:31:20.0953 (UTC) FILETIME=[D2084E90:01C51B5F]
Return-Path: <jpfoster@exterity.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jp.foster@exterity.co.uk
Precedence: bulk
X-list: linux-mips

Yeah! 
Got it working withgcc 3.4.1. Trying again with latest linux-mips and 
it runs as far as borking that it can't find rootfs unknown block,
but I assume that has to do with initramfs.  

---------
VFS: Cannot open root device "<NULL>" or unknown-block(0,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(0,0)
---------

Do I need to disable ramdisk support for this?


I think there were config options enabled that were causing the crash,
pared it down to just the network and ethernet and serial console and it
works, just had to patch this to get the compile working 

Index: mips/Kconfig
===================================================================
RCS file: /home/cvs/linux/arch/mips/Kconfig,v
retrieving revision 1.142
diff -r1.142 Kconfig
88a89
>       select SYS_SUPPORTS_BIG_ENDIAN
Index: mips/kernel/process.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/process.c,v
retrieving revision 1.75
diff -r1.75 process.c
169,172c169,172
<       gp[EF_CP0_EPC] = regs->cp0_epc;
<       gp[EF_CP0_BADVADDR] = regs->cp0_badvaddr;
<       gp[EF_CP0_STATUS] = regs->cp0_status;
<       gp[EF_CP0_CAUSE] = regs->cp0_cause;
---
> //    gp[EF_CP0_EPC] = regs->cp0_epc;
> //    gp[EF_CP0_BADVADDR] = regs->cp0_badvaddr;
> //    gp[EF_CP0_STATUS] = regs->cp0_status;
> //    gp[EF_CP0_CAUSE] = regs->cp0_cause;

These must be compiler defined or something.

Thanks everyone. The compiler was built from uclibc buildroot and set
for mips1


-- 
jp.foster@exterity.co.uk
Digital Simplicity

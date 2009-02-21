Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Feb 2009 07:04:19 +0000 (GMT)
Received: from tenor.i-cable.com ([203.83.115.107]:26022 "HELO
	tenor.i-cable.com") by ftp.linux-mips.org with SMTP
	id S21299229AbZBUHEQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 21 Feb 2009 07:04:16 +0000
Received: (qmail 5500 invoked by uid 508); 21 Feb 2009 07:04:08 -0000
Received: from 203.83.114.121 by tenor (envelope-from <robert.zhangle@gmail.com>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/7824.  
 Clear:RC:1(203.83.114.121):. 
 Processed in 0.191023 secs); 21 Feb 2009 07:04:08 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 21 Feb 2009 07:04:07 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id n1L746Wq022396;
	Sat, 21 Feb 2009 15:04:07 +0800 (HKT)
Date:	Sat, 21 Feb 2009 15:03:59 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [RFC] implement syscall pciconfig_iobase
Message-ID: <20090221070359.GB28041@adriano.hkcable.com.hk>
Mail-Followup-To: Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
References: <20090220130156.GA14095@adriano.hkcable.com.hk> <20090220145127.GD19924@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090220145127.GD19924@linux-mips.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

On 14:51 Fri 20 Feb     , Ralf Baechle wrote:
> You can find the resources either by something like:
> 
> # lspci -vvv -s 1d.1
> 00:1d.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #2 (rev 02) (prog-if 00 [UHCI])
> 	Subsystem: Dell Device 01fe
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin B routed to IRQ 21
> 	Region 4: I/O ports at 6f60 [size=32]
> 	Kernel driver in use: uhci_hcd
> 
> Now let's see how to find this in sysfs:
[snip]

Hi, Ralf,

After careful thought, I think this may be not what I need.
Actually libpciaccess, which is a integral component of X now, need this
mmap-able resourceN (N=1,2,3..) file. And previously mips don't have these file.
This patch just solved this problem.
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=98873f53becea9a8a46972ff252e96fe575b120d

What I need is access to this address in userspace:
#define LOONGSON2E_IO_PORT_BASE         0x1fd00000UL
which is defined in arch/mips/include/asm/mach-lemote/pci.h

Or maybe a better idea is to implement ioperm/iopl for mips, as discussed 7
years ago:
http://www.linux-mips.org/archives/linux-mips/2002-04/msg00085.html

Zhang, Le

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Mar 2003 20:38:27 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:50427 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8224827AbTCZUi0>;
	Wed, 26 Mar 2003 20:38:26 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id MAA18108;
	Wed, 26 Mar 2003 12:38:22 -0800
Subject: Re: au1500 mm problems?
From: Pete Popov <ppopov@mvista.com>
To: Bruno Randolf <br1@4g-systems.de>
Cc: linux-mips@linux-mips.org
In-Reply-To: <200303261854.10478.br1@4g-systems.de>
References: <200303261854.10478.br1@4g-systems.de>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1048711127.23483.188.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 26 Mar 2003 12:38:47 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips


> i am regularily getting the following 2 types of kernel oopses on my au1500 
> based board (mycable XXS), whenever i try to do something more demanding to 
> the CPU (like compiling):
> 
> Unhandled kernel unaligned access in unaligned.c::emulate_load_store_insn,
> line 481:
> 
> Unable to handle kernel paging request at virtual address 02000014, epc ==
> 80137554, ra == 4
> Oops in fault.c::do_page_fault, line 205:
> 
> do you have any suggestions for me what could be causes for these? 

Natively compiling large apps or the kernel seems to really stress the
hardware and the software. The last time I had a problem with native
compiles resulting in similar crashes, it turned out to be a CPU
hardware bug, which has long been fixed since then.

> i have 64MB ram and my root filesystem mounted over NFS. branch linux_2_4 a 
> few weeks ago. i can provide you with the complete oops if that would help.
> 
> btw: i cant use petes 36bit patch on the latest linux_2_4 branch anymore - it 
> always gives me a "Reserved instruction in kernel code in traps.c::do_ri, 
> line 654:" when i boot the kernel.

Hmm, I'll test it on the Db board and see what happened.

Pete

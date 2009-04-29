Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2009 07:03:24 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:43949 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S20022352AbZD2GDV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Apr 2009 07:03:21 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3T63JCD028173;
	Wed, 29 Apr 2009 08:03:19 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3T63HYm028171;
	Wed, 29 Apr 2009 08:03:17 +0200
Date:	Wed, 29 Apr 2009 08:03:17 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: oops in futex_init()
Message-ID: <20090429060317.GB15627@linux-mips.org>
References: <20090428124645.GA14347@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090428124645.GA14347@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 28, 2009 at 02:46:45PM +0200, Manuel Lauss wrote:

> >From time to time, my test systems don't boot correctly and spew the
> following oops in futex_init():
> 
> calling  init_timer_list_procfs+0x0/0x40 @ 1
> initcall init_timer_list_procfs+0x0/0x40 returned 0 after 29 usecs
> calling  futex_init+0x0/0xac @ 1
> Reserved instruction in kernel code[#1]:
> Cpu 0
> $ 0   : 00000000 10003c00 00000000 00000001
> $ 4   : fffffff2 00000000 32e02014 00000000
> $ 8   : 00000000 00000000 c4653600 000000cd
> $12   : 3b9aca00 000186a0 870ce3f0 0000000d
> $16   : 32e02014 00000000 00000000 8042f0dc
> $20   : 00000000 00000000 00000000 00000000
> $24   : 00000005 80243a3c
> $28   : 87020000 87021f30 00000000 80100460
> Hi    : 00000000
> Lo    : 00000000
> epc   : 8042f0f8 futex_init+0x1c/0xac
>     Not tainted
> ra    : 80100460 _stext+0x60/0x1c8
> Status: 10003c03    KERNEL EXL IE
> Cause : 00808028
> PrId  : 04030202 (Au1250)
> Modules linked in:
> Process swapper (pid: 1, threadinfo=87020000, task=87018000, tls=00000000)
> Stack : 00000000 8042f0dc 00000001 00002543 0000001d 00000000 87021f00 8014f014
>         0000000e 00000000 8702a900 87002000 00003137 00000000 00000000 801ba18c
>         8041e7a0 000000e0 80410000 00000000 00000000 8014f09c 32e02014 00000000
>         80448360 804484f4 00000000 00000000 00000000 80428304 00000000 00000000
>         00000000 00000000 87020000 00000000 00000000 80106ea4 10003c03 00000000
>         ...
> Call Trace:
> [<8042f0f8>] futex_init+0x1c/0xac
> [<80100460>] _stext+0x60/0x1c8
> [<80428304>] kernel_init+0x98/0x104
> [<80106ea4>] kernel_thread_helper+0x10/0x18
> 
> 
> Code: 30420004  14400008  2404fff2 <c0440000> 14800005  00000000  00000821  e0410000  1020fffa
> Disabling lock debugging due to kernel taint
> note: swapper[1] exited with preempt_count 1
> Kernel panic - not syncing: Attempted to kill init!
> 
> 
> Disassembly of futex_init():
> 
> (gdb) disass 0x8042f0f8
> Dump of assembler code for function futex_init:
> 0x8042f0dc <futex_init+0>:      lw      v1,20(gp)
> 0x8042f0e0 <futex_init+4>:      addiu   v1,v1,1
> 0x8042f0e4 <futex_init+8>:      sw      v1,20(gp)
> 0x8042f0e8 <futex_init+12>:     lw      v0,24(gp)
> 0x8042f0ec <futex_init+16>:     andi    v0,v0,0x4
> 0x8042f0f0 <futex_init+20>:     bnez    v0,0x8042f114 <futex_init+56>
> 0x8042f0f4 <futex_init+24>:     li      a0,-14
> 0x8042f0f8 <futex_init+28>:     ll      a0,0(v0)

So this is in futex_atomic_cmpxchg_inatomic which has been inlined into
futex_init.  The epc is pointing to this LL instruction which is a
legitimate MIPS32 instruction, so a reserved instruction exception does
not make sense.  However, a NULL pointer has intensionally been passed
as the argument heres so this LL instruction will take a TLB exception,
do_page_fault() will change the EPC to return to to point to the fixup
handler which in the sources are these lines:

                "       .section .fixup,\"ax\"                          \n"
                "4:     li      %0, %5                                  \n"
                "       j       3b                                      \n"
                "       .previous                                       \n"
                "       .section __ex_table,\"a\"                       \n"
                "       "__UA_ADDR "\t1b, 4b                            \n"
                "       "__UA_ADDR "\t2b, 4b                            \n"
                "       .previous                                       \n"

That's how it normally should function.  If however in the exception
handler something goes wrong while c0_status.exl is still set the c0_epc
regiser won't be updated for the 2nd exception which is that reserved
instruction exception.  This sort of bug can be ugly to chase, I'm afraid.

  Ralf

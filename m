Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2003 23:09:22 +0100 (BST)
Received: from [IPv6:::ffff:207.215.131.7] ([IPv6:::ffff:207.215.131.7]:27348
	"EHLO mail.pioneer-pdt.com") by linux-mips.org with ESMTP
	id <S8225625AbTJIWJU>; Thu, 9 Oct 2003 23:09:20 +0100
Received: from 127.0.0.1 (localhost.pioneer-pdt.com [127.0.0.1])
	by dummy.domain.name (Postfix) with SMTP
	id BB0609D81D; Thu,  9 Oct 2003 15:09:11 -0700 (PDT)
Received: from janelle (unknown [172.30.2.14])
	by mail.pioneer-pdt.com (Postfix) with SMTP
	id 608889D81B; Thu,  9 Oct 2003 15:09:11 -0700 (PDT)
Message-ID: <021e01c38eb2$4e95f840$2256fea9@janelle>
From: "Steve Scott" <steve.scott@pioneer-pdt.com>
To: <linux-mips@linux-mips.org>
Cc: <steve.scott@pioneer-pdt.com>
References: <5334.156.153.254.2.1065650433.squirrel@webmail.rmci.net> <20031009140319.GA17647@linux-mips.org>
Subject: bug in kernel_entry?
Date: Thu, 9 Oct 2003 15:11:36 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Return-Path: <steve.scott@pioneer-pdt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steve.scott@pioneer-pdt.com
Precedence: bulk
X-list: linux-mips

I ran across what looks like a bug in the 'kernel_entry' function in
linux/arch/mips/kernel/head.S while chasing another problem. Our
version of kernel_entry is for 2.4.17. 2.4.22 seems to have
the same problem.

kernel_entry initializes the kernel stack pointer 'kernelsp'. But then
immediately after this clears the bss, which has the side effect of setting
kernelsp to 0. In our system, on initial entry to cpu_idle(), kernelsp is 0.

The bug "heals" itself the first time schedule() is called. But, if for some
reason CP0_STATUS doesn't have CU0 set at startup (which would be
bad for other reasons), and you get an exception before the first call to
schedule() (e.g., the syscall to create "init"), the exception handler will
try to save registers starting from kernelsp, which is 0.

from head.S:

    NESTED(kernel_entry, 16, sp)
    .
    .
    .
    /*
     * Stack for kernel and init, current variable
     */
    la $28, init_task_union
    addiu t0, $28, KERNEL_STACK_SIZE-32
    subu sp, t0, 4*SZREG

    sw t0, kernelsp                /* <-- this is going to get overwritten below when bss
is cleared... [srs] */

    /* The firmware/bootloader passes argc/argp/envp
     * to us as arguments.  But clear bss first because
     * the romvec and other important info is stored there
     * by prom_init().
     */
    la t0, _edata                    /* <-- here is the code that eventually clears
kernelsp [srs] */
    sw zero, (t0)
    la t1, (_end - 4)
1:
    addiu t0, 4
    bne t0, t1, 1b
    sw zero, (t0)

   jal init_arch
    nop
  END(kernel_entry)

--steve

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Feb 2007 23:48:29 +0000 (GMT)
Received: from newmail.sw.starentnetworks.com ([12.33.234.78]:47534 "EHLO
	mail.sw.starentnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20039662AbXBIXsY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Feb 2007 23:48:24 +0000
Received: from zeus.sw.starentnetworks.com (zeus.sw.starentnetworks.com [12.33.233.46])
	by mail.sw.starentnetworks.com (Postfix) with ESMTP id 062B23EEDE
	for <linux-mips@linux-mips.org>; Fri,  9 Feb 2007 18:47:39 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17869.2075.900049.547334@zeus.sw.starentnetworks.com>
Date:	Fri, 9 Feb 2007 18:47:39 -0500
From:	Dave Johnson <djohnson+linux-mips@sw.starentnetworks.com>
To:	linux-mips@linux-mips.org
Subject: problems booting sb1250, page fault issue?
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Return-Path: <djohnson@sw.starentnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: djohnson+linux-mips@sw.starentnetworks.com
Precedence: bulk
X-list: linux-mips


I've been successfully running 2.6.12 on the sibyte bcm1250 for over a
year and have recently been trying to move forward to a more
recent kernel.

I've got 2.6.18 from linux-mips.org's git tree at the 'linux-2.6.18'
TAG built and almost booting.

While usually I'd run SMP+PREEMPT, I've turned those off to simplify
the kernel.  I'm running n64 kernel with o32 userspace.

It will run all the way through kernel startup, but once it starts
userspace (glibc + sysvinit) things go down hill fast.

I replaced init with a statically linked test program that does a few
syscalls and then spins to try to track down the issue.  When things
go wrong the symptom is usually a SIGSEGV or SIGBUS to the process
very shortly after it starts running.

How far the test program gets varies, but it usually looks like the
cpu starts executing incorrect code (at the right address) after
returning to userspace from an interrupt/exception.


I have two variants of the test 'init' program:

1) once into main() print hello world then branch to self.

This program usually works reliably. If the program makes it all the
way to the branch to self instruction things are good.  The kernel
schedules it just fine, taking timer interrupts as expected.

2) once into main() print hello world then call a function that
consists of 2MB worth of 'addiu $8,$8,1' instructions then branch to
self.

Running this program _always_ fails part way through the adds.  The
program executes through the add instruction and every time it crosses
a page boundary it causes a page fault and the kernel loads in the
next page from the filesystem as expected.

On startup, the program faults in various text, data, and stack pages,
and prints Hello World.  After this it starts linearly executing add
instructions starting at about address 0x00401000.

In the below case after about 100KB of add instructions the program
takes a SEGV for no apparent reason at 0x00419140!

The entire 0x00419000 - 0x00419FFF page should be full of add
instructions none of which should cause a SEGV!

I enabled some printk's in the page fault handler and I see this:

Cpu0[init:1:0000000010004624:1:ffffffff8025f438]
Cpu0[init:1:0000000000400190:0:0000000000400190]
Cpu0[init:1:0000000010003f70:0:00000000004001e0]
Cpu0[init:1:0000000000604670:0:0000000000604670]
Cpu0[init:1:00000000100004f4:0:00000000006046f4]
Cpu0[init:1:0000000010000550:1:0000000000604718]
Cpu0[init:1:000000000060e380:0:000000000060e380]
Cpu0[init:1:0000000000619890:0:0000000000619890]
Cpu0[init:1:000000000062c028:0:000000000062c028]
Cpu0[init:1:000000000061fd70:0:000000000061fd70]
Cpu0[init:1:0000000010002f80:0:000000000061998c]
Cpu0[init:1:0000000000618e10:0:0000000000618e10]
Cpu0[init:1:0000000000620c50:0:0000000000620c50]
Cpu0[init:1:000000000062ad20:0:000000000062ad20]
Cpu0[init:1:0000000000679b74:0:000000000062ad78]
Cpu0[init:1:000000000060fb40:0:000000000060fb40]
Cpu0[init:1:0000000000606b24:0:0000000000606b24]
Cpu0[init:1:0000000000605d20:0:0000000000605d20]
Cpu0[init:1:0000000000607010:0:0000000000607010]
Cpu0[init:1:000000000060c7f0:0:000000000060c7f0]
Cpu0[init:1:0000000010006004:1:0000000000607894]
Cpu0[init:1:0000000000610528:0:0000000000610528]
Cpu0[init:1:000000000062e490:0:000000000062e490]
Cpu0[init:1:0000000000678c30:0:0000000000678c30]
Hello World!
Cpu0[init:1:0000000000401000:0:0000000000401000]
Cpu0[init:1:0000000000402000:0:0000000000402000]
Cpu0[init:1:0000000000403000:0:0000000000403000]
Cpu0[init:1:0000000000404000:0:0000000000404000]
Cpu0[init:1:0000000000405000:0:0000000000405000]
Cpu0[init:1:0000000000406000:0:0000000000406000]
Cpu0[init:1:0000000000407000:0:0000000000407000]
Cpu0[init:1:0000000000408000:0:0000000000408000]
Cpu0[init:1:0000000000409000:0:0000000000409000]
Cpu0[init:1:000000000040a000:0:000000000040a000]
Cpu0[init:1:000000000040b000:0:000000000040b000]
Cpu0[init:1:000000000040c000:0:000000000040c000]
Cpu0[init:1:000000000040d000:0:000000000040d000]
Cpu0[init:1:000000000040e000:0:000000000040e000]
Cpu0[init:1:000000000040f000:0:000000000040f000]
Cpu0[init:1:0000000000410000:0:0000000000410000]
Cpu0[init:1:0000000000411000:0:0000000000411000]
Cpu0[init:1:0000000000412000:0:0000000000412000]
Cpu0[init:1:0000000000413000:0:0000000000413000]
Cpu0[init:1:0000000000414000:0:0000000000414000]
Cpu0[init:1:0000000000415000:0:0000000000415000]
Cpu0[init:1:0000000000416000:0:0000000000416000]
Cpu0[init:1:0000000000417000:0:0000000000417000]
Cpu0[init:1:0000000000418000:0:0000000000418000]
Cpu0[init:1:0000000000419000:0:0000000000419000]
Cpu0[init:1:0000000000000098:1:0000000000419140]
do_page_fault() #2: sending SIGSEGV to init for invalid write access to
0000000000000098 (epc == 0000000000419140, ra == 00000000006045b8)
Cpu0[init:1:0000000000000098:1:0000000000419140]
do_page_fault() #2: sending SIGSEGV to init for invalid write access to
0000000000000098 (epc == 0000000000419140, ra == 00000000006045b8)
Cpu0[init:1:0000000000000098:1:0000000000419140]
do_page_fault() #2: sending SIGSEGV to init for invalid write access to
0000000000000098 (epc == 0000000000419140, ra == 00000000006045b8)
Cpu0[init:1:0000000000000098:1:0000000000419140]
do_page_fault() #2: sending SIGSEGV to init for invalid write access to
0000000000000098 (epc == 0000000000419140, ra == 00000000006045b8)
Cpu0[init:1:0000000000000098:1:0000000000419140]
do_page_fault() #2: sending SIGSEGV to init for invalid write access to
0000000000000098 (epc == 0000000000419140, ra == 00000000006045b8)
Cpu0[init:1:0000000000000098:1:0000000000419140]


I've carefully gone through syscall and interrupt/exception entry/exit
with a jtag debugger to make sure registers are saved/restored
correctly and everything looks fine at least on the few times I walked
through it.

After taking the fault, I also examined the page that took the
fault and verified it is full of 'addiu $8,$8,1' including the
instruction that the kernel thinks a SEGV occurred on.

Since the page contains correct data, I tried adding gratuitous icache
flushes after each page fault before returning to userspace to rule
out any issues there, but with no help.

Has issues like this been seen before?  If not, does anyone have ideas
that I could try next?

-- 
Dave Johnson
Starent Networks

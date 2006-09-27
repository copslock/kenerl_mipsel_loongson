Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Sep 2006 20:54:05 +0100 (BST)
Received: from newmail.sw.starentnetworks.com ([12.33.234.78]:11790 "EHLO
	mail.sw.starentnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20039014AbWI0TyC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 27 Sep 2006 20:54:02 +0100
Received: from zeus.sw.starentnetworks.com (zeus.sw.starentnetworks.com [12.33.233.46])
	by mail.sw.starentnetworks.com (Postfix) with ESMTP id 802CA3E1B9
	for <linux-mips@linux-mips.org>; Wed, 27 Sep 2006 15:53:55 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17690.54995.407882.581783@zeus.sw.starentnetworks.com>
Date:	Wed, 27 Sep 2006 15:53:55 -0400
From:	Dave Johnson <djohnson+linux-mips@sw.starentnetworks.com>
To:	linux-mips@linux-mips.org
Subject: wrong SP restored after DBE exception
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Return-Path: <djohnson@sw.starentnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: djohnson+linux-mips@sw.starentnetworks.com
Precedence: bulk
X-list: linux-mips


I'm running into an odd problem with the DBE exception handler.

I've got an IO device that on some error conditions causes a bus fault
on access.  The driver I have that accesses this device directs
all reads/writes through a wrapper function to handle potential bus
faults (see the read version below).

If the device causes a DBE on access, do_be() looks up the EPC in the
DBE table and successfully corrects the PC to handle the fault.

This works most of the time, however on about 1 out of 100 faults the
SP register is saved and restored incorrectly.  When control returns to
the faulting function SP is 304 bytes less than where it should
be and as expected things go down hill from there.

304 bytes is PT_SIZE (the amount of space for saved registers)

I suspect something is wrong with except_vec3_generic() or
handle_dbe() but the only thing that comes to mind is potential nested
interrupts/exceptions that would clobber K0/K1.  The fact that SP is
off by 304 bytes seems to indicate it saved twice but only restored
once.

CPU:    SiByte BCM1250 (both A8 and B2 stepping tested)
Kernel: linux 2.6.12 (yes, I know it's old), 64bit kernel
Config: Occurs with and without SMP and with and without PREEMPT

I took a quick look to see if this area has changed between 2.6.12 and
2.6.17 and the only part I see is get_saved_sp() and that should
only effect faults from userspace.  All the faults I'm getting are
from a kernel-mode driver.

I've walked through one (succesful) DBE fault from this driver using a
JTAG debugger and everything looks to run exactly as expected.  I have
yet to catch a failing one with the debugger except for after the
restore is finished but that's too late.

Anyone have any thoughts on this issue?


------------------------
read wrapper function is:

	.set    noreorder
/* int sb_io_trap_readb(unsigned char *value, const volatile void *addrs); */
LEAF(sb_io_trap_readb)
	/* do the read, handle error */
8:	lb	t0, (a1)
9:	add	t0, t0, zero /* consume read */
	.section __dbe_table,"a"
	PTR	8b, 1f
	PTR	9b, 1f
	.previous
	/*
	 * write out to the caller's pointer, if this fails it's a bug
	 * and we should fault as normal
	 */
	sb	t0, (a0)
	/* all good, return success */
	jr	ra
	move	v0, zero
	/* fault handler, return -EIO */
1:	jr	ra
	li	v0, -EIO
END(sb_io_trap_readb)

-- 
Dave Johnson
Starent Networks

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jan 2003 11:58:09 +0000 (GMT)
Received: from p508B7CBF.dip.t-dialin.net ([IPv6:::ffff:80.139.124.191]:19658
	"EHLO p508B7CBF.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225896AbTAFL6J>; Mon, 6 Jan 2003 11:58:09 +0000
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:51187 "EHLO
	av.mvista.com") by ralf.linux-mips.org with ESMTP
	id <S869794AbTAEBjq>; Sun, 5 Jan 2003 02:39:46 +0100
Received: from localhost (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id MAA05799;
	Sat, 4 Jan 2003 12:25:23 -0800
Subject: PATCH:  unaligned handler problem
From: Pete Popov <ppopov@mvista.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20030103144615.A8482@linux-mips.org>
References: <1041589762.18883.4.camel@adsl.pacbell.net>
	 <20030103144615.A8482@linux-mips.org>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1041711952.29512.4.camel@adsl.pacbell.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 04 Jan 2003 12:25:52 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, 2003-01-03 at 05:46, Ralf Baechle wrote:
> On Fri, Jan 03, 2003 at 02:29:22AM -0800, Pete Popov wrote:
> 
> > The changes betwen rev 1.23 and 1.24 in unaligned.c, to replace
> > check_axs() with verify_area(), causes any unaligned access from within
> > a kernel module to crash. access_ok() returns -EFAULT as the
> > __access_mask is 0xffffffff so __access_ok evaluates to > 0.  It's too
> > late for me to look into it any further but perhaps the problem will be
> > obvious to someone else. I'm not sure what get_fs() should return in
> > this case (again, the access is from within a kernel module) but it
> > returns 0xffffffff.
> 
> The address error handler should do something like:
> 
> 	mm_segment_t seg;
> 
> 	seg = get_fs();
> 	if (!user_mode(regs))
> 		set_fs(KERNEL_DS);
> 
> 	... usual unaligned stuff goes here ...
> 
> 	set_fs(seg);

Thanks! The patch below works. I had a test case plus a pcmcia driver that was
crashing, and now they both pass.


--- linux-2.4-head/arch/mips/kernel/unaligned.c	Thu Dec 26 21:35:00 2002
+++ linux-2.4-dev/arch/mips/kernel/unaligned.c	Sat Jan  4 12:21:06 2003
@@ -98,6 +98,11 @@
 	union mips_instruction insn;
 	unsigned long value, fixup;
 	unsigned int res;
+	mm_segment_t seg;
+
+	seg = get_fs();
+	if (!user_mode(regs))
+		set_fs(KERNEL_DS);
 
 	regs->regs[0] = 0;
 	/*
@@ -458,6 +463,7 @@
 	unaligned_instructions++;
 #endif
 
+	set_fs(seg);
 	return;
 
 fault:
@@ -469,24 +475,28 @@
 		printk(KERN_DEBUG "%s: Forwarding exception at [<%lx>] (%lx)\n",
 		       current->comm, regs->cp0_epc, new_epc);
 		regs->cp0_epc = new_epc;
+		set_fs(seg);
 		return;
 	}
 
 	die_if_kernel ("Unhandled kernel unaligned access", regs);
 	send_sig(SIGSEGV, current, 1);
 
+	set_fs(seg);
 	return;
 
 sigbus:
 	die_if_kernel("Unhandled kernel unaligned access", regs);
 	send_sig(SIGBUS, current, 1);
 
+	set_fs(seg);
 	return;
 
 sigill:
 	die_if_kernel("Unhandled kernel unaligned access or invalid instruction", regs);
 	send_sig(SIGILL, current, 1);
 
+	set_fs(seg);
 	return;
 }
 

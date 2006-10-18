Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2006 23:38:23 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:51653 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038827AbWJRWiV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Oct 2006 23:38:21 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k9IMcejD011619;
	Wed, 18 Oct 2006 23:38:41 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k9IMcdHo011618;
	Wed, 18 Oct 2006 23:38:39 +0100
Date:	Wed, 18 Oct 2006 23:38:39 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Nicolas Schichan <nschichan@freebox.fr>
Cc:	linux-mips@linux-mips.org
Subject: Re: [patch] [RFC] Kexec on MIPS
Message-ID: <20061018223839.GA11263@linux-mips.org>
References: <200610181514.56081.nschichan@freebox.fr> <20061018143129.GB3498@linux-mips.org> <200610182321.21299.nschichan@freebox.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610182321.21299.nschichan@freebox.fr>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 18, 2006 at 11:21:21PM +0200, Nicolas Schichan wrote:

One more problem:

+       sys     sys_kexec_load          1

The last column is the number of arguments slots of the syscall as counted
by the MIPS argument passing conventions, so this should actually be 4.
Not this was actually a harmless bug; it does hurt for syscalls that need
more than 4 slots.

Then buglets with O32 / N32 ABIs on 64-bit kernels:

diff -Nru linux-orig/arch/mips/kernel/scall64-n32.S linux-work/arch/mips/kernel/scall64-n32.S
--- linux-orig/arch/mips/kernel/scall64-n32.S   2006-10-14 05:34:03.000000000 +0200
+++ linux-work/arch/mips/kernel/scall64-n32.S   2006-10-17 15:58:59.000000000 +0200
@@ -392,3 +392,4 @@
        PTR     sys_tee
        PTR     sys_vmsplice                    /* 6271 */
        PTR     sys_move_pages
+       PTR     sys_kexec_load
diff -Nru linux-orig/arch/mips/kernel/scall64-o32.S linux-work/arch/mips/kernel/scall64-o32.S
--- linux-orig/arch/mips/kernel/scall64-o32.S   2006-10-14 05:34:03.000000000 +0200
+++ linux-work/arch/mips/kernel/scall64-o32.S   2006-10-17 15:59:23.000000000 +0200
@@ -514,4 +514,5 @@
        PTR     sys_tee
        PTR     sys_vmsplice
        PTR     compat_sys_move_pages
+       PTR     sys_kexec_load
        .size   sys_call_table,.-sys_call_table

That is these two being 32-bit syscalls on a 64-bit kernel need to use the
compat_sys_kexec_load syscall wrapper to work right.

And finally there are the syscall numbers.  The ones you've picked are
already taken, so I've choosen:

	O32 ABI: 4311
	N64 ABI: 5270
	N32 ABI: 6270

Note I'll allocate these syscalls immediately to give ABI stability - it's
a standard Linux syscall afterall.  So you can drop the unistd.h bits from
your patch.

And finally:

diff -Nru linux-orig/Makefile linux-work/Makefile
--- linux-orig/Makefile 2006-10-14 05:34:03.000000000 +0200
+++ linux-work/Makefile 2006-10-17 16:09:02.000000000 +0200

You may want to drop that part from your patch, too ;-)

  Ralf

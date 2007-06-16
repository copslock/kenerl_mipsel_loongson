Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Jun 2007 18:02:04 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:64419 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023022AbXFQRB4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 17 Jun 2007 18:01:56 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5HGsHl8031402;
	Sun, 17 Jun 2007 17:54:29 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5GJXxv1014176;
	Sat, 16 Jun 2007 20:33:59 +0100
Date:	Sat, 16 Jun 2007 20:33:59 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sadarul Firos <sadarul.firos@nestgroup.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: "Segfault/illegal instruction" - udevd - ntpd - glibc
Message-ID: <20070616193358.GA22195@linux-mips.org>
References: <9A1299C7A40D7447A108107E951450CA01C9E015@MAIL-TVM.tvm.nestgroup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9A1299C7A40D7447A108107E951450CA01C9E015@MAIL-TVM.tvm.nestgroup.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 15, 2007 at 09:23:34PM +0530, Sadarul Firos wrote:

> I am working with two MIPS based boards (one is MIPS and the other is
> MIPSEL) running linux-2.6.18/glibc-2.3.5. I am performing a consecutive
> reboot test on these boards. After some number of reboots (say 80) I  am
> getting "segmentaion fault/illegal instruction" while running udevd and
> ntpd during bootup. Upon observing the core dump, it is noted that the
> segfault occured from the _init function of libnss_dns.so (in the case
> of ntpd) and libnss_compat.so (in the case of udevd). I assume that
> there might be a problem somewhere in the call_init function in
> glibc-2.3.5/elf/dl-init.c. After I put some printf statements for
> debugging in the call_init function, there is no segfault/illegal
> instruction in the reboot testing. I have also used gdb to debug the
> problem but the "segfault/illegal instruction" doesn't occur during the
> reboot test. Could anyone please help me to sort out this problem. The
> gdb output using coredump is attached.

Normally the address space layout and most other variables during a
program load should be identical each time so userspace should behave
identical.   So I sense the scent of a TLB or more likely cache managment
problem.

What 2.6.18 variant exactly are you running, that is where & when did
download it, what CPU?

  Ralf

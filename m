Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jul 2003 20:05:12 +0100 (BST)
Received: from oswego.oswego.edu ([IPv6:::ffff:129.3.1.1]:32145 "EHLO
	oswego.oswego.edu") by linux-mips.org with ESMTP
	id <S8225208AbTG1TFJ>; Mon, 28 Jul 2003 20:05:09 +0100
Received: from rocky.oswego.edu (rocky.oswego.edu [129.3.1.36])
	by oswego.oswego.edu (8.12.9+Sun/8.12.9) with ESMTP id h6SJ54aP025198;
	Mon, 28 Jul 2003 15:05:04 -0400 (EDT)
Received: from rocky.oswego.edu (localhost [127.0.0.1])
	by rocky.oswego.edu (8.12.9+Sun/8.12.9) with ESMTP id h6SJ54M7015019;
	Mon, 28 Jul 2003 15:05:04 -0400 (EDT)
Received: from localhost (wjhun@localhost)
	by rocky.oswego.edu (8.12.9+Sun/8.12.9/Submit) with ESMTP id h6SJ536B015014;
	Mon, 28 Jul 2003 15:05:03 -0400 (EDT)
X-Authentication-Warning: rocky.oswego.edu: wjhun owned process doing -bs
Date: Mon, 28 Jul 2003 15:05:03 -0400 (EDT)
From: William Jhun <wjhun@Oswego.EDU>
To: Louis Hamilton <hamilton@redhat.com>
cc: <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [patch] Mips64 Ocelot-C and Jaguar ATX platform support
In-Reply-To: <3F1F0BDC.8040609@redhat.com>
Message-ID: <Pine.SOL.4.30.0307281503540.7737-100000@rocky.oswego.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <wjhun@Oswego.EDU>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wjhun@Oswego.EDU
Precedence: bulk
X-list: linux-mips

Louis,

Using Ralf's pre-packaged mips64 gcc 2.95.4 / binutils 2.13.2.1 .rpm, I
wasn't able to get this to build without having CPU-specific gcc opts
(patch below, please verify what flags are appropriate). Also, shouldn't

define_bool CONFIG_BOOT_ELF32 y

be in the config-shared.in in the jaguar section? I cannot link
otherwise...

At this point (with latest linux_2_4 tree), I can boot the kernel but get
a hang after mounting NFS root via the gt64340 eth0. If I can find a
serial cable for the second port, I might try to step with kgdb...

Thanks,
Will

Index: arch/mips64/Makefile
===================================================================
RCS file: /home/cvs/linux/arch/mips64/Makefile,v
retrieving revision 1.22.2.34
diff -U3 -r1.22.2.34 Makefile
--- arch/mips64/Makefile        5 Jul 2003 13:17:04 -0000       1.22.2.34
+++ arch/mips64/Makefile        28 Jul 2003 18:37:47 -0000
@@ -79,6 +79,9 @@
 #CFLAGS                += -mips64      # Should be used then we get a
MIPS64 compiler
 CFLAGS         += -mcpu=r8000 -mips4
 endif
+ifdef CONFIG_CPU_RM9000
+GCCFLAGS       += -mcpu=r8000 -mips4
+endif

 #
 # We unconditionally build the math emulator

On Wed, 23 Jul 2003, Louis Hamilton wrote:

> Ralf,
>
> Here is 64-bit support for both the RM7000-based Ocelot-C and
> RM9000-based Jaguar ATX platforms.
> Since the port was 2.4.21 based, this patch submission is for the 2.4 tree.
> This patch supersedes the Ocelot-C patch I sent earlier, since it
> encompasses both platforms.
>
> Notes the board support lives under arch/mips/momentum.
> Also, CONFIG_BOARD_SCACHE and CONFIG_RM7000_CPU_SCACHE are utilized and
> integrated into each platform's default configuration files.
> As in the first patch, drivers/net/mv64340_eth.{c,h} is added to provide
> ethernet support.
>
> If it looks ok, please check changes into the tree.
>
> Regards,
> Louis
>
> Louis Hamilton
> Red Hat, Inc.
>
>

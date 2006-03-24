Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2006 21:25:49 +0000 (GMT)
Received: from w099.z064220152.sjc-ca.dsl.cnc.net ([64.220.152.99]:55752 "EHLO
	duck.specifix.com") by ftp.linux-mips.org with ESMTP
	id S8133917AbWCXVZk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Mar 2006 21:25:40 +0000
Received: from [127.0.0.1] (duck.corp.specifix.com [192.168.1.1])
	by duck.specifix.com (Postfix) with ESMTP
	id 0E1FB41E5; Fri, 24 Mar 2006 13:35:40 -0800 (PST)
Subject: Re: Compilation problem with kernel 2.4.16
From:	James E Wilson <wilson@specifix.com>
To:	dhunjukrishna@gmail.com
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060324082842.68469.qmail@web53506.mail.yahoo.com>
References: <20060324082842.68469.qmail@web53506.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1143236139.13187.55.camel@aretha.corp.specifix.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date:	Fri, 24 Mar 2006 13:35:40 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <wilson@specifix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@specifix.com
Precedence: bulk
X-list: linux-mips

On Fri, 2006-03-24 at 00:28, Krishna wrote:
> scripts/basic/fixdep.c: In function `print_deps':
> scripts/basic/fixdep.c:336: warning: unused variable `map'
> /home1/guest/vikram/COMPILER/specifix/broadcom_2004e_341/i686-pc-linux-gnu/bin/../lib/gcc/sb1-elf/3.4.1/../../../../sb1-elf/bin/ld: warning: cannot find entry symbol _start; defaulting to 0000000000400040

You apparently have something like
HOSTCC=sb1-elf-gcc
in your linux kernel Makefile.  This will not work.  The host compiler
is the compiler for the machine that you are building the linux kernel
on.  This will normally be just "cc" or "gcc".

The other problem is that you have apparently set CROSS-COMPILE to
sb1-elf- which will also not work.  This must be either mips-linux- or
mips64-linux- (if you want a 64-bit kernel) as others have already
mentioned.

You can use the specifix toolchain release to build the linux kernel. 
However, you can't use the sb1-elf binaries.  These are only for
building embedded applications that run on top of CFE without an OS.  To
build the linux kernel, you need to grab the sources (which are just FSF
gcc-3.4.x with some SB-1 support backported), configure them for
mips-linux (or mips64-linux), and then build and install them.  You can
then use this compile to build the linux kernel.

There is a learning curve here if you have never done this before. 
There is probably a FAQ somewhere that explains how to do this.  I don't
know offhand where to look for linux kernel building FAQs.  Perhaps
someone else can point you at one.
-- 
Jim Wilson, GNU Tools Support, http://www.specifix.com

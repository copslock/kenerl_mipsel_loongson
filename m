Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Feb 2003 03:46:01 +0000 (GMT)
Received: from zok.sgi.com ([IPv6:::ffff:204.94.215.101]:5771 "EHLO
	zok.sgi.com") by linux-mips.org with ESMTP id <S8225195AbTBJDqB>;
	Mon, 10 Feb 2003 03:46:01 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by zok.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h1A2r5Kp003942;
	Sun, 9 Feb 2003 18:53:06 -0800
Received: from pureza.melbourne.sgi.com (pureza.melbourne.sgi.com [134.14.55.244]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id OAA16613; Mon, 10 Feb 2003 14:45:52 +1100
Received: from pureza.melbourne.sgi.com (localhost.localdomain [127.0.0.1])
	by pureza.melbourne.sgi.com (8.12.5/8.12.5) with ESMTP id h1A3jp8G023226;
	Mon, 10 Feb 2003 14:45:52 +1100
Received: (from clausen@localhost)
	by pureza.melbourne.sgi.com (8.12.5/8.12.5/Submit) id h1A3jnGc023224;
	Mon, 10 Feb 2003 14:45:49 +1100
Date: Mon, 10 Feb 2003 14:45:49 +1100
From: Andrew Clausen <clausen@melbourne.sgi.com>
To: Linux-MIPS <linux-mips@linux-mips.org>
Cc: Guido Guenther <agx@sigxcpu.org>
Subject: porting arcboot
Message-ID: <20030210034549.GA8408@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <clausen@pureza.melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

Hi all,

I'm planning to try porting arcboot to ip27 (mips64).

I plan to do this by cross-compiling... this is actually the only
option since there's no 64 bit userland yet.

Some issues:

 * I'll be cross-compiling (using the mips64-linux-gcc & friends that
are provided on ftp.linux-mips.org), which means some makefile hacking...

 * there's no mips64-linux glibc, which means no libc headers are
available.  So I need to either cut&paste libc headers, or remove
dependencies on them.  This affects lots of code.

 * the e2fs stuff... how is this being maintained?  It uses libc
headers a bit... can I kill them?  Or will this make it hard to update
to new upstream e2fsprogs releases?

Anything else?

Cheers,
ANdrew

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Feb 2003 22:40:11 +0000 (GMT)
Received: from zok.sgi.com ([IPv6:::ffff:204.94.215.101]:49296 "EHLO
	zok.sgi.com") by linux-mips.org with ESMTP id <S8225230AbTBJWkK>;
	Mon, 10 Feb 2003 22:40:10 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by zok.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h1ALlDKp007684;
	Mon, 10 Feb 2003 13:47:14 -0800
Received: from pureza.melbourne.sgi.com (pureza.melbourne.sgi.com [134.14.55.244]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id JAA25799; Tue, 11 Feb 2003 09:39:58 +1100
Received: from pureza.melbourne.sgi.com (localhost.localdomain [127.0.0.1])
	by pureza.melbourne.sgi.com (8.12.5/8.12.5) with ESMTP id h1AMdv8G029642;
	Tue, 11 Feb 2003 09:39:57 +1100
Received: (from clausen@localhost)
	by pureza.melbourne.sgi.com (8.12.5/8.12.5/Submit) id h1AMdtu7029639;
	Tue, 11 Feb 2003 09:39:55 +1100
Date: Tue, 11 Feb 2003 09:39:55 +1100
From: Andrew Clausen <clausen@melbourne.sgi.com>
To: Guido Guenther <agx@gandalf.physik.uni-konstanz.de>
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: porting arcboot
Message-ID: <20030210223955.GF8408@pureza.melbourne.sgi.com>
References: <20030210034549.GA8408@pureza.melbourne.sgi.com> <20030210100319.GA30624@merry>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030210100319.GA30624@merry>
User-Agent: Mutt/1.4i
Return-Path: <clausen@pureza.melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

On Mon, Feb 10, 2003 at 11:03:19AM +0100, Guido Guenther wrote:
> E2fslib will move out of arcboot with the next release and arcboot will
> link against the non pic version in the debian archive. I'd really like
> to keep e2fslib out of arcboot (at least for the debian version which is
> quiet different from the oss.sgi.com version).

Ah, ok.  Now we're just stuck with the problem that we can't build
e2fsprogs for misp64, since we don't have the toolchain for it.

e2fsprogs looks like it resists cross-compiling also :(

So, the obstacles are:
 * e2fsprogs uses libc headers quite extensively, but there is no
glibc available for mips64 (right?).  It also seems to make quite a
few libc calls?  (How are you planning to deal with that?  Link
against it statically?  What about syscalls?)
 * e2fsprogs doesn't use autoconf/automake "properly".  It doesn't seem
to support cross-compiling.  Adding cross-compile support looks
somewhat non-trivial, since it builds it's own tools to compile itself.
(A fancy sed replacement, for some reason?)
 * there is no toolchain to build e2fsprogs on mips64 cleanly... need
to do that objcopy business.  This means hacking the build process?

> There should't be many
> libc header dependencies left then. If there are still any I'd be happy
> to kill them.

:)

Cheers,
Andrew

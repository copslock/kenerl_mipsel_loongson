Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Feb 2003 05:04:05 +0000 (GMT)
Received: from rj.sgi.com ([IPv6:::ffff:192.82.208.96]:20705 "EHLO rj.sgi.com")
	by linux-mips.org with ESMTP id <S8225225AbTBLFEE>;
	Wed, 12 Feb 2003 05:04:04 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by rj.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h1C340G8007515;
	Tue, 11 Feb 2003 19:04:01 -0800
Received: from pureza.melbourne.sgi.com (pureza.melbourne.sgi.com [134.14.55.244]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id QAA11344; Wed, 12 Feb 2003 16:03:47 +1100
Received: from pureza.melbourne.sgi.com (localhost.localdomain [127.0.0.1])
	by pureza.melbourne.sgi.com (8.12.5/8.12.5) with ESMTP id h1C53g8G027321;
	Wed, 12 Feb 2003 16:03:44 +1100
Received: (from clausen@localhost)
	by pureza.melbourne.sgi.com (8.12.5/8.12.5/Submit) id h1C53fFE027319;
	Wed, 12 Feb 2003 16:03:41 +1100
Date: Wed, 12 Feb 2003 16:03:41 +1100
From: Andrew Clausen <clausen@melbourne.sgi.com>
To: Florian Lohoff <flo@rfc822.org>
Cc: Guido Guenther <agx@gandalf.physik.uni-konstanz.de>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: porting arcboot
Message-ID: <20030212050341.GI8408@pureza.melbourne.sgi.com>
References: <20030210034549.GA8408@pureza.melbourne.sgi.com> <20030210100319.GA30624@merry> <20030210223955.GF8408@pureza.melbourne.sgi.com> <20030211224622.GC1186@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030211224622.GC1186@paradigm.rfc822.org>
User-Agent: Mutt/1.4i
Return-Path: <clausen@pureza.melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

On Tue, Feb 11, 2003 at 11:46:22PM +0100, Florian Lohoff wrote:
> You dont need e2fsprogs

Right, just they seem so coupled...

> - Just certain parts of the libe2fs which itself
> just uses some very basic libc functions like malloc/free/str* which
> we all have within arcboot.

I disagree.

libe2fs includes lots of headers:

	pureza:~/e2fsprogs-1.32/lib$ find . | grep '\.[ch]$' | xargs grep -h "#include <" | sort | uniq | wc -l
	     77

Also, running nm gives libc calls that invoke syscalls galore.
For example:

	open64, close, ioctl, opendir, fprintf, getmntent, lseek64, time

I got these names from:

	pureza:~/e2fsprogs-1.32/lib$ nm libext2fs.a | grep '^ *U' | less

Am I missing something?

>  So you simple need to cross-compile the libe2fs.

That seems *hard*.

Cheers,
Andrew

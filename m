Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Feb 2003 22:56:34 +0000 (GMT)
Received: from zok.SGI.COM ([IPv6:::ffff:204.94.215.101]:63711 "EHLO
	zok.sgi.com") by linux-mips.org with ESMTP id <S8224939AbTBCW4d>;
	Mon, 3 Feb 2003 22:56:33 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by zok.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h13M3OKp032202;
	Mon, 3 Feb 2003 14:03:25 -0800
Received: from pureza.melbourne.sgi.com (pureza.melbourne.sgi.com [134.14.55.244]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id JAA13568; Tue, 4 Feb 2003 09:56:28 +1100
Received: from pureza.melbourne.sgi.com (localhost.localdomain [127.0.0.1])
	by pureza.melbourne.sgi.com (8.12.5/8.12.5) with ESMTP id h13Mu2Md019955;
	Tue, 4 Feb 2003 09:56:02 +1100
Received: (from clausen@localhost)
	by pureza.melbourne.sgi.com (8.12.5/8.12.5/Submit) id h13Mu1JR019953;
	Tue, 4 Feb 2003 09:56:01 +1100
Date: Tue, 4 Feb 2003 09:56:01 +1100
From: Andrew Clausen <clausen@melbourne.sgi.com>
To: Jason Ormes <jormes@wideopenwest.com>
Cc: linux-mips@linux-mips.org
Subject: Re: debian's mips userland on mips64
Message-ID: <20030203225601.GG967@pureza.melbourne.sgi.com>
References: <20030122073006.GF6262@pureza.melbourne.sgi.com> <002001c2cba5$ab641320$4437e183@fermi.win.fnal.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002001c2cba5$ab641320$4437e183@fermi.win.fnal.gov>
User-Agent: Mutt/1.4i
Return-Path: <clausen@pureza.melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

On Mon, Feb 03, 2003 at 10:59:52AM -0600, Jason Ormes wrote:
> I happened to see that you were running on an origin 200. I'm currently
> trying to build a kernel for an origin 200 that I have laying around and
> am getting a bunch of errors in the ip27-init.c file.  Is there some
> magic combination of flags when I build this?

I've been using 2.4.x cvs.  What error do you get?  Please post
to the list!

I've been compiling with:

	alias mipsmake='make CROSS_COMPILE=mips64-linux ARCH=mips64'
	mipsmake clean
	mipsmake menuconfig	<-- select arch/mips64/defconfig-ip27
	mipsmake vmlinux.64

>   You mention that you are
> using the mips64-linux kernel but when I turn on ip27 support it wants
> to build a little endian version?  Any help you could give me would be
> gratefully appreciated.

Doesn't for me...

Cheers,
Andrew

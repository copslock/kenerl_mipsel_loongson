Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id OAA498124 for <linux-archive@neteng.engr.sgi.com>; Wed, 25 Feb 1998 14:14:58 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA03103 for linux-list; Wed, 25 Feb 1998 14:13:32 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA03097 for <linux@cthulhu.engr.sgi.com>; Wed, 25 Feb 1998 14:13:30 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA21854
	for <linux@cthulhu.engr.sgi.com>; Wed, 25 Feb 1998 14:13:29 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id RAA04588;
	Wed, 25 Feb 1998 17:13:29 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 25 Feb 1998 17:13:29 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Masashi Sasahara/=?ISO-2022-JP?B?GyRCOns4NkA1O0obKEI=?= <sasahm@taec.toshiba.com>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: installation problem.
In-Reply-To: <199802252154.NAA28430@sol-x86-1.taec.com>
Message-ID: <Pine.LNX.3.95.980225171236.28713C-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Wed, 25 Feb 1998, Masashi Sasahara/[ISO-2022-JP] 笹原正司 wrote:
> > I'd certainly suggest you use a different kernel.  Uh, I think there's a
> > .82 kernel kicking around on ftp.linux.sgi.com.  If not, I'll make sure
> > there is.
>   I'm using pre-compiled .72 kernel in
> ftp://ftp.linux.sgi.com/pub/test, which is working fine on my
> Irix box. However I couldn't find .82.

Aiyee.  I meant 72, not 82.  I was working on upversioning it to 82 at one
point but never finished.

>   BTW, How can I get the kernel source for Linux/SGI? Do I need
> to get from CVS tree?  I tried to compile the source .72 but, at
> least, include/asm-mips is not synchronized.

Yup, you need to get it from the CVS.

- Alex

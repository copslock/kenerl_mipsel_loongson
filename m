Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA50568 for <linux-archive@neteng.engr.sgi.com>; Fri, 17 Jul 1998 11:22:57 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA21710
	for linux-list;
	Fri, 17 Jul 1998 11:22:36 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id LAA11769;
	Fri, 17 Jul 1998 11:22:34 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id LAA12337; Fri, 17 Jul 1998 11:21:18 -0700
Date: Fri, 17 Jul 1998 11:21:18 -0700
Message-Id: <199807171821.LAA12337@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Cc: greg@xtp.engr.sgi.com (Greg Chesson), adevries@engsoc.carleton.ca,
        anubis@BanjaLuka.NET, linux@cthulhu.engr.sgi.com
Subject: Re: What about...
In-Reply-To: <m0yxF1A-000aOoC@the-village.bc.nu>
References: <9807171047.ZM18720@xtp.engr.sgi.com>
	<m0yxF1A-000aOoC@the-village.bc.nu>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alan Cox writes:
 > > many "holes"...  The idea of a simple buddy-system allocator as is
 > > ingrained in the Linux kernel falls apart completely in the face of
 > > this kind of architecture.   I suppose you could run a copy of Linux
 > > on every node, but I consider that an excuse rather than a solution.
 > 
 > Actually the Linux buddy stuff is quite happy with holes. Its still
 > completely inappropriate. From the above I deduce we'd have to do
 > mips64 before we even considerd it anyway

     Yes, the address space is very large, even in a single rack.

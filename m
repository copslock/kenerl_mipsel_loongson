Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id RAA937664 for <linux-archive@neteng.engr.sgi.com>; Fri, 9 Jan 1998 17:25:59 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA03520 for linux-list; Fri, 9 Jan 1998 17:22:18 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA03500 for <linux@cthulhu.engr.sgi.com>; Fri, 9 Jan 1998 17:22:13 -0800
Received: from multi11.netcomi.com (multi11.netcomi.com [204.58.155.211]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id RAA20922
	for <linux@cthulhu.engr.sgi.com>; Fri, 9 Jan 1998 17:22:09 -0800
	env-from (mgix@nothingreal.com)
Received: from ghoul (lax-ca39-05.ix.netcom.com [205.184.226.133]) by multi11.netcomi.com (8.8.5/8.7.3) with SMTP id TAA18011; Fri, 9 Jan 1998 19:20:47 -0600
From: "Emmanuel Mogenet" <mgix@nothingreal.com>
To: "Alex deVries" <adevries@engsoc.carleton.ca>,
        "SGI Linux" <linux@cthulhu.engr.sgi.com>
Subject: Re: RedHat 5.0 RPMs for SGI...
Date: Fri, 9 Jan 1998 17:21:31 -0800
Message-ID: <01bd1d66$153f46a0$060200c0@ghoul>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.71.1712.3
X-MimeOLE: Produced By Microsoft MimeOLE V4.71.1712.3
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



>For example, 'su' takes up 4.5MB.  This seems like an awful lot to me,
>compared to the Intel equivalent of 1MB. I know the binaries are going to
>be larger because of the RISC thing, but really that large?
>
>Is this normal?


Here, on the stuff we're working on, we experience that a DLL compiled
with visual C++ in full optimization mode is on average 2.5 times smaller
than the exact same code compiled into a DSO under IRIX 6.2 with compiler
at -O3 -n32 -mips3.

I don't know about gcc under IRIX, but I've never seen a factor of 4 pop up
before.

That seems like an awful lot.


    - Mgix

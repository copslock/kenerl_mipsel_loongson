Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id KAA48647 for <linux-archive@neteng.engr.sgi.com>; Thu, 15 Jan 1998 10:32:41 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA10964 for linux-list; Thu, 15 Jan 1998 10:30:20 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA10924 for <linux@cthulhu.engr.sgi.com>; Thu, 15 Jan 1998 10:30:14 -0800
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA23308
	for <linux@cthulhu.engr.sgi.com>; Thu, 15 Jan 1998 10:30:09 -0800
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id NAA10381;
	Thu, 15 Jan 1998 13:32:52 -0500
Date: Thu, 15 Jan 1998 13:32:52 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Michael Hill <mdhill@interlog.com>
cc: Honza Pazdziora <adelton@informatics.muni.cz>, linux@cthulhu.engr.sgi.com
Subject: Re: 2.1.72 precompiled on Linus...
In-Reply-To: <199801151344.IAA03709@mdhill.interlog.com>
Message-ID: <Pine.LNX.3.95.980115132717.4203B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Thu, 15 Jan 1998, Michael Hill wrote:
> Honza Pazdziora writes:
>  > However, after the boot (via bootp) the screen goes blank and that's
>  > it -- no boot messages come. It doesn't however crash visibly as the
>  > yesL2.
> The result here is the same (noL2 version).

The with-L2 version worked on my machine, but it never put anything on the
console.  I didn't notice that the first time because in the end it booted
just fine.

Uh, let me have another look at the config...

- A

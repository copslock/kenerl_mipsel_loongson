Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id OAA214053 for <linux-archive@neteng.engr.sgi.com>; Thu, 12 Feb 1998 14:02:10 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA22747 for linux-list; Thu, 12 Feb 1998 14:01:01 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id OAA22732 for <linux@cthulhu.engr.sgi.com>; Thu, 12 Feb 1998 14:00:58 -0800
Received: from chiara.csoma.elte.hu (chiara.csoma.elte.hu [157.181.71.18]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id OAA00956
	for <linux@cthulhu.engr.sgi.com>; Thu, 12 Feb 1998 14:00:55 -0800
	env-from (mingo@chiara.csoma.elte.hu)
Received: from localhost (mingo@localhost)
	by chiara.csoma.elte.hu (8.8.5/8.8.5) with SMTP id XAA05135;
	Thu, 12 Feb 1998 23:00:09 +0100
Date: Thu, 12 Feb 1998 23:00:09 +0100 (CET)
From: MOLNAR Ingo <mingo@chiara.csoma.elte.hu>
To: David Woodhouse <Dave@imladris.demon.co.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, ralf@uni-koblenz.de,
        linux-kernel@vger.rutgers.edu, linux@cthulhu.engr.sgi.com
Subject: Re: TLB entries > 4kb 
In-Reply-To: <E0y36YO-00042j-00@imladris.demon.co.uk>
Message-ID: <Pine.LNX.3.96.980212225556.4223D-100000@chiara.csoma.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Thu, 12 Feb 1998, David Woodhouse wrote:

> GGI (well, KGI) should be able to fix both of these, shouldn't it?

the hw virtualization (cli/sti) thing yes, but the 4MB thing not, as
GGILib lives in user-space, GGI does not spend too much time in the
kernel, rendering is done in user-space.

but i suspect things doing direct rendering like Quake could benefit from
4MB pages big time. For this we have to implement ring-0 processes though
... XFree86 is nicely accelerated (and the accelerator chip has no
business with the CPU).

-- mingo

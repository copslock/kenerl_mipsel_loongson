Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA48693 for <linux-archive@neteng.engr.sgi.com>; Wed, 25 Nov 1998 12:46:42 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA53947
	for linux-list;
	Wed, 25 Nov 1998 12:45:54 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from xtp.engr.sgi.com (xtp.engr.sgi.com [150.166.75.34])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id MAA34822
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 25 Nov 1998 12:45:52 -0800 (PST)
	mail_from (greg@xtp.engr.sgi.com)
Received: by xtp.engr.sgi.com (950413.SGI.8.6.12/911001.SGI)
	 id MAA23962; Wed, 25 Nov 1998 12:43:31 -0800
From: "Greg Chesson" <greg@xtp.engr.sgi.com>
Message-Id: <9811251243.ZM23960@xtp.engr.sgi.com>
Date: Wed, 25 Nov 1998 12:43:31 -0800
In-Reply-To: Jeffrey Watts <watts@sunflower.com>
        "Re: help offered" (Nov 25,  2:11pm)
References: <Pine.LNX.4.02.9811251408240.27356-100000@violet.jayhawks.net>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: Jeffrey Watts <watts@sunflower.com>, Olivier Galibert <galibert@pobox.com>
Subject: Re: help offered
Cc: linux@cthulhu.engr.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Small systems have a much lower failure rate than large (128p) systems.
This is for software as well as hardware.

There have been improvements in all hw failure modes in the last
year.  The most common failure is memory.  This is no suprise since there
are statistically 10X more memory components in a system compared to everything
else.  The second most common failure is power supplies.  The power supplies
have been reengineered.  New systems have the new supplies.  Systems
in the field are upgraded when there are problems.

Although all systems are burned in and tested before leaving the factory,
they can suffer damage by the time they arrive at a new site.  Although the
DOA rate is low, it is still non-zero.

Once a system is installed and any infant mortality problems have been
solved, the probability for continuous operation is very high.
Bad power, frequent reconfigurations, moving cables and boards about
can cause problems with any system.

g

-- 
Greg Chesson

Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id IAA241283 for <linux-archive@neteng.engr.sgi.com>; Thu, 4 Dec 1997 08:52:12 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA13511 for linux-list; Thu, 4 Dec 1997 08:51:42 -0800
Received: from xtp.engr.sgi.com (xtp.engr.sgi.com [150.166.75.34]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA13493 for <linux@cthulhu.engr.sgi.com>; Thu, 4 Dec 1997 08:51:40 -0800
Received: by xtp.engr.sgi.com (950413.SGI.8.6.12/911001.SGI)
	 id IAA07616; Thu, 4 Dec 1997 08:51:27 -0800
From: "Greg Chesson" <greg@xtp.engr.sgi.com>
Message-Id: <9712040851.ZM7614@xtp.engr.sgi.com>
Date: Thu, 4 Dec 1997 08:51:26 -0800
In-Reply-To: Lige Hensley <ligeh@carpediem.com>
        "Re: Linux on the O2" (Dec  4, 12:39am)
References: <Pine.SGI.3.96.971204001929.20475A-100000@barramunda>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: Lige Hensley <ligeh@carpediem.com>, Chris Carlson <cwcarlson@home.com>
Subject: Re: Linux on the O2
Cc: linux@cthulhu.engr.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Mips does quite well with cpus in the embedded systems area: about
35 Million components/year at recent count.  This area accounts for
good revenue for Mips and its vlsi partners.

The R12000, which is an improved R10000, and its planned shrinks
and process upgrades are competitive with other processors in all areas
except for extreme floating point.  Mips had a best-of-breed raw floating
point cpu project that was cancelled because it was deemed not competitive
enough in integer performance to serve in all but a few platforms.

Mips processors tend to be employed with more powerful cache and memory
and io subsystems than equivalent Intel parts.  This natually leads
to differences in cost/price.

Another little-appreciated factoid: in order to comply with Intel specs
for system transceiver components used with high-performance Intel cpus,
one needs to use a $25 component.
Nearly all cheap/fast motherboards use a $2 component that works
"most of the time."

g

Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA54587 for <linux-archive@neteng.engr.sgi.com>; Thu, 18 Mar 1999 04:52:41 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA81185
	for linux-list;
	Thu, 18 Mar 1999 04:50:14 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA93020
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 18 Mar 1999 04:50:12 -0800 (PST)
	mail_from (mike@mdhill.genxl.com)
Received: from mdhill.genxl.com ([142.154.27.29]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id EAA03588
	for <linux@cthulhu.engr.sgi.com>; Thu, 18 Mar 1999 04:50:10 -0800 (PST)
	mail_from (mike@mdhill.genxl.com)
Received: (from mike@localhost) by mdhill.genxl.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id HAA01475; Thu, 18 Mar 1999 07:45:44 -0500
From: "Michael Hill" <mike@mdhill.genxl.com>
Message-Id: <9903180745.ZM1473@mdhill.genxl.com>
Date: Thu, 18 Mar 1999 07:45:43 -0500
In-Reply-To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
        "newport console problems, some hardware questions" (Mar 15, 10:03pm)
References: <19990315220341.C2301@alpha.franken.de>
Reply-to: mdhill@genxl.com
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux@cthulhu.engr.sgi.com
Subject: Re: newport console problems, some hardware questions
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mar 15, 10:03pm, Thomas Bogendoerfer wrote:

> Ok, I finally found the reason for the video corruptions with the new
> newport console some reported to me. It happens only, when there are
> less than 1024 scanlines on the screen. My fix is to enable the
> faster scrolling only with 1024 scanline screen modes. This slows
> down scrolling, and I hope there is a better solution (but I doubt it).

This works well, Thomas.  Now I can see what's happening on the screen.  I
haven't run into any problems with the scrolling speed yet (I don't notice a
difference just by watching it).

Mike

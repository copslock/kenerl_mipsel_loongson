Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA88274 for <linux-archive@neteng.engr.sgi.com>; Tue, 26 Jan 1999 08:57:46 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA63316
	for linux-list;
	Tue, 26 Jan 1999 08:56:54 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from xtp.engr.sgi.com (xtp.engr.sgi.com [150.166.75.34])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id IAA78143
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 26 Jan 1999 08:56:53 -0800 (PST)
	mail_from (greg@xtp.engr.sgi.com)
Received: by xtp.engr.sgi.com (950413.SGI.8.6.12/911001.SGI)
	for linux@cthulhu id IAA02560; Tue, 26 Jan 1999 08:56:52 -0800
From: "Greg Chesson" <greg@xtp.engr.sgi.com>
Message-Id: <9901260856.ZM2558@xtp.engr.sgi.com>
Date: Tue, 26 Jan 1999 08:56:52 -0800
In-Reply-To: Marco Masotti <masotti@mclink.it>
        "An X server for the  1600SW Flat Panel (Or just to get X right away)" (Jan 26,  4:09pm)
References: 1.0.1.199901261608.8803@mclink.it
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: linux@cthulhu.engr.sgi.com
Subject: Re: An X server for the  1600SW Flat Panel (Or just to get X right away)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Jan 26,  4:09pm, Marco Masotti wrote:
> Subject: An X server for the  1600SW Flat Panel (Or just to get X right aw
>
>
> Hi,
>
> I just was wondering whether this option would be a thinkable way to an  X
server, of course in case one would go for the LCD Flat Panel onto the Visual
WS.
>
> I mean, putting the Number Nine card in a Pci slot and then running the
commercial X server off the current ported Linux.
>
>   http://www.accelerated-x.com/media/announce.html
>
>  Thanks, Marco
>-- End of excerpt from Marco Masotti


This probably works.
I've seen a PCI/Nine board working with the 1600 display
on a commodity box in the display lab.  It was not running Linux so I can't
comment on that.  But the display and demos seemed to operate as well
as on the SGI 320 running the same software side-by-side.

The missing piece for me is having hardware-accelerated OpenGL
working on that combination.  I don't think we'll see that until sometime
after the open-GLX work is complete.

g


-- 
Greg Chesson

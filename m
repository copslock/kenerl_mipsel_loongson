Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA00780 for <linux-archive@neteng.engr.sgi.com>; Wed, 23 Dec 1998 09:52:22 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA95500
	for linux-list;
	Wed, 23 Dec 1998 09:51:41 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from xtp.engr.sgi.com (xtp.engr.sgi.com [150.166.75.34])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id JAA93451;
	Wed, 23 Dec 1998 09:51:39 -0800 (PST)
	mail_from (greg@xtp.engr.sgi.com)
Received: by xtp.engr.sgi.com (950413.SGI.8.6.12/911001.SGI)
	 id JAA05338; Wed, 23 Dec 1998 09:51:37 -0800
From: "Greg Chesson" <greg@xtp.engr.sgi.com>
Message-Id: <9812230951.ZM5336@xtp.engr.sgi.com>
Date: Wed, 23 Dec 1998 09:51:36 -0800
In-Reply-To: Alex deVries <adevries@engsoc.carleton.ca>
        "Re: Status" (Dec 22, 10:50pm)
References: <Pine.LNX.3.96.981222224859.1946C-100000@lager.engsoc.carleton.ca>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: Alex deVries <adevries@engsoc.carleton.ca>
Subject: Re: Status
Cc: Ariel Faigon <ariel@cthulhu.engr.sgi.com>,
        Fredrik Rovik <fredrov@hotmail.com>, linux@cthulhu.engr.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Indy, I2, and Challenge-S are all related.
Challenge-S is an Indy (small blue box) with the media stuff removed,
with basically the same motherboard.  I don't know for sure whether
it has the extra SCSI channel like the I2.  The I2 is a different
motherboard in a larger (than Indy) box.  Core chipsets are the same.

What we need to do is make it easy for Linux to determine what
chipsets are attached to the cpu.  Bill Earl might have some straightforward
answers.  I'm in favor of simply publishing the relevant sections
of Irix bootstrap code.  Perhaps Santa Claus can make a code drop this year.

g

-- 
Greg Chesson

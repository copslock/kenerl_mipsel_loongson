Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA55719 for <linux-archive@neteng.engr.sgi.com>; Wed, 25 Nov 1998 13:08:31 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA50927
	for linux-list;
	Wed, 25 Nov 1998 13:07:22 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from xtp.engr.sgi.com (xtp.engr.sgi.com [150.166.75.34])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id NAA94734;
	Wed, 25 Nov 1998 13:07:19 -0800 (PST)
	mail_from (greg@xtp.engr.sgi.com)
Received: by xtp.engr.sgi.com (950413.SGI.8.6.12/911001.SGI)
	 id NAA24038; Wed, 25 Nov 1998 13:04:48 -0800
From: "Greg Chesson" <greg@xtp.engr.sgi.com>
Message-Id: <9811251304.ZM24036@xtp.engr.sgi.com>
Date: Wed, 25 Nov 1998 13:04:47 -0800
In-Reply-To: alan@lxorguk.ukuu.org.uk (Alan Cox)
        "Re: help offered" (Nov 25,  9:46pm)
References: <m0zimlz-0007U1C@the-village.bc.nu>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: alan@lxorguk.ukuu.org.uk (Alan Cox), ariel@cthulhu.engr.sgi.com
Subject: Re: help offered
Cc: galibert@pobox.com, linux@cthulhu.engr.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

One definition of OS scalability that I have not seen
in general use is this:

	an OS scales to S number of processors if all S processors
	can be executing in the kernel at the same time.

An OS that scales to S active kernels can usually operate hardware
with P processors, where P > S.  A system for 1P should
be able to handle 2P with a little work.  I expect a lightweight kernel
like Linux to handle 4p with a few locks if on average only one of the
4p is in the kernel.  I'd suggest that the LInux kernel is at present
(1S, 4p) or maybe (1.5S, 4P).

g

-- 
Greg Chesson

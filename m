Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id WAA65700 for <linux-archive@neteng.engr.sgi.com>; Wed, 21 Jan 1998 22:12:00 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA07461 for linux-list; Wed, 21 Jan 1998 22:11:25 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA07457 for <linux@cthulhu.engr.sgi.com>; Wed, 21 Jan 1998 22:11:23 -0800
Received: from netscape.com (h-205-217-237-46.netscape.com [205.217.237.46]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id WAA23415
	for <linux@cthulhu.engr.sgi.com>; Wed, 21 Jan 1998 22:11:23 -0800
	env-from (shaver@netscape.com)
Received: from dredd.mcom.com (dredd.mcom.com [205.217.237.54])
	by netscape.com (8.8.5/8.8.5) with ESMTP id WAA03384
	for <linux@cthulhu.engr.sgi.com>; Wed, 21 Jan 1998 22:11:22 -0800 (PST)
Received: from netscape.com ([208.12.32.37]) by dredd.mcom.com
          (Netscape Messaging Server 3.0)  with ESMTP id AAA17258;
          Wed, 21 Jan 1998 22:11:22 -0800
Message-ID: <34C6E304.680D7541@netscape.com>
Date: Thu, 22 Jan 1998 06:11:16 +0000
From: Mike Shaver <shaver@netscape.com>
Organization: Package Reflectors
X-Mailer: Mozilla 4.03 [en] (X11; U; Linux 2.0.31 i686)
MIME-Version: 1.0
To: Alex deVries <adevries@engsoc.carleton.ca>
CC: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: root-be-0.03.tar.gz
References: <Pine.LNX.3.95.980122005800.20627E-100000@lager.engsoc.carleton.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries wrote:
> Here's a question:  is it possible to boot off of the local disk without
> the image being on an EFS partition? Will I ever be able to have my
> machine have no EFS partition? How will ARC find the image?

Could we not modify sash to know about ext2?
I thought I read somewhere that we could get sash sources/info, which
would help a lot.

Mike

-- 
548137.65 541127.34

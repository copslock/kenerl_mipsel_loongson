Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA87280 for <linux-archive@neteng.engr.sgi.com>; Sat, 2 Jan 1999 11:07:39 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA11305
	for linux-list;
	Sat, 2 Jan 1999 11:06:59 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA82174
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 2 Jan 1999 11:06:57 -0800 (PST)
	mail_from (shaver@netscape.com)
Received: from netscape.com (h-205-217-237-46.netscape.com [205.217.237.46]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA09795
	for <linux@cthulhu.engr.sgi.com>; Sat, 2 Jan 1999 11:06:57 -0800 (PST)
	mail_from (shaver@netscape.com)
Received: from tintin.mcom.com (tintin.mcom.com [205.217.233.42])
	by netscape.com (8.8.5/8.8.5) with ESMTP id LAA15102
	for <linux@cthulhu.engr.sgi.com>; Sat, 2 Jan 1999 11:06:55 -0800 (PST)
Received: from netscape.com ([205.217.243.67]) by
          tintin.mcom.com (Netscape Messaging Server 4.0) with ESMTP id
          F4Y53J00.HDE; Sat, 2 Jan 1999 11:06:55 -0800 
Message-ID: <368E6E9C.E286AAEB@netscape.com>
Date: Sat, 02 Jan 1999 14:08:12 -0500
From: Mike Shaver <shaver@netscape.com>
Organization: Just Another Snake Cult
X-Mailer: Mozilla 4.51 [en] (X11; I; Linux 2.1.131 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@dm.cobaltmicro.com>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: EFS volume descriptors
References: <368E66DC.15C986F2@netscape.com> <199901021850.KAA07779@dm.cobaltmicro.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

"David S. Miller" wrote:
> Have a look at /usr/include/sys/dvh.h on an IRIX system for
> enlightenment.

I took a look there before (and again as well), but it didn't leave me
feeling confident about partitions.  Everything in there seems to talk
about the first block of the device, which I took to be /dev/sda rather
than /dev/sda1 (say).  When people are mounting the CDROM, they'll be
mounting the ``whole'' device, so block 0 is full of voldesc goodness;
what's in block 0 of an EFS partition?  A dummy voldesc?

Mike

-- 
10073.24 9299.81

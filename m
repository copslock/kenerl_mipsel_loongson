Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA73748 for <linux-archive@neteng.engr.sgi.com>; Sun, 3 Jan 1999 14:20:14 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA05217
	for linux-list;
	Sun, 3 Jan 1999 14:19:52 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA62808
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 3 Jan 1999 14:19:50 -0800 (PST)
	mail_from (shaver@netscape.com)
Received: from netscape.com (h-205-217-237-46.netscape.com [205.217.237.46]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA00867
	for <linux@cthulhu.engr.sgi.com>; Sun, 3 Jan 1999 14:19:49 -0800 (PST)
	mail_from (shaver@netscape.com)
Received: from tintin.mcom.com (tintin.mcom.com [205.217.233.42])
	by netscape.com (8.8.5/8.8.5) with ESMTP id OAA06476
	for <linux@cthulhu.engr.sgi.com>; Sun, 3 Jan 1999 14:19:48 -0800 (PST)
Received: from netscape.com ([205.217.243.67]) by
          tintin.mcom.com (Netscape Messaging Server 4.0) with ESMTP id
          F508P000.LEY; Sun, 3 Jan 1999 14:19:48 -0800 
Message-ID: <368FED40.12D7952E@netscape.com>
Date: Sun, 03 Jan 1999 17:20:48 -0500
From: Mike Shaver <shaver@netscape.com>
Organization: Just Another Snake Cult
X-Mailer: Mozilla 4.51 [en] (X11; I; Linux 2.1.131 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Olson <olson@anchor.engr.sgi.com>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: EFS volume descriptors
References: <199901032216.OAA36969@anchor.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Dave Olson wrote:
> Nothing is at block 0 of the filesystem.  Historically, back to v6
> unix, there were things like badblock tables there, so many filesystems
> for unix have simply not used block 0.  efs does not use it.

Drat.  So do I need the user to tell me if it's an EFS CD vs. an EFS
partition, so that I know to use the voldesc or not?  I guess I could
register a second fstype ("efscd" or some such) and make the user use
that.

Mike

-- 
108334.35 92988.48

Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA65894 for <linux-archive@neteng.engr.sgi.com>; Sun, 3 Jan 1999 14:29:46 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA54402
	for linux-list;
	Sun, 3 Jan 1999 14:28:39 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA46053
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 3 Jan 1999 14:28:37 -0800 (PST)
	mail_from (shaver@netscape.com)
Received: from netscape.com (h-205-217-237-47.netscape.com [205.217.237.47]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA00816
	for <linux@cthulhu.engr.sgi.com>; Sun, 3 Jan 1999 14:28:36 -0800 (PST)
	mail_from (shaver@netscape.com)
Received: from tintin.mcom.com (tintin.mcom.com [205.217.233.42])
	by netscape.com (8.8.5/8.8.5) with ESMTP id OAA22590
	for <linux@cthulhu.engr.sgi.com>; Sun, 3 Jan 1999 14:28:35 -0800 (PST)
Received: from netscape.com ([205.217.243.67]) by
          tintin.mcom.com (Netscape Messaging Server 4.0) with ESMTP id
          F5093N00.5EU; Sun, 3 Jan 1999 14:28:35 -0800 
Message-ID: <368FEF50.22B8170@netscape.com>
Date: Sun, 03 Jan 1999 17:29:36 -0500
From: Mike Shaver <shaver@netscape.com>
Organization: Just Another Snake Cult
X-Mailer: Mozilla 4.51 [en] (X11; I; Linux 2.1.131 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Olson <olson@anchor.engr.sgi.com>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: EFS volume descriptors
References: <199901032222.OAA25109@anchor.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Dave Olson wrote:
> Look at block 0 on the disk ("absolute" block 0), and use the magic
> number to see if it's an sgi volume.  If it is, for each partition
> other than 8 and 10, check to see if block 1 is an EFS superblock.
> That's the only possible way.  For almost all (but not all!) efs
> CD's, there will only be partition 7,8,10, so you can just check
> partition 7, if you want to be lazy.

Excellent!  Thanks.

Mike

-- 
108908.71 93516.45

Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA85695 for <linux-archive@neteng.engr.sgi.com>; Sat, 2 Jan 1999 10:34:46 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA99549
	for linux-list;
	Sat, 2 Jan 1999 10:34:05 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA07986
	for <linux@engr.sgi.com>;
	Sat, 2 Jan 1999 10:34:03 -0800 (PST)
	mail_from (shaver@netscape.com)
Received: from netscape.com (h-205-217-237-47.netscape.com [205.217.237.47]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA09849
	for <linux@engr.sgi.com>; Sat, 2 Jan 1999 10:34:03 -0800 (PST)
	mail_from (shaver@netscape.com)
Received: from tintin.mcom.com (tintin.mcom.com [205.217.233.42])
	by netscape.com (8.8.5/8.8.5) with ESMTP id KAA02234
	for <linux@engr.sgi.com>; Sat, 2 Jan 1999 10:33:51 -0800 (PST)
Received: from netscape.com ([205.217.243.67]) by
          tintin.mcom.com (Netscape Messaging Server 4.0) with ESMTP id
          F4Y3KG00.VDN for <linux@engr.sgi.com>; Sat, 2 Jan 1999 10:33:52 -0800 
Message-ID: <368E66DC.15C986F2@netscape.com>
Date: Sat, 02 Jan 1999 13:35:08 -0500
From: Mike Shaver <shaver@netscape.com>
Organization: Just Another Snake Cult
X-Mailer: Mozilla 4.51 [en] (X11; I; Linux 2.1.131 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: EFS volume descriptors
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On an EFS CDROM, there's a volume descriptor at block 0.  On an EFS
partition, there's a superblock at block 1.  I'd like my all-new code to
handle both cases, so I'm wondering what's at block 0 of an EFS
partition.  Is it something that I can reliably check to see if I'm
mounting a partition or CD?

Mike

-- 
7734.79 7103.32

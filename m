Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA80487 for <linux-archive@neteng.engr.sgi.com>; Thu, 4 Feb 1999 06:39:30 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA19030
	for linux-list;
	Thu, 4 Feb 1999 06:38:42 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA95048
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 4 Feb 1999 06:38:40 -0800 (PST)
	mail_from (shaver@netscape.com)
Received: from netscape.com (h-205-217-237-47.netscape.com [205.217.237.47]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA03743
	for <linux@cthulhu.engr.sgi.com>; Thu, 4 Feb 1999 06:38:15 -0800 (PST)
	mail_from (shaver@netscape.com)
Received: from tintin.mcom.com (tintin.mcom.com [205.217.233.42])
	by netscape.com (8.8.5/8.8.5) with ESMTP id GAA15856
	for <linux@cthulhu.engr.sgi.com>; Thu, 4 Feb 1999 06:38:14 -0800 (PST)
Received: from netscape.com ([205.217.243.67]) by
          tintin.mcom.com (Netscape Messaging Server 4.01 Dec 31 1998
          03:21:10) with ESMTP id F6MWNP00.BSS; Thu, 4 Feb 1999 06:38:13 -0800 
Message-ID: <36B9B121.C84B16C3@netscape.com>
Date: Thu, 04 Feb 1999 09:39:29 -0500
From: Mike Shaver <shaver@netscape.com>
Organization: Just Another Snake Cult
X-Mailer: Mozilla 4.51 [en] (X11; I; Linux 2.2.0-pre7-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chad Streck <streckc@vbe.com>
CC: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: efs fs module
References: <36B984B1.DF661745@vbe.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Chad Streck wrote:
> I tried this questions to some people, but I was suggested to post here.

I think I was one of those people; sorry for not responding earlier. 
(Insert generic whiny excuse about travelling and mail backlog and
stuff.)

The state of the EFS code in the linus CVS tree is this:
- prior to the most recent kernel merge (to 2.1.131), the code in fs/efs
was able to mount and read EFS partitions, provided that they did not
involve indirect extents.  Symlinks and stuff all worked, although
building as a module did not.
- once I merged to 2.1.131 (and then checked in the EFS code), I started
to see very odd behaviour; specifically, the inode-mode checks for
directory/file/socket/etc. were failing in ``impossible'' ways.  I can
post more about that later, but if you've got an EFS partition handy,
just build with -DDEBUG_EFS and try to mount it.  You'll see the error
message in question.  On the bright side, module-loading works well.
- I have efslook code here as well, and was in the process of comparing
its indirect-extent algorithm to my own when I did the 2.1.131 merge of
my code, so maybe once I get past that inode-mode problem I can finish
it up?  Oh, to dream.

Hope that helps answer your question.

Mike

-- 
243311.90 206264.81

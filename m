Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id RAA17123
	for <pstadt@stud.fh-heilbronn.de>; Thu, 29 Jul 1999 17:44:54 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA09545; Thu, 29 Jul 1999 08:39:44 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA15484
	for linux-list;
	Thu, 29 Jul 1999 08:32:09 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA95942
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 29 Jul 1999 08:31:56 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA05386
	for <linux@cthulhu.engr.sgi.com>; Thu, 29 Jul 1999 08:31:52 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-2.uni-koblenz.de [141.26.131.2])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id RAA12613
	for <linux@cthulhu.engr.sgi.com>; Thu, 29 Jul 1999 17:31:47 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id PAA08642;
	Thu, 29 Jul 1999 15:32:24 +0200
Date: Thu, 29 Jul 1999 15:32:23 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Tim Hockin <thockin@cobaltnet.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: an ld problem?
Message-ID: <19990729153223.D4730@uni-koblenz.de>
References: <379FBBFE.FB8C1734@cobaltnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <379FBBFE.FB8C1734@cobaltnet.com>; from Tim Hockin on Wed, Jul 28, 1999 at 07:27:10PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jul 28, 1999 at 07:27:10PM -0700, Tim Hockin wrote:

> where it aborts.  I am a bit bewildered.  Anyone have any ideas to
> offer?  Help?

I cheated; we currently ship only with a static libstdc++.  We've got
a fix for one of the many libbfd coredump bugs in elf32-mips.c in
our patchset of ftp.linux.sgi.com.  I think it won't cure this
particular case, however.

  Ralf

Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id CAA20054
	for <pstadt@stud.fh-heilbronn.de>; Thu, 15 Jul 1999 02:51:44 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA05944; Wed, 14 Jul 1999 17:50:33 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA82336
	for linux-list;
	Wed, 14 Jul 1999 17:46:47 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA58684
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 14 Jul 1999 17:46:44 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAB05560
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jul 1999 17:46:42 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-10.uni-koblenz.de [141.26.131.10])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id CAA10357
	for <linux@cthulhu.engr.sgi.com>; Thu, 15 Jul 1999 02:46:40 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id XAA01242;
	Wed, 14 Jul 1999 23:53:46 +0200
Date: Wed, 14 Jul 1999 23:53:46 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Tim Hockin <thockin@cobaltnet.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Float / Double issues
Message-ID: <19990714235346.A1231@uni-koblenz.de>
References: <378AADF5.96152E0B@cobaltnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <378AADF5.96152E0B@cobaltnet.com>; from Tim Hockin on Mon, Jul 12, 1999 at 08:09:41PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Jul 12, 1999 at 08:09:41PM -0700, Tim Hockin wrote:

> Hey gang - I have what seems to be two seperate issues on Mips/Linux
> (cobalt boxes).
> 
> 1) Programs using doubles with pthreads get corrupted data in the
> doubles.

That one is funny.  It was/is a longstanding libc bug originally reported
by Dong Liu.  I actually thought it'd be fixed but now thanks to your
report I see it's still broken.  So the multithreaded variant of your
double.c doesn't work at all on our libc.

The bug is in glibc/sysdeps/unix/sysv/linux/mips/clone.S; I suppose
Cobalt's libc which I last worked on late October is still using my
old clone.S from that time or somebody else there came up with a funky
new bug completly on it's own - which might explain why double.c cannot
even successfully create the threads.

More later ...

  Ralf

Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id QAA15846
	for <pstadt@stud.fh-heilbronn.de>; Wed, 30 Jun 1999 16:11:41 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id HAA3934182; Wed, 30 Jun 1999 07:09:14 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA77753
	for linux-list;
	Wed, 30 Jun 1999 07:06:14 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA46095
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 30 Jun 1999 07:06:11 -0700 (PDT)
	mail_from (weave@eng.umd.edu)
Received: from imap0.glue.umd.edu (imap0.glue.umd.edu [128.8.10.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA05503
	for <linux@cthulhu.engr.sgi.com>; Wed, 30 Jun 1999 07:06:10 -0700 (PDT)
	mail_from (weave@eng.umd.edu)
Received: from z.glue.umd.edu (root@z.glue.umd.edu [128.8.10.71])
	by imap0.glue.umd.edu (8.9.3/8.9.3) with ESMTP id KAA28517
	for <linux@cthulhu.engr.sgi.com>; Wed, 30 Jun 1999 10:06:09 -0400 (EDT)
Received: from z.glue.umd.edu (sendmail@localhost [127.0.0.1])
	by z.glue.umd.edu (8.9.3/8.9.3) with SMTP id KAA10050
	for <linux@cthulhu.engr.sgi.com>; Wed, 30 Jun 1999 10:06:08 -0400 (EDT)
Received: from localhost by z.glue.umd.edu (8.9.3/8.9.3) with ESMTP id KAA10046
	for <linux@cthulhu.engr.sgi.com>; Wed, 30 Jun 1999 10:06:08 -0400 (EDT)
X-Authentication-Warning: z.glue.umd.edu: weave owned process doing -bs
Date: Wed, 30 Jun 1999 10:06:07 -0400 (EDT)
From: Vince Weaver <weave@eng.umd.edu>
X-Sender: weave@z.glue.umd.edu
To: linux@cthulhu.engr.sgi.com
Subject: Re: IRIX Partations with HardHat Linux
In-Reply-To: <199906301348.PAA13995@sun168.eu>
Message-ID: <Pine.GSO.4.10.9906301001520.8406-100000@z.glue.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, 30 Jun 1999, Tom Woelfel wrote:

> Dag Bakke writes:
>  > No, you're not. Install linux 2.2.7 (.9?) on any i386 and enable experimental
>  > options and EFS.
>  > 
>  > Then you should be able to mount the CD on the linux-i386 box and set up tftp,
>  > bootp and nfs for remote booting/installing. (You don't need nfs for booting
>  > fx, though.)
>  > Something for a rainy day....
> 
> Hmm, is there a FAQ on how to set up such an environment ? 

my friend and I managed to upgrade Irix6.2 to Irix6.5 on a Indigo2 with no
CD-ROM this way.

It involved a Linux box with an early 2.3.x kernel on it [2.3.2 I think]
with efs support compiled it.

It took many hours of tweaking the booptab file and tftp, but finally we
got the SASH off the Irix CD to load, and eventually a miniroot.  

The one thing that really helped was putting the Debug Messages in bootp
up as high as possible, so you can see what files the SGI is requesting,
and then mess around with your bootp server until it gets the file it is
looking for.

I would be a bit more explicit but the final breakthrough was made late at
night after many, many, many randomly guessed attempts, and we were so
happy to get it working we were afraid to try and replicate it because we
never thought we'd figure it out again.

Vince

____________
\  /\  /\  /  Vince Weaver          
 \/__\/__\/   weave@eng.umd.edu     http://www.glue.umd.edu/~weave

Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA26585 for <linux-archive@neteng.engr.sgi.com>; Sat, 18 Jul 1998 18:06:04 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA26980
	for linux-list;
	Sat, 18 Jul 1998 18:05:32 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA30196
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 18 Jul 1998 18:05:30 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA14584
	for <linux@cthulhu.engr.sgi.com>; Sat, 18 Jul 1998 18:05:25 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-13.uni-koblenz.de [141.26.249.13])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id DAA20037
	for <linux@cthulhu.engr.sgi.com>; Sun, 19 Jul 1998 03:05:21 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id DAA00658;
	Sun, 19 Jul 1998 03:05:06 +0200
Message-ID: <19980719030505.B489@uni-koblenz.de>
Date: Sun, 19 Jul 1998 03:05:05 +0200
To: Andi Kleen <ak@muc.de>
Cc: linux@cthulhu.engr.sgi.com, lm@bitmover.com
Subject: Re: [lm@bitmover.com: Linux performance vs IRIX performance]
References: <19980718052722.H378@uni-koblenz.de> <k21zrjqh9q.fsf@zero.aec.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <k21zrjqh9q.fsf@zero.aec.at>; from Andi Kleen on Sat, Jul 18, 1998 at 06:02:25PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, Jul 18, 1998 at 06:02:25PM +0200, Andi Kleen wrote:

> ralf@uni-koblenz.de writes:
> 
> > A factor of 4.4 difference.  It's not fair to actually expect that good of
> > a result - the SGI OS is an SMP OS that scales up to approximately 128 
> > processors, has all sorts of useful and not so useful features that Linux
> > doesn't have, etc, etc.  None the less, it is likely that Linux on the same
> > hardware would be about 3 times faster than IRIX.  
> 
> Larry did not say what kind of FS he used on the Irix box (XFS or EFS), but
> for me it looks like a typical sync metadata/async metadata comparison.

Whatever - the impact of the dcache on the performance is sometimes really
amazing.  As long as Linux doesn't hit the disk on an Indy it is _much_
faster than IRIX.  For the normal case XFS and ext2 aren't too far from
each other.  Finally when Linux hits the disk it looses badly, the current
wd33c93 driver performs pretty badly.

  Ralf

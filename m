Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Sep 2002 23:32:07 +0200 (CEST)
Received: from p508B7AB5.dip.t-dialin.net ([80.139.122.181]:42116 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1123906AbSIZVcG>; Thu, 26 Sep 2002 23:32:06 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g8QLVvo31298;
	Thu, 26 Sep 2002 23:31:57 +0200
Date: Thu, 26 Sep 2002 23:31:57 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Alex deVries <adevries@linuxcare.com>
Cc: Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org
Subject: Re: Format of bootable Indy CDs?
Message-ID: <20020926233157.A30002@linux-mips.org>
References: <3D92B80A.3080802@linuxcare.com> <20020926171033.GA13337@paradigm.rfc822.org> <3D935DE6.7020206@linuxcare.com> <20020926225611.A26300@linux-mips.org> <3D937609.3010201@linuxcare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D937609.3010201@linuxcare.com>; from adevries@linuxcare.com on Thu, Sep 26, 2002 at 05:03:05PM -0400
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 26, 2002 at 05:03:05PM -0400, Alex deVries wrote:

> > On Thu, Sep 26, 2002 at 03:20:06PM -0400, Alex deVries wrote
> >>What open source tools do we have to create such an EFS filesystem?
> > 
> > None.  The in-kernel EFS filesystem is read-only.
> 
> Okay.  Let me look at that.
> 
> EFS seems pretty simple, but is there a filesystem described apart from 
> the .h files?

No.  EFS is not a very complex filesystem, roughly as complex as for example
UFS.

However later PROMs also know about XFS I think and that's the trivial
case.  Anyway, as afair the EFS CDROMs are partitioned like disks a
bootloader there could also be made to contain something like libext2fs and
boot the rest of a ext2 on the CDROM.  ISOfs if you have a nice library
to use for that.

  Ralf

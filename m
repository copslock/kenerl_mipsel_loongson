Received:  by oss.sgi.com id <S305234AbQCaPQP>;
	Fri, 31 Mar 2000 07:16:15 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:60222 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305227AbQCaPPt>; Fri, 31 Mar 2000 07:15:49 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id HAA07810; Fri, 31 Mar 2000 07:19:25 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA68025
	for linux-list;
	Fri, 31 Mar 2000 07:09:06 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA61487
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 31 Mar 2000 07:09:04 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA09637
	for <linux@cthulhu.engr.sgi.com>; Fri, 31 Mar 2000 07:08:52 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-26.uni-koblenz.de (cacc-26.uni-koblenz.de [141.26.131.26])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id RAA13011;
	Fri, 31 Mar 2000 17:08:50 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S407783AbQCaLqB>;
	Fri, 31 Mar 2000 13:46:01 +0200
Date:   Fri, 31 Mar 2000 13:46:01 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: resources.h patch / RLIM_INFINITY __KERNEL__ depend ?
Message-ID: <20000331134601.A5728@uni-koblenz.de>
References: <20000330142705.B3530@paradigm.rfc822.org> <20000330184715.A1600@uni-koblenz.de> <20000331102952.B273@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000331102952.B273@paradigm.rfc822.org>; from flo@rfc822.org on Fri, Mar 31, 2000 at 10:29:52AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Mar 31, 2000 at 10:29:52AM +0200, Florian Lohoff wrote:

> > > again - short patch - RLIM_INFINITY - This is also defined in
> > > both glibc 2.0 and glibc 2.1 headers so it should be __KERNEL__
> > > dependend - Shouldnt it ?
> > 
> > Glibc 2.1 doesn't include <asm/resource.h>, and 2.0 shouldn't do as well
> > as per convention.  So the fix is to copy the necessary definitions from
> > kernel headers into glibc headers.
> > 
> > Thanks for reporting this.  I'm just cooking  a new glibc release ...
> 
> My glibc does include asm/resource.h - This is default hardhat (little endian)
> 
> resourcebits.h:#include <asm/resource.h>
> 
> This is what caused a lot of userspace builts to fail.

I know.  It's something that used to work with kernel 2.2 but breaks with
2.3.  There are a few more problems of this kind with glibc 2.0 and I'm
cooking up a patch that will make glibc usable and compilable with 2.3
as well.

  Ralf

Received:  by oss.sgi.com id <S305160AbQERPjN>;
	Thu, 18 May 2000 15:39:13 +0000
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:31804 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305181AbQERPix>; Thu, 18 May 2000 15:38:53 +0000
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id IAA02812; Thu, 18 May 2000 08:43:25 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id IAA22017; Thu, 18 May 2000 08:38:22 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA87799
	for linux-list;
	Thu, 18 May 2000 08:28:57 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA85657
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 18 May 2000 08:28:54 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA06826
	for <linux@cthulhu.engr.sgi.com>; Thu, 18 May 2000 08:28:53 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-11.uni-koblenz.de (cacc-11.uni-koblenz.de [141.26.131.11])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id RAA10264;
	Thu, 18 May 2000 17:28:54 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S1405589AbQERP2J>;
	Thu, 18 May 2000 17:28:09 +0200
Date:   Thu, 18 May 2000 17:28:09 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Soren S. Jorvang" <soren@wheel.dk>
Cc:     Florian Lohoff <flo@rfc822.org>, linux@cthulhu.engr.sgi.com
Subject: Re: O2 ARCS
Message-ID: <20000518172809.D1455@uni-koblenz.de>
References: <20000517051524.A21067@gnyf.wheel.dk> <20000517215310.F779@uni-koblenz.de> <20000518011656.A721@paradigm.rfc822.org> <20000518151657.A5906@gnyf.wheel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000518151657.A5906@gnyf.wheel.dk>; from soren@wheel.dk on Thu, May 18, 2000 at 03:16:57PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, May 18, 2000 at 03:16:57PM +0200, Soren S. Jorvang wrote:

> On Thu, May 18, 2000 at 01:16:56AM +0200, Florian Lohoff wrote:
> > On Wed, May 17, 2000 at 09:53:11PM +0200, Ralf Baechle wrote:
> > > The ARCS firmware isn't the big deal but the R10000 support for this
> > > system or any other non-cachecoherent system.  Harald Koerfgen has
> > > started poking at an O2 port and he's got first success.
> > 
> > BTW: Is there any Documentation for the ARC Firmware of the SGIs ?
> 
> While not quite identical to the SGI ARCS firmware, 
> http://www.microsoft.com/hwdev/download/respec/riscspec.zip
> is useful.

Staring at the winword file in this archive with strings this pretty much
looks like one of the dead tree copies I was using for my work, so it's
definately usable.  The ARC / ARCS differences are not too big, just look
into arch/mips/arc/ which handles them.  The differences between specs and
real world implementation is another thing - I haven't yet seen a single
implementation that conforms to the spec.  Which is why I believe the
ARC spec should best be locked up in Fort Knox ;-)

  Ralf

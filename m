Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Aug 2003 21:00:31 +0100 (BST)
Received: from ftp.mips.com ([IPv6:::ffff:206.31.31.227]:26836 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225202AbTHKUA0>;
	Mon, 11 Aug 2003 21:00:26 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h7BJxlMO007981;
	Mon, 11 Aug 2003 12:59:47 -0700 (PDT)
Received: from uhler-linux.mips.com (uhler-linux [192.168.65.120])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id NAA15351;
	Mon, 11 Aug 2003 13:00:30 -0700 (PDT)
Subject: Re: C0 config reg for 5k core
From: Mike Uhler <uhler@mips.com>
To: David Kesselring <dkesselr@mmc.atmel.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <Pine.GSO.4.44.0308111556500.4643-100000@ares.mmc.atmel.com>
References: <Pine.GSO.4.44.0308111556500.4643-100000@ares.mmc.atmel.com>
Content-Type: text/plain
Organization: MIPS Technologies, Inc.
Message-Id: <1060632030.1071.29.camel@uhler-linux.mips.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 11 Aug 2003 13:00:30 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <uhler@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: uhler@mips.com
Precedence: bulk
X-list: linux-mips

For MIPS32 and MIPS64 processors (the 5K is MIPS64), it is
architecturally defined and required, and the compatibility
verification testing verifies it (and, yes, we do run compatibility
verification testing on our own cores).

/gmu

On Mon, 2003-08-11 at 12:57, David Kesselring wrote:
> Is this reg, supposed to be the same among all processor or does it
> differ?
> 
> On 11 Aug 2003, Mike Uhler wrote:
> 
> > Bit 0 of Config1 is FPU-present.  Bit 4 is "Performance counters
> > present".  I guarantee you that the 5K family implements this
> > pattern.
> >
> > /gmu
> >
> >
> > On Mon, 2003-08-11 at 11:28, David Kesselring wrote:
> > > Has anyone else built linux 2.4 for a 5k or 5kf core? When comparing cpu.h
> > > and the MIPS64 5K Processor Core Family Software Users Manual it doesn't
> > > look to me that the c0-config1 reg is defined the same way. Am I reading
> > > something wrong? For example in the spec FPU flag is bit0 while in cpu.h
> > > it is bit4. Seems pretty basic.
> > >
> > > David Kesselring
> > > Atmel MMC
> > > dkesselr@mmc.atmel.com
> > > 919-462-6587
> > --
> >
> > Michael Uhler, Chief Technology Officer
> > MIPS Technologies, Inc.  Email: uhler@mips.com  Pager:uhler_p@mips.com
> > 1225 Charleston Road     Voice:  (650)567-5025  FAX:   (650)567-5225
> > Mountain View, CA 94043  Mobile: (650)868-6870  Admin: (650)567-5085
> >
> >
> >
> >
> 
> David Kesselring
> Atmel MMC
> dkesselr@mmc.atmel.com
> 919-462-6587
-- 

Michael Uhler, Chief Technology Officer
MIPS Technologies, Inc.  Email: uhler@mips.com  Pager:uhler_p@mips.com
1225 Charleston Road     Voice:  (650)567-5025  FAX:   (650)567-5225
Mountain View, CA 94043  Mobile: (650)868-6870  Admin: (650)567-5085

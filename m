Received:  by oss.sgi.com id <S305163AbPKCAEi>;
	Tue, 2 Nov 1999 16:04:38 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:5711 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305162AbPKCAEc>; Tue, 2 Nov 1999 16:04:32 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id QAA00601
	for <linuxmips@oss.sgi.com>; Tue, 2 Nov 1999 16:10:02 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA99467
	for linux-list;
	Tue, 2 Nov 1999 15:55:04 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from calypso.engr.sgi.com (calypso.engr.sgi.com [150.166.49.50])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA96373;
	Tue, 2 Nov 1999 15:54:58 -0800 (PST)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: (from ulfc@localhost)
	by calypso.engr.sgi.com (8.9.3/8.8.7) id PAA18487;
	Tue, 2 Nov 1999 15:53:43 -0800
Date:   Tue, 2 Nov 1999 15:53:43 -0800
From:   Ulf Carlsson <ulfc@cthulhu.engr.sgi.com>
To:     "Juan J. Sierralta P." <juanjo@atmlab.utfsm.cl>
Cc:     Jeff Harrell <jharrell@ti.com>, linux@cthulhu.engr.sgi.com
Subject: Re: SGI, MIPS, Hardhat Linux question...
Message-ID: <19991102155343.F15879@engr.sgi.com>
References: <19991102.21303700@jharrell_dt.> <381F7700.AF49CEE8@atmlab.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <381F7700.AF49CEE8@atmlab.utfsm.cl>; from Juan J. Sierralta P. on Tue, Nov 02, 1999 at 08:42:56PM -0300
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

> 	I got the CVS sources for Kernel (2.3.19) and exactly the
> same error messages appears I'm using an HardHat 5.1 with
> 2.1.100 on a SGI Indy 5000 so maybe it isn't a
> cross-compiler error. I also checked the symlinks and seems
> ok....

Are you using gcc or egcs to cross-compiler?  If I remember correctly that
message is caused by the gcc specs file that isn't compatible with the current
MIPS kernels. Use this cross-compiler instead:

    ftp://oss.sgi.com/pub/linux/mips/crossdev/i386-linux/mips-linux/

And don't forget to turn off the -N option in arch/mips/Makefiles, or it will
not boot.

Ulf

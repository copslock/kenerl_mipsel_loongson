Received:  by oss.sgi.com id <S305171AbPLHGAg>;
	Tue, 7 Dec 1999 22:00:36 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:13944 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305167AbPLHGAS>; Tue, 7 Dec 1999 22:00:18 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id WAA03796; Tue, 7 Dec 1999 22:09:21 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id WAA17838
	for linux-list;
	Tue, 7 Dec 1999 22:00:51 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from hollywood.engr.sgi.com (hollywood.engr.sgi.com [150.166.61.38])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id WAA36414
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 7 Dec 1999 22:00:48 -0800 (PST)
	mail_from (owner-linux@hollywood.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by hollywood.engr.sgi.com (940816.SGI.8.6.9/960327.SGI.AUTOCF) via ESMTP id WAA25031; Tue, 7 Dec 1999 22:00:42 -0800
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [150.166.40.92])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id WAA12351;
	Tue, 7 Dec 1999 22:00:25 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id WAA16757;
	Tue, 7 Dec 1999 22:00:15 -0800
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From:   "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14413.62447.427645.648406@liveoak.engr.sgi.com>
Date:   Tue, 7 Dec 1999 22:00:15 -0800 (PST)
To:     fisher@sgi.com
Cc:     ralf@oss.sgi.com, kevink@mips.com, linux@hollywood.engr.sgi.com,
        fisher@hollywood.engr.sgi.com (William Fisher)
Subject: Re: Question for David Miller or anyone else about R6000 code
In-Reply-To: <199912080313.TAA24823@hollywood.engr.sgi.com>
References: <19991206092830.C765@uni-koblenz.de>
	<199912080313.TAA24823@hollywood.engr.sgi.com>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

William Fisher writes:
...
 > 	Since the R6000 was an ECL machine produced in late 1992, just
 > 	before the MIPS/SGI merger. There were only a few machines sold
 > 	and the machine was designed to be a Fortran FP specialist.
 > 
 > 	Hence the R6000 is long since dead. We still have the MIPS risc/os 5.01
 > 	operating system source code, so if anybody has lots of free cycles
 > 	to waste, I'm sure we can send them locore.

      Actually, CDC later sold quite a few multiple-processor machines, after
MIPS was merged into SGI.  They are not very practical, however, as they
use a lot of power and are only a little faster than a 100 MHZ R4000SC.

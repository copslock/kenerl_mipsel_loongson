Received:  by oss.sgi.com id <S305161AbQDXLpL>;
	Mon, 24 Apr 2000 04:45:11 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:17273 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305187AbQDXLo4>; Mon, 24 Apr 2000 04:44:56 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id EAA08937; Mon, 24 Apr 2000 04:49:03 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA08976
	for linux-list;
	Mon, 24 Apr 2000 04:33:18 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA94281
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 24 Apr 2000 04:33:16 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA03135
	for <linux@cthulhu.engr.sgi.com>; Mon, 24 Apr 2000 04:33:15 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 52E2783D; Mon, 24 Apr 2000 13:33:17 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 26E038FFD; Mon, 24 Apr 2000 13:24:33 +0200 (CEST)
Date:   Mon, 24 Apr 2000 13:24:33 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Ulf Carlsson <ulfc@calypso.engr.sgi.com>
Cc:     Florian Lohoff <flo@oss.sgi.com>, linux@cthulhu.engr.sgi.com
Subject: Re: early crash on indigo2 fix breaks indy ...
Message-ID: <20000424132433.E2583@paradigm.rfc822.org>
References: <20000406181353Z305167-1649+66@oss.sgi.com> <Pine.LNX.4.21.0004240346370.23887-100000@calypso.engr.sgi.com> <20000424132221.D2583@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20000424132221.D2583@paradigm.rfc822.org>; from Florian Lohoff on Mon, Apr 24, 2000 at 01:22:21PM +0200
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Apr 24, 2000 at 01:22:21PM +0200, Florian Lohoff wrote:
> On Mon, Apr 24, 2000 at 03:49:21AM -0700, Ulf Carlsson wrote:
> > > Modified files:
> > > 	arch/mips/arc  : memory.c 
> > > 
> > > Log message:
> > > 	Fix early crash on SGI_IP22 due to not reserving kernel
> > > 	pages in the boomem setup
> > 
> > This breaks on my Indy.  What machine are you using?  Do we know whether the
> > part of memory where the kernel is loaded is reported as free memory from the
> > prom or should we add some tests?

BTW: allocating/preserving the pages twice (once per arc-prom and 
once afterwards shouldnt hurt at all.

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."

Received:  by oss.sgi.com id <S305192AbQDXTaQ>;
	Mon, 24 Apr 2000 12:30:16 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:28197 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305191AbQDXT3t>; Mon, 24 Apr 2000 12:29:49 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id MAA04152; Mon, 24 Apr 2000 12:33:56 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA39661
	for linux-list;
	Mon, 24 Apr 2000 12:18:51 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA46585
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 24 Apr 2000 12:18:49 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA02968
	for <linux@cthulhu.engr.sgi.com>; Mon, 24 Apr 2000 12:18:47 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id A0BC383C; Mon, 24 Apr 2000 21:18:49 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 0DB018FFD; Mon, 24 Apr 2000 21:09:41 +0200 (CEST)
Date:   Mon, 24 Apr 2000 21:09:41 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Ulf Carlsson <ulfc@calypso.engr.sgi.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: early crash on indigo2 fix breaks indy ...
Message-ID: <20000424210940.C1623@paradigm.rfc822.org>
References: <20000424132221.D2583@paradigm.rfc822.org> <Pine.LNX.4.21.0004241152170.23887-100000@calypso.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.LNX.4.21.0004241152170.23887-100000@calypso.engr.sgi.com>; from Ulf Carlsson on Mon, Apr 24, 2000 at 11:57:13AM -0700
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Apr 24, 2000 at 11:57:13AM -0700, Ulf Carlsson wrote:
> > Indigo2 - I had the problem that the first alloc_bootmem i think
> > got back pages in the kernel marked as "free" - The resulting memset
> > let the kernel crash. My solution was to mark the kernel pages
> > as reserved.
> > 
> > BTW: What does break on indy ? Does it crash ? Does it
> > hang in SCSI Detection ?
> 
> Yeah, I noted that it didn't make any difference to revert your change except
> that the algorithm breaks and I get spammed with zillions of ``hm, page
> already marked as reserved'' messages when we try to reserve the already
> reserved memory.  Is it possible to detect this with the PROM version or
> something?

One might check if you walk through the memory table the
arc gives back and free it via the bootmem api you can check whether
you got back a memory chunk which contains the kernel (Or overlaps)
and realloc it after freeing or just not free it up. Should be obvious
and trivial after the change i made ...

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."

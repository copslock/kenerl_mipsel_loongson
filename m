Received:  by oss.sgi.com id <S305194AbQD1Kt7>;
	Fri, 28 Apr 2000 03:49:59 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:59760 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305175AbQD1Ktm>;
	Fri, 28 Apr 2000 03:49:42 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id DAA23764; Fri, 28 Apr 2000 03:44:55 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id DAA69754; Fri, 28 Apr 2000 03:47:56 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA35777
	for linux-list;
	Fri, 28 Apr 2000 03:35:34 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA14963
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 28 Apr 2000 03:35:32 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA07582
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Apr 2000 03:35:25 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id AA39081F; Fri, 28 Apr 2000 12:35:21 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 85BEE8FFD; Fri, 28 Apr 2000 11:18:35 +0200 (CEST)
Date:   Fri, 28 Apr 2000 11:18:35 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     Ulf Carlsson <ulfc@calypso.engr.sgi.com>,
        linux@cthulhu.engr.sgi.com
Subject: Re: early crash on indigo2 fix breaks indy ...
Message-ID: <20000428111835.B2891@paradigm.rfc822.org>
References: <20000424132221.D2583@paradigm.rfc822.org> <Pine.LNX.4.21.0004241152170.23887-100000@calypso.engr.sgi.com> <20000424210940.C1623@paradigm.rfc822.org> <20000426131047.F757@uni-koblenz.de> <20000428091646.A1458@paradigm.rfc822.org> <20000428015227.E797@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20000428015227.E797@uni-koblenz.de>; from Ralf Baechle on Fri, Apr 28, 2000 at 01:52:28AM -0700
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Apr 28, 2000 at 01:52:28AM -0700, Ralf Baechle wrote:
> > The problem i seen on MY indigo2 is that i get a memory chunk from
> > the ARC which is freed up although the kernel resides in that memory
> > chunk. The first allocation of memory (still in the bootmem) 
> > then gets kernel pages - does a "memset" and dead we are.
> 
> In that case I suggest you enable the define DEBUG near the top of
> arch/mips/arc/memory.c and take a closer look at the printout.

I did that - And i also included a lot more debugging myself. I also
mailed to output to the list but nobody seemed able to help - So i
fixed it myself ...

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."

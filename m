Received:  by oss.sgi.com id <S305194AbQD1Ia2>;
	Fri, 28 Apr 2000 01:30:28 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:63061 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305175AbQD1IaB>;
	Fri, 28 Apr 2000 01:30:01 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id BAA12845; Fri, 28 Apr 2000 01:25:14 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id BAA08727; Fri, 28 Apr 2000 01:28:15 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA01772
	for linux-list;
	Fri, 28 Apr 2000 01:02:35 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA84224
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 28 Apr 2000 01:02:33 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA03711
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Apr 2000 01:02:20 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 65541816; Fri, 28 Apr 2000 10:02:09 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 397878FFD; Fri, 28 Apr 2000 09:16:46 +0200 (CEST)
Date:   Fri, 28 Apr 2000 09:16:46 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     Ulf Carlsson <ulfc@calypso.engr.sgi.com>,
        linux@cthulhu.engr.sgi.com
Subject: Re: early crash on indigo2 fix breaks indy ...
Message-ID: <20000428091646.A1458@paradigm.rfc822.org>
References: <20000424132221.D2583@paradigm.rfc822.org> <Pine.LNX.4.21.0004241152170.23887-100000@calypso.engr.sgi.com> <20000424210940.C1623@paradigm.rfc822.org> <20000426131047.F757@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20000426131047.F757@uni-koblenz.de>; from Ralf Baechle on Wed, Apr 26, 2000 at 01:10:47PM -0700
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Apr 26, 2000 at 01:10:47PM -0700, Ralf Baechle wrote:
> 
> I don't see why the kernel memory could ever be treated as free.  Initially
> the entire memory is considered to be allocated.  Then all areas that are
> free as per ARC(S) firmware get freed.  The kernel itself should of course
> not be part of those areas.  Then even later once again as part of
> free_initmem() the rest of the ARC(S) memory gets freed, that's all the
> firmware temporary areas.  Again the kernel memory should not reside in
> any of those areas.  So I can't make any sense out of your changes?
>

The problem i seen on MY indigo2 is that i get a memory chunk from
the ARC which is freed up although the kernel resides in that memory
chunk. The first allocation of memory (still in the bootmem) 
then gets kernel pages - does a "memset" and dead we are.

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."

Received:  by oss.sgi.com id <S305194AbQD1JHI>;
	Fri, 28 Apr 2000 02:07:08 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:19037 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305175AbQD1JGn>;
	Fri, 28 Apr 2000 02:06:43 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id CAA15683; Fri, 28 Apr 2000 02:01:56 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id CAA66185; Fri, 28 Apr 2000 02:06:12 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA21171
	for linux-list;
	Fri, 28 Apr 2000 01:56:53 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from lappi (dhcp-163-154-5-221.engr.sgi.com [163.154.5.221])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA97925
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 28 Apr 2000 01:56:52 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S1403826AbQD1Iw2>;
	Fri, 28 Apr 2000 01:52:28 -0700
Date:   Fri, 28 Apr 2000 01:52:28 -0700
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     Ulf Carlsson <ulfc@calypso.engr.sgi.com>,
        linux@cthulhu.engr.sgi.com
Subject: Re: early crash on indigo2 fix breaks indy ...
Message-ID: <20000428015227.E797@uni-koblenz.de>
References: <20000424132221.D2583@paradigm.rfc822.org> <Pine.LNX.4.21.0004241152170.23887-100000@calypso.engr.sgi.com> <20000424210940.C1623@paradigm.rfc822.org> <20000426131047.F757@uni-koblenz.de> <20000428091646.A1458@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000428091646.A1458@paradigm.rfc822.org>; from flo@rfc822.org on Fri, Apr 28, 2000 at 09:16:46AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Apr 28, 2000 at 09:16:46AM +0200, Florian Lohoff wrote:

> > I don't see why the kernel memory could ever be treated as free.  Initially
> > the entire memory is considered to be allocated.  Then all areas that are
> > free as per ARC(S) firmware get freed.  The kernel itself should of course
> > not be part of those areas.  Then even later once again as part of
> > free_initmem() the rest of the ARC(S) memory gets freed, that's all the
> > firmware temporary areas.  Again the kernel memory should not reside in
> > any of those areas.  So I can't make any sense out of your changes?
> >
> 
> The problem i seen on MY indigo2 is that i get a memory chunk from
> the ARC which is freed up although the kernel resides in that memory
> chunk. The first allocation of memory (still in the bootmem) 
> then gets kernel pages - does a "memset" and dead we are.

In that case I suggest you enable the define DEBUG near the top of
arch/mips/arc/memory.c and take a closer look at the printout.

  Ralf

Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA10621 for <linux-archive@neteng.engr.sgi.com>; Thu, 27 May 1999 13:00:56 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA57781
	for linux-list;
	Thu, 27 May 1999 12:58:59 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA54893
	for <linux@engr.sgi.com>;
	Thu, 27 May 1999 12:58:56 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA08274
	for <linux@engr.sgi.com>; Thu, 27 May 1999 12:58:04 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-24.uni-koblenz.de [141.26.131.24])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id VAA01910
	for <linux@engr.sgi.com>; Thu, 27 May 1999 21:57:59 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id VAA04075;
	Thu, 27 May 1999 21:26:54 +0200
Date: Thu, 27 May 1999 21:26:54 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "Vladimir A. Roganov" <roganov@niisi.msk.ru>
Cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Platform-independent hack in ptrace.c
Message-ID: <19990527212654.A4058@uni-koblenz.de>
References: <374D37E6.59A6A9F3@niisi.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <374D37E6.59A6A9F3@niisi.msk.ru>; from Vladimir A. Roganov on Thu, May 27, 1999 at 04:17:42PM +0400
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, May 27, 1999 at 04:17:42PM +0400, Vladimir A. Roganov wrote:

> Does anybody know which kind of protection is encoded in ptrace.c:69:
> (function get_long)
> 
> 	/* This is a hack for non-kernel-mapped video buffers and similar */
> 	if (MAP_NR(page) >= MAP_NR(high_memory))
> 		return 0;
> 
> By this reason gdb shows all user-mapped io as zeros.
> 
> Same time, put_long enable to write to such memory !
> So when You enter something like 'set *p = 0xff' gdb'ing program 
> which has p->video_memory, You will see appearing pixels, but 'p *p' 
> prints only zeros.
> 
> Elimination of this check does not destroy something: gdb shows right
> values.
> 
> It looks clean that above problem is not very important, but just
> imagine programmer debugging some application for Linux used to control
> some device on MIPS embedded computer, which mmap'ed to device registers
> and don't understand why they are all clean :-)

Basically I think you're right.  However a correct patch is slightly more
complex and will acount for the fact that KSEG0 through which we route
the access is only 512mb large.  Therefore we might have to install a
temporary mapping and access memory through it, if outside of the 512mb.
The other bug is that memory accesses via ptrace for virtual addresses
which are uncached would be executed cached, trouble ahead.  Further
complexity is added by handling write buffers for the R3000 and
virtual coherency for R4000.

  Ralf

Received:  by oss.sgi.com id <S305192AbQD1BnG>;
	Thu, 27 Apr 2000 18:43:06 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:28942 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305176AbQD1BnC>; Thu, 27 Apr 2000 18:43:02 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id SAA09937; Thu, 27 Apr 2000 18:47:12 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA99787
	for linux-list;
	Thu, 27 Apr 2000 18:36:43 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from lappi (dhcp-163-154-5-221.engr.sgi.com [163.154.5.221])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA83200
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 27 Apr 2000 18:36:42 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S1406385AbQDZUKr>;
	Wed, 26 Apr 2000 13:10:47 -0700
Date:   Wed, 26 Apr 2000 13:10:47 -0700
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     Ulf Carlsson <ulfc@calypso.engr.sgi.com>,
        linux@cthulhu.engr.sgi.com
Subject: Re: early crash on indigo2 fix breaks indy ...
Message-ID: <20000426131047.F757@uni-koblenz.de>
References: <20000424132221.D2583@paradigm.rfc822.org> <Pine.LNX.4.21.0004241152170.23887-100000@calypso.engr.sgi.com> <20000424210940.C1623@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000424210940.C1623@paradigm.rfc822.org>; from flo@rfc822.org on Mon, Apr 24, 2000 at 09:09:41PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Apr 24, 2000 at 09:09:41PM +0200, Florian Lohoff wrote:

> > Yeah, I noted that it didn't make any difference to revert your change except
> > that the algorithm breaks and I get spammed with zillions of ``hm, page
> > already marked as reserved'' messages when we try to reserve the already
> > reserved memory.  Is it possible to detect this with the PROM version or
> > something?
> 
> One might check if you walk through the memory table the
> arc gives back and free it via the bootmem api you can check whether
> you got back a memory chunk which contains the kernel (Or overlaps)
> and realloc it after freeing or just not free it up. Should be obvious
> and trivial after the change i made ...

I don't see why the kernel memory could ever be treated as free.  Initially
the entire memory is considered to be allocated.  Then all areas that are
free as per ARC(S) firmware get freed.  The kernel itself should of course
not be part of those areas.  Then even later once again as part of
free_initmem() the rest of the ARC(S) memory gets freed, that's all the
firmware temporary areas.  Again the kernel memory should not reside in
any of those areas.  So I can't make any sense out of your changes?

  Ralf

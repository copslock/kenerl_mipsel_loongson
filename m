Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Feb 2005 15:53:57 +0000 (GMT)
Received: from p3EE076D7.dip.t-dialin.net ([IPv6:::ffff:62.224.118.215]:15124
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225239AbVBDPxl>; Fri, 4 Feb 2005 15:53:41 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j14Fre2b022764;
	Fri, 4 Feb 2005 16:53:40 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j14FreU8022763;
	Fri, 4 Feb 2005 16:53:40 +0100
Date:	Fri, 4 Feb 2005 16:53:40 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dominic Sweetman <dom@mips.com>
Cc:	Nigel Stephens <nigel@mips.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: c-r4k.c cleanup
Message-ID: <20050204155340.GB22217@linux-mips.org>
References: <20050204.231254.74753794.anemo@mba.ocn.ne.jp> <4203890B.5030305@mips.com> <20050204145803.GA5618@linux-mips.org> <16899.37525.412441.558873@gargle.gargle.HOWL> <20050204154532.GA22217@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204154532.GA22217@linux-mips.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 04, 2005 at 04:45:32PM +0100, Ralf Baechle wrote:

> > Note that I-cache aliases are not completely harmless; sometimes you
> > want to invalidate any I-cache copies of some data, and if it's
> > aliased you may miss some of them.  Shared libraries are generally
> > aligned to some large page-size multiple - so multiple text images are
> > usually the same colour, and don't matter.  You can get problems with
> > trampolines and stuff.
> 
> Linux computes the necessary alignment on the fly.  The method used is
> not strictly correct because as you say it should account for possible
> I-cache aliases also.
> 
> Seems it's cache day again today ;-)

This is what I've checked in.

  Ralf

Index: arch/mips/mm/c-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/c-r4k.c,v
retrieving revision 1.97
diff -u -r1.97 c-r4k.c
--- arch/mips/mm/c-r4k.c	4 Feb 2005 15:19:01 -0000	1.97
+++ arch/mips/mm/c-r4k.c	4 Feb 2005 15:48:38 -0000
@@ -1012,9 +1012,17 @@
 	 * normally they'd suffer from aliases but magic in the hardware deals
 	 * with that for us so we don't need to take care ourselves.
 	 */
-	if (c->cputype != CPU_R10000 && c->cputype != CPU_R12000)
+	switch (c->cputype) {
 		if (c->dcache.waysize > PAGE_SIZE)
-		        c->dcache.flags |= MIPS_CACHE_ALIASES;
+			
+	case CPU_R10000:
+	case CPU_R12000:
+		break;
+	case CPU_24K:
+		if (!(read_c0_config7() & (1 << 16)))
+	default:
+			c->dcache.flags |= MIPS_CACHE_ALIASES;
+	}
 
 	switch (c->cputype) {
 	case CPU_20KC:

Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Nov 2004 20:45:15 +0000 (GMT)
Received: from p508B7F2C.dip.t-dialin.net ([IPv6:::ffff:80.139.127.44]:62495
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225322AbUKUUpL>; Sun, 21 Nov 2004 20:45:11 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iALKh0Rn012865;
	Sun, 21 Nov 2004 21:43:00 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iALKh0Gx012864;
	Sun, 21 Nov 2004 21:43:00 +0100
Date: Sun, 21 Nov 2004 21:43:00 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Synthesize TLB refill handler at runtime
Message-ID: <20041121204300.GA12664@linux-mips.org>
References: <20041121170242.GR20986@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.4.61.0411212048520.26374@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0411212048520.26374@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 21, 2004 at 08:50:30PM +0100, Geert Uytterhoeven wrote:

> On Sun, 21 Nov 2004, Thiemo Seufer wrote:
> > currently we have a large number of TLB refill handlers written in
> > hand-optimized assembly which are mostly indentical. The appended
> > patch removes them all, and adds a micro-assembler instead which
> > synthesizes the proper variant for the CPU at runtime.
> 
> Woow.....

This has been the plan for quite a while already.  Nowhere else than in
the TLB exception handler more details about exception handling,
pipeline structure, SMP etc. become visible and benchmarkable in that
few instructions.  Copy_page / clear_page have basically been a test
how well it'd work out - it did.  So from that point it was just a
question of who was going to bite the bullet and do the work and Thiemo
did.  Thanks!

  Ralf

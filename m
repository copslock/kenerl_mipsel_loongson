Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2003 21:18:40 +0000 (GMT)
Received: from p508B5FBF.dip.t-dialin.net ([IPv6:::ffff:80.139.95.191]:45737
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225397AbTJ1VSg>; Tue, 28 Oct 2003 21:18:36 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h9SLIWNK014115;
	Tue, 28 Oct 2003 22:18:32 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h9SLITBN014114;
	Tue, 28 Oct 2003 22:18:29 +0100
Date: Tue, 28 Oct 2003 22:18:29 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Kesselring <dkesselr@mmc.atmel.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Unresolved symbols
Message-ID: <20031028211829.GC7649@linux-mips.org>
References: <Pine.GSO.4.44.0310281308450.20592-100000@ares.mmc.atmel.com> <Pine.GSO.4.21.0310282135290.10351-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0310282135290.10351-100000@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 28, 2003 at 09:36:05PM +0100, Geert Uytterhoeven wrote:
> Date: Tue, 28 Oct 2003 21:36:05 +0100 (MET)
> From: Geert Uytterhoeven <geert@linux-m68k.org>
> To: David Kesselring <dkesselr@mmc.atmel.com>
> cc: Linux/MIPS Development <linux-mips@linux-mips.org>
> Subject: Re: Unresolved symbols
> Content-Type: TEXT/PLAIN; charset=US-ASCII
> 
> On Tue, 28 Oct 2003, David Kesselring wrote:
> > I've been unabled to track down these errors. I think it's because I don't
> > understand how some of the linux h files are used by an independently
> > compiled kernel module. Why is "extern __inline__" used in a file like
> > atomic.h.
> 
> `extern inline' is wrong, and should be replaced by `static inline', which is
> work-in-progress.

I've replaced all extern inline in cvs 2.4 / 2.6.

  Ralf

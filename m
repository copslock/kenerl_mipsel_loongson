Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2004 19:46:45 +0000 (GMT)
Received: from p508B7363.dip.t-dialin.net ([IPv6:::ffff:80.139.115.99]:28997
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225226AbUBBTqp>; Mon, 2 Feb 2004 19:46:45 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i12JkNex025169;
	Mon, 2 Feb 2004 20:46:23 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i12JkMw0025168;
	Mon, 2 Feb 2004 20:46:22 +0100
Date: Mon, 2 Feb 2004 20:46:22 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Karsten Merker <karsten@excalibur.cologne.de>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: MIPS Kernel size
Message-ID: <20040202194622.GA25095@linux-mips.org>
References: <1075215091.40167af364b77@imp1-a.free.fr> <20040202140925.GB22008@linux-mips.org> <20040202184325.GE913@excalibur.cologne.de> <20040202185726.GB23667@linux-mips.org> <Pine.GSO.4.58.0402022033180.19699@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0402022033180.19699@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 02, 2004 at 08:38:18PM +0100, Geert Uytterhoeven wrote:

> a few years ago...
> 
> Fortunately, system size is still important for some applications. Witness the
> existence of a System Size Working Group in the CE Linux Forum. So yes, some
> people still care.

All but one of the new MIPS systems I got in the past years support memory
sizes in the GB range ...

> > The Cobalt case is special; it's firmware could almost be the definition
> > of the term crap ...
> 
> Can't you use the firmware to load a second stage booter, which can load
> larger kernels?

That would be possible - but would still leave all the other limitations
of the original firmware such as not supporting netboots.  Peter Horten
seem to have worked on something better.

  Ralf

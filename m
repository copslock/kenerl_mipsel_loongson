Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2003 13:35:04 +0100 (BST)
Received: from p508B5DEF.dip.t-dialin.net ([IPv6:::ffff:80.139.93.239]:46777
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225309AbTHSMe7>; Tue, 19 Aug 2003 13:34:59 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h7JCYs8R017880;
	Tue, 19 Aug 2003 14:34:54 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h7JCYr7E017879;
	Tue, 19 Aug 2003 14:34:53 +0200
Date: Tue, 19 Aug 2003 14:34:53 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org
Subject: Re: GCCFLAGS for gcc 3.3.x (-march and _MIPS_ISA)
Message-ID: <20030819123453.GA17120@linux-mips.org>
References: <20030819033843.GA6223@linux-mips.org> <Pine.GSO.3.96.1030819140527.29184B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030819140527.29184B-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 19, 2003 at 02:22:37PM +0200, Maciej W. Rozycki wrote:

>  OK, I now recall <asm/asm.h> and <asm/regdef.h> as traditionally being
> often included in user assembly.  But then we should get rid of
> configuration dependency entirely, i.e. remove "#include <linux/config.h>" 
> and a CONFIG_CPU_HAS_PREFETCH dependency.  Perhaps <asm/pref.h> would be
> desireable if we don't want wasting cycles.
> 
>  It's a pity a more reasonable choice wasn't made for the location of
> these headers -- the asm and linux trees shouldn't really be used for
> userland.  For example Alpha has <alpha/regdef.h> that comes from glibc. 

I completly agree on that.  Userspace should used <sys/regdef.h>,
<sys/fpregdef.h> and <sys/asm.h> for that which are the three de-facto
standard headers used throughout the MIPS world.

As for prefetching I like your suggestion of <asm/pref.h>.  The prefetching
stuff is a Linux extension of asm.h.  Moving it to it's own header file
along with the necessary bits for <linux/prefetch.h> would make a nice
cleanup.

  Ralf

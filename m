Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jan 2006 13:01:06 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:34591 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133555AbWA3Mzz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jan 2006 12:55:55 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0UD0QTK005207;
	Mon, 30 Jan 2006 13:00:35 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0TF7mQ1027650;
	Sun, 29 Jan 2006 15:07:48 GMT
Date:	Sun, 29 Jan 2006 15:07:48 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck <vagabon.xyz@gmail.com>
Cc:	"Kevin D. Kissell" <kevink@mips.com>,
	Nigel Stephens <nigel@mips.com>, linux-mips@linux-mips.org
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
Message-ID: <20060129150747.GC3420@linux-mips.org>
References: <43D8F000.9010106@mips.com> <cda58cb80601260831i61167787g@mail.gmail.com> <43D8FF16.40107@mips.com> <cda58cb80601261002w6eb02249k@mail.gmail.com> <43D93025.9040800@mips.com> <cda58cb80601270103t1419117cq@mail.gmail.com> <43DA240F.5070301@mips.com> <cda58cb80601270654jf779622w@mail.gmail.com> <00df01c62357$ef9a1fa0$10eca8c0@grendel> <cda58cb80601270932x323e4923j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80601270932x323e4923j@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 27, 2006 at 06:32:15PM +0100, Franck wrote:

> > ifdef CONFIG_CPU_SMARTMIPS
> > cflags-$(CONFIG_CPU_MIPS32R1)   += \
> >                         $(call set_gccflags,mips32,smartmips,4kec,mips3,mips2)\
> >                         -Os, -Wa,--trap

-Os has no business here.  That's what CONFIG_CC_OPTIMIZE_FOR_SIZE is for.

> > if the values I threw in for the MIPS32R1+SmartMIPS (e.g. 4KSc) combination
> > would actually work.  I just want to point out that it isn't that hard to do.
> 
> I agree it's not hard to do. But it becomes more tricky if you want
> something clean that gives best results for every cpus...Moreover I
> don't think your solution avoids maintenence problems IMHO.
> 
> Ralf, could you give your opinion ?

I think I'm going to start by throwing the insane option selection
complexity which was needed for support of gcc 2.95 ... 3.1; a few days
gcc 3.2 became the minimum required to build a 2.6 kernel, then see what
can nicely be implemented.

  Ralf

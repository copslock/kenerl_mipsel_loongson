Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 May 2005 14:08:41 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:53010 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225242AbVEYNIZ>; Wed, 25 May 2005 14:08:25 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j4PD7fi7004212;
	Wed, 25 May 2005 14:07:41 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j4PD7fjs004211;
	Wed, 25 May 2005 14:07:41 +0100
Date:	Wed, 25 May 2005 14:07:41 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kumba <kumba@gentoo.org>
Cc:	Jerry <jerry@wicomtechnologies.com>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: relocation truncated to fit
Message-ID: <20050525130741.GK4383@linux-mips.org>
References: <1399568766.20050525115143@wicomtechnologies.com> <20050525104905.GI4383@linux-mips.org> <429471EE.3090307@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <429471EE.3090307@gentoo.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 25, 2005 at 08:39:10AM -0400, Kumba wrote:
> Date:	Wed, 25 May 2005 08:39:10 -0400
> From:	Kumba <kumba@gentoo.org>
> To:	Jerry <jerry@wicomtechnologies.com>
> CC:	Ralf Baechle <ralf@linux-mips.org>,
> 	linux-mips <linux-mips@linux-mips.org>
> Subject: Re: relocation truncated to fit
> Content-Type:	text/plain; charset=UTF-8;
> 
> Ralf Baechle wrote:
> > On Wed, May 25, 2005 at 11:51:43AM +0300, Jerry wrote:
> > 
> > 
> >>drivers/sound/sounddrivers.o: In function `sound_insert_unit':
> >>sound_core.c:(.text+0x1ac): undefined reference to `strcpy'
> >>sound_core.c:(.text+0x1ac): relocation truncated to fit: R_MIPS_26 against `strcpy'
> >>make[1]: *** [vmlinux] Ошибка 1
> >>make[1]: Leaving directory `/work/video/kernel'
> >>make: *** [vmlinux] Ошибка 2
> >>
> >>It's not a "sound drivers" problem, howewer without it kernel compiles
> >>and run succesfully. Seems like gcc/bunitils bug/feature. What have to
> >>be done to eliminate this error?
> >>
> >>GNU ld version 2.15.96 20050308
> >>gcc version 3.4.3
> > 
> > 
> > Don't use gcc 3.4 to compile Linux 2.4.  It may work for some kernel
> > configurations but it will fail for others.
> > 
> >   Ralf
> 
> I would've thought this was fixed in 2.4.x now.  You might try using newer 
> sources.  The below patch fixes the issue:
> 
> http://dev.gentoo.org/~kumba/tmp/gcc-strcpy-fix.patch
> 
> 
> As the original patch I found stated about gcc-3.4.x:
> 
> From: Jan Hubicka <jh@suse.cz>
> 
> GCC now converts sprintf (a,"%s",b) to strcpy.  This lose on kernel as
> strcpy is not inlined and not present in library, so one gets linker
> failure.  It seems to make sense to apply this optimization by hand.

That fixes just the tip of the iceberg.  You want to rebuild with
-ffreestanding which 2.6 already does.  With that applied still some
2.4 kernel configurations will run into a bunch of other gcc 3.4-related
bug and not last loads of warnings.

  Ralf

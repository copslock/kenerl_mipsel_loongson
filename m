Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2003 07:41:28 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:4729
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225301AbTHSGlZ>; Tue, 19 Aug 2003 07:41:25 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.35 #1)
	id 19p0BD-0004ZM-00
	for linux-mips@linux-mips.org; Tue, 19 Aug 2003 08:41:19 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19p0BC-0003xK-00
	for <linux-mips@linux-mips.org>; Tue, 19 Aug 2003 08:41:18 +0200
Date: Tue, 19 Aug 2003 08:41:18 +0200
To: linux-mips@linux-mips.org
Subject: Re: GCCFLAGS for gcc 3.3.x (-march and _MIPS_ISA)
Message-ID: <20030819064118.GB13468@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030812.152654.74756131.nemoto@toshiba-tops.co.jp> <20030812065118.GD23104@rembrandt.csv.ica.uni-stuttgart.de> <20030819035756.GC6223@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030819035756.GC6223@linux-mips.org>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Tue, Aug 12, 2003 at 08:51:18AM +0200, Thiemo Seufer wrote:
> 
> > > 	GCCFLAGS += -mabi=32 -march=mips2 -mtune=r4600 -Wa,--trap
> > > (or	GCCFLAGS += $(call check_gcc, -mcpu=r4600 -mips2, -mabi=32 -march=mips2 -mtune=r4600) -Wa,--trap)
> > > 
> > > Isn't it?
> > 
> > -march=mips2 is an alias for -march=r6000, I don't think that's a
> > good choice.
> 
> Why? MIPSII / MIPS32 are the highest ISAs supported for building 32-bit
> kernels so that makes sense.

Because you get only MIPS II instructions then. This doesn't matter
much for R4600, but the improvements of later ISAs won't be used.

-mabi=32 -march=r4600 works for 32bit kernels with newer toolchains,
there's no need to use -mtune separately.


Thiemo

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2003 04:58:00 +0100 (BST)
Received: from p508B5DEF.dip.t-dialin.net ([IPv6:::ffff:80.139.93.239]:63386
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225301AbTHSD56>; Tue, 19 Aug 2003 04:57:58 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h7J3vu8R007619;
	Tue, 19 Aug 2003 05:57:56 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h7J3vujF007618;
	Tue, 19 Aug 2003 05:57:56 +0200
Date: Tue, 19 Aug 2003 05:57:56 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@linux-mips.org
Subject: Re: GCCFLAGS for gcc 3.3.x (-march and _MIPS_ISA)
Message-ID: <20030819035756.GC6223@linux-mips.org>
References: <20030812.152654.74756131.nemoto@toshiba-tops.co.jp> <20030812065118.GD23104@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030812065118.GD23104@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3071
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 12, 2003 at 08:51:18AM +0200, Thiemo Seufer wrote:

> > 	GCCFLAGS += -mabi=32 -march=mips2 -mtune=r4600 -Wa,--trap
> > (or	GCCFLAGS += $(call check_gcc, -mcpu=r4600 -mips2, -mabi=32 -march=mips2 -mtune=r4600) -Wa,--trap)
> > 
> > Isn't it?
> 
> -march=mips2 is an alias for -march=r6000, I don't think that's a
> good choice.

Why? MIPSII / MIPS32 are the highest ISAs supported for building 32-bit
kernels so that makes sense.

  Ralf

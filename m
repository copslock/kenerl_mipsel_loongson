Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Aug 2003 04:04:04 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:57189
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225193AbTHNDEC>; Thu, 14 Aug 2003 04:04:02 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.35 #1)
	id 19n8PA-0005pJ-00
	for linux-mips@linux-mips.org; Thu, 14 Aug 2003 05:04:00 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19n8P9-000837-00
	for <linux-mips@linux-mips.org>; Thu, 14 Aug 2003 05:03:59 +0200
Date: Thu, 14 Aug 2003 05:03:59 +0200
To: linux-mips@linux-mips.org
Subject: Re: GCCFLAGS for gcc 3.3.x (-march and _MIPS_ISA)
Message-ID: <20030814030359.GJ10792@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030812065118.GD23104@rembrandt.csv.ica.uni-stuttgart.de> <20030812.190636.39150536.nemoto@toshiba-tops.co.jp> <20030812101625.GJ23104@rembrandt.csv.ica.uni-stuttgart.de> <20030813.002644.59461513.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813.002644.59461513.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> >>>>> On Tue, 12 Aug 2003 12:16:25 +0200, Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de> said:
> 
> >> Does anybody know why __BUILD_clear_ade uses MFC0 and REG_S
> >> though other parts using mfc0 and sw ?
> 
> Thiemo> Probably because BADVADDR has to be 64bit for 64bit
> Thiemo> kernels. :-)
> 
> If so, MFC0 and REG_S should be controlled by __mips64 (or
> CONFIG_MIPS64) as you and Maciej W. Rozycki said in other mails.  I
> wonder why currently is not.  Historical reason ? :-)

Pre-3.0 gcc used -mips2 instead of -mabi=32 as hint to generate
32bit code. I guess the defines were affected by this also.


Thiemo

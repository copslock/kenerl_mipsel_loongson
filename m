Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2003 11:16:29 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:19550
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225072AbTHLKQ1>; Tue, 12 Aug 2003 11:16:27 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.35 #1)
	id 19mWCX-0000TL-00
	for linux-mips@linux-mips.org; Tue, 12 Aug 2003 12:16:25 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19mWCX-0001a4-00
	for <linux-mips@linux-mips.org>; Tue, 12 Aug 2003 12:16:25 +0200
Date: Tue, 12 Aug 2003 12:16:25 +0200
To: linux-mips@linux-mips.org
Subject: Re: GCCFLAGS for gcc 3.3.x (-march and _MIPS_ISA)
Message-ID: <20030812101625.GJ23104@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030812.152654.74756131.nemoto@toshiba-tops.co.jp> <20030812065118.GD23104@rembrandt.csv.ica.uni-stuttgart.de> <20030812.190636.39150536.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030812.190636.39150536.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> >>>>> On Tue, 12 Aug 2003 08:51:18 +0200, Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de> said:
> >> The option -march=r4600 seems to make gcc 3.3.x choose
> >> MIPS_ISA_MIPS3.
> 
> Thiemo> Which is ok, because the available ISA has little to do with
> Thiemo> the actually used register width.
> 
> Thiemo> If the intention is to use mfc0 for 32bit kernels and dmfc0
> Thiemo> for 64bit, the check should probably be
> 
> Thiemo> #ifdef __mips64
> Thiemo> # define MFC0		dmfc0
> Thiemo> # define MTC0		dmtc0
> Thiemo> #else
> Thiemo> # define MFC0		mfc0
> Thiemo> # define MTC0		mtc0
> Thiemo> #endif
> 
> Thanks for your explanations.  Perhaps the code should be fixed is
> __BUILD_clear_ade in entry.S, but I'm not sure.  Does anybody know why
> __BUILD_clear_ade uses MFC0 and REG_S though other parts using mfc0
> and sw ?

Probably because BADVADDR has to be 64bit for 64bit kernels. :-)


Thiemo

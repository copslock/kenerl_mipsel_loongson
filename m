Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2003 09:10:58 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:41565
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225072AbTHLIKy>; Tue, 12 Aug 2003 09:10:54 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.35 #1)
	id 19mUF2-000874-00
	for linux-mips@linux-mips.org; Tue, 12 Aug 2003 10:10:52 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19mUF2-0002G5-00
	for <linux-mips@linux-mips.org>; Tue, 12 Aug 2003 10:10:52 +0200
Date: Tue, 12 Aug 2003 10:10:52 +0200
To: linux-mips@linux-mips.org
Subject: Re: GCCFLAGS for gcc 3.3.x (-march and _MIPS_ISA)
Message-ID: <20030812081052.GG23104@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030812.152654.74756131.nemoto@toshiba-tops.co.jp> <3F388E0C.50802@gentoo.org> <20030812070645.GF23104@rembrandt.csv.ica.uni-stuttgart.de> <3F389DB2.5020101@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F389DB2.5020101@gentoo.org>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Kumba wrote:
> Thiemo Seufer wrote:
> 
> >I recommend to prefer -march=mips3 over -mips3. It documents the
> >intention to use a generic arch better and avoids confusion with
> >e.g. -mips16, which has a totally different meaning.
> >
> >It won't work with old toolchains, though.
> >
> >
> >Thiemo
> 
> Good point.  Does the -march=mips3 work for gcc-3.2.x as well, or is 
> that a gcc-3.3.x change?

It's only in 3.3 and upwards.


Thiemo

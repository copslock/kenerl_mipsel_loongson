Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Feb 2005 18:14:31 +0000 (GMT)
Received: from lennier.cc.vt.edu ([IPv6:::ffff:198.82.162.213]:49130 "EHLO
	lennier.cc.vt.edu") by linux-mips.org with ESMTP
	id <S8225282AbVBKSOQ>; Fri, 11 Feb 2005 18:14:16 +0000
Received: from dagger.cc.vt.edu (IDENT:mirapoint@evil-dagger.cc.vt.edu [10.1.1.11])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id j1BIE8ik020923;
	Fri, 11 Feb 2005 13:14:08 -0500
Received: from [127.0.0.1] (68-232-97-125.chvlva.adelphia.net [68.232.97.125])
	by dagger.cc.vt.edu (MOS 3.5.7-GR)
	with ESMTP id CQB52181 (AUTH spbecker);
	Fri, 11 Feb 2005 13:14:07 -0500 (EST)
Message-ID: <420CF611.5030705@gentoo.org>
Date:	Fri, 11 Feb 2005 13:14:41 -0500
From:	"Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Frederic TEMPORELLI - astek <ftemporelli@astek.fr>
CC:	linux-mips@linux-mips.org
Subject: Re: IP32 - issues with last CVS snapshoot
References: <420CEE7F.3080201@astek.fr>
In-Reply-To: <420CEE7F.3080201@astek.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

Frederic TEMPORELLI - astek wrote:
> Hello,
> 
> I've been able to compile and launch 2.6.11-rc3 from last CVS snapshoot.
> 
> First, there's something wrong with "make ip32_defconfig" which generate 
> config file with "Kernel code model = 64-bit kernel" (MIPS64=y) but 
> doesn't preselect  "Use 64-bit ELF format for building" (BUILD_ELF64=n)
> doing so, "make" quickly generates an error:

O2 doesn't use 64-bit ELF format.  You have to use o64.  See the 
arch/mips/Makefile portion of http://dev.gentoo.org/~geoman/cvs.diff for 
the proper changes.  I'm willing to bet a lot of your problems will go 
away if you stop using ELF64.  Such a kernel will boot, but it never 
quite works right.  Not only that, but 64-bit kernels have had some 
major problems in 2.6.11 so far that I'm not sure Ralf has completely 
fixed just yet.  Last I knew swap still didn't work, so I bet that is 
where your swap problem is coming from.

Steve

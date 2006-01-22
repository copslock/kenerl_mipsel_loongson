Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jan 2006 02:55:04 +0000 (GMT)
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:24494 "EHLO
	rwcrmhc11.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8133452AbWAVCym (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 22 Jan 2006 02:54:42 +0000
Received: from [192.168.1.4] (pcp04414054pcs.nrockv01.md.comcast.net[69.140.185.48])
          by comcast.net (rwcrmhc11) with ESMTP
          id <20060122025839013007m9nqe>; Sun, 22 Jan 2006 02:58:40 +0000
Message-ID: <43D2F4D9.6010406@gentoo.org>
Date:	Sat, 21 Jan 2006 21:58:33 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: DECstation compile fails: opcode not supported (eret)
References: <20060121195956.GA15498@deprecation.cyrius.com>
In-Reply-To: <20060121195956.GA15498@deprecation.cyrius.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Martin Michlmayr wrote:
> linux-mips git with the standard DECstation config from
> arch/mips/configs/decstation_defconfig fails with the following error:
> 
>   AS      arch/mips/kernel/genex.o
> arch/mips/kernel/genex.S: Assembler messages:
> arch/mips/kernel/genex.S:240: Error: opcode not supported on this processor: mips1 (mips1) `eret'
> make[1]: *** [arch/mips/kernel/genex.o] Error 1
> make: *** [arch/mips/kernel] Error 2
> 
> Toolchain used:
> gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)
> binutils: 2.16.91 20051117 Debian GNU/Linux

I think this broke it:
http://www.linux-mips.org/git?p=linux.git;a=commitdiff;h=cfbc9cac62f0438cefe171736729e786b45884b8;hp=2dcaaf2decd31ac9a21d616604c0a7c1fa65d5a4


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond

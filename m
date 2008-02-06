Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Feb 2008 03:26:09 +0000 (GMT)
Received: from qmta04.emeryville.ca.mail.comcast.net ([76.96.30.40]:1713 "EHLO
	QMTA04.emeryville.ca.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S20034991AbYBFD0B (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Feb 2008 03:26:01 +0000
Received: from OMTA14.emeryville.ca.mail.comcast.net ([76.96.30.60])
	by QMTA04.emeryville.ca.mail.comcast.net with comcast
	id m22W1Y0031HpZEsA406j00; Wed, 06 Feb 2008 03:25:45 +0000
Received: from [192.168.1.4] ([69.140.18.238])
	by OMTA14.emeryville.ca.mail.comcast.net with comcast
	id m3Rq1Y00Z58Be2l8a00000; Wed, 06 Feb 2008 03:25:53 +0000
X-Authority-Analysis: v=1.0 c=1 a=mHkp4NPBQMTj-ToxHy0A:9
 a=C1SEP9C3daKCn9w2vRhkrsVy384A:4 a=XF7b4UCPwd8A:10
Message-ID: <47A928BF.5000302@gentoo.org>
Date:	Tue, 05 Feb 2008 22:25:51 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	Florian Lohoff <flo@rfc822.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org, debian-mips@lists.debian.org
Subject: Re: Tester with IP27/IP30 needed
References: <20080115112719.GB7920@paradigm.rfc822.org> <20080117004054.GA12051@alpha.franken.de> <479609A6.2020204@gentoo.org> <20080122154958.GA29108@linux-mips.org> <479AA532.5040603@gentoo.org> <20080126143949.GA6579@alpha.franken.de> <47A4E9DF.5070603@gentoo.org> <20080203021647.GA15910@linux-mips.org> <20080203062711.GA28394@paradigm.rfc822.org> <47A80C0A.4040106@gentoo.org> <20080205122211.GA24136@networkno.de>
In-Reply-To: <20080205122211.GA24136@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Kumba wrote:
> 
> glibc for mips has currently no such mechanism. Note that this change
> breaks MIPS I CPUs, so it is not generally applicable.

I'll have to ask one of our devs who knows autoconf really well.  I figure 
that's probably a good place to catch something like this.  Have configure check 
/proc/cpuinfo and look for "R10000", and if it finds it, mod CFLAGS to pass 
-DR10k_LLSC_WAR, and #ifdef on that in atomic.h.

Sound plausible?


>> And any idea if uClibc will need similar mods?
> 
> It needs a similiar change to support R10000 v2.5.

Thought it would.  I'll keep this in mind if we ever get that running again.



Cheers,


--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond

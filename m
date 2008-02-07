Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Feb 2008 05:30:56 +0000 (GMT)
Received: from qmta01.westchester.pa.mail.comcast.net ([76.96.62.16]:17358
	"EHLO QMTA01.westchester.pa.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S20022204AbYBGFas (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Feb 2008 05:30:48 +0000
Received: from OMTA07.westchester.pa.mail.comcast.net ([76.96.62.59])
	by QMTA01.westchester.pa.mail.comcast.net with comcast
	id mLrh1Y02U1GhbT8510Ja00; Thu, 07 Feb 2008 05:30:35 +0000
Received: from [192.168.1.4] ([69.140.18.238])
	by OMTA07.westchester.pa.mail.comcast.net with comcast
	id mVWf1Y00G58Be2l3T00000; Thu, 07 Feb 2008 05:30:40 +0000
X-Authority-Analysis: v=1.0 c=1 a=8rNRuJ1kDQyzUA1EHfYA:9
 a=ZluIzpL3rFPDPbGnU7FQLa_zARIA:4 a=GZmr5YlNZX8A:10
Message-ID: <47AA977E.5000205@gentoo.org>
Date:	Thu, 07 Feb 2008 00:30:38 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
MIME-Version: 1.0
To:	Florian Lohoff <flo@rfc822.org>
CC:	Thiemo Seufer <ths@networkno.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org, debian-mips@lists.debian.org
Subject: Re: Tester with IP27/IP30 needed
References: <479609A6.2020204@gentoo.org> <20080122154958.GA29108@linux-mips.org> <479AA532.5040603@gentoo.org> <20080126143949.GA6579@alpha.franken.de> <47A4E9DF.5070603@gentoo.org> <20080203021647.GA15910@linux-mips.org> <20080203062711.GA28394@paradigm.rfc822.org> <47A80C0A.4040106@gentoo.org> <20080205122211.GA24136@networkno.de> <47A928BF.5000302@gentoo.org> <20080206085610.GA20751@paradigm.rfc822.org>
In-Reply-To: <20080206085610.GA20751@paradigm.rfc822.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18186
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Florian Lohoff wrote:
> No - the very same GLIBC does not work on mips1 machines and vice versa.
> Might by okay for gentoo but debian needs a run everywhere glibc which
> means some ld.so tricks like with the libc6-i686 to load a different
> glibc from my understanding.

While I could test this easily on gentoo, I was thinking of it more as an 
upstream fix.  I suppose one of those configure switches could be included to 
skip the check as well, with the default being on.  Figured I'd see what you 
guys thought, since it does seem to be a bug that should to be addressed somehow 
rather than patched forever in one of the distros.


--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond

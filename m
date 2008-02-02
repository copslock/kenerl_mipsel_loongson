Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Feb 2008 22:08:50 +0000 (GMT)
Received: from qmta07.emeryville.ca.mail.comcast.net ([76.96.30.64]:58780 "EHLO
	QMTA07.emeryville.ca.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S20031130AbYBBWIm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 2 Feb 2008 22:08:42 +0000
Received: from OMTA13.emeryville.ca.mail.comcast.net ([76.96.30.52])
	by QMTA07.emeryville.ca.mail.comcast.net with comcast
	id kd4v1Y00F17UAYkA70X900; Sat, 02 Feb 2008 22:08:32 +0000
Received: from [192.168.1.4] ([69.140.18.238])
	by OMTA13.emeryville.ca.mail.comcast.net with comcast
	id km8Y1Y00E58Be2l8Z00000; Sat, 02 Feb 2008 22:08:35 +0000
X-Authority-Analysis: v=1.0 c=1 a=NO_UjUUC5dBMtSl9ZVQA:9
 a=pljzPeXGaX0wzBsF5R0A:7 a=WgWhcjP_WEcGfe5YBQNgxSYBjIcA:4 a=XF7b4UCPwd8A:10
Message-ID: <47A4E9DF.5070603@gentoo.org>
Date:	Sat, 02 Feb 2008 17:08:31 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
MIME-Version: 1.0
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org,
	debian-mips@lists.debian.org
Subject: Re: Tester with IP27/IP30 needed
References: <20080115112420.GA7347@alpha.franken.de> <20080115112719.GB7920@paradigm.rfc822.org> <20080117004054.GA12051@alpha.franken.de> <479609A6.2020204@gentoo.org> <20080122154958.GA29108@linux-mips.org> <479AA532.5040603@gentoo.org> <20080126143949.GA6579@alpha.franken.de>
In-Reply-To: <20080126143949.GA6579@alpha.franken.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Thomas Bogendoerfer wrote:
> no suprise here. As Ralf already noted cache barrier is a restricted
> instruction, it will always cause a illegal instruction when used
> in user space. Nevertheless it looks like all IP28 are affected
> by the simple exploit. Flo built glibc 2.7 with LLSC war workaround
> and this avoids triggering the hang.

Ah, didn't know the 'cache' instructions was kernel-mode only.  Explains why it 
survived then :)

How does one enable the LLSC war workaround in glibc?


--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond

Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Jan 2008 03:13:06 +0000 (GMT)
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:53130
	"EHLO QMTA03.westchester.pa.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S20039030AbYAZDM5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 26 Jan 2008 03:12:57 +0000
Received: from OMTA09.westchester.pa.mail.comcast.net ([76.96.62.20])
	by QMTA03.westchester.pa.mail.comcast.net with comcast
	id hdAP1Y00B0SCNGk050AZ00; Sat, 26 Jan 2008 03:12:51 +0000
Received: from [192.168.1.4] ([69.140.18.238])
	by OMTA09.westchester.pa.mail.comcast.net with comcast
	id hfCq1Y00A58Be2l3V00000; Sat, 26 Jan 2008 03:12:51 +0000
X-Authority-Analysis: v=1.0 c=1 a=d3G3_sfZAon2kaaokJgA:9 a=KafzyCGZcZfgMJqINtQnTsMJ9A0A:4 a=QJAqVYndk0IA:10
Message-ID: <479AA532.5040603@gentoo.org>
Date:	Fri, 25 Jan 2008 22:12:50 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org,
	debian-mips@lists.debian.org
Subject: Re: Tester with IP27/IP30 needed
References: <20080115112420.GA7347@alpha.franken.de> <20080115112719.GB7920@paradigm.rfc822.org> <20080117004054.GA12051@alpha.franken.de> <479609A6.2020204@gentoo.org> <20080122154958.GA29108@linux-mips.org>
In-Reply-To: <20080122154958.GA29108@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> 
> It's a cache instruction so priviledged which means userspace can't execute
> it.  It's also entirely unclear if a cache barrier instruction would make a
> difference at all.

The cache barrier has an interesting effect.  I built three binaries: f, f2, and 
f3 (I'm cheap on the names):

f  - cache barriers on load and stores (-mr10k-cache-barrier=2)
f2 - cache barriers on loads only (-mr10k-cache-barrier=1)
f3 - no cache barriers (flag omitted from gcc)

Running 'f' and 'f2' generates an "Illegal instruction" error, then drops back 
to the command line, while 'f3' hangs the box.  This is an IP28 running on 
2.6.23.9, using Thomas' patches backported to fit (plus Peter's Impact code and 
two sgiseeq patches from upstream).

This is similar to using a gentoo stage3 in a chroot environment that was built 
back in May of 2007, so I think this hang up pre-dates glibc-2.7 by some degree, 
as that chroot uses glibc-2.5.  Chroot into this userland, and run our 
"env-update" script, and you'll hang the box.

FYI, CPU rev in this machine is R10000 v2.5.  I think that's the same for all 
IP28 systems.



--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond

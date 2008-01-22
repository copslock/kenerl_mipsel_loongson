Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jan 2008 15:20:24 +0000 (GMT)
Received: from qmta08.westchester.pa.mail.comcast.net ([76.96.62.80]:44172
	"EHLO QMTA08.westchester.pa.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S28588541AbYAVPUO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Jan 2008 15:20:14 +0000
Received: from OMTA07.westchester.pa.mail.comcast.net ([76.96.62.59])
	by QMTA08.westchester.pa.mail.comcast.net with comcast
	id gCH71Y00D1GhbT8050Ln00; Tue, 22 Jan 2008 15:20:08 +0000
Received: from [192.168.1.4] ([69.140.18.238])
	by OMTA07.westchester.pa.mail.comcast.net with comcast
	id gFL71Y00E58Be2l3T00000; Tue, 22 Jan 2008 15:20:08 +0000
X-Authority-Analysis: v=1.0 c=1 a=Qe0Gm9MKgkNc51YevaYA:9 a=8xSsz2717CHieX4BIBicLNtb9J8A:4 a=XF7b4UCPwd8A:10
Message-ID: <479609A6.2020204@gentoo.org>
Date:	Tue, 22 Jan 2008 10:20:06 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
MIME-Version: 1.0
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:	Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org,
	debian-mips@lists.debian.org
Subject: Re: Tester with IP27/IP30 needed
References: <20080115112420.GA7347@alpha.franken.de> <20080115112719.GB7920@paradigm.rfc822.org> <20080117004054.GA12051@alpha.franken.de>
In-Reply-To: <20080117004054.GA12051@alpha.franken.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Thomas Bogendoerfer wrote:
> On Tue, Jan 15, 2008 at 12:27:19PM +0100, Florian Lohoff wrote:
>> Simple testcase for me is:
> 
[snip]

No effect on Octane R14000A, as far as lockups.  Spikes the CPU usage in 'ps
aux', but that's about it.

If I can get my plucky IP32 R10K to boot again soon, I may try it there for
kicks and giggles.  Maybe we're also seeing a side effect of the R10K's spec
exec knocking the non-cache-coherent machines out?

Also, tried building the code with the R10K cache barrier on to see if anything
else changes?  Generally reserved for kernel stuff, but Peter once speculated
userland might have a use for it.


--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands
do them because they must, while the eyes of the great are elsewhere."  --Elrond

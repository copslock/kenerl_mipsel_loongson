Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Feb 2008 07:11:25 +0000 (GMT)
Received: from qmta01.emeryville.ca.mail.comcast.net ([76.96.30.16]:58805 "EHLO
	QMTA01.emeryville.ca.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S20023976AbYBEHLR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 5 Feb 2008 07:11:17 +0000
Received: from OMTA06.emeryville.ca.mail.comcast.net ([76.96.30.51])
	by QMTA01.emeryville.ca.mail.comcast.net with comcast
	id lVWT1Y00216AWCUA10d300; Tue, 05 Feb 2008 07:11:02 +0000
Received: from [192.168.1.4] ([69.140.18.238])
	by OMTA06.emeryville.ca.mail.comcast.net with comcast
	id ljB61Y00258Be2l8S00000; Tue, 05 Feb 2008 07:11:09 +0000
X-Authority-Analysis: v=1.0 c=1 a=xNf9USuDAAAA:8 a=yzZtjsIgX-HcIXBt9YEA:9
 a=GvoO7B1UHpgB1oHFA9wA:7 a=Tcex07jpsPutSQbRQqsc4_egSxAA:4 a=GZmr5YlNZX8A:10
Message-ID: <47A80C0A.4040106@gentoo.org>
Date:	Tue, 05 Feb 2008 02:11:06 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
MIME-Version: 1.0
To:	Florian Lohoff <flo@rfc822.org>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org, debian-mips@lists.debian.org
Subject: Re: Tester with IP27/IP30 needed
References: <20080115112420.GA7347@alpha.franken.de> <20080115112719.GB7920@paradigm.rfc822.org> <20080117004054.GA12051@alpha.franken.de> <479609A6.2020204@gentoo.org> <20080122154958.GA29108@linux-mips.org> <479AA532.5040603@gentoo.org> <20080126143949.GA6579@alpha.franken.de> <47A4E9DF.5070603@gentoo.org> <20080203021647.GA15910@linux-mips.org> <20080203062711.GA28394@paradigm.rfc822.org>
In-Reply-To: <20080203062711.GA28394@paradigm.rfc822.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Florian Lohoff wrote:
> On Sun, Feb 03, 2008 at 03:16:48AM +0100, Ralf Baechle wrote:
>> On Sat, Feb 02, 2008 at 05:08:31PM -0500, Kumba wrote:
>>
>>> Thomas Bogendoerfer wrote:
>>>> no suprise here. As Ralf already noted cache barrier is a restricted
>>>> instruction, it will always cause a illegal instruction when used
>>>> in user space. Nevertheless it looks like all IP28 are affected
>>>> by the simple exploit. Flo built glibc 2.7 with LLSC war workaround
>>>> and this avoids triggering the hang.
>>> Ah, didn't know the 'cache' instructions was kernel-mode only.  Explains 
>>> why it survived then :)
>>>
>>> How does one enable the LLSC war workaround in glibc?
>> By modifying the code ;-)
> 
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=462112
> 
> Flo

Interesting.  Is there a reason the kernel uses an #ifdef to choose between 
'bezq' and 'bezql' that's not needed in glibc itself?  Or does glibc itself lack 
a mechanism to detect CPU types to single out this specific change?

And any idea if uClibc will need similar mods?


Thanks!,

--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Feb 2008 12:22:28 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:48562 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20026310AbYBEMWS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Feb 2008 12:22:18 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id F41DF48916;
	Tue,  5 Feb 2008 13:22:12 +0100 (CET)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1JMMoV-0001sZ-Rj; Tue, 05 Feb 2008 12:22:11 +0000
Date:	Tue, 5 Feb 2008 12:22:11 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	Kumba <kumba@gentoo.org>
Cc:	Florian Lohoff <flo@rfc822.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org, debian-mips@lists.debian.org
Subject: Re: Tester with IP27/IP30 needed
Message-ID: <20080205122211.GA24136@networkno.de>
References: <20080115112719.GB7920@paradigm.rfc822.org> <20080117004054.GA12051@alpha.franken.de> <479609A6.2020204@gentoo.org> <20080122154958.GA29108@linux-mips.org> <479AA532.5040603@gentoo.org> <20080126143949.GA6579@alpha.franken.de> <47A4E9DF.5070603@gentoo.org> <20080203021647.GA15910@linux-mips.org> <20080203062711.GA28394@paradigm.rfc822.org> <47A80C0A.4040106@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47A80C0A.4040106@gentoo.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Kumba wrote:
> Florian Lohoff wrote:
>> On Sun, Feb 03, 2008 at 03:16:48AM +0100, Ralf Baechle wrote:
>>> On Sat, Feb 02, 2008 at 05:08:31PM -0500, Kumba wrote:
>>>
>>>> Thomas Bogendoerfer wrote:
>>>>> no suprise here. As Ralf already noted cache barrier is a restricted
>>>>> instruction, it will always cause a illegal instruction when used
>>>>> in user space. Nevertheless it looks like all IP28 are affected
>>>>> by the simple exploit. Flo built glibc 2.7 with LLSC war workaround
>>>>> and this avoids triggering the hang.
>>>> Ah, didn't know the 'cache' instructions was kernel-mode only.  
>>>> Explains why it survived then :)
>>>>
>>>> How does one enable the LLSC war workaround in glibc?
>>> By modifying the code ;-)
>>
>> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=462112
>>
>> Flo
>
> Interesting.  Is there a reason the kernel uses an #ifdef to choose 
> between 'bezq' and 'bezql' that's not needed in glibc itself?  Or does 
> glibc itself lack a mechanism to detect CPU types to single out this 
> specific change?

glibc for mips has currently no such mechanism. Note that this change
breaks MIPS I CPUs, so it is not generally applicable.

> And any idea if uClibc will need similar mods?

It needs a similiar change to support R10000 v2.5.


Thiemo

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 May 2005 13:36:53 +0100 (BST)
Received: from sccrmhc14.comcast.net ([IPv6:::ffff:204.127.202.59]:25275 "EHLO
	sccrmhc14.comcast.net") by linux-mips.org with ESMTP
	id <S8224977AbVEYMgh>; Wed, 25 May 2005 13:36:37 +0100
Received: from [192.168.1.4] (pcp0011842295pcs.waldrf01.md.comcast.net[69.251.97.45])
          by comcast.net (sccrmhc14) with ESMTP
          id <2005052512362901400i90g9e>; Wed, 25 May 2005 12:36:30 +0000
Message-ID: <429471EE.3090307@gentoo.org>
Date:	Wed, 25 May 2005 08:39:10 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Jerry <jerry@wicomtechnologies.com>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: relocation truncated to fit
References: <1399568766.20050525115143@wicomtechnologies.com> <20050525104905.GI4383@linux-mips.org>
In-Reply-To: <20050525104905.GI4383@linux-mips.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Wed, May 25, 2005 at 11:51:43AM +0300, Jerry wrote:
> 
> 
>>drivers/sound/sounddrivers.o: In function `sound_insert_unit':
>>sound_core.c:(.text+0x1ac): undefined reference to `strcpy'
>>sound_core.c:(.text+0x1ac): relocation truncated to fit: R_MIPS_26 against `strcpy'
>>make[1]: *** [vmlinux] Ошибка 1
>>make[1]: Leaving directory `/work/video/kernel'
>>make: *** [vmlinux] Ошибка 2
>>
>>It's not a "sound drivers" problem, howewer without it kernel compiles
>>and run succesfully. Seems like gcc/bunitils bug/feature. What have to
>>be done to eliminate this error?
>>
>>GNU ld version 2.15.96 20050308
>>gcc version 3.4.3
> 
> 
> Don't use gcc 3.4 to compile Linux 2.4.  It may work for some kernel
> configurations but it will fail for others.
> 
>   Ralf

I would've thought this was fixed in 2.4.x now.  You might try using newer 
sources.  The below patch fixes the issue:

http://dev.gentoo.org/~kumba/tmp/gcc-strcpy-fix.patch


As the original patch I found stated about gcc-3.4.x:

From: Jan Hubicka <jh@suse.cz>

GCC now converts sprintf (a,"%s",b) to strcpy.  This lose on kernel as
strcpy is not inlined and not present in library, so one gets linker
failure.  It seems to make sense to apply this optimization by hand.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond

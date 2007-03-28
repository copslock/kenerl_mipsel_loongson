Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2007 14:26:51 +0100 (BST)
Received: from alnrmhc16.comcast.net ([206.18.177.56]:65535 "EHLO
	alnrmhc16.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20022005AbXC1N0t (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Mar 2007 14:26:49 +0100
Received: from [192.168.1.4] (c-69-251-93-234.hsd1.md.comcast.net[69.251.93.234])
          by comcast.net (alnrmhc16) with ESMTP
          id <20070328132605b1600dibvae>; Wed, 28 Mar 2007 13:26:06 +0000
Message-ID: <460A6CED.1070308@gentoo.org>
Date:	Wed, 28 Mar 2007 09:26:05 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0b2 (Windows/20070116)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ths@networkno.de, ralf@linux-mips.org
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
References: <4607CF1D.50904@gentoo.org>	<20070326.234316.23009158.anemo@mba.ocn.ne.jp>	<46086A90.7070402@gentoo.org> <20070327.235310.128618679.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070327.235310.128618679.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14750
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Mon, 26 Mar 2007 20:51:28 -0400, Kumba <kumba@gentoo.org> wrote:
>> Lets try this one; the kernel was built with gcc-4.1.2 and binutils-2.17 this 
>> time around, and I tested it before running objdump on it.  It just hangs right 
>> after loading:
>>
>>  > bootp(): console=ttyS0,38400 root=/dev/md0
>> Setting $netaddr to 192.168.1.12 (from server )
>> Obtaining  from server
>> 4358278+315290 entry: 0x80401000
> 
> Now I can not see any problem with the disassembled code.  No idea why
> it does not work at all...
> 
> BTW, why IP32 does not support 32-bit kernel, though it has 32-bit
> firmware?

Well, what's the need to use the move/lui/ld sequence over 
move/lui/daddui/dsll/daddui/dsll//ld anyways?  I'll have to warm the Indy up and 
try a 64bit kernel there I guess, to see if it exhibits similar issues with this 
segment of code.


--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Nov 2004 01:34:41 +0000 (GMT)
Received: from lennier.cc.vt.edu ([IPv6:::ffff:198.82.162.213]:57255 "EHLO
	lennier.cc.vt.edu") by linux-mips.org with ESMTP
	id <S8225008AbUKYBeh>; Thu, 25 Nov 2004 01:34:37 +0000
Received: from dagger.cc.vt.edu (IDENT:mirapoint@evil-dagger.cc.vt.edu [10.1.1.11])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id iAP1WFFP004622;
	Wed, 24 Nov 2004 20:32:15 -0500
Received: from [192.168.1.2] (68-232-97-125.chvlva.adelphia.net [68.232.97.125])
	by dagger.cc.vt.edu (MOS 3.4.8-GR)
	with ESMTP id CCH25483 (AUTH spbecker);
	Wed, 24 Nov 2004 20:34:28 -0500 (EST)
Message-ID: <41A536A5.5050508@gentoo.org>
Date: Wed, 24 Nov 2004 20:34:29 -0500
From: "Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041119)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: TheNop <TheNop@gmx.net>
CC: linux-mips@linux-mips.org
Subject: Re: Cross tool chain based on gcc-3.4.x
References: <41A3CE25.7040406@gmx.net> <41A3E3E7.7020701@gentoo.org> <41A510DE.8030004@gmx.net>
In-Reply-To: <41A510DE.8030004@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

TheNop wrote:
> Stephen P. Becker wrote:
> 
>> TheNop wrote:
>>
>>> Hello,
>>>
>>> I try to get a cross compiler based on
>>> gcc-3.4.2
>>> glibc-2.3.2
>>> binutils-2.15
>>> working;  without success.
>>>
>>> Is anyone using a cross compiler base on  gcc-3.4.x for a mips big 
>>> endian target?
>>>
>>> Best regarts
>>> TheNop
>>>
>>
>> I've got a very recent i686->mips-unknown-linux-gnu cross-toolchain 
>> available 
>> at:http://dev.gentoo.org/~geoman/mips-glibc-crosstools.tar.bz2 if you 
>> are too frustrated with building your own.
>>
>> It includes gcc-3.4.3, glibc-2.3.4 (20041102), and binutils 2.15.91.0.2.
>>
>> Steve
>>
>>
> Hi Steve,
> 
> thanx a lot.
> This tool chain works perfectly for me. Now I can build 2.6.x kernel.
> In the past I tried to build a cross tool chain using crosstools. I 
> don`t get any combination of gcc-3.4.x/glibc-2.x.x working. Only the 
> gcc-3.4.x-glibc-2.3.3 combination I could compile without errors, but I 
> couldn't compile a 2.6.x kernel.
> 
> Could you please tell me, how you compile the tool chain?
> It would be great, if you can provide me a script or a list of patches 
> you applied for building.
> 
> Best regards
> TheNop
> 
> 

Actually, if you just wanted to build kernels, you don't need glibc at 
all.  Just build binutils and then a bootstrap gcc compiler, and you are 
set.  The only reason I messed with a full toolchain at all is so that I 
can use c++ through distcc.

Steve

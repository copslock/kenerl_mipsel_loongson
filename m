Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2004 22:47:19 +0000 (GMT)
Received: from pop.gmx.net ([IPv6:::ffff:213.165.64.20]:60644 "HELO
	mail.gmx.net") by linux-mips.org with SMTP id <S8225208AbUKXWrG>;
	Wed, 24 Nov 2004 22:47:06 +0000
Received: (qmail 4195 invoked by uid 65534); 24 Nov 2004 22:47:00 -0000
Received: from c209182.adsl.hansenet.de (EHLO [192.168.0.1]) (213.39.209.182)
  by mail.gmx.net (mp010) with SMTP; 24 Nov 2004 23:47:00 +0100
X-Authenticated: #947741
Message-ID: <41A510DE.8030004@gmx.net>
Date: Wed, 24 Nov 2004 23:53:18 +0100
From: TheNop <TheNop@gmx.net>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: Cross tool chain based on gcc-3.4.x
References: <41A3CE25.7040406@gmx.net> <41A3E3E7.7020701@gentoo.org>
In-Reply-To: <41A3E3E7.7020701@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <TheNop@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: TheNop@gmx.net
Precedence: bulk
X-list: linux-mips

Stephen P. Becker wrote:

> TheNop wrote:
>
>> Hello,
>>
>> I try to get a cross compiler based on
>> gcc-3.4.2
>> glibc-2.3.2
>> binutils-2.15
>> working;  without success.
>>
>> Is anyone using a cross compiler base on  gcc-3.4.x for a mips big 
>> endian target?
>>
>> Best regarts
>> TheNop
>>
>
> I've got a very recent i686->mips-unknown-linux-gnu cross-toolchain 
> available 
> at:http://dev.gentoo.org/~geoman/mips-glibc-crosstools.tar.bz2 if you 
> are too frustrated with building your own.
>
> It includes gcc-3.4.3, glibc-2.3.4 (20041102), and binutils 2.15.91.0.2.
>
> Steve
>
>
Hi Steve,

thanx a lot.
This tool chain works perfectly for me. Now I can build 2.6.x kernel.
In the past I tried to build a cross tool chain using crosstools. I 
don`t get any combination of gcc-3.4.x/glibc-2.x.x working. Only the 
gcc-3.4.x-glibc-2.3.3 combination I could compile without errors, but I 
couldn't compile a 2.6.x kernel.

Could you please tell me, how you compile the tool chain?
It would be great, if you can provide me a script or a list of patches 
you applied for building.

Best regards
TheNop

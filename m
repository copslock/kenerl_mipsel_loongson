Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Feb 2005 18:15:33 +0000 (GMT)
Received: from mail.romat.com ([IPv6:::ffff:212.143.245.3]:61448 "EHLO
	mail.romat.com") by linux-mips.org with ESMTP id <S8225287AbVBUSPS>;
	Mon, 21 Feb 2005 18:15:18 +0000
Received: from localhost (localhost.lan [127.0.0.1])
	by mail.romat.com (Postfix) with ESMTP id 0CEB8EB2D3;
	Mon, 21 Feb 2005 20:15:12 +0200 (IST)
Received: from mail.romat.com ([127.0.0.1])
 by localhost (mail.romat.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 15326-01; Mon, 21 Feb 2005 20:15:05 +0200 (IST)
Received: from [192.168.1.199] (linux.lan [192.168.1.199])
	by mail.romat.com (Postfix) with ESMTP id 7F53CEB2B6;
	Mon, 21 Feb 2005 20:15:05 +0200 (IST)
Message-ID: <421A2526.6020806@romat.com>
Date:	Mon, 21 Feb 2005 20:15:02 +0200
From:	Gilad Rom <gilad@romat.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Clem Taylor <clem.taylor@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: compiling yamon for Au1550 with a recent toolchain?
References: <ecb4efd1050221083348d1f90b@mail.gmail.com>
In-Reply-To: <ecb4efd1050221083348d1f90b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new at romat.com
Return-Path: <gilad@romat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gilad@romat.com
Precedence: bulk
X-list: linux-mips

I have. I can tell you it required a lot of hacking, most of which
I haven't written down.

I can send you my sources if you'd like. They're hardwired for
Au1500/Little Endian, but they build ;)
Shoudn't take long to change the actual build type.

Gilad.

Clem Taylor wrote:
> This isn't completely on topic, but it is a step on the way. I'm
> getting ready for my Au1550 based hardware that will be back from
> assembly soon. I'm trying to get the AMD provided yamon source to
> compile. I'm using gcc 3.4.3 and bintools 2.15.94.0.2. After a few
> tweeks to the makefile, yamon compiles but fails to link:
> 
> mips-ld -G 0 -T ./../link/link_el.xn -o ./yamon-02.23DB1550_el.elf -Map ...
> mips-ld: section .data [000000009fc3d650 -> 000000009fc40faf] overlaps
> section .rodata.str1.4 [000000009fc3d650 -> 000000009fc47197]
> mips-ld: ./yamon-02.23DB1550_el.elf: section .rodata.str1.4 lma
> 0x9fc3d650 overlaps previous sections
> mips-ld: ./yamon-02.23DB1550_el.elf: section .rodata.cst4 lma
> 0x9fc47198 overlaps previous sections
> 
> The linker command file (bin/link/link_el.xn) puts .data and .rodata
> in _etext. I changed the *(.rodata) to *(.rodata*) in the link_el.xn,
> but that didn't help.
> 
> Any ideas what might be going on? Has anyone tried compiling this
> yamon with a recent gcc/bintools?
> 
>                                   Thanks,
>                                   Clem
> 
> 

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2005 04:24:27 +0000 (GMT)
Received: from rwcrmhc11.comcast.net ([IPv6:::ffff:204.127.198.35]:54154 "EHLO
	rwcrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8224772AbVCQEYM>; Thu, 17 Mar 2005 04:24:12 +0000
Received: from [192.168.1.4] (pcp05077810pcs.waldrf01.md.comcast.net[68.54.246.193])
          by comcast.net (rwcrmhc11) with ESMTP
          id <2005031704240401300ed4fqe>; Thu, 17 Mar 2005 04:24:05 +0000
Message-ID: <4239066E.8080900@gentoo.org>
Date:	Wed, 16 Mar 2005 23:24:14 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Leonel Gayard <leonel.gayard@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: How do I compile GCC to generate MIPS code ?
References: <2ccb2254050316185449699409@mail.gmail.com>
In-Reply-To: <2ccb2254050316185449699409@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Leonel Gayard wrote:
> Hi all,
> 
> I have recently started to study the MIPS architecture. For instance,
> I wanted to have GCC compile C code into MIPS assembly and run it in
> SPIM. (I have an Intel machine running Linux).
> 
> So I want to try something like this:
> 
> gcc -Wall -pedantic -S --march=mips1 test.c
> 
> in order to have it generate MIPS assembly.
> 
> It does not work. All I get is:
> 
> cc1: error: bad value (mips32) for -march= switch
> cc1: error: bad value (mips32) for -mcpu= switch
> 
> Clearly, I need to recompile GCC so it has MIPS in its available
> architectures. Remark, this is not cross-compiling, because I want GCC
> to run on an i686 machine, it just generates MIPS code.
> 
> Can any one help me do this ?
> 
> Thank you
> Leonel

Cross compiling is the (black) art of building a compiler that runs on Arch X, 
but generates code for Arch Y.  You definitely do not want to replace your 
system compiler (that is, i686-pc-linux-gnu-gcc) with a mips one, cause then 
you won't be able to rebuild i686 packages.  You want a second compiler to be 
available capable of handling mips-unknown-linux-gnu.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: small 
hands do them because they must, while the eyes of the great are elsewhere." 
--Elrond

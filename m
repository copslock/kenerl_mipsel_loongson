Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Feb 2005 14:00:17 +0000 (GMT)
Received: from amsfep14-int.chello.nl ([IPv6:::ffff:213.46.243.21]:42537 "EHLO
	amsfep14-int.chello.nl") by linux-mips.org with ESMTP
	id <S8225216AbVB1OAB>; Mon, 28 Feb 2005 14:00:01 +0000
Received: from [127.0.0.1] (really [62.195.248.222])
          by amsfep14-int.chello.nl
          (InterMail vM.6.01.03.04 201-2131-111-106-20040729) with ESMTP
          id <20050228135953.CHVF1537.amsfep14-int.chello.nl@[127.0.0.1]>;
          Mon, 28 Feb 2005 14:59:53 +0100
Message-ID: <4223240C.4010207@amsat.org>
Date:	Mon, 28 Feb 2005 15:00:44 +0100
From:	Jeroen Vreeken <pe1rxq@amsat.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Geert Uytterhoeven <geert@linux-m68k.org>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: sparse and mips
References: <422256A3.2030407@amsat.org> <20050228121120.GA11719@linux-mips.org> <Pine.LNX.4.62.0502281325390.5171@numbat.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0502281325390.5171@numbat.sonytel.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <pe1rxq@amsat.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pe1rxq@amsat.org
Precedence: bulk
X-list: linux-mips

Geert Uytterhoeven wrote:

>You're using 2.6.10?
>
>When I played with sparse on m68k (cross-compile environment), I had to make
>some modifications to arch/m68k/Makefile, to pass a few additional flags to
>sparse in case of cross-compilation. Later these changes were moved to the main
>Makefile, since they were valid for all architectures if cross-compilation was
>involved.
>
>So I suggest to take a look at CHECKFLAGS in the main Makefile of the latest
>version (2.6.11-rc5) first, and see whether it works there.
>  
>
Adding the following few lines fixes the problems with the headers (they 
are normally defined by gcc)...
I am not sure that is all that is needed (the rest might just be me 
doing bad things in my driver) but since they are mips specific I think 
arch/mips/Makefile would be the right place for them:

CHECKFLAGS    += -D__mips__
ifdef CONFIG_MIPS32
CHECKFLAGS    += -D_MIPS_SZLONG=32
else
CHECKFLAGS    += -D_MIPS_SZLONG=64
endif
ifdef CONFIG_CPU_LITTLE_ENDIAN
CHECKFLAGS    += -D__MIPSEL__
else
CHECKFLAGS    += -D__MIPSEB__
endif

Jeroen

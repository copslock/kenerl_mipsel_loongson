Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Mar 2005 11:18:32 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:6161 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225305AbVCCLSR>; Thu, 3 Mar 2005 11:18:17 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j23BElM8009004;
	Thu, 3 Mar 2005 11:14:48 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j23Akti3007358;
	Thu, 3 Mar 2005 10:46:55 GMT
Date:	Thu, 3 Mar 2005 10:46:54 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jeroen Vreeken <pe1rxq@amsat.org>
Cc:	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: sparse and mips
Message-ID: <20050303104654.GB5457@linux-mips.org>
References: <422256A3.2030407@amsat.org> <20050228121120.GA11719@linux-mips.org> <Pine.LNX.4.62.0502281325390.5171@numbat.sonytel.be> <4223240C.4010207@amsat.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4223240C.4010207@amsat.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 28, 2005 at 03:00:44PM +0100, Jeroen Vreeken wrote:

> Adding the following few lines fixes the problems with the headers (they 
> are normally defined by gcc)...
> I am not sure that is all that is needed (the rest might just be me 
> doing bad things in my driver) but since they are mips specific I think 
> arch/mips/Makefile would be the right place for them:
> 
> CHECKFLAGS    += -D__mips__
> ifdef CONFIG_MIPS32
> CHECKFLAGS    += -D_MIPS_SZLONG=32

I went for something slightly more beautyful:

CHECKFLAGS-y                            += -D__linux__ -D__mips__
CHECKFLAGS-$(CONFIG_MIPS32)             += -D_MIPS_SZLONG=32 \
                                           -D__PTRDIFF_TYPE__=int
CHECKFLAGS-$(CONFIG_MIPS64)             += -D_MIPS_SZLONG=64 \
                                           -D__PTRDIFF_TYPE__="long int"
CHECKFLAGS-$(CONFIG_CPU_BIG_ENDIAN)     += -D__MIPSEL__
CHECKFLAGS-$(CONFIG_CPU_LITTLE_ENDIAN)  += -D__MIPSEL__

Still needs a few more symbols I guess.  And I fixed a few of the worst
offenders, especially uaccess.h.

  Ralf

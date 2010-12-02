Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2010 16:16:03 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47773 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493245Ab0LBPP4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Dec 2010 16:15:56 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oB2FFl1P008952;
        Thu, 2 Dec 2010 15:15:47 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oB2FFk1j008950;
        Thu, 2 Dec 2010 15:15:46 GMT
Date:   Thu, 2 Dec 2010 15:15:46 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     wu zhangjin <wuzhangjin@gmail.com>
Cc:     Arnaud Lacombe <lacombar@gmail.com>,
        John Reiser <jreiser@bitwagon.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-mips@linux-mips.org
Subject: Re: Build failure triggered by recordmcount
Message-ID: <20101202151546.GB7503@linux-mips.org>
References: <AANLkTikjbP89qp24u1Pw6zcsyV7WcYYtmR0Yt3yCaXoh@mail.gmail.com>
 <AANLkTim-+1csKoCc7kqXERmLZRSt9LAAB=JPK+0gaYPo@mail.gmail.com>
 <AANLkTikaUxKqsqXKYpETOnWAMuCi5gp30ANux0RQuK6Z@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTikaUxKqsqXKYpETOnWAMuCi5gp30ANux0RQuK6Z@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 22, 2010 at 10:57:40PM +0800, wu zhangjin wrote:

> The cause should be the endian problem, I guess you were cross-compiling it?
> 
> If we compile the kernel for (32bit + big endian) target on an x86
> machine(little endian) or reversely, then, it will fail.
> 
> Since the scripts/recordmcount is compiled with the local toolchain,
> the data structs will be explained according to the local
> configuration(endian...).
> 
> So, we may need to custom our own elf.h for recordmcount according to
> the target type(endian here) of the kernel image:
> 
> At first, pass the target information to recordmcount(only a demo
> here, we may need to clear it carefully):
> 
> diff --git a/scripts/Makefile b/scripts/Makefile
> index 2e08810..151fe3e 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -11,6 +11,9 @@ hostprogs-$(CONFIG_KALLSYMS)     += kallsyms
>  hostprogs-$(CONFIG_LOGO)         += pnmtologo
>  hostprogs-$(CONFIG_VT)           += conmakehash
>  hostprogs-$(CONFIG_IKCONFIG)     += bin2c
> +HOSTCFLAGS_recordmcount.o        += -DARCH=__$(ARCH)__ \
> +       -DBIT=__$(if $(CONFIG_64BIT),64,32)__           \
> +       -DENDIAN=__$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)__
>  hostprogs-$(BUILD_C_RECORDMCOUNT) += recordmcount
> 
>  always         := $(hostprogs-y) $(hostprogs-m)

FYI, dropping this one from the patchworks queue then as John's patch seems
to be the right thing.

  Ralf

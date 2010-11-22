Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Nov 2010 19:47:08 +0100 (CET)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:62755 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492049Ab0KVSrC convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Nov 2010 19:47:02 +0100
Received: by pwj8 with SMTP id 8so1828497pwj.36
        for <linux-mips@linux-mips.org>; Mon, 22 Nov 2010 10:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vpyPoD86GmieFhbJ5NE8lrs8DREBvIGxXxNh5DY4D9c=;
        b=N/v2fE6cWZqxCYBxeR3/xM1kkKzFxxIeD6cAE4yk7SwV2eqlmwEfppUghM4A6K18ZW
         RZIg4QJIgtBKnTM0zOlrxguuButeHi8i9VQ8QWgxCFKkZBr6ZOeKRrZjKeUoYB/+beWh
         rxPTWk0ROHqGSlCy4NvKgbYjxdiEVOH1cRhXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AmYTM8vGDKipSk1X/4kF1CPwRMwW+y/Oq1aoEJxeiTe7yWHMMQvGkpIfoCF4IQ0Dw1
         tVCYF6SmkF0fDTVa86Vofg75Eu96gG1QfP0D5oTKYsJrxgfG6hOy5j58JXMT8KBeU3r/
         CpoitqzA1a8QXYRDrj9SIV807jaDbOZqhfsZs=
MIME-Version: 1.0
Received: by 10.229.184.8 with SMTP id ci8mr5392603qcb.72.1290451615082; Mon,
 22 Nov 2010 10:46:55 -0800 (PST)
Received: by 10.229.182.3 with HTTP; Mon, 22 Nov 2010 10:46:54 -0800 (PST)
In-Reply-To: <AANLkTikaUxKqsqXKYpETOnWAMuCi5gp30ANux0RQuK6Z@mail.gmail.com>
References: <AANLkTikjbP89qp24u1Pw6zcsyV7WcYYtmR0Yt3yCaXoh@mail.gmail.com>
        <AANLkTim-+1csKoCc7kqXERmLZRSt9LAAB=JPK+0gaYPo@mail.gmail.com>
        <AANLkTikaUxKqsqXKYpETOnWAMuCi5gp30ANux0RQuK6Z@mail.gmail.com>
Date:   Mon, 22 Nov 2010 13:46:54 -0500
Message-ID: <AANLkTinr1bU+_YCTW9xyJ9H0qiSOifBMsxC6iujszMvs@mail.gmail.com>
Subject: Re: Build failure triggered by recordmcount
From:   Arnaud Lacombe <lacombar@gmail.com>
To:     wu zhangjin <wuzhangjin@gmail.com>
Cc:     John Reiser <jreiser@bitwagon.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <lacombar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lacombar@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Mon, Nov 22, 2010 at 9:57 AM, wu zhangjin <wuzhangjin@gmail.com> wrote:
> Hi,
>
> The cause should be the endian problem, I guess you were cross-compiling it?
>
yes.

> If we compile the kernel for (32bit + big endian) target on an x86
> machine(little endian) or reversely, then, it will fail.
>
> Since the scripts/recordmcount is compiled with the local toolchain,
> the data structs will be explained according to the local
> configuration(endian...).
>
will it ? recordmcount.c does not switch endianness based on the host,
but based on format of the object file, see the switch
(ehdr->e_ident[EI_DATA]) { ... } in do_file(), the result does also
depend a runtime endianness check.

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
> @@ -11,6 +11,9 @@ hostprogs-$(CONFIG_KALLSYMS)     += kallsyms
>  hostprogs-$(CONFIG_LOGO)         += pnmtologo
>  hostprogs-$(CONFIG_VT)           += conmakehash
>  hostprogs-$(CONFIG_IKCONFIG)     += bin2c
> +HOSTCFLAGS_recordmcount.o        += -DARCH=__$(ARCH)__ \
> +       -DBIT=__$(if $(CONFIG_64BIT),64,32)__           \
> +       -DENDIAN=__$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)__
>  hostprogs-$(BUILD_C_RECORDMCOUNT) += recordmcount
>
>  always         := $(hostprogs-y) $(hostprogs-m)
>
hum,

% grep "BIT\|ENDIAN" scripts/recordmcount.*
scripts/recordmcount.h: mcsec.sh_type = w(SHT_PROGBITS);
scripts/recordmcount.h: if (SHT_PROGBITS != w(txthdr->sh_type) ||

so none these macro are not checked explicitly, and headers included
should not either.

 - Arnaud

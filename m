Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Dec 2009 20:06:13 +0100 (CET)
Received: from mail-ew0-f223.google.com ([209.85.219.223]:33259 "EHLO
        mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1494393AbZLNTGA convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Dec 2009 20:06:00 +0100
Received: by ewy23 with SMTP id 23so2025906ewy.24
        for <multiple recipients>; Mon, 14 Dec 2009 11:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=JyM2wfXylOHk+NH5lbls2axSSvPl5h1jp1Bc4SrPbXA=;
        b=mHDSUWxR7m0nID86WwNB9pICcrOv61/322gZ5Fnz3WT3Nwp9gzlgi0AhgREH/CXxPy
         V05Sy6bYuwIW0OZFljn8Asp4kEb6JJsX1DA85xv5Qkg4Uvy00oLrEOW5F1xRIhheFAnj
         60zEnOPPyNAzfqd1c75u3nINC4g5+gDmVOFy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=H82P5nTuq7crjvYsfLN8DDQ+BozLA2B4He+VIxjVvpJsi1blzuTRVqw8z5FEPwRm84
         MfV04Qj/GC7J/4uJ1f0NwXQYTVQkzpN0OEfV50Yuvz004KwLrt9mybsXvTbFx5SrXJeG
         QEMwCMigqWNv3ZbXmZ2RpcQrwPbJtIY7kHqiU=
MIME-Version: 1.0
Received: by 10.216.85.210 with SMTP id u60mr2071823wee.226.1260817550721; 
        Mon, 14 Dec 2009 11:05:50 -0800 (PST)
In-Reply-To: <200912141802.13171.ffainelli@freebox.fr>
References: <200912121757.56365.ffainelli@freebox.fr>
         <20091212193114.GA11103@alpha.franken.de>
         <200912141802.13171.ffainelli@freebox.fr>
Date:   Mon, 14 Dec 2009 20:05:50 +0100
X-Google-Sender-Auth: 1e14a4d88ce5b7d9
Message-ID: <10f740e80912141105kcccb4e9y68cf47b35bb7a648@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: add readl/write_be
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Florian Fainelli <ffainelli@freebox.fr>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>,
        ralf@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 14, 2009 at 18:02, Florian Fainelli <ffainelli@freebox.fr> wrote:
> On Saturday 12 December 2009 20:31:14 Thomas Bogendoerfer wrote:
>> On Sat, Dec 12, 2009 at 05:57:56PM +0100, Florian Fainelli wrote:
>> > +#define readl_be(addr)                     __raw_readl((__force unsigned *)addr)
>> > +#define writel_be(val, addr)               __raw_writel(val, (__force unsigned
>> > *)addr)
>>
>> looks broken for little endian machines. __raw_XXX doesn't do any swapping,
>> so IMHO the correct thing would be to use be32_to_cpu/cpu_to_be32.
>
> Yeah, I missed that point. Please find below version 2 of the patch which also addresses David's comment.
> --
> From: Florian Fainelli <ffainelli@freebox.fr>
> Subject: [PATCH v2] MIPS: add readl_be/writel_be
>
> MIPS currently lacks the readl_be and writel_be accessors
> which are required by BCM63xx for OHCI and EHCI support.
> Let's define them globally for MIPS. This also fixes the
> compilation of the bcm63xx defconfig against USB.
>
> Changes from v1:
> - make it work on little-endian machines
> - protect macros arguments with parenthesis
>
> Signed-off-by: Florian Fainelli <ffainelli@freebox.fr>
> ---
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index 436878e..4a76d39 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -447,6 +447,9 @@ __BUILDIO(q, u64)
>  #define readl_relaxed                  readl
>  #define readq_relaxed                  readq
>
> +#define readl_be(addr)                 cpu_to_be32(__raw_readl((__force unsigned *)(addr)))
> +#define writel_be(val, addr)           __raw_writel(be32_to_cpu((val)), (__force unsigned *)(addr))

Shouldn't it be the other way around (cpu <-> be32), i.e.

#define readl_be(addr)
be32_to_cpu(__raw_readl((__force unsigned *)(addr)))
#define writel_be(val, addr)
__raw_writel(cpu_to_be32((val)), (__force unsigned *)(addr))

? I know it'll work both ways, though...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

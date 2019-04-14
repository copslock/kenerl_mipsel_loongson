Return-Path: <SRS0=Gg09=SQ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F878C10F13
	for <linux-mips@archiver.kernel.org>; Sun, 14 Apr 2019 21:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A3520850
	for <linux-mips@archiver.kernel.org>; Sun, 14 Apr 2019 21:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7D4zOoM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfDNVUJ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 14 Apr 2019 17:20:09 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:40396 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfDNVUJ (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 14 Apr 2019 17:20:09 -0400
Received: by mail-wm1-f44.google.com with SMTP id z24so17765951wmi.5
        for <linux-mips@vger.kernel.org>; Sun, 14 Apr 2019 14:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2AGQIFcQxasa4udfiLKZK+AfZp6PqqxaaIedPAmmEk8=;
        b=A7D4zOoM6yzT1nQ5x7COZO5/50Wu9hSleT7BkgM0flgYUOEIIb50dPi3AS3UsZzoye
         MLQ0uYybgtEfCm/0BYkExIymveZodOlx5cDFuRQ0MBUGnZ4xycs+wXy4W2nrlNM/mmgj
         Q9fIw6SIOmOEoSJE9AWRn3a8sqKSw7XBjQaxQ7fjBNqw8e7/CJ6MItQa00BvJs2k/y9J
         EjrgXQEdGOy7w9DvMSl2GGgqnwVav9t/R6sjU4QBoP1LzN+XF92SSu6aUwmxleo6MnfH
         A2ADn4hMnBJATMeU7bmZzioh8kzMjDpebLwoowgRcoMjiZ0JzdWBVYWpH4mFhpVgUOkv
         igyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2AGQIFcQxasa4udfiLKZK+AfZp6PqqxaaIedPAmmEk8=;
        b=MFyyxdNFCGNVOkngls1B/0UdPzky8ARoylUXljh22R+tR8Z1i/qzeubsS/4OeRUiAV
         XZIC0enlkSoH2qmOhlN+qNTBDRVSDEKZ/AIPSi0pY0eMaUV0K7rl+vFaILic21vpVxQj
         dRMCO7BahHdofww226yQ9ARXyouWLGEcPXjOyiK6d6I+RPnwqq8z+OpqJlbPwbFCusBK
         6MsG9WPGDLmVc7IIqXYHWGiFO2xISjvzAj4hb1XV6+6yd6vYh2/MXpUTEt+HL3ag7fIW
         /k27DEK3hpa83Q7fHbSfeQKFGVLCO6ef7TVF/HR/Z565iqAC1Eznk7tm9Ie3fKIFSoi+
         ndqg==
X-Gm-Message-State: APjAAAWQy6ZXrPWNdkztC1JXs3jGeoS9yPPz/OmGaYQVsob1+P6SSZRF
        6mLOKL5FDcww2B2m+xfGvW0=
X-Google-Smtp-Source: APXvYqx/Oyratk46WPRqIceSBQDg54i6OBY8KRceKtmDy3Jf/BSdP9ltW+GFVe+UZMVL4vmwt0TkmA==
X-Received: by 2002:a05:600c:2118:: with SMTP id u24mr19375779wml.24.1555276807659;
        Sun, 14 Apr 2019 14:20:07 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net. [88.21.103.193])
        by smtp.gmail.com with ESMTPSA id n1sm12890495wmc.19.2019.04.14.14.20.06
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 14:20:06 -0700 (PDT)
Subject: Re: [RFC] MIPS: Install final length of TLB refill handler rather
 than 256 bytes
To:     Fredrik Noring <noring@nocrew.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>
References: <20190405160531.GF33393@sx9>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Openpgp: url=http://pgp.mit.edu/pks/lookup?op=get&search=0xE3E32C2CDEADC0DE
Message-ID: <5b42742e-b9fb-996a-fbe4-918d48aa0a18@amsat.org>
Date:   Sun, 14 Apr 2019 23:20:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405160531.GF33393@sx9>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Fredrik,

On 4/5/19 6:05 PM, Fredrik Noring wrote:
> The R5900 TLB refill handler is limited to 128 bytes, corresponding
> to 32 instructions.

There is a comment about the R4000 worst case:

 /* The worst case length of the handler is around 18 instructions for
  * R3000-style TLBs and up to 63 instructions for R4000-style TLBs.
  * Maximum space available is 32 instructions for R3000 and 64
  * instructions for R4000.

So you need to check the handler generated for your cpu doesn't exceed
your 32 instructions.

> Installing a 256 byte TLB refill handler for the R5900 at address
> 0x80000000 overwrites the performance counter handler at address
> 0x80000080, according to the TX79 manual[1]:
> 
>         Table 5-2. Exception Vectors for Level 1 exceptions
> 
>              Exceptions      |      Vector Address
>                              |   BEV = 0  |   BEV = 1
>         ---------------------+------------+-----------
>         TLB Refill (EXL = 0) | 0x80000000 | 0xBFC00200
>         TLB Refill (EXL = 1) | 0x80000180 | 0xBFC00380
>         Interrupt            | 0x80000200 | 0xBFC00400
>         Others               | 0x80000180 | 0xBFC00380
>         ---------------------+------------+-----------
> 
>         Table 5-3. Exception Vectors for Level 2 exceptions
> 
>              Exceptions      |      Vector Address
>                              |   DEV = 0  |   DEV = 1
>         ---------------------+------------+-----------
>         Reset, NMI           | 0xBFC00000 | 0xBFC00000
>         Performance Counter  | 0x80000080 | 0xBFC00280
>         Debug, SIO           | 0x80000100 | 0xBFC00300
>         ---------------------+------------+-----------
> 
> Reference:
> 
> [1] "TX System RISC TX79 Core Architecture" manual, revision 2.0,
>     Toshiba Corporation, p. 5-7, https://wiki.qemu.org/File:C790.pdf
> 
> Signed-off-by: Fredrik Noring <noring@nocrew.org>
> ---
> Hi MIPS maintainers,
> 
> Reading through the TX79 manual I noticed that the installation of
> the TLB refill handler seems to overwrite the performance counter
> handler. Is there any particular reason to not install the actual
> lengths of the handlers, such as memory boundaries or alignments?
> 
> I have a separate patch that checks the R5900 handler length limit,
> but it depends on R5900 support, which isn't merged (yet).
> 
> Fredrik
> ---
> 
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -1462,9 +1462,9 @@ static void build_r4000_tlb_refill_handler(void)
>  	pr_debug("Wrote TLB refill handler (%u instructions).\n",
>  		 final_len);
>  

> -	memcpy((void *)ebase, final_handler, 0x100);
> -	local_flush_icache_range(ebase, ebase + 0x100);
> -	dump_handler("r4000_tlb_refill", (u32 *)ebase, (u32 *)(ebase + 0x100));
> +	memcpy((void *)ebase, final_handler, 4 * final_len);
> +	local_flush_icache_range(ebase, ebase + 4 * final_len);
> +	dump_handler("r4000_tlb_refill", (u32 *)ebase, (u32 *)(ebase + 4 * final_len));

Maybe you could modify the logic few lines earlier that check and
panic("TLB refill handler space exceeded") and add a case for your cpu
type. There you could set a handler_max_size = 0x80, 0x100 else.

Take my comment as RFC too, I'm just wondering :)

Regards,

Phil.

>  }
>  
>  static void setup_pw(void)
> 
> 

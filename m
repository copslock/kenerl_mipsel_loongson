Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2017 21:06:46 +0200 (CEST)
Received: from mail-qk0-x241.google.com ([IPv6:2607:f8b0:400d:c09::241]:33689
        "EHLO mail-qk0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994812AbdEWTGjpJsOD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 May 2017 21:06:39 +0200
Received: by mail-qk0-x241.google.com with SMTP id o85so23966676qkh.0;
        Tue, 23 May 2017 12:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/pP4Kg+kwQIpYFdKL2NH0iOBuCFPeywm9E5BhoohfC0=;
        b=jr99V4fIOvFcXVDAvc2BeBtJMuZ+xNxWCzGjO/nVNRfWDrbE40rx68YoxOxQP6VI2c
         ECvI7yKNCBWZyZ6CJMnWT+Pr06IofbSaUPaGD8IAO6uXKqtrokLpb7SlZSBwkh59ENk6
         AxLsVeHdNgZkS/YqgloWwspsfosBBUx07SzJN6wP5bwh4neSw9xKJCL/GMOKENtcDxT8
         Em6NLVcv75xOT3ZO1luiqBRRnTBayL9OlXUnQYXzFPu5+rTeDuWMGUF59ApjTN+/zO48
         Vrf368XiQ7cj9eWuhbQF0AzjDYSj1NKtaTVVLdAyMp7ueKd1qcHg+K7KlP8nd7a9YSHQ
         sczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/pP4Kg+kwQIpYFdKL2NH0iOBuCFPeywm9E5BhoohfC0=;
        b=BYlxf2ufgievg7nOAClGAt+Iwg+5/vYJE6Lm7z/y2qrLLne2+ENOqllG8Ppq2BvR7q
         9Dv059rFFOi4crJ0GPTVFi9TlF6fFZ3ZjiYu6RHKChlU3uTKqsDLmud5fBjkxNuiQg9y
         1nfEkr5Eia6Gv/c8W5MgNJF5imM0dte9QtsbPF/X0P61fcObkCYvC3buucIVh8jKa0KG
         y74M+4bh2RSeUGn5Uw2JeSsrwFPP9dGCKydXjdF4DvtNrg/343gkEkfKtHibBXzlGr3J
         2SQUHZGt1M0/EGQZrFop0eECYrQSr8o0RpDT/tzliRiQmnsBPD7+R/u4rc0FkSfLtsdE
         HIUQ==
X-Gm-Message-State: AODbwcCQafBj8MPPQmg1pofDB4Zyo7h/xscUQWEjN5ux+o9yLR24sPCj
        xo+f4iVt5IfFhg==
X-Received: by 10.55.169.193 with SMTP id s184mr26552153qke.118.1495566390405;
        Tue, 23 May 2017 12:06:30 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id 24sm1003246qtt.53.2017.05.23.12.06.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 12:06:29 -0700 (PDT)
Subject: Re: [PATCH 4/4] MIPS16e2: Provide feature overrides for non-MIPS16
 systems
To:     "Maciej W. Rozycki" <macro@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org
References: <alpine.DEB.2.00.1705180145220.2590@tp.orcam.me.uk>
 <alpine.DEB.2.00.1705230345530.2590@tp.orcam.me.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5cb0253e-8523-bf57-722a-a5ea19873121@gmail.com>
Date:   Tue, 23 May 2017 12:06:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1705230345530.2590@tp.orcam.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 05/23/2017 05:40 AM, Maciej W. Rozycki wrote:
> Hardcode the absence of the MIPS16e2 ASE for all the systems that do so 
> for the MIPS16 ASE already, providing for code to be optimized away.
> 
> Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
> ---

Could you switch to using git format-patch such that we have a diffstat
at the beginning of the patch which helps the reviewer figure out which
files are being touched?

It just occurred to me that a bunch of other platforms are lacking a
cpu-feature-overrides.h file, but presumably would never be able to
support mips16e2, like ar7, emma2rh, pnx833x and so on.

> linux-mips16e2-ase-optim.diff
> Index: linux-sfr-test/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
> ===================================================================
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h	2017-05-22 22:42:15.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h	2017-05-22 22:57:28.987400000 +0100
> @@ -40,6 +40,7 @@
>  #endif
>  
>  #define cpu_has_mips16			0
> +#define cpu_has_mips16e2		0
>  #define cpu_has_mdmx			0
>  #define cpu_has_mips3d			0
>  #define cpu_has_smartmips		0
> Index: linux-sfr-test/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
> ===================================================================
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h	2017-05-22 22:42:15.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h	2017-05-22 22:57:28.991406000 +0100
> @@ -31,6 +31,7 @@
>  #define cpu_has_ejtag			1
>  #define cpu_has_llsc			1
>  #define cpu_has_mips16			0
> +#define cpu_has_mips16e2		0
>  #define cpu_has_mdmx			0
>  #define cpu_has_mips3d			0
>  #define cpu_has_smartmips		0
> Index: linux-sfr-test/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h
> ===================================================================
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h	2017-05-22 22:42:15.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h	2017-05-22 22:57:28.995412000 +0100
> @@ -19,6 +19,7 @@
>  #define cpu_has_ejtag			1
>  #define cpu_has_llsc			1
>  #define cpu_has_mips16			0
> +#define cpu_has_mips16e2		0
>  #define cpu_has_mdmx			0
>  #define cpu_has_mips3d			0
>  #define cpu_has_smartmips		0

And why not mach-bmips/cpu-features-overrides.h?

> Index: linux-sfr-test/arch/mips/include/asm/mach-cobalt/cpu-feature-overrides.h
> ===================================================================
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-cobalt/cpu-feature-overrides.h	2017-05-22 22:42:15.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-cobalt/cpu-feature-overrides.h	2017-05-22 22:57:29.001406000 +0100
> @@ -37,6 +37,7 @@
>  #endif
>  
>  #define cpu_has_mips16		0
> +#define cpu_has_mips16e2	0
>  #define cpu_has_mdmx		0
>  #define cpu_has_mips3d		0
>  #define cpu_has_smartmips	0
> Index: linux-sfr-test/arch/mips/include/asm/mach-dec/cpu-feature-overrides.h
> ===================================================================
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-dec/cpu-feature-overrides.h	2017-05-22 22:42:15.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-dec/cpu-feature-overrides.h	2017-05-22 22:57:29.006398000 +0100
> @@ -27,6 +27,7 @@
>  #define cpu_has_mcheck			0
>  #define cpu_has_ejtag			0
>  #define cpu_has_mips16			0
> +#define cpu_has_mips16e2		0
>  #define cpu_has_mdmx			0
>  #define cpu_has_mips3d			0
>  #define cpu_has_smartmips		0
> Index: linux-sfr-test/arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h
> ===================================================================
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h	2017-05-22 22:42:15.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h	2017-05-22 22:57:29.010397000 +0100
> @@ -19,6 +19,7 @@
>  #define cpu_has_32fpr		1
>  #define cpu_has_counter		1
>  #define cpu_has_mips16		0
> +#define cpu_has_mips16e2	0
>  #define cpu_has_divec		0
>  #define cpu_has_cache_cdex_p	1
>  #define cpu_has_prefetch	0
> Index: linux-sfr-test/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h
> ===================================================================
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h	2017-05-22 22:42:15.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h	2017-05-22 22:57:29.020398000 +0100
> @@ -43,6 +43,7 @@
>  #define cpu_has_ejtag			0
>  #define cpu_has_llsc			1
>  #define cpu_has_mips16			0
> +#define cpu_has_mips16e2		0
>  #define cpu_has_mdmx			0
>  #define cpu_has_mips3d			0
>  #define cpu_has_smartmips		0
> Index: linux-sfr-test/arch/mips/include/asm/mach-ip28/cpu-feature-overrides.h
> ===================================================================
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-ip28/cpu-feature-overrides.h	2017-05-22 22:42:15.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-ip28/cpu-feature-overrides.h	2017-05-22 22:57:29.024398000 +0100
> @@ -16,6 +16,7 @@
>   */
>  #define cpu_has_watch		1
>  #define cpu_has_mips16		0
> +#define cpu_has_mips16e2	0
>  #define cpu_has_divec		0
>  #define cpu_has_vce		0
>  #define cpu_has_cache_cdex_p	0
> Index: linux-sfr-test/arch/mips/include/asm/mach-ip32/cpu-feature-overrides.h
> ===================================================================
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-ip32/cpu-feature-overrides.h	2017-05-22 22:42:15.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-ip32/cpu-feature-overrides.h	2017-05-22 22:57:29.028408000 +0100
> @@ -29,6 +29,7 @@
>  #define cpu_has_32fpr		1
>  #define cpu_has_counter		1
>  #define cpu_has_mips16		0
> +#define cpu_has_mips16e2	0
>  #define cpu_has_vce		0
>  #define cpu_has_cache_cdex_s	0
>  #define cpu_has_mcheck		0
> Index: linux-sfr-test/arch/mips/include/asm/mach-jz4740/cpu-feature-overrides.h
> ===================================================================
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-jz4740/cpu-feature-overrides.h	2017-05-22 22:42:15.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-jz4740/cpu-feature-overrides.h	2017-05-22 22:57:29.032407000 +0100
> @@ -23,6 +23,7 @@
>  #define cpu_has_ejtag 1
>  #define cpu_has_llsc		1
>  #define cpu_has_mips16 0
> +#define cpu_has_mips16e2	0
>  #define cpu_has_mdmx 0
>  #define cpu_has_mips3d 0
>  #define cpu_has_smartmips 0
> Index: linux-sfr-test/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
> ===================================================================
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h	2017-05-22 22:42:16.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h	2017-05-22 22:57:29.043398000 +0100
> @@ -32,6 +32,7 @@
>  #define cpu_has_mcheck		0
>  #define cpu_has_mdmx		0
>  #define cpu_has_mips16		0
> +#define cpu_has_mips16e2	0
>  #define cpu_has_mips3d		0
>  #define cpu_has_mipsmt		0
>  #define cpu_has_smartmips	0
> Index: linux-sfr-test/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
> ===================================================================
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h	2017-05-22 22:42:16.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h	2017-05-22 22:57:29.047397000 +0100
> @@ -13,6 +13,7 @@
>  #define cpu_has_4k_cache	1
>  #define cpu_has_watch		1
>  #define cpu_has_mips16		0
> +#define cpu_has_mips16e2	0
>  #define cpu_has_counter		1
>  #define cpu_has_divec		1
>  #define cpu_has_vce		0
> Index: linux-sfr-test/arch/mips/include/asm/mach-rc32434/cpu-feature-overrides.h
> ===================================================================
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-rc32434/cpu-feature-overrides.h	2017-05-22 22:42:16.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-rc32434/cpu-feature-overrides.h	2017-05-22 22:57:29.051411000 +0100
> @@ -48,6 +48,7 @@
>  #define cpu_has_llsc			1
>  
>  #define cpu_has_mips16			0
> +#define cpu_has_mips16e2		0
>  #define cpu_has_mdmx			0
>  #define cpu_has_mips3d			0
>  #define cpu_has_smartmips		0
> Index: linux-sfr-test/arch/mips/include/asm/mach-rm/cpu-feature-overrides.h
> ===================================================================
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-rm/cpu-feature-overrides.h	2017-05-22 22:42:16.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-rm/cpu-feature-overrides.h	2017-05-22 22:57:29.066402000 +0100
> @@ -17,6 +17,7 @@
>  #define cpu_has_counter		1
>  #define cpu_has_watch		0
>  #define cpu_has_mips16		0
> +#define cpu_has_mips16e2	0
>  #define cpu_has_divec		0
>  #define cpu_has_cache_cdex_p	1
>  #define cpu_has_prefetch	0
> Index: linux-sfr-test/arch/mips/include/asm/mach-sibyte/cpu-feature-overrides.h
> ===================================================================
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-sibyte/cpu-feature-overrides.h	2017-05-22 22:42:16.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-sibyte/cpu-feature-overrides.h	2017-05-22 22:57:29.070404000 +0100
> @@ -13,6 +13,7 @@
>   */
>  #define cpu_has_watch		1
>  #define cpu_has_mips16		0
> +#define cpu_has_mips16e2	0
>  #define cpu_has_divec		1
>  #define cpu_has_vce		0
>  #define cpu_has_cache_cdex_p	0
> Index: linux-sfr-test/arch/mips/include/asm/mach-tx49xx/cpu-feature-overrides.h
> ===================================================================
> --- linux-sfr-test.orig/arch/mips/include/asm/mach-tx49xx/cpu-feature-overrides.h	2017-05-22 22:42:16.000000000 +0100
> +++ linux-sfr-test/arch/mips/include/asm/mach-tx49xx/cpu-feature-overrides.h	2017-05-22 22:57:29.074404000 +0100
> @@ -6,6 +6,7 @@
>  #define cpu_has_inclusive_pcaches	0
>  
>  #define cpu_has_mips16		0
> +#define cpu_has_mips16e2	0
>  #define cpu_has_mdmx		0
>  #define cpu_has_mips3d		0
>  #define cpu_has_smartmips	0
> 


-- 
Florian

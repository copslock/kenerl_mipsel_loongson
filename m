Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2014 17:47:41 +0100 (CET)
Received: from mail-pa0-f44.google.com ([209.85.220.44]:50547 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817294AbaCXQrgq2eOF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Mar 2014 17:47:36 +0100
Received: by mail-pa0-f44.google.com with SMTP id bj1so5732181pad.3
        for <multiple recipients>; Mon, 24 Mar 2014 09:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Bml+15j+mhfkwuYvzh9wm/A3N5iKuKxiz9iZiuJvUxU=;
        b=b5eA3KoUj0UjV9tB2DfE61JBYxH2s85/KjIC7y9fR/HydOiyfVk+6mYAPCpob7Enng
         Z/7Xl35538Y0CdnHbkAZCoWvaKcQhms1XG2+6wXinq4OYmzv88cjbBE51tYcTP+elXAy
         c+0nXqlsqHjSx/h8NStRuNZQRYiAw4Hrnz/2FotmkOKIAcL1CAMnIn18QnLkp88nSXWi
         xjRNLW1AgUXzPX2fLCT44auyfvUpmgagtoL2GAdpB/XwIBPACoIROj+Ro8MxQ92ZuBX4
         HxoRMfY2quGPPizzPUr270nQILb+T7DM4id9+bf+aKWhqniFkljJPlmo95nYrwEt20h/
         mwLw==
X-Received: by 10.66.146.170 with SMTP id td10mr73516706pab.105.1395679648425;
 Mon, 24 Mar 2014 09:47:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.186.101 with HTTP; Mon, 24 Mar 2014 09:44:03 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.10.1403241604280.18427@eddie.linux-mips.org>
References: <1390327294-2618-1-git-send-email-florian@openwrt.org>
 <20140324141259.GL17197@linux-mips.org> <alpine.LFD.2.10.1403241604280.18427@eddie.linux-mips.org>
From:   Florian Fainelli <florian@openwrt.org>
Date:   Mon, 24 Mar 2014 09:44:03 -0700
X-Google-Sender-Auth: jZxUBtKHhgcpqBRTy_OEJyy9Qz8
Message-ID: <CAGVrzcaF=Oz5XV1XhuJGxfcBVS-iU4XiSp3xC0ZFGHPSG1HKvA@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: add MIPS_L1_CACHE_SHIFT_2
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

2014-03-24 9:20 GMT-07:00 Maciej W. Rozycki <macro@linux-mips.org>:
> On Mon, 24 Mar 2014, Ralf Baechle wrote:
>
>> > Some older machines such as the DECStation use a L1 data-cache shift of
>> > 2 (value of 4), add a Kconfig symbol for this value so they can express
>> > this requirement.
>>
>> Older DECstations got R2000/R3000 processors which have 16 byte cache
>> lines.  So a cache shift value of 4 would appear to be right.  Maciej?

I used arch/mips/include/asm/mach-dec/cpu-feature-overrides.h as a
reference and it does look consistent with your boot log snippets
(assuming those are only for R2k/R3k processors and not R4k ones?)

>
>  Nope:
>
> This is a DECstation 5000/1xx
> CPU revision is: 00000230 (R3000A)
> FPU revision is: 00000340
> [...]
> Primary instruction cache 64kB, linesize 4 bytes.
> Primary data cache 128kB, linesize 4 bytes.
>
> or:
>
> This is a DECstation 5000/2x0
> CPU revision is: 00000230
> FPU revision is: 00000340
> [...]
> Primary instruction cache 64kB, linesize 4 bytes.
> Primary data cache 64kB, linesize 4 bytes.
>
> or:
>
> This is a DECstation 5000/200
> CPU revision is: 00000220
> FPU revision is: 00000320
> [...]
> Primary instruction cache 64kB, linesize 4 bytes.
> Primary data cache 64kB, linesize 4 bytes.
>
> or even:
>
> This is a DECstation 2100/3100
> CPU revision is: 00000220
> FPU revision is: 00000320
> [...]
> Primary instruction cache 64kB, linesize 4 bytes.
> Primary data cache 64kB, linesize 4 bytes.
>
> -- so it looks like it's consistent 4 bytes across all the variations
> (there's also a /1xx variant with 64kB D$ that I don't have a log from,
> but it has the same line size AFAIK).

-- 
Florian

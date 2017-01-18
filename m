Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2017 10:49:01 +0100 (CET)
Received: from mail-io0-x242.google.com ([IPv6:2607:f8b0:4001:c06::242]:33630
        "EHLO mail-io0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993085AbdARJsusHLHA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jan 2017 10:48:50 +0100
Received: by mail-io0-x242.google.com with SMTP id 101so1076546iom.0;
        Wed, 18 Jan 2017 01:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=VTsNciQeCT50uSfFY0qYV4l4ZY+kkjOrYcgGnbWRwa4=;
        b=oXg0+6HhHBWiA3rgSNRsUHqhN4sIsJVj923Yj7NR8mGKw0pNAbhYUM6o5g33xjh0+h
         B3TTWL/eFm8E9fSyAn1DgVphIJJl399ieUPGyDB5rYQALGQaymGnZavr+3LsyVeeEoSK
         h5zJkVgIyUMw1CsmfuGYrf5F9j/u8P4GwCd3Zve2A8NqcJrC5t3IN8GCbFElLcM6Oslc
         FzngVo2cGfumfI0hPPxZduWaE8rESP7BFHeQIH56NsmbuNc3btgSg3AXZf1uB/m8h3fC
         +s+RgqF6VqJrzXFgBVOBvItT+TXOL+hlGIr6n+zpZJeXur3hT2BELzp/R4Z3D8/4PPNm
         Zc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=VTsNciQeCT50uSfFY0qYV4l4ZY+kkjOrYcgGnbWRwa4=;
        b=ZI1ctyb53NJLXxk5dazVj2MCRLhrz5WqNQGcYI1nSLB0WdaSKtSenL62FoQFnRnhUe
         GxCA3AO811pItPSVboD6WC6+hBww6nMTmWEMAl2jvis684nomg74do6HNKaGUj2kp6O1
         L3VU5/9tCiOMqFuTed5hF8GpTOgAn8vUvZY1U5cnp5h24Crijr8RGVcYVvStPztEiTWH
         0ZETJY0X97wIwm+tGK47+6GIR8Y7UJ3Z72qvbAEPm2ZmoWaYf7fg4Jl0y3D1dBIskeN9
         lfu93sIFbjCjfrOkPGYs0YNk+FDR8aFbuy7fsw9JbygQBXForKS5pnyVvG+qbKep57X6
         AhIQ==
X-Gm-Message-State: AIkVDXL4WfV5miguypDzcpsxvqsg1AZkJOGDCQ7HqjWVimX/tqdrw3WfW+mkIQxyc9b7UUeBAJH1VesCCqdNnQ==
X-Received: by 10.107.173.95 with SMTP id w92mr3044812ioe.136.1484732923400;
 Wed, 18 Jan 2017 01:48:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.50.35.99 with HTTP; Wed, 18 Jan 2017 01:48:42 -0800 (PST)
In-Reply-To: <da86f6a2-e0b6-9202-baa5-c2dde188afb6@cogentembedded.com>
References: <20170117151911.4109452-1-arnd@arndb.de> <20170117151911.4109452-4-arnd@arndb.de>
 <da86f6a2-e0b6-9202-baa5-c2dde188afb6@cogentembedded.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 Jan 2017 10:48:42 +0100
X-Google-Sender-Auth: cNjrMjA9xeZKqIUDDtxiXdWZ7Iw
Message-ID: <CAK8P3a1ju66vuSK=D4OLY61zKydWSSF4mhSD17s343j5RFq3aA@mail.gmail.com>
Subject: Re: [PATCH 04/13] MIPS: zboot: fix 'make clean' failure
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Alban Bedel <albeu@free.fr>, Paul Bolle <pebolle@tiscali.nl>,
        Paul Burton <paul.burton@imgtec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Wed, Jan 18, 2017 at 10:43 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 1/17/2017 6:18 PM, Arnd Bergmann wrote:
>> diff --git a/arch/mips/include/asm/uaccess.h
>> b/arch/mips/include/asm/uaccess.h
>> index 5347cfe15af2..c66db8169af9 100644
>> --- a/arch/mips/include/asm/uaccess.h
>> +++ b/arch/mips/include/asm/uaccess.h
>> @@ -80,6 +80,9 @@ extern u64 __ua_limit;
>>
>>  #define segment_eq(a, b)       ((a).seg == (b).seg)
>>
>> +extern size_t __copy_user_inatomic(void *__to, const void *__from, size_t
>> __n);
>> +extern size_t __copy_user(void *__to, const void *__from, size_t __n);
>> +
>>  /*
>>   * eva_kernel_access() - determine whether kernel memory access on an EVA
>> system
>>   *
>
>
>    Unrelated change?

Sorry, my mistake. That was meant to be part of "MIPS: Fix
modversions". I'll send this separately once the kernelci bot has some
results for today's linux-next.

    Arnd

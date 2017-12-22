Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Dec 2017 10:37:27 +0100 (CET)
Received: from mail-lf0-x235.google.com ([IPv6:2a00:1450:4010:c07::235]:38732
        "EHLO mail-lf0-x235.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990517AbdLVJhVdhXbm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Dec 2017 10:37:21 +0100
Received: by mail-lf0-x235.google.com with SMTP id w196so12914283lff.5
        for <linux-mips@linux-mips.org>; Fri, 22 Dec 2017 01:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gXPJslPtcAs4FZl7sp8Wjl0TbuuHbnjnArlw3MzizEc=;
        b=mPgghiFnsQgClekpe2jaPopL3K4MiHCAb7jzh4J7OU+n6xUBimSXjOKPJ1n0IZe7Sq
         wrl+b3kvFAVdpRTHwW9kaGxi7PI20yeabbJFe9cWPUW0vqybGzMsim7A09Lzn79bNOXN
         9DyftOMmwwrWGLuLv/7o384duamDusOer17svEPXbd/7sNdQ3wCDEPSSJ0pfI0YH/Frw
         6yNaDPR0w7yWo8xJdZJn8fz97Ksig9qNN6QQolBFUrn9g1CfFLxBpkV2RAC+HNPeCkwO
         HA5Bh9Av3MacfiTY3/PDHV4WJWUWa/j12z3hJRk/0iFpQHJPjP92GYlf+sNqb83hH+fI
         UETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gXPJslPtcAs4FZl7sp8Wjl0TbuuHbnjnArlw3MzizEc=;
        b=pKcXqA8hP7oOuokp5rkEqLRyW83yActGUQSNDHBfr62Yvjaacnpd93MXdD9ecbAEX9
         G+11yU7ylob2birZxgQXFm0zTgNyH3bsGjvBy+a2WaQb8kHwuFCxM1GPRQ1eRDs+ys39
         QEIeWsnkopM0swsAjDgJn1JACROoHjWC6F1PF4p3RsrEmvirSG0feGbKtrfF+xn9yqgk
         GXAh42jzlU6hypNLAPgd7bcBFYw1rEppeMkBWAZLi6L5qJSjaRtTV9X+w9+Ys6KnfgGZ
         7O4ePRfMFtA4LFeEVWNSsqpGBxdjj6OkQR1v3rtPKOev3aCW56vPugpRXd0pZEyNBTDR
         LRnA==
X-Gm-Message-State: AKGB3mK6IYGpzSZxRuOwc2EztT/oD9nPAq9AFsTYGUemIYywfpLmTcNp
        dpKS1etkU/Q+eTVR7twYxs2OSKxf
X-Google-Smtp-Source: ACJfBou56NgQGq0S83qLwuzoqsIXaAzpSu6OyGLM6QXu+nZ1cvTFYid8gAa4EHSkxjBYtUYHSyYGsA==
X-Received: by 10.46.15.25 with SMTP id 25mr8415553ljp.119.1513935435637;
        Fri, 22 Dec 2017 01:37:15 -0800 (PST)
Received: from upc8.baikal.int (mail.baikalelectronics.com. [87.245.175.226])
        by smtp.gmail.com with ESMTPSA id 72sm4420074ljz.31.2017.12.22.01.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Dec 2017 01:37:14 -0800 (PST)
Subject: Re: [P5600 && EVA memory caching question] PCI region
To:     James Hogan <james.hogan@mips.com>
Cc:     linux-mips@linux-mips.org, paul.burton@mips.com
References: <6132c323-32a7-1d38-b77c-a191be22faa4@gmail.com>
 <20171206114611.GM5027@jhogan-linux.mipstec.com>
 <330a5200-531f-fcfa-674a-c81fb3144e92@gmail.com>
 <20171214152138.GV5027@jhogan-linux.mipstec.com>
 <ca9adcbc-9777-46a0-ce0b-15e83e01fc72@gmail.com>
 <20171215232821.GA5027@jhogan-linux.mipstec.com>
 <b8706fae-aea8-99b5-f91d-37690eff6949@gmail.com>
 <20171221134119.GE5027@jhogan-linux.mipstec.com>
From:   Yuri Frolov <crashing.kernel@gmail.com>
Message-ID: <8cdb85dc-a8e6-4837-868b-a6702a7014cb@gmail.com>
Date:   Fri, 22 Dec 2017 12:37:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171221134119.GE5027@jhogan-linux.mipstec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Return-Path: <crashing.kernel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: crashing.kernel@gmail.com
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

>> I'm looking at arch/mips/include/asm//mach-malta/kernel-entry-init.h and
>> there is a definition for SegCtl2:
>>
>>           /* SegCtl2 */
>>           li      t0, ((MIPS_SEGCFG_MUSUK << MIPS_SEGCFG_AM_SHIFT) |      \
>>                   (6 << MIPS_SEGCFG_PA_SHIFT) |                           \
>>                   (1 << MIPS_SEGCFG_EU_SHIFT)) |                          \
>>                   (((MIPS_SEGCFG_MUSUK << MIPS_SEGCFG_AM_SHIFT) |         \
>>                   (4 << MIPS_SEGCFG_PA_SHIFT) |                           \
>>                   (1 << MIPS_SEGCFG_EU_SHIFT)) << 16)
>>
>> it defines, that kernel logical addresses from the range 0x00000000 -
>> 0x7fffffff are unmapped (no tlbs) and dictates, that in order to get a
>> physical address for any logical addresses from 0x00000000 - 0x3fffffff
>> range in kernel space, bits [31:29] of the logical address must be
>> changed to 100,
>> and (again in kernel space) for any logical addresses from 0x40000000 -
>> 0x7fffffff range, bits [31:29] of the logical address must be changed to
>> 110, right?
> yes, the Malta implementation is slightly ugly as it relies on a
> hardware physical memory alias of RAM starting at PA 0x80000000.
>
>> What physical addresses will logical addresses 0x00000000 and 0x20000000
>> be translated in kernel space?.. logical 0x00000000 --> physical
>> 0x80000000, and logical 0x20000000 --> .... 0x80000000 too?
> VA 0x20000000 -> PA 0xa0000000, since seg4 and seg5 are 1GB segments, so
> its only bits 30 and up that can be changed.
Ah, I've got it now.
>   I seem to remember the bit
> corresponding to bit 29 isn't even writable in the SegCtl2 register.
I shoulda read the actual definition of SegCtl2, my bad. I presumed the 
definitions are the same for
SegCtl0 - SegCtl2.
> Does that clarify things?
Yes, absolutely.  Thank you very much!

-- yuri

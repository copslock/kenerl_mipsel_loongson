Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 May 2013 23:46:19 +0200 (CEST)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36329 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834988Ab3EXVqNoDHNw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 May 2013 23:46:13 +0200
Received: by mail-pa0-f53.google.com with SMTP id kq12so4783316pab.12
        for <multiple recipients>; Fri, 24 May 2013 14:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=6/ySs5TxwtXM51iii8TUlzL1Yv3KTCqYDCdYlJAOG3A=;
        b=NFuvYhgKE+WnKkk5m+FLfxUjMWlfx0NRhuwzWuFzIyJUSWZL0fIyALX9Apm1ftHZlH
         LMLYAHxmWYTePW0bWV93dXSkZtX0011TktDAlFnEGMwSYweC6TOZJUwfclPpG+cC4S2Q
         3u2Ey/Hbv1Rdq2+dNVoD0J44AhQXv/tJunGYDAyXlxPf3wfw1EnMKzOFvE32WjDn6/cg
         OCqD9+RTqnI9g+qMjr75HXmym1x1ub/ftLVgTq3nUFnJshTveymbnQOEkGa+cj98+K+t
         STkjXDuD4jHnVCmRzaFAKfrj+6u0xUld5uBfvp/6FwTdcYtNDa7ojzYYLgxbb7jWmnO/
         qjRQ==
X-Received: by 10.66.145.229 with SMTP id sx5mr20139134pab.11.1369431965162;
        Fri, 24 May 2013 14:46:05 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id pb5sm17225573pbc.29.2013.05.24.14.46.03
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 14:46:04 -0700 (PDT)
Message-ID: <519FDF9A.6080204@gmail.com>
Date:   Fri, 24 May 2013 14:46:02 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>,
        Jonas Gorski <jogo@openwrt.org>
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        "Steven J. Hill" <sjhill@mips.com>,
        David Daney <david.daney@cavium.com>,
        John Crispin <blogic@openwrt.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH] MIPS: define cpu_has_mmips where appropriate
References: <1369345335-28062-1-git-send-email-jogo@openwrt.org> <519F933A.6020407@gmail.com>
In-Reply-To: <519F933A.6020407@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 05/24/2013 09:20 AM, David Daney wrote:
> On 05/23/2013 02:42 PM, Jonas Gorski wrote:
>> Disable cpu_has_mmips for everything but SEAD3 and MALTA. Most of these
>> platforms are from before the micromips introduction, so they are very
>> unlikely to implement it.
>>
>> Reduces an -Os compiled, uncompressed kernel image by 8KiB for BCM63XX.
>>
>> Signed-off-by: Jonas Gorski <jogo@openwrt.org>
>
> Acked-by: David Daney <david.daney@cavium.com>

I changed my mind:  NAK.

I will send a smaller, but equivalent patch.


>> ---
>>
>> Position chosen is based on asm/cpu-features.h. Missing hardware and/or
>> data sheets for most platforms I obviously couldn't verify its
>> non-existence, so maintainer acks are appreciated.
>>
>>   arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
>> |    1 +
>>   arch/mips/include/asm/mach-au1x00/cpu-feature-overrides.h
>> |    1 +
>>   arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h
>> |    1 +
>>   arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
>> |    1 +
>>   arch/mips/include/asm/mach-cobalt/cpu-feature-overrides.h
>> |    1 +
>>   arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h
>> |    1 +
>>   arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h
>> |    1 +
>>   arch/mips/include/asm/mach-ip28/cpu-feature-overrides.h
>> |    1 +
>>   arch/mips/include/asm/mach-ip32/cpu-feature-overrides.h
>> |    1 +
>>   arch/mips/include/asm/mach-jz4740/cpu-feature-overrides.h
>> |    1 +
>>   arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
>> |    1 +
>>   arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
>> |    1 +
>>   arch/mips/include/asm/mach-pmcs-msp71xx/cpu-feature-overrides.h
>> |    1 +
>>   arch/mips/include/asm/mach-powertv/cpu-feature-overrides.h
>> |    1 +
>>   arch/mips/include/asm/mach-ralink/rt288x/cpu-feature-overrides.h
>> |    1 +
>>   arch/mips/include/asm/mach-ralink/rt305x/cpu-feature-overrides.h
>> |    1 +
>>   arch/mips/include/asm/mach-ralink/rt3883/cpu-feature-overrides.h
>> |    1 +
>>   arch/mips/include/asm/mach-rc32434/cpu-feature-overrides.h
>> |    1 +
>>   arch/mips/include/asm/mach-rm/cpu-feature-overrides.h
>> |    1 +
>>   arch/mips/include/asm/mach-sibyte/cpu-feature-overrides.h
>> |    1 +
>>   arch/mips/include/asm/mach-tx49xx/cpu-feature-overrides.h
>> |    1 +
>>   21 files changed, 21 insertions(+)
>>
> [...]
>

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 01:05:49 +0100 (CET)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:51992
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990411AbdKIAFivSsE9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Nov 2017 01:05:38 +0100
Received: by mail-qk0-x243.google.com with SMTP id n66so5634247qki.8;
        Wed, 08 Nov 2017 16:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iZC129uEWEW9xoXXHtMKkKH1po20018Jyjk6xb/2QXA=;
        b=FDauhRiSk1qLDaywM8zjTZRY29FTRw6tcB387OhXcNQ531e3BQnAAVJWbs4bNqyHu1
         gkxcUGoYP2NI1xy2BUHt/Jkdg2+TT1FX4fvJLy0TKExD3eRJEGyIU0qsc5mvzrjdxwAu
         ugWWyM1Gb1x4ZRqipomNoDSdlfDFPmJ1vHqtA4xG8b6b0n9FSL0SQUU/aQbjJwVOx8rA
         zW55ob22kXy0dncB9PqVMXQ23o6HaMEVj2Xij/r1VeGgovdRav1M3y5Jtx7txid7lELj
         ZhsfK1HUuKiv9CpDS/4fZHvDTQaqLNp10hofBcMiqnBMWXIf6znnnyGZOxtGs2qZXX8T
         /gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iZC129uEWEW9xoXXHtMKkKH1po20018Jyjk6xb/2QXA=;
        b=jwhEcWKsosFfDHN99WSwtChy/QY0ca8pdnn6cwd6NChJdWFyafnIkW3pfX5rQUFMjc
         izyppJQSyezm/BOeLxnTeivTy2byECipkyGKEiYnj7tSpxj7t3LcE0S6LIgiv+E9F1Fy
         rzGWsgW+iBOyggEhnccamEeBry/DWOw7XW3r9qW3VjhwHtCk+8pf9FLBs9X8mZiLnlLf
         xg5sM5mykX6BlrVWmKPcbnXQOZgWFxHAII+Jk9XEzcDNYnDTC6BkXgjV1xkVuFYTnpkh
         pOzQTRrpLkkh2izbI8wf+5V30nDlp5OjeQs2XxfL/BsWeCcWb+7au7DitYNtvMTtRFAN
         fq2A==
X-Gm-Message-State: AJaThX72jd0PmlhGGBcZKSNRutaySYecgrIyLagVSHWSmYzfAe2za/BF
        I6KNOAeVjM8dw8cd+bK5+QAI3AGi
X-Google-Smtp-Source: AGs4zMabSTVdDwFiG8+NW8SQDRYNmP5VAJN5qWn1iYjCVYBLQCGaw6/+6wbbfIbGnQ5EUFPUoFhb4g==
X-Received: by 10.55.72.201 with SMTP id v192mr3746511qka.333.1510185932194;
        Wed, 08 Nov 2017 16:05:32 -0800 (PST)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id f62sm3870643qkh.51.2017.11.08.16.05.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Nov 2017 16:05:31 -0800 (PST)
Subject: Re: [PATCH] MIPS: page.h: define virt_to_pfn()
To:     James Hogan <james.hogan@mips.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        paul.burton@mips.com, macro@linux-mips.org
References: <20170309211149.8339-1-f.fainelli@gmail.com>
 <20171108231527.GQ15260@jhogan-linux>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <aa38339b-7f88-3643-cce5-dd60f06d6f13@gmail.com>
Date:   Wed, 8 Nov 2017 16:05:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20171108231527.GQ15260@jhogan-linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60780
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

On 11/08/2017 03:15 PM, James Hogan wrote:
> Hi Florian,
> 
> On Thu, Mar 09, 2017 at 01:11:49PM -0800, Florian Fainelli wrote:
>> Based on the existing definition of virt_to_page() which already does a
>> PFN_DOWN(vir_to_phys(kaddr)).
> 
> I was just wondering if there was a particular motivation for this
> change?

Initially that was a part of an experiment to try to build and use ION
on MIPS, but I think this dependency somehow got removed. I might have
thought about using it for CONFIG_DEBUG_VIRTUAL too.

In then end I sent it because it sounded like a simple change that could
have some use later.

Thanks for going through the patch queue :)

> 
> Cheers
> James
> 
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  arch/mips/include/asm/page.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
>> index 5f987598054f..ad461216b5a1 100644
>> --- a/arch/mips/include/asm/page.h
>> +++ b/arch/mips/include/asm/page.h
>> @@ -240,8 +240,8 @@ static inline int pfn_valid(unsigned long pfn)
>>  
>>  #endif
>>  
>> -#define virt_to_page(kaddr)	pfn_to_page(PFN_DOWN(virt_to_phys((void *)     \
>> -								  (kaddr))))
>> +#define virt_to_pfn(kaddr)   	PFN_DOWN(virt_to_phys((void *)(kaddr)))
>> +#define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
>>  
>>  extern int __virt_addr_valid(const volatile void *kaddr);
>>  #define virt_addr_valid(kaddr)						\
>> -- 
>> 2.9.3
>>


-- 
Florian

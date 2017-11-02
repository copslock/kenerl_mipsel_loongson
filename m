Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 18:49:39 +0100 (CET)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:53116
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991960AbdKBRt3cjstY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Nov 2017 18:49:29 +0100
Received: by mail-pg0-x242.google.com with SMTP id a192so241723pge.9;
        Thu, 02 Nov 2017 10:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=32QbRC8XDIOBymUYOSgOw8crtbmy2rYVUsCyJF/0eZ0=;
        b=bOH2DVmRnEn7uHOIJaji979qBrtXA1eia2f/YfquM/HC+SS9R3Uuk2oG27LQa5halv
         xu41dB0xN749nNI0qkVFMbfvQrfEvDCWYu7szg01dP8u2ncpuiRP5+YI/s4Np+ZNXEPh
         FrbwIgCZqJvuIk+bce+4cUVB7FnmyyCbXD27dgvOegGzVbfVAglqU1VBrqHfFkWFazWE
         VaE0uFpLtTgMp5suTkbolJgi1wZwYFQhzZGdUGV4blYfrPBqyysKbaOV8jJIz7DyC/QQ
         recetAN0exfc7SOEelm67PxiGZknpExQjG3CxBhSaUf6pDS9+7Qcu9DENtzogWZmSjKt
         RuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=32QbRC8XDIOBymUYOSgOw8crtbmy2rYVUsCyJF/0eZ0=;
        b=RuNSor0FUzjYnMZpe62oB6Z4VSxCuLmDtdPi6vMljxHkfEwJ9a0hWR1B//XZtYzfr0
         zhjcBHBvY4qVMyRFIzifgYRkVcQavAxiC79SNCdvvWh5bze5jJcf+CRLiwX1qD8gKsJo
         DBhf3G7n8fDVkzo7VMAeUMTiNGGJr3xGOob1QaTwl+WPIu9eVO1uyNrlJuT8l/qrVs6l
         aSHZfDE6H10SG9/AkP+yQAQ4jREtpFrKYDZcKlGnuk5UoZntg8tJPSoCoqM2T2NCIrTo
         7Ioj0cQW4od7zjU5tMNFuv5lqIj+0vcBOhUV7T973GR1k7RHUAo7YPNkrXhv6zDpzqNu
         GI8w==
X-Gm-Message-State: AMCzsaUOttGKP/3AlMBjUgQIpC0d6xED0NQndju++q45n9sNErBqrJc+
        UOlG7QCG3RmqB8mewsB5RiM=
X-Google-Smtp-Source: ABhQp+SSnpfUOYgsIWNln619NX850LL58niGBOaBR9lJBK3ki/jkp4O3mig9dAR2y8LDaOCu4g/t3A==
X-Received: by 10.84.202.12 with SMTP id w12mr4042517pld.358.1509644962695;
        Thu, 02 Nov 2017 10:49:22 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id c26sm7114581pfl.115.2017.11.02.10.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Nov 2017 10:49:21 -0700 (PDT)
Subject: Re: [PATCH 3/7] MIPS: Octeon: Add a global resource manager.
To:     David Daney <ddaney@caviumnetworks.com>,
        Andrew Lunn <andrew@lunn.ch>,
        David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Carlos Munoz <cmunoz@cavium.com>
References: <20171102003606.19913-1-david.daney@cavium.com>
 <20171102003606.19913-4-david.daney@cavium.com>
 <20171102122327.GE4772@lunn.ch>
 <caeae680-915a-d08c-d220-899db0970328@caviumnetworks.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6ff04462-88ec-a972-4084-e26ea3cb630a@gmail.com>
Date:   Thu, 2 Nov 2017 10:49:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <caeae680-915a-d08c-d220-899db0970328@caviumnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60692
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

On 11/02/2017 09:03 AM, David Daney wrote:
> On 11/02/2017 05:23 AM, Andrew Lunn wrote:
>>> +static void res_mgr_lock(void)
>>> +{
>>> +    unsigned int tmp;
>>> +    u64 lock = (u64)&res_mgr_info->rlock;
>>> +
>>> +    __asm__ __volatile__(
>>> +        ".set noreorder\n"
>>> +        "1: ll   %[tmp], 0(%[addr])\n"
>>> +        "   bnez %[tmp], 1b\n"
>>> +        "   li   %[tmp], 1\n"
>>> +        "   sc   %[tmp], 0(%[addr])\n"
>>> +        "   beqz %[tmp], 1b\n"
>>> +        "   nop\n"
>>> +        ".set reorder\n" :
>>> +        [tmp] "=&r"(tmp) :
>>> +        [addr] "r"(lock) :
>>> +        "memory");
>>> +}
>>> +
>>> +static void res_mgr_unlock(void)
>>> +{
>>> +    u64 lock = (u64)&res_mgr_info->rlock;
>>> +
>>> +    /* Wait until all resource operations finish before unlocking. */
>>> +    mb();
>>> +    __asm__ __volatile__(
>>> +        "sw $0, 0(%[addr])\n" : :
>>> +        [addr] "r"(lock) :
>>> +        "memory");
>>> +
>>> +    /* Force a write buffer flush. */
>>> +    mb();
>>> +}
>>
>> It would be good to add some justification for using your own locks,
>> rather than standard linux locks.
> 
> Yes, I will add that.
> 
> 
>>
>> Is there anything specific to your hardware in this resource manager?
>> I'm just wondering if this should be generic, put somewhere in lib. Or
>> maybe there is already something generic, and you should be using it,
>> not re-inventing the wheel again.
> 
> The systems built around this hardware may have other software running
> on CPUs that are not running the Linux kernel.  The data structures used
> to arbitrate usage of shared system hardware resources use exactly these
> locking primitives, so they cannot be changed to use the Linux locking
> implementation de jour.

Would hwspinlock be a possible option so this is abstracted on the Linux
side using these locking primitives through the hwspinlock layer which
in turn does exactly what is above?
-- 
Florian

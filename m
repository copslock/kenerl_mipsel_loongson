Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Dec 2011 16:04:45 +0100 (CET)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:60840 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903656Ab1LPPEh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Dec 2011 16:04:37 +0100
Received: by eekc13 with SMTP id c13so2092864eek.36
        for <multiple recipients>; Fri, 16 Dec 2011 07:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:organization:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=SaA2YNdFsQvC0pqVQTohzWthVBlIcBLHNozXKssSb4M=;
        b=sJBVCz8rUzN7ft1NAH1gIcI2tnrVRYfTNpjTtISvFWUF6k/MP0fCO4dxEXZvQEmmcO
         /Zkig7cjDvfKCd8GnIl4Ux0LhTRhKdCyHSEb9I4KE4fLLk2MEcuCPH+ZEcKYgvdfLWaD
         QidC8EbUbuU+Qfyx3DLOIK+RWLcWfQ7bVjLyM=
Received: by 10.205.122.133 with SMTP id gg5mr3028331bkc.65.1324047872327;
        Fri, 16 Dec 2011 07:04:32 -0800 (PST)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id q16sm23518688bky.10.2011.12.16.07.04.28
        (version=SSLv3 cipher=OTHER);
        Fri, 16 Dec 2011 07:04:29 -0800 (PST)
Message-ID: <4EEB5DCE.70904@openwrt.org>
Date:   Fri, 16 Dec 2011 16:03:42 +0100
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111124 Thunderbird/8.0
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, ralf@linux-mips.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 4/5] MIPS: BCM63XX: add RNG driver platform_device stub
References: <1323457270-16330-1-git-send-email-florian@openwrt.org> <1323457270-16330-5-git-send-email-florian@openwrt.org> <4EE370D9.9090900@mvista.com>
In-Reply-To: <4EE370D9.9090900@mvista.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13293

Hello Sergei,

On 12/10/11 15:46, Sergei Shtylyov wrote:
> Hello.
>
> On 09-12-2011 23:01, Florian Fainelli wrote:
>
>> Signed-off-by: Florian Fainelli<florian@openwrt.org>
> [...]
>
>> diff --git a/arch/mips/bcm63xx/dev-trng.c b/arch/mips/bcm63xx/dev-trng.c
>> new file mode 100644
>> index 0000000..19ccfbf
>> --- /dev/null
>> +++ b/arch/mips/bcm63xx/dev-trng.c
>> @@ -0,0 +1,40 @@
> [...]
>> +static struct resource trng_resources[] = {
>> +    {
>> +        .start        = -1, /* filled at runtime */
>> +        .end        = -1, /* filled at runtime */
>> +        .flags        = IORESOURCE_MEM,
>> +    },
>> +};
>> +
>> +static struct platform_device bcm63xx_trng_device = {
>> +    .name        = "bcm63xx-trng",
>> +    .id        = 0,
>
>    Why not -1? Isn't there only single device of this sort?

There is a single device, I will fix that in a second version of the 
patchset.
--
Florian

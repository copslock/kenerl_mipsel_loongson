Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Oct 2017 18:12:39 +0200 (CEST)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:55848
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992241AbdJQQMcuT4-w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Oct 2017 18:12:32 +0200
Received: by mail-qt0-x243.google.com with SMTP id v41so4651736qtv.12;
        Tue, 17 Oct 2017 09:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aJcE+ehoVoFEETt9GUs3ITmGGXVeK9qzNxiJVxlWEgU=;
        b=stzak8elx9LRHP3VsYY4onNbLPdIyxCtLjexkMofl6/Zk3Bz+ibpWSSeSh4QKiICZO
         T3sKbE2QuNm3opeJhCjB7Lwqtu0QbAXHPHu3l9QBY1JQ6h3/Cy4NXXXB+4sVKSUvwpbJ
         sUMKeWt95EPVFeDhHStrg+I+p9zMdAlJKXR0zqqjatili9OjoY1i8oOo6Nu3NimESEs0
         /16YHnhtAhZnCTDPh3khOgXrawtAz/9obViUvT1Kb9UZm+ZAhAa2koAdcSxyAJQQBr7r
         xAHtqwcJCJLefX9Azi7JPGS25YHrYc7Y4ySOJ5hxidX65Jey9Ac/YH5n9ji2KfeIyiye
         9Vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aJcE+ehoVoFEETt9GUs3ITmGGXVeK9qzNxiJVxlWEgU=;
        b=UR1dSGphSnidAlHexTzaYAPJQxyxLD0r0fLGeghHPWq3t5dChOwpakNMhwWlkvnOut
         Rt5iuqu4+0uQBhYyW6c9i3AOi7wWoUjCqoD5ENqjyMH4R2zHfncKBifOuqkabJUEQ8EX
         X2HIRzINRXTFguqGBo8ZjQisxMF2Nq+WRbTa/oEKKYrf1t//oh50dGId6r99Rt4ak/qx
         OB0hwQqFyYDoira4WBjop+xVH2kN+Va56KUPL/xQebceN7lKTmt5Rnwu6UEROsJU6RE7
         qZfS3XjEJCu8pTnBFAXO+tsdlK4VqawYKXx/9XzkOeBZhwRaRIivZD1MxA6TAikXDFyj
         TE1Q==
X-Gm-Message-State: AMCzsaWM5nvJOuVLlPifN6FLi8vg8iHl1jjv8XM+AM+dtsFAvftRBXYV
        gCnESeJHXn3IZvycsS9BQEI=
X-Google-Smtp-Source: AOwi7QA+ffPScFRF33HIcNEr5BWGf7XwKmdkx/SRpUjlix0E6YWQtUtuenhS2AP1mvHMz4Ixq2TW0g==
X-Received: by 10.200.38.194 with SMTP id 2mr19163057qtp.196.1508256746284;
        Tue, 17 Oct 2017 09:12:26 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id 2sm6612212qto.28.2017.10.17.09.12.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Oct 2017 09:12:25 -0700 (PDT)
Subject: Re: [PATCH 1/9] SOC: brcmstb: add memory API
To:     Christoph Hellwig <hch@infradead.org>,
        Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-2-git-send-email-jim2101024@gmail.com>
 <20171017082413.GA10574@infradead.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <abdb1e9d-f8c9-8066-48c5-37b4e2474952@gmail.com>
Date:   Tue, 17 Oct 2017 09:12:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20171017082413.GA10574@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60429
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

On 10/17/2017 01:24 AM, Christoph Hellwig wrote:
>> +/* Macros to help extract property data */
>> +#define U8TOU32(b, offs) \
>> +	((((u32)b[0 + offs] << 0)  & 0x000000ff) | \
>> +	 (((u32)b[1 + offs] << 8)  & 0x0000ff00) | \
>> +	 (((u32)b[2 + offs] << 16) & 0x00ff0000) | \
>> +	 (((u32)b[3 + offs] << 24) & 0xff000000))
> 
> Please us helpers like get_unaligned_le32 instead opencoding them.
> 
>> +#define DT_PROP_DATA_TO_U32(b, offs) (fdt32_to_cpu(U8TOU32(b, offs)))
> 
> And together with this it looks really whacky.  So you're converting
> from le to native first and then do another conversion from be to cpu?
> 
> Something doesn't work out here.
> 
>> +/* -------------------- Functions -------------------- */
> 
> Please remove pointless comments like this one.
> 
>> +
>> +/*
>> + * If the DT nodes are handy, determine which MEMC holds the specified
>> + * physical address.
>> + */
>> +#ifdef CONFIG_ARCH_BRCMSTB
>> +int __brcmstb_memory_phys_addr_to_memc(phys_addr_t pa, void __iomem *base)
> 
> Please move this into the arm arch code.

No, this needs to work on both ARM and ARM64, hence the reason why this
is in a reasonably architecture neutral place.

> 
>> +#elif defined(CONFIG_MIPS)
> 
> And this into the mips arch code.

Same reason as above.

> 
>> +EXPORT_SYMBOL(brcmstb_memory_phys_addr_to_memc);
> 
>> +EXPORT_SYMBOL(brcmstb_memory_memc_size);
> 
> Why is this exported?

Because the PCIE RC driver can be built as a module.
-- 
Florian

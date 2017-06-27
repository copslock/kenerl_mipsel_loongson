Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jun 2017 20:21:33 +0200 (CEST)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:36364
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991087AbdF0SV1VKBb0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jun 2017 20:21:27 +0200
Received: by mail-qk0-x243.google.com with SMTP id r62so4889997qkf.3;
        Tue, 27 Jun 2017 11:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MuLxnPijITWQ0DCdR494yQPrCqr2YMy1Bbg0DBP3eCM=;
        b=Q3FVmX8DAhQaKwx6HWtrL0Wh8em1Ign3YHCDPb9SUwwq4ttejKICsnzfEN07V91a8n
         YGZSJTs7uES6M9nb9xGCumJmHhhXRdvYzRsYWISHhKe405Gn+ZeHYwpBS1xWwt7plh1l
         kddwKIffxLnpMXhn8mnCLcpb3F6UXOgNGauiZjG612loZzwNzJVIwxEPqe1HBTUeGNpq
         HnCstsLPDDb4Rf+J9j3iYq4PywQ3VtIAW9OKpuf5YRdE1RRFMBfrc7+HNDbS6x9u17xu
         Voq15lXE+m4PdaUn9HKYgrnJN60wyNiERWM03yqIguZ8/3VBqvcXfN/Gks69yjuBKZI2
         upqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MuLxnPijITWQ0DCdR494yQPrCqr2YMy1Bbg0DBP3eCM=;
        b=KpnCkcxmF4jogx3g2bDXf75nsJVN8PYSLgUfrSEMYNY/3mAA/ImfTmS7ijQOl2ayWD
         3Jg6wUL4ZONAKyLnBlCjLi5xIvBIjDke2b9x98qP/9ZMD7VW+2Mmi93kdluemps5+4fE
         VsWrabB0RWCmpOxLXek3hFxWq6k552gNuAYToJ9ZSibQipGN/IbUeHLuk5Yb2l6rzkU/
         6A7IOM2Q+uYx2f1MjEkBbbgs2//Z34iNcVfHQAv1OM1uFu5YGuLUYwOwZgfwQ1wT9H4E
         PpihVoY0bfeqA1FsznJLyz+zDenzmUiUlcpSKKqYLMU6LGIPgLh76S8i1JeF6nxuQ+9U
         UtLQ==
X-Gm-Message-State: AKS2vOx2l2YygXoalrtC6xIaPF+4l2A3t7WilReCaR2cY+lPcn6h5s0M
        zuGIqF/yzUhE+Q==
X-Received: by 10.55.104.81 with SMTP id d78mr8342130qkc.24.1498587681577;
        Tue, 27 Jun 2017 11:21:21 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id w68sm2738193qkb.23.2017.06.27.11.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2017 11:21:21 -0700 (PDT)
Subject: Re: [PATCH 1/4] misc: sram: Allow ARM64 to select SRAM_EXEC
To:     Mark Rutland <mark.rutland@arm.com>, lorenzo.pieralisi@arm.com
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>, Eric Anholt <eric@anholt.net>,
        Justin Chen <justinpopo6@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM BCM47XX MIPS ARCHITECTURE" 
        <linux-mips@linux-mips.org>, linux-pm@vger.kernerl.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, will.deacon@arm.com,
        catalin.marinas@arm.com
References: <20170626223248.14199-1-f.fainelli@gmail.com>
 <20170626223248.14199-3-f.fainelli@gmail.com>
 <20170627173859.GA5189@leverpostej>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <171ae8ff-2af2-65e3-9796-308b21976876@gmail.com>
Date:   Tue, 27 Jun 2017 11:21:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170627173859.GA5189@leverpostej>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58830
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

On 06/27/2017 10:38 AM, Mark Rutland wrote:
> On Mon, Jun 26, 2017 at 03:32:42PM -0700, Florian Fainelli wrote:
>> Now that ARM64 also has a fncpy() implementation, allow selection
>> SRAM_EXEC for ARM64 as well.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Sorr,y but I must NAK this patch.
> 
> As mentioned on prior threads regarding fncpy, I do not think it makes
> sense to enable this for arm64. The only use-cases that have been
> described so far for this are power-management stuff that should live in
> PSCI or other secure FW, and have no place in the kernel on arm64

This is a valid reason, but this is only one use case presented, the
only thing is that we need to make sure, as patch reviewers and you guys
as architecture maintainers, that this is not used as a means to bypass
PSCI for suspend/resume operation, which I now agree with.

Still, the general use case remains: you have a piece of addressable
memory which can be used to allocate space from and relocate code to be
it for security, performance, predictability, isolation, or anything,
and that should be possible given standard kernel facilities offered by
the SRAM driver.

> > There are no other users of this functionality, and until there are, I
> see no reason to enable this, and risk a proliferation of unnecessary
> platform-specific code.
> 
> It should be possible to #ifdef-ise the relevant callers of this such
> that they can be built on arm64 without using fncpy or sram_exec
> functionality. AFAICT, there are no users on arm64 introduced by this
> series.

I sent this patch accidentally as part of this patch series anyway, so
if you want to keep the discussion alive, reply here:

https://patchwork.kernel.org/patch/9793745/

> 
> Thanks,
> Mark.
> 
>> ---
>>  drivers/misc/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index 07bbd4cc1852..ac8779278c0c 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -464,7 +464,7 @@ config SRAM
>>  	bool "Generic on-chip SRAM driver"
>>  	depends on HAS_IOMEM
>>  	select GENERIC_ALLOCATOR
>> -	select SRAM_EXEC if ARM
>> +	select SRAM_EXEC if ARM || ARM64
>>  	help
>>  	  This driver allows you to declare a memory region to be managed by
>>  	  the genalloc API. It is supposed to be used for small on-chip SRAM
>> -- 
>> 2.9.3
>>


-- 
Florian

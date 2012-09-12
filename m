Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2012 00:08:47 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:41592 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903351Ab2ILWIk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Sep 2012 00:08:40 +0200
Received: by obbta17 with SMTP id ta17so3601656obb.36
        for <multiple recipients>; Wed, 12 Sep 2012 15:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=QQ0noX15Z5BL3V3kLW6FG8GbGxnVnZVlNfZYaapKMjY=;
        b=bRMOccOwj9JDNzoG7X7DPaR6WkdITRz10oOshhzppzvnMi6tHXxTaHD60gndFb5SIP
         X1sGIgCiwFSmCzXSlGgZZhDia93m1DIOJ1e5V7yTmW57AKLFI5xyeg74fn97NJk2mxCY
         OSrE3uQOEC01VKeez3Aojf43Thmi27uG2Bht1cNfrMdU1lA0PFTG7J6D7nA9i8RDijUx
         4jSynL2UsxKWp7t9QnReFx8HWTp3C5ddog8AFOpRi7SKiCGJYUBrDWmv95zhGj+ytCCG
         xXXLQakySWlKF0uL71C6PlRuirciUEBNIlDY4/fICV8ElYjXbG/6/Er2TCl8rF1gajQs
         XFJQ==
Received: by 10.60.170.47 with SMTP id aj15mr1657oec.29.1347487714394;
        Wed, 12 Sep 2012 15:08:34 -0700 (PDT)
Received: from [10.10.10.90] ([173.226.190.126])
        by mx.google.com with ESMTPS id th3sm21504107obb.6.2012.09.12.15.08.32
        (version=SSLv3 cipher=OTHER);
        Wed, 12 Sep 2012 15:08:33 -0700 (PDT)
Message-ID: <505107DF.5020105@gmail.com>
Date:   Wed, 12 Sep 2012 17:08:31 -0500
From:   Rob Herring <robherring2@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
MIME-Version: 1.0
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     Cyril Chemparathy <cyril@ti.com>, linux-mips@linux-mips.org,
        x86@kernel.org, a-jacquiot@ti.com, mahesh@linux.vnet.ibm.com,
        linus.walleij@linaro.org, grant.likely@secretlab.ca,
        paul.gortmaker@windriver.com, paulus@samba.org, hpa@zytor.com,
        m.szyprowski@samsung.com, jonas@southpole.se,
        linux@arm.linux.org.uk, linux-c6x-dev@linux-c6x.org,
        nico@linaro.org, david.daney@cavium.com, mingo@redhat.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        benh@kernel.crashing.org, suzuki@in.ibm.com, linux@openrisc.net,
        arnd@arndb.de, microblaze-uclinux@itee.uq.edu.au,
        devicetree-discuss@lists.ozlabs.org, msalter@redhat.com,
        rob.herring@calxeda.com, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, blogic@openwrt.org,
        dhowells@redhat.com, monstr@monstr.eu,
        linux-kernel@vger.kernel.org, ralf@linux-mips.org, tj@kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] of: specify initrd location using 64-bit
References: <1347465937-7056-1-git-send-email-cyril@ti.com> <CAMuHMdUuQzD0bq8PifBea2-0Pk7RhmPA0-GAFprsk+vMxMGjGw@mail.gmail.com> <5050CE33.9060909@ti.com> <5050E965.5080405@linutronix.de>
In-Reply-To: <5050E965.5080405@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 09/12/2012 02:58 PM, Sebastian Andrzej Siewior wrote:
> On 09/12/2012 08:02 PM, Cyril Chemparathy wrote:
>>>> -void __init early_init_dt_setup_initrd_arch(unsigned long start,
>>>> unsigned long end)
>>>> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
>>>
>>> Why not phys_addr_t?
>>>
>>
>> The rest of the memory specific bits of the device-tree code use u64 for
>> addresses, and I kept it the same for consistency.
> 
> Geert is right here. If it is a physical address, it should be
> phys_addr_t.

While generally true, for the DT specific code I think it should be a
fixed u64. The size of the address is defined by the FDT, not the
kernel. It is very likely we could have a FDT that specifies addresses
in 64-bit values, but then we boot a kernel is compiled for !LPAE.
phys_addr_t is currently sized based on LPAE setting.

Also, this is how the memory and reserved nodes are handled currently,
so we should be consistent.

Rob

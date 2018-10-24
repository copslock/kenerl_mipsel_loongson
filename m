Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Oct 2018 22:01:45 +0200 (CEST)
Received: from mail-wr1-x442.google.com ([IPv6:2a00:1450:4864:20::442]:43709
        "EHLO mail-wr1-x442.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994641AbeJXUBiF5RML (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Oct 2018 22:01:38 +0200
Received: by mail-wr1-x442.google.com with SMTP id t10-v6so6880842wrn.10
        for <linux-mips@linux-mips.org>; Wed, 24 Oct 2018 13:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uhQ43+JcdTBslpZHUr3xaLEsxX6YfiYn2s0FtMDUby0=;
        b=Xcco2/ijRsvXrf5JKzv3o+XTkEv3Y+BlXsqkx6TNEr4Mo7ESNP15Ecm5FvAxbmMsC3
         GasDkImyXxSfubzhakP6yk3Gng1x0NFbC9optb+1wuE86rrg05xlKdC5DbyAMXGUpqJ+
         GR3A0rNnq3r/Z0P/BgmPO3FARfLHALO/CHFcfc7tmTpTKxbrXWJS9qljrhOzbO/lajUd
         jqVKWUUoVtbbOjoCuiY89wvkgZu0qolosLcwtnyIu5fpXfTX6Nx3Idw49VZElT/Ymu9s
         J1mBkTG8fb3ib9sh2aOQ5SWlMStr/uHXzMRWKNL+vr5/XBftfCeb5V6eIbNEdfcoJ8hC
         T/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uhQ43+JcdTBslpZHUr3xaLEsxX6YfiYn2s0FtMDUby0=;
        b=Yu6tLqLX5CnfGPSlUMvdrRiKhEFjZ+q3VcUGmrB1OqlqrNdyuI62IBtjLDsCKljGd0
         zUtq/6AtYIeJKKdvwCe36f55i1rX0nlyLU/NtPvCopNFh6UlmP71aXoSu88TrYnqevMd
         eGK8T/1ngqozKGyiT/GQaA5qYW59WVTvA5apscIg+29ESPVN4lofEUMo8cItgxvRxSiM
         8WNqqZc8p2H+ppzq29goH+8qpiLTzNO5cyrcM4Tim4kGPEH3CcMwdUj0WOoOxajsOVXm
         IVIGfGSW+jPB0Bxu+8paI2afuSTAdhyoZ8yJbSRWbvcLTD+KF2ONCfyEoy40lUhifTfR
         VTMA==
X-Gm-Message-State: AGRZ1gI1MEvazNsjgyzCxrvvO5+6t+rDFhYYuBOLBspdRCKVLqCvdXb5
        rvR+sF+YhRRiHGxejC6pH+Q=
X-Google-Smtp-Source: AJdET5f8WB/ydfFuKYrtsm5FGsryDp7J53TJZKdK6x1JVkqsT43x6Npjcoz8+EbmzbruFVdqPY2Q/w==
X-Received: by 2002:adf:bd0f:: with SMTP id j15-v6mr855942wrh.267.1540411292323;
        Wed, 24 Oct 2018 13:01:32 -0700 (PDT)
Received: from [10.67.49.121] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id o11-v6sm4380630wrq.41.2018.10.24.13.01.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 13:01:31 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] arm64: Cut rebuild time when changing
 CONFIG_BLK_DEV_INITRD
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Olof Johansson <olof@lixom.net>, linux-alpha@vger.kernel.org,
        arcml <linux-snps-arc@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        Linux-MIPS <linux-mips@linux-mips.org>,
        nios2-dev@lists.rocketboards.org,
        Openrisc <openrisc@lists.librecores.org>,
        linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        SH-Linux <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        devicetree@vger.kernel.org,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
References: <20181024193256.23734-1-f.fainelli@gmail.com>
 <CAL_Jsq+KCOv6pXXHhHDZ+7-QUrmtMDvSjEVhK15yZ3qbnn61Ag@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <6e647f76-8523-09d3-9b72-d8d8abd213a4@gmail.com>
Date:   Wed, 24 Oct 2018 13:01:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+KCOv6pXXHhHDZ+7-QUrmtMDvSjEVhK15yZ3qbnn61Ag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66927
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

On 10/24/18 12:55 PM, Rob Herring wrote:
> On Wed, Oct 24, 2018 at 2:33 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> Hi all,
>>
>> While investigating why ARM64 required a ton of objects to be rebuilt
>> when toggling CONFIG_DEV_BLK_INITRD, it became clear that this was
>> because we define __early_init_dt_declare_initrd() differently and we do
>> that in arch/arm64/include/asm/memory.h which gets included by a fair
>> amount of other header files, and translation units as well.
> 
> I scratch my head sometimes as to why some config options rebuild so
> much stuff. One down, ? to go. :)
> 

This one was by far the most invasive one due to its include chain, but
yes, there would be many more that could be optimized.

>> Changing the value of CONFIG_DEV_BLK_INITRD is a common thing with build
>> systems that generate two kernels: one with the initramfs and one
>> without. buildroot is one of these build systems, OpenWrt is also
>> another one that does this.
>>
>> This patch series proposes adding an empty initrd.h to satisfy the need
>> for drivers/of/fdt.c to unconditionally include that file, and moves the
>> custom __early_init_dt_declare_initrd() definition away from
>> asm/memory.h
>>
>> This cuts the number of objects rebuilds from 1920 down to 26, so a
>> factor 73 approximately.
>>
>> Apologies for the long CC list, please let me know how you would go
>> about merging that and if another approach would be preferable, e.g:
>> introducing a CONFIG_ARCH_INITRD_BELOW_START_OK Kconfig option or
>> something like that.
> 
> There may be a better way as of 4.20 because bootmem is now gone and
> only memblock is used. This should unify what each arch needs to do
> with initrd early. We need the physical address early for memblock
> reserving. Then later on we need the virtual address to access the
> initrd. Perhaps we should just change initrd_start and initrd_end to
> physical addresses (or add 2 new variables would be less invasive and
> allow for different translation than __va()). The sanity checks and
> memblock reserve could also perhaps be moved to a common location.
> 
> Alternatively, given arm64 is the only oddball, I'd be fine with an
> "if (IS_ENABLED(CONFIG_ARM64))" condition in the default
> __early_init_dt_declare_initrd as long as we have a path to removing
> it like the above option.

OK, let me cook a patch doing that and meanwhile I will look at how much
work is involved to implement the above option you outlined, which also
sounds entirely reasonable.

Thanks!
-- 
Florian

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 21:05:19 +0100 (CET)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:45575
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990477AbeAXUFLHGdtL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Jan 2018 21:05:11 +0100
Received: by mail-qt0-x244.google.com with SMTP id x27so13540907qtm.12;
        Wed, 24 Jan 2018 12:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nIHN/4Vgk1QjDI8Zjl2FUUGwE7mGDAVyADiOnl9956E=;
        b=S+WX6hfFnQHsS+aJeBJiHjYejgYX1G0arFPNnhHXZG5ZmBUXaHLzuvtjGWI/vgyqKP
         St6HBX18ybJG3KpsK4DvQHRzRogU2CrLG33CkLBXFCeA/LhHfCZ/MevlvNmjcb73EW7F
         nWLU29YjDoLjwRzfyV2GeJZuMbsypOH7USqui4UvJcUF4Dz7/SaoHwRs4z2i/ReFvKAj
         JlhEU/rz90zxmcapeICHeoZ7qpM+r8OSzUjZjuYzM9x0O4BcBfhb6i+3AddbqvJa52lv
         lKgC5yKkaOWoglrW40LnEVzeVN3tvbB0zZwqO37OcvNuvR108DgqkQvW+lfTwozotROc
         ruoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nIHN/4Vgk1QjDI8Zjl2FUUGwE7mGDAVyADiOnl9956E=;
        b=pLA4DsWINSjfx/H2zwcCFURd//OpY6dQexiaWtgzcKek21HyIaCYCRK28ZBzg4E+Pd
         UBhvzX+8/Ok90vxl0asebP/Nr1rLN5XhXjfVltSKe5/sRBttnYhL88+vpejHEUks3ZzG
         6t4TPDy8T3gdYdbddjvfo9kxqVSWgbWXmOiPpnSZOqoeHioDMd5RLwlHuo0McCmFDejp
         urzcgUFMMDxoLwzZqTMqBaH9MRr/0DAZkZsbsKn514Vc5pFZmKXchJ9vJ2hoBff78g8s
         0K1lo2rXWH/vKsHMwwK/LDUvm40h5xdtTqVGThx3ji4SIqe4BMc0spnVNRBckVQiw57t
         +q+A==
X-Gm-Message-State: AKwxyteq6z4NAsU6dnxF8p5P/SRsxjiMg2KrvLU/ESd2MocXcB8Sh55t
        NHW/HHvSCD010RYjDPUO61o=
X-Google-Smtp-Source: AH8x226JEzVf5mGLqg9mTZdiCoM9W5mJVXUwmoqRUvKEN2DgbH+Y1ReGNOD7eiQe3fdos8ZKIfaf6Q==
X-Received: by 10.55.129.195 with SMTP id c186mr11115163qkd.352.1516824303503;
        Wed, 24 Jan 2018 12:05:03 -0800 (PST)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id m1sm762038qkf.8.2018.01.24.12.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2018 12:05:02 -0800 (PST)
Subject: Re: [PATCH v4 4/8] PCI: brcmstb: Add dma-range mapping for inbound
 traffic
To:     Christoph Hellwig <hch@lst.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-pci@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <1516058925-46522-1-git-send-email-jim2101024@gmail.com>
 <1516058925-46522-5-git-send-email-jim2101024@gmail.com>
 <CAL_JsqKpWNJXNpKS5qC99N0+H_P37DcRE-rN9HFwT5tVmRFCNw@mail.gmail.com>
 <20180118073123.GA15766@lst.de>
 <EDAEFB0F-BB7C-444A-B282-F178F5ADFCBF@gmail.com>
 <20180118152331.GA24461@lst.de>
 <d62226a2-a92c-cdcb-4a9b-e69ab677bc60@broadcom.com>
 <20180123132033.GA21438@lst.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f746f9d5-b12d-9ffc-83e3-3851b4de6e52@gmail.com>
Date:   Wed, 24 Jan 2018 12:04:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180123132033.GA21438@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62318
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

On 01/23/2018 05:20 AM, Christoph Hellwig wrote:
> On Fri, Jan 19, 2018 at 11:47:54AM -0800, Florian Fainelli wrote:
>> How can this work well in the context of a loadable module for instance?
>> For MIPS, this would mean that we have to override phys_to_dma() and
>> dma_to_phys() in the platform that is *susceptible* to use this PCIe
>> controller (arch/mips/bmips) which is fine, but there, we essentially
>> need to find a way to make this dynamic based on whether the PCIe
>> controller is loaded or not.
>>
>> As you might have seen from this patch, what needs to be done is highly
>> dependent on the processor architecture and its memory controller
>> physical memory map, so I don't see how we are in any better situation
>> if we need to replicate 3 times across MIPS, ARM and ARM64 how the
>> addresses need to be mangled.
>>
>> Are you suggesting we somehow decouple the memory mangling part into a
>> portion that can be built into the kernel image (so phys_to_dma() and
>> dma_to_phys() is resolved at vmlinux link time) and can be selected by
>> different architectures that need it? If so, yikes.
> 
> On architectures with crazy PCIe controllers (this seems to include
> mips, arm, arm64 and x86 thanks to the weird SOCs) we will need a
> a few different memory maps, yes.  Take a look at
> arch/x86/pci/sta2x11-fixup.c, preferably from a tree where the worst
> issues are fixed:
> 
> http://git.infradead.org/users/hch/misc.git/blob/refs/heads/dma-direct-all:/arch/x86/pci/sta2x11-fixup.c
> 
> Overriding phys_to_dma and dma_to_phys is required if you need to
> support swiotlb, and chances are with a broken PCIe controller on
> arm64 or mips64 you eventuall will.
> 
> This sta2x11 code should probably be lifted to common code in
> one form or another eventually, althought it will need another
> fair round of cleanups for now.

This looks nicer than the current shape, but this still requires to
register a PCI fixup to override phys_to_dma() and dma_to_phys(), and it
would appear that you have dodged my question about how this is supposed
to fit with an entirely modular PCIe root complex driver? Are you
suggesting that we split the module into a built-in part and a modular part?

> 
>> I can see value in having a generic mechanism, ala X86_DMA_REMAP
>> allowing architectures to have the ability to override phys_to_dma() and
>> dma_to_phys() but right now, especially if we look at
>> arch/x86/pci/sta2x11-fixup.c this really appears to be quite messy and
>> equally ugly than stacking operations...
>>
>> What is the actual problem you want to avoid with the stacking of DMA
>> operations, is it because it becomes harder to audit, or are there are
>> other reasons?
> 
> Audit, consolidate into a single dma-direct implementation and properly
> support swiotlb out of the box.
> 

OK.
-- 
Florian

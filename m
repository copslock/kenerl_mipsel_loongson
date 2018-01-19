Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Jan 2018 20:48:18 +0100 (CET)
Received: from mail-wr0-x243.google.com ([IPv6:2a00:1450:400c:c0c::243]:44932
        "EHLO mail-wr0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992079AbeASTsL4GUW7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Jan 2018 20:48:11 +0100
Received: by mail-wr0-x243.google.com with SMTP id w50so2541103wrc.11
        for <linux-mips@linux-mips.org>; Fri, 19 Jan 2018 11:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J9VOwdLJXDn6CV0b/YRUP485OMQx0P+DPCv3soxh36Q=;
        b=TplHvHH173ezZL+TbOLNSdkos1TDtBVVP+Ve3XnqjkZ+kvbieQbjTEGqSkYOKn+ZPh
         FSWEGjm8uOpyEEQFuuSNL6miwx9PkziFvUj690N82rC6D69aKJnKh4S5+yuUorSjNFU4
         Go6+GVO/aSyDItWjunv6LYYZKORZqbDESbzoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J9VOwdLJXDn6CV0b/YRUP485OMQx0P+DPCv3soxh36Q=;
        b=Qj8Zv4h1sdJjLjjrav96uiFXWTQT5qfZGtJi+aMC+1OHetCuFhIXRlQFCVzidqfjhp
         gXNd2PFiLC6Yrma6xPRdhAFLVLxGV/dny0pwmsADr0rIYYVG9ndcS9n+VOknjncqwJ2P
         0B1BLysidNSOZs19dh935qVM0wdPIULK79K06E6MsVe+Jh9wOV6uvWwbdWBTvukcwviD
         m/4tnBb1jdvbqWb2MMJfRr+TS6eN3D0rElAj7rGabVuwBFeTkHXPUtOA1jI9RH6x3Qae
         D1WUfhkJlw681gIO279brxR1zRgLm8xJKuzatnyl21i4wxDjdpyIYCeliJiwv0/9SaZ4
         6Tbg==
X-Gm-Message-State: AKwxyteEhJBkzfxk+NJg/RV8/pA31wVHBVt0MwJYlhKvR3Tm87DEeYfe
        qOLosboDomY2Ke/CBCWKmV7/MQ==
X-Google-Smtp-Source: ACJfBouINVWasR0rCxygJ/4x4vpIDKqLHdA+gbrp4E/8KALFCzHQYQJJG4VWGc6u953PmEAuedQzQw==
X-Received: by 10.223.187.13 with SMTP id r13mr8332864wrg.62.1516391285524;
        Fri, 19 Jan 2018 11:48:05 -0800 (PST)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id a73sm17685885wrc.53.2018.01.19.11.47.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jan 2018 11:48:04 -0800 (PST)
Subject: Re: [PATCH v4 4/8] PCI: brcmstb: Add dma-range mapping for inbound
 traffic
To:     Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>
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
From:   Florian Fainelli <florian.fainelli@broadcom.com>
Message-ID: <d62226a2-a92c-cdcb-4a9b-e69ab677bc60@broadcom.com>
Date:   Fri, 19 Jan 2018 11:47:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180118152331.GA24461@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <florian.fainelli@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@broadcom.com
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

On 01/18/2018 07:23 AM, Christoph Hellwig wrote:
> On Thu, Jan 18, 2018 at 07:09:23AM -0800, Florian Fainelli wrote:
>>> But in this case it actually is the example to follow as told
>>> previously.
>>>
>>> NAK again for these chained dma ops that only create problems.
>>
>> Care to explain what should be done instead?
> 
> Override phys_to_dma and dma_to_phys as mips and x86 do for similar
> situations.

How can this work well in the context of a loadable module for instance?
For MIPS, this would mean that we have to override phys_to_dma() and
dma_to_phys() in the platform that is *susceptible* to use this PCIe
controller (arch/mips/bmips) which is fine, but there, we essentially
need to find a way to make this dynamic based on whether the PCIe
controller is loaded or not.

As you might have seen from this patch, what needs to be done is highly
dependent on the processor architecture and its memory controller
physical memory map, so I don't see how we are in any better situation
if we need to replicate 3 times across MIPS, ARM and ARM64 how the
addresses need to be mangled.

Are you suggesting we somehow decouple the memory mangling part into a
portion that can be built into the kernel image (so phys_to_dma() and
dma_to_phys() is resolved at vmlinux link time) and can be selected by
different architectures that need it? If so, yikes.

> 
> Bonous points of finding some generic way of doing it instead of
> hiding it in arch code.
> 

I can see value in having a generic mechanism, ala X86_DMA_REMAP
allowing architectures to have the ability to override phys_to_dma() and
dma_to_phys() but right now, especially if we look at
arch/x86/pci/sta2x11-fixup.c this really appears to be quite messy and
equally ugly than stacking operations...

What is the actual problem you want to avoid with the stacking of DMA
operations, is it because it becomes harder to audit, or are there are
other reasons?
-- 
Florian

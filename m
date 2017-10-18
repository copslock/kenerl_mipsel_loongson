Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2017 16:41:30 +0200 (CEST)
Received: from mail-io0-x236.google.com ([IPv6:2607:f8b0:4001:c06::236]:56720
        "EHLO mail-io0-x236.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992361AbdJROlYAYT7A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Oct 2017 16:41:24 +0200
Received: by mail-io0-x236.google.com with SMTP id m81so6439087ioi.13;
        Wed, 18 Oct 2017 07:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5YEIfX7V7x4JMLtGPmMqTsPLztnl1j8/jGYyeaPPrBA=;
        b=FBWYJ3irhiXuA8hyWUT0IMDOT2Opu9IeqR3efUJB9HGOdLNiQ5i0yCk5slBXwjxi5N
         /WNe4+R2s8hMCKVVOUOO2bbrc/Did2IxJ66kMFsSPL4dg5V2fsUCTDn+nBXgHGOJtkJb
         CR2MgXQKdt4lPvDDqsLTZTfsw3J1hVbIoNiQ2MSxX3YiA5rL/+APItDlgjFk2HVpUsm5
         b5iYLiqnbsMeDYoW/bwutOBEplUjAGvnuzKFsAe5ukZv0vdFbF1rDdWkyOUEaG8/pIwE
         t8sgTfy3D7Wz1sQVrUlV7mYQv3dPorXjPkhwXOZpJYxtAD0BN8tDuMRGrATqSx0BW+D7
         ud1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5YEIfX7V7x4JMLtGPmMqTsPLztnl1j8/jGYyeaPPrBA=;
        b=EmNHCPa0XtWBS83cYekWy+uJkK1MkNBQGhUbsbXCcib77708CLnV6HCSAC41fV2uL/
         RNyYmRYdMh02yFo6IsdSs3hJeJforvu/60pJWdzyNVWNr3+SRc4b/LbrzP6KtsyFPmyF
         b4EFjWp0VBNoKBEoTiqSSGoiaYdLlM3hLP6QQFDWSYhnrS4KuJW4C91RbV7Xgs2qH39C
         BwuMJf0I6oJDmr+V4OK7uUxz/tDKHiUqdYjbG8gZjo2Cndi84SMvbH8HmArZM9Ki1h18
         Vw+98zjI42VArAhU96hfDiUViYaZfkm3/G4UmMc+2DF1SIGL1y8aeoM7N1DVw1bftedi
         caUQ==
X-Gm-Message-State: AMCzsaUvlqZeq5ZXIYaUcMKCI3kRF8DVk3xdReDd0osCdUUbGP2mEjGx
        b2b2iSPGDLisOioo1f6Vs/BQcyrp+G2bo0tNSIc=
X-Google-Smtp-Source: ABhQp+QRDfTfKrw1qeZSSwnanY+c2n3Agwl9y+FapxRYgS1Ij3G+zAAFP4C16wYnu1Mnw9TpeCW2uAYTD93jCpUbr0I=
X-Received: by 10.107.20.209 with SMTP id 200mr21059466iou.219.1508337677675;
 Wed, 18 Oct 2017 07:41:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.47.156 with HTTP; Wed, 18 Oct 2017 07:41:17 -0700 (PDT)
In-Reply-To: <20171018065316.GA11183@lst.de>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-6-git-send-email-jim2101024@gmail.com> <589c04cb-061b-a453-3188-79324a02388e@arm.com>
 <20171017081422.GA19475@lst.de> <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com>
 <20171018065316.GA11183@lst.de>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Wed, 18 Oct 2017 10:41:17 -0400
Message-ID: <CANCKTBv+yiCNsrnx3m+W9wPqC4NdKPZ2p=zLtSa8fX6v1rPcYQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound traffic
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, linux-pci <linux-pci@vger.kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jim2101024@gmail.com
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

On Wed, Oct 18, 2017 at 2:53 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Tue, Oct 17, 2017 at 12:11:55PM -0400, Jim Quinlan wrote:
>> My understanding is that dma_pfn_offset is that it is a single
>> constant offset from RAM, in our case, to map to PCIe space.
>
> Yes.
>
>> But in
>> my commit message I detail how our PCIe controller presents memory
>> with multiple regions with multiple different offsets. If an EP device
>> maps to a region on the host memory, yes we can set the dma_pfn_offset
>> for that device for that location within that range,.  But if the
>> device then unmaps and allocates from another region with a different
>> offset, it won't work.  If  I set dma_pfn_offset I have to assume that
>> the device is using only one region of memory only, not more than one,
>> and that it is not unmapping that region and mapping another (with a
>> different offset).  Can I make those assumptions?
>
> No, we can't make that assumption unfortunately.  But how is your
> code going to work if the mapping spans multiple of your translation
> regions?

That's what brcm_to_{pci,cpu} are for -- they keep a list of the
dma-ranges given in the PCIe DT node, and translate from system memory
addresses to pci-space addresses, and vice versa.  As long as people
are using the DMA API it should work.  It works for all of the ARM,
ARM64, and MIPS Broadcom systems I've tested, using eight different EP
devices.  Note that I am not thrilled to be advocating this mechanism
but it seemed the best alternative.

>memorymaintiners
> Also I really don't think the stacking of dma_ops as in this patch
> is a good idea.  For MIPS you should do the variant suggested in
> the patch description and hook into dma_to_phys/phys_to_dma helpers,
> and for ARM/ARM64 you should talk to the maintainers on how they
> want the translation integrated.

I would prefer that the same code work for all three architectures.
What I would like from ARM/ARM64 is the ability to override
phys_to_dma() and dma_to_phys(); I thought the chances of that being
accepted would be slim.  But you are right, I should ask the
maintainers.

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Feb 2018 14:39:58 +0100 (CET)
Received: from mail-io0-x236.google.com ([IPv6:2607:f8b0:4001:c06::236]:40374
        "EHLO mail-io0-x236.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993973AbeBLNjvOatqo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Feb 2018 14:39:51 +0100
Received: by mail-io0-x236.google.com with SMTP id t22so17271048ioa.7;
        Mon, 12 Feb 2018 05:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7nWAZlvit2hiVs1QAfibzNRkjwHFmRIll52vPPjNLP0=;
        b=jY/jZobKxkadRIJQ4apEUmD8vJhe6hdaBDfle5UWJ+CI3uZh5XbvzWMEjxlOv2IfXP
         X6/btjc7L71t0t+oYUtqu+BhwzS2PPmF9aVt+Ktc+EQDQxxVT43L+kcDjk+0Du7z/b0R
         faanbs5+grI/shUHZJb5s0ZkQ3zIu9togM+FWB+1JBs6RRqd8Sa8kS0+BaeXh/2uABE6
         ZjwdJrQysbWgKk4T9LbzsaC45CBXE0SdW4TWanUp524o1QQt95mzsopvx2HT+7UWSklj
         EpocRLFTBp1Jn3oeKBm0Vo208LhSeMkiKdPOJplKQaLtQCCt8g1cHBfKz1g/aelzXxWE
         xiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7nWAZlvit2hiVs1QAfibzNRkjwHFmRIll52vPPjNLP0=;
        b=hRF1U6by6iK/2c9zpTWD/aZG475wWMGFh4d0wc+oMMIDZxLppIxbl/Z1n/FDChaTUn
         Pis9QCd4v1wazVzNkiNG+I2D7FU1YaAlBwnOz9Bi8d2Cjvi2PyBHi+7PU1FyCzSNVNto
         wD3El4YCqlMTyF8WiWZRGwIJZL/0Jd1S+lRVN7B88YZuaK2Z1CQ++wbo+G4nnxxeiDrr
         xUaFlYXT2wJ3CstIDOm2xJ7pYvopoD6WeGFjI0FnUxMRcuN1ajK3Yn8Y+w7OVWDoChuM
         J5d0jMOa+b5YDmDUGeVXwWHMOq0lZ/tHU36dyrvbXygRI/uvXeGUBuq7Sau65cwQ/Eak
         W1qg==
X-Gm-Message-State: APf1xPCTsWslTVWNOcq9VUzp7AZcJ9yhUG5cb9dge43sIAgcZr2dheQK
        Wmvh1yud7lMIri0FFSaqM5gDjfhlQnd7Fl85K7s=
X-Google-Smtp-Source: AH8x227WkneCvGw8OX081R+raFc0zuWySRnNHnA4Vm91/Bf9g1x+LlKSAjAaRExRDNnnQzx1eWMtfmPnjQOs6PJ7vTw=
X-Received: by 10.107.140.139 with SMTP id o133mr8886544iod.219.1518442784356;
 Mon, 12 Feb 2018 05:39:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.8.9 with HTTP; Mon, 12 Feb 2018 05:39:43 -0800 (PST)
In-Reply-To: <CANCKTBszKRp7gYKE=S3fA0=MoOVFFkO6PgmR476t3HAJ9US2gg@mail.gmail.com>
References: <1516058925-46522-1-git-send-email-jim2101024@gmail.com>
 <1516058925-46522-5-git-send-email-jim2101024@gmail.com> <CAL_JsqKpWNJXNpKS5qC99N0+H_P37DcRE-rN9HFwT5tVmRFCNw@mail.gmail.com>
 <20180118073123.GA15766@lst.de> <EDAEFB0F-BB7C-444A-B282-F178F5ADFCBF@gmail.com>
 <20180118152331.GA24461@lst.de> <d62226a2-a92c-cdcb-4a9b-e69ab677bc60@broadcom.com>
 <20180123132033.GA21438@lst.de> <f746f9d5-b12d-9ffc-83e3-3851b4de6e52@gmail.com>
 <20180126075343.GB2356@lst.de> <CANCKTBszKRp7gYKE=S3fA0=MoOVFFkO6PgmR476t3HAJ9US2gg@mail.gmail.com>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Mon, 12 Feb 2018 08:39:43 -0500
Message-ID: <CANCKTBvS8jCgoq4EzBSdXeQ_Hc50+WHfyAoc=H8LJTbF3dCtNA@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] PCI: brcmstb: Add dma-range mapping for inbound traffic
To:     Christoph Hellwig <hch@lst.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
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
        linux-pci <linux-pci@vger.kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62503
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

On Fri, Jan 26, 2018 at 12:46 PM, Jim Quinlan <jim2101024@gmail.com> wrote:
> On Fri, Jan 26, 2018 at 2:53 AM, Christoph Hellwig <hch@lst.de> wrote:
>> On Wed, Jan 24, 2018 at 12:04:58PM -0800, Florian Fainelli wrote:
>>> This looks nicer than the current shape, but this still requires to
>>> register a PCI fixup to override phys_to_dma() and dma_to_phys(), and it
>>> would appear that you have dodged my question about how this is supposed
>>> to fit with an entirely modular PCIe root complex driver? Are you
>>> suggesting that we split the module into a built-in part and a modular part?
>>
>> I don't think entirely modular PCI root bridges should be a focal point
>> for the design.  If we happen to support them by other design choices:
>> fine, but they should not be a priority.
>
> I disagree.  If there is one common thing our customers request  it is
> the ability to remove (or control the insmod of after boot)  the pcie
> RC driver.  I didn't add this in as a "nice-to-have".
>
>>
>> That being said if we have core dma mapping or PCIe code that has
>> a list of offsets and the root complex only populates them it should
>> work just fine.
>
> I'm looking at arch/arm/include/asm/dma-mapping.h.  In addition to
> overriding dma_to_phsy() and phys_to_dma(), it looks like I may have
> to define __arch_pfn_to_dma(), __arch_dma_to_pfn(),
> __arch_dma_to_virt(), __arch_virt_to_dma().  Do  you agree or is this
> not necessary?  If it is, this seems more intrusive than our
> pcie-brcmstb-dma.c solution which  doesn't require tentacles into
> major include files and Kconfigs.
>
> Another issue is that our function wrappers -- depending upon whether
> we are dealing with a pci device or not -- will have to possibly call
> the actual ARM and ARM64 definitions of these functions, which have
> been of course #ifdef'd out.  This means that our code must contain
> identical copies of these functions' code and that the code must
> somehow be kept in sync.  Do you see a solution to this?
>
> Jim

Cristoph,
Could you please respond to my comments?  Even a negative response is
better than none.  The problem with doing what you suggested is with
ARM -- ARM64 and MIPS relatively uncomplicated .  With ARM, I have to
define the aforementioned functions -- the only way of doing this is
to define arch/arm/mach-bcm/include/mach/memory.h, and for that to be
picked up we no longer can have CONFIG_ARCH_MULTIPLATFORM=y, which is
an unacceptable cost to pay for just an unusual PCIe RC controller.

Regarding my current submission -- you are right, SWIOTLB will not
work for EPs that require it.  However, we don't care about these
devices, and can just bailout with EPs when the dma_mask is <=
0xffff_ffff or if swiotlb_force ==  SWIOTLB_FORCE.  Note that this
would only affect PCIe DMA.  We also have no plan of using MIPS64.

-- Jim

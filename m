Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Jan 2018 18:46:58 +0100 (CET)
Received: from mail-io0-x22c.google.com ([IPv6:2607:f8b0:4001:c06::22c]:40341
        "EHLO mail-io0-x22c.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993029AbeAZRqv1k75x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Jan 2018 18:46:51 +0100
Received: by mail-io0-x22c.google.com with SMTP id t22so1234136ioa.7;
        Fri, 26 Jan 2018 09:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=63vpePTo/Gxz4tLg+VvXG6N1DvFEAltssPjs8xZShw0=;
        b=jFX1OcMy5jgzcFsv0oKMfnqxU0r07u/pKgGcKeKRoAxlTftPWCK5FWeTHutytwCrBE
         RAF6Y9z1/f/DaKHVEhu64EZQ/wKo3VM0SKNnWcHSg/lsnH6L2anABqRFr6P/TV/H9hG6
         0brlNwJPFajFESq5mrqlOKLzkriFfJBdsFis0C1Oyl3PnWDX5oaxdKOQ24gTbqU7v7Oq
         cLnAop5S0Nxf3l9FmcEQ6uY8F8Ic9lOLP7H7ETqQsElXjE6yPWfF91SCqWyMkCCFgiRE
         4l/lJ3SN/oj7N8wE9iErW+hetbw8cwqbf0n5wjjQ8tkIBwJa43C7iDiXWRmHiv+cau6v
         u8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=63vpePTo/Gxz4tLg+VvXG6N1DvFEAltssPjs8xZShw0=;
        b=c9+HGlhewpg7RoUKteoKkPfmhvoT2TfH4cYAhrSfHm5QcZwqtKJ6mUOtM49ZSfVqQl
         qwEgi615hIa0gjpShkwxsvToFNrhVdjf+WbdQ7V444aiv9B8TcArVXqRSsz2CmzBCuNz
         EZwRaycvkhX/EIDmVIFcd/1RmWEdgoDl2wPaLXWzazlT8pq5F6joYSrhnMLCW0u6/uRy
         XfNlRR+jnAjhO/8qTa4ic58K+VWT0U3HUGvrk3h1gDGXCNIQu+Q5tMhvNj4KCUPjFZWO
         ILml6lP9RajwQ2Sl/I5G/QTgJPcFK2Ov/HjJzffONMxZ7X3pkI6tvo+wT9nSMwb+T9Mm
         dvzQ==
X-Gm-Message-State: AKwxytdnE45fEt7wxMDtU3K9irQI5uirzmI5lzQ4TeH2nmrJnG2ZmSaU
        0T9wFU7bqaGcpzSkcVFHdM2Fg6Jlxk+PTPtPCjU=
X-Google-Smtp-Source: AH8x224iiw9mgigr0wnjK3HlUOIfja3F/gyzgzYh3GRBiZfx2VCQ3c0uiU9Ik7aZLg7GTyH0eOlPoMYCLRIYQdh9pyg=
X-Received: by 10.107.132.224 with SMTP id o93mr3544245ioi.58.1516988805129;
 Fri, 26 Jan 2018 09:46:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.8.9 with HTTP; Fri, 26 Jan 2018 09:46:44 -0800 (PST)
In-Reply-To: <20180126075343.GB2356@lst.de>
References: <1516058925-46522-1-git-send-email-jim2101024@gmail.com>
 <1516058925-46522-5-git-send-email-jim2101024@gmail.com> <CAL_JsqKpWNJXNpKS5qC99N0+H_P37DcRE-rN9HFwT5tVmRFCNw@mail.gmail.com>
 <20180118073123.GA15766@lst.de> <EDAEFB0F-BB7C-444A-B282-F178F5ADFCBF@gmail.com>
 <20180118152331.GA24461@lst.de> <d62226a2-a92c-cdcb-4a9b-e69ab677bc60@broadcom.com>
 <20180123132033.GA21438@lst.de> <f746f9d5-b12d-9ffc-83e3-3851b4de6e52@gmail.com>
 <20180126075343.GB2356@lst.de>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Fri, 26 Jan 2018 12:46:44 -0500
Message-ID: <CANCKTBszKRp7gYKE=S3fA0=MoOVFFkO6PgmR476t3HAJ9US2gg@mail.gmail.com>
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
X-archive-position: 62342
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

On Fri, Jan 26, 2018 at 2:53 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Jan 24, 2018 at 12:04:58PM -0800, Florian Fainelli wrote:
>> This looks nicer than the current shape, but this still requires to
>> register a PCI fixup to override phys_to_dma() and dma_to_phys(), and it
>> would appear that you have dodged my question about how this is supposed
>> to fit with an entirely modular PCIe root complex driver? Are you
>> suggesting that we split the module into a built-in part and a modular part?
>
> I don't think entirely modular PCI root bridges should be a focal point
> for the design.  If we happen to support them by other design choices:
> fine, but they should not be a priority.

I disagree.  If there is one common thing our customers request  it is
the ability to remove (or control the insmod of after boot)  the pcie
RC driver.  I didn't add this in as a "nice-to-have".

>
> That being said if we have core dma mapping or PCIe code that has
> a list of offsets and the root complex only populates them it should
> work just fine.

I'm looking at arch/arm/include/asm/dma-mapping.h.  In addition to
overriding dma_to_phsy() and phys_to_dma(), it looks like I may have
to define __arch_pfn_to_dma(), __arch_dma_to_pfn(),
__arch_dma_to_virt(), __arch_virt_to_dma().  Do  you agree or is this
not necessary?  If it is, this seems more intrusive than our
pcie-brcmstb-dma.c solution which  doesn't require tentacles into
major include files and Kconfigs.

Another issue is that our function wrappers -- depending upon whether
we are dealing with a pci device or not -- will have to possibly call
the actual ARM and ARM64 definitions of these functions, which have
been of course #ifdef'd out.  This means that our code must contain
identical copies of these functions' code and that the code must
somehow be kept in sync.  Do you see a solution to this?

Jim

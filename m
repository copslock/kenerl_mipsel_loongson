Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Oct 2017 18:12:10 +0200 (CEST)
Received: from mail-it0-x22a.google.com ([IPv6:2607:f8b0:4001:c0b::22a]:44200
        "EHLO mail-it0-x22a.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992274AbdJQQMDSemCw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Oct 2017 18:12:03 +0200
Received: by mail-it0-x22a.google.com with SMTP id n195so6015872itg.1;
        Tue, 17 Oct 2017 09:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=54Hsn2D6eg30yTyWEbW3Q3NN0MKlLy/uG+ZcrBo1HUI=;
        b=QgkY6DeJHGsJhdqVqk9ruLVDeJRzO+xyL6X/xP5yN9vp2SnN6fZrKgKY0yVU3wFXms
         oSinh7hvADGbInbwTvgp44S4D3e+ooex1MYREW8fEeS5XSA1E8TMbz1hhZOH3cZyciaK
         hoQyaRFz6WpZYhZXUT1n/bpsf/NBeI3TyUqW1zFu9Ik3KfhYmhiR553guEevXoXXwSrr
         Z0g3cfqCWj5JDhMtuTd7eZYoo8cyvRxyVmP+9HpV+xo2VPvqJf83ab4ZummlqWzMgGOg
         INLXphFIiUmPC3bqfcvlb1rHvdtn6pjaHAQBkesfTM6UB7fZSKLv2vHQJugcOL06HRzo
         paQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=54Hsn2D6eg30yTyWEbW3Q3NN0MKlLy/uG+ZcrBo1HUI=;
        b=ryBu/So2OlyE/edQUnlyCrR/Cr8ANIpwZE7tkk/xJvMb/VPP9SPkDdhXS1S/wlKJFZ
         kW0Fz/xa+0RLr5pA97nKox0XhlbOPnAbm0AMnsCVuV8fld2K/E3xzEEXGq0y/BIu/Y7Z
         avlHbOQhuiIvfepkwbCjBeBiJgr9CGeMiGaWXWjnS7NBVvkMM3LcTJEUtZ6H/6kTMx8C
         9Fd2yr6Pv7tqmyQkP6ykffRKx4d+COacjxmzUjUbRQvm42mUmP8tpxEkk3bjpGdVlg8b
         RpmKqhAS7f6PpCU6gY4JJ4jROO4n1IxAE0Ir3vSQV0fYazk1BW5g3ovJM2Onu5bzSX27
         DkzQ==
X-Gm-Message-State: AMCzsaUsMJrM7q/jMHjjDQfyttr+VETygwfno3VCoh6oeuMp5coDieI4
        B4iTJvG3jlBia+CChCt2f61tVnSnV0DG4uOBlcQ=
X-Google-Smtp-Source: ABhQp+QofCgG5oh6vBqr5fRlRDSyWUsnk5f1IU12aEWnlRanB7IkM5ZtOWHtz8k5Ljr81ebT7tv2TF9xiWmq14JvdzA=
X-Received: by 10.36.135.202 with SMTP id f193mr6080671ite.47.1508256716098;
 Tue, 17 Oct 2017 09:11:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.47.156 with HTTP; Tue, 17 Oct 2017 09:11:55 -0700 (PDT)
In-Reply-To: <20171017081422.GA19475@lst.de>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-6-git-send-email-jim2101024@gmail.com> <589c04cb-061b-a453-3188-79324a02388e@arm.com>
 <20171017081422.GA19475@lst.de>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Tue, 17 Oct 2017 12:11:55 -0400
Message-ID: <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com>
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
X-archive-position: 60428
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

On Tue, Oct 17, 2017 at 4:14 AM, Christoph Hellwig <hch@lst.de> wrote:
> Just took a quick look over this and I basically agree with the comments
> from Robin.
>
> What I don't understand is why you're even trying to do all these
> hacky things.
>
> It seems like the controller should simply set dma_pfn_offset for
> each device hanging off it, and all the supported architectures
> should be updated to obey that if they don't do so yet, and
> you're done without needing this giant mess.

My understanding is that dma_pfn_offset is that it is a single
constant offset from RAM, in our case, to map to PCIe space.  But in
my commit message I detail how our PCIe controller presents memory
with multiple regions with multiple different offsets. If an EP device
maps to a region on the host memory, yes we can set the dma_pfn_offset
for that device for that location within that range,.  But if the
device then unmaps and allocates from another region with a different
offset, it won't work.  If  I set dma_pfn_offset I have to assume that
the device is using only one region of memory only, not more than one,
and that it is not unmapping that region and mapping another (with a
different offset).  Can I make those assumptions?

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Oct 2017 17:27:55 +0200 (CEST)
Received: from mail-it0-x243.google.com ([IPv6:2607:f8b0:4001:c0b::243]:52770
        "EHLO mail-it0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992366AbdJTP1swzuKJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Oct 2017 17:27:48 +0200
Received: by mail-it0-x243.google.com with SMTP id j140so13837188itj.1;
        Fri, 20 Oct 2017 08:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZQmAmjST0i6kuSF7jkgG340Clj96wRZqCkKy1MARpsA=;
        b=aLAsxa3aBeCOiDDP/VryHDRpRfGk/4qXI8f4TR4utxaPZep8e3bOvld3CvZMHUOILB
         U0aA+WQY0e+2FRw1bZgUdiU6RQq4VyRNthJJMJuLlgRFQHhaaa1Glahi9wxzF2E2C/yY
         TivLQSn0PyXrsvNxi0Pt9As2epvk5pNhf3qrGkadoRKQibBZXlk/nW84baUs3DOdVzGQ
         Qw2XUoTTtST9E3tUWR8b8PZgYX9f23tWL9+bqnSIRpcXaQPyFF2o6Qej4x6v/P03wKDF
         W8X9hlQjoYPeXTgHjW8fQKMhUg6Ntv3ZsOJYn+yvFwhlHRvvJnyH4qWFcNAfGmf1ZpHt
         R/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZQmAmjST0i6kuSF7jkgG340Clj96wRZqCkKy1MARpsA=;
        b=Ld2elpdYh+/3lYP2EajrPC+nHsH9Ziq3R6ssNDBvZhsPRUoMmJopp6fCk7utbBa3bX
         eFoDZ4cdUnJ6PDzU9guZd9FmRYDPSkp65PLb7bVfyiB9Ju/jEwlaTBDUeqD/og8clfzL
         o5BTmhZR/Tryoiz6nfWFuEWh1AMpICFHI/eTGRijWVPkFwZFeE7w5iz6Pnnas5W1GwB+
         pB8RxZwm6tXSBo9/BSCRpnRRpMeZuYXPKElEE5kB9HYiz8VC2T5USLyJ3H4cjDja8PFN
         hhT4yVnJ4nitkdkssXsmkOWlitc7nU4MPguLyqBafZKJtKQKn5uKXT2mSEfMayEgqWa6
         9Vng==
X-Gm-Message-State: AMCzsaVQV4NEregkPKZS3o72MVm1RUE7KY9eJhGo5isItL/45kNQqTG7
        aLMI2EF55fQiMmUgbUEpcwZSipueMiZLlGSGmyk=
X-Google-Smtp-Source: ABhQp+S/CiVV9+bJSX5MqFoaprna71Dhx24qMUTk2+drqvCsM0kj9NC6O4kLtT1uBLaxH9BPk3i5LJvMD6bt6LAGDlw=
X-Received: by 10.36.65.34 with SMTP id x34mr3215706ita.118.1508513262619;
 Fri, 20 Oct 2017 08:27:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.47.156 with HTTP; Fri, 20 Oct 2017 08:27:41 -0700 (PDT)
In-Reply-To: <20171020145752.GA4694@lst.de>
References: <1507761269-7017-6-git-send-email-jim2101024@gmail.com>
 <589c04cb-061b-a453-3188-79324a02388e@arm.com> <20171017081422.GA19475@lst.de>
 <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com>
 <20171018065316.GA11183@lst.de> <CANCKTBv+yiCNsrnx3m+W9wPqC4NdKPZ2p=zLtSa8fX6v1rPcYQ@mail.gmail.com>
 <20171019091644.GA14983@lst.de> <CANCKTBuaTD29My77QfOeUmtZfLAmmJXUYe6QvBW+uoH2Kb+tAQ@mail.gmail.com>
 <20171020073730.GA12937@lst.de> <CANCKTBsRRkwNMrxWjtgxbyZqT6NOxPX0NHDbnEO2BMjj8oVtpg@mail.gmail.com>
 <20171020145752.GA4694@lst.de>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Fri, 20 Oct 2017 11:27:41 -0400
Message-ID: <CANCKTBtxp9gSdndKAZ7xGA+VozQsn2PX_-9P8A22_5Matbb7-w@mail.gmail.com>
Subject: Re: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound traffic
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
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
X-archive-position: 60509
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

On Fri, Oct 20, 2017 at 10:57 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Fri, Oct 20, 2017 at 10:41:56AM -0400, Jim Quinlan wrote:
>> I am not sure I understand your comment -- the size of the request
>> shouldn't be a factor.  Let's look at your example of the DMA request
>> of 3fffff00 to 4000000f (physical memory).  Lets say it is for 15
>> pages.  If we block out  the last page [0x3ffff000..0x3fffffff] from
>> what is available, there is no 15 page span that can happen across the
>> 0x40000000 boundary.  For SG, there can be no merge that connects a
>> page from one region to another region.  Can you give an example of
>> the scenario you are thinking of?
>
> What prevents a merge from say the regions of
> 0....3fffffff and 40000000....7fffffff?

Huh? [0x3ffff000...x3ffffff] is not available to be used. Drawing from
the original example, we now have to tell Linux that these are now our
effective memory regions:

      memc0-a@[        0....3fffefff] <=> pci@[        0....3fffefff]
      memc0-b@[100000000...13fffefff] <=> pci@[ 40000000....7fffefff]
      memc1-a@[ 40000000....7fffefff] <=> pci@[ 80000000....bfffefff]
      memc1-b@[300000000...33fffefff] <=> pci@[ c0000000....ffffefff]
      memc2-a@[ 80000000....bfffefff] <=> pci@[100000000...13fffefff]
      memc2-b@[c00000000...c3fffffff] <=> pci@[140000000...17fffffff]

This leaves a one-page gap between phsyical memory regions which would
normally be contiguous. One cannot have a dma alloc that spans any two
regions.  This is a drastic step, but I don't see an alternative.
Perhaps  I may be missing what you are saying...

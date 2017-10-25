Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Oct 2017 18:00:17 +0200 (CEST)
Received: from mail-it0-x229.google.com ([IPv6:2607:f8b0:4001:c0b::229]:47353
        "EHLO mail-it0-x229.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991726AbdJYQAKUT03p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Oct 2017 18:00:10 +0200
Received: by mail-it0-x229.google.com with SMTP id p138so1675470itp.2;
        Wed, 25 Oct 2017 09:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fc3aJVpmjatcQbykbfLE2xjgZaff9g0u1urqgEYLcXg=;
        b=YW+99uadOvsK3a2N/zV5wGnR63e85k1X0zCnRooerByudhDZj7aZZ+64yPCY3u/A0N
         pnuVq/g5yzAfSESgM4DJwaitiLMxtD38zG09Ea4hDMVKAsFxT+yRez+Wlsj4rbaVnn+J
         NZL4Pm59f82QVK3YVdwC3FsTPYuDwHv0c7NoQsRpFie63e6HoVNFLQgXQ1FDh6zbOnrJ
         XDDcBnw97XtR5fY8pbAo/hvP79+xBhPSGAu7cvzx7iuXGooTyzTo4ttpBL4lWNFy9Wqy
         iZxonlAoS/A+9Pag+2IQ7oLRGU20TI8YGCOixsRb4oU/OsE2xpiDRrEebikRd0YWY2N1
         ihaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fc3aJVpmjatcQbykbfLE2xjgZaff9g0u1urqgEYLcXg=;
        b=oYxzcJiz7bB8UpECKoQ/EgdNwPE1S7/l/CejU38Ld9kQXDjlIktDmkrFM5dpFVseUO
         kM1XfXuNcimScOODwZpHr8dZsZ5kzl8obp4dON7Lzl98wmYh5Wfke4lGMCKrG74BKvLd
         y07ZNmCr7x/B9PXycwFBVo3R1h1dwFO4CoJD2BRyRMbxNgrQFscdqpm6uVAlCKRcCZtv
         RRCsR/JyhcDSp66K4MxyQNkmTckEFskf0T6dmbfvyRASAlm+TVBPDv61cduKixLERfYZ
         zkGlKZOgZDXzFkHtxDSpy9iNZjVkaSU6Z+4IFjRClLUFboQxIFpkOwNEL6kxr/c85FUp
         ikyw==
X-Gm-Message-State: AMCzsaX4OngX0xcdvuTrrDiaclI3nMxk2NjuTeEXLkdksOAOBrhAdOML
        OLKmNy3tx64ErwOV1Y7dgqd17L6JnA5gI/n5EDI=
X-Google-Smtp-Source: ABhQp+Sz+byagbX/t+U4PIRva+TApjxOThMqz8onPoo3Mjv73aDEXNqhXovRwhiQt+wjY22uLd1QiSrWIcmELzrIZZo=
X-Received: by 10.36.65.34 with SMTP id x34mr2866703ita.118.1508947204280;
 Wed, 25 Oct 2017 09:00:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.47.156 with HTTP; Wed, 25 Oct 2017 09:00:03 -0700 (PDT)
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD00A252D@AcuExch.aculab.com>
References: <1508868949-16652-1-git-send-email-jim2101024@gmail.com>
 <1508868949-16652-5-git-send-email-jim2101024@gmail.com> <063D6719AE5E284EB5DD2968C1650D6DD00A252D@AcuExch.aculab.com>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Wed, 25 Oct 2017 12:00:03 -0400
Message-ID: <CANCKTBuH_FsRAEWtae5L_YvvC6QQSKETLNKU+G+8_LGwMy6smw@mail.gmail.com>
Subject: Re: [PATCH 4/8] PCI: host: brcmstb: add dma-ranges for inbound traffic
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60555
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

On Wed, Oct 25, 2017 at 5:46 AM, David Laight <David.Laight@aculab.com> wrote:
> From: Jim QuinlanPCIE_IPROC_MSI
>> Sent: 24 October 2017 19:16
>> The Broadcom STB PCIe host controller is intimately related to the
>> memory subsystem.  This close relationship adds complexity to how cpu
>> system memory is mapped to PCIe memory.  Ideally, this mapping is an
>> identity mapping, or an identity mapping off by a constant.  Not so in
>> this case.
>>
>> Consider the Broadcom reference board BCM97445LCC_4X8 which has 6 GB
>> of system memory.  Here is how the PCIe controller maps the
>> system memory to PCIe memory:
>>
>>   memc0-a@[        0....3fffffff] <=> pci@[        0....3fffffff]
>>   memc0-b@[100000000...13fffffff] <=> pci@[ 40000000....7fffffff]
>>   memc1-a@[ 40000000....7fffffff] <=> pci@[ 80000000....bfffffff]
>>   memc1-b@[300000000...33fffffff] <=> pci@[ c0000000....ffffffff]
>>   memc2-a@[ 80000000....bfffffff] <=> pci@[100000000...13fffffff]
>>   memc2-b@[c00000000...c3fffffff] <=> pci@[140000000...17fffffff]
>
> I presume the first column is the 'cpu physical address'
> and the second the 'pci' address?
>
Yes.  I probably made this more difficult to read because I ordered
the rows by PCI addresses.

> ...
>
> Isn't this just the same as having an iommu that converts 'bus'
> addresses into 'physical' ones?

Pretty much, but for PCIe devices only.  This could be done by somehow
overriding the arch specific phys_to_dma() and dma_to_phys() calls.

>
> A simple table lookup of the high address bits will do the
> conversion.
True, but this table could be passed something like ARM_MAPPING_ERROR,
which may be out the table (the driver is not privy to
ARM_MAPPING_ERROR's definition).

Thanks,
Jim

>
>         David
>

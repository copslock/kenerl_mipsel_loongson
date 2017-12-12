Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Dec 2017 21:53:41 +0100 (CET)
Received: from mail-it0-x241.google.com ([IPv6:2607:f8b0:4001:c0b::241]:35693
        "EHLO mail-it0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990718AbdLLUxfE29RF convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Dec 2017 21:53:35 +0100
Received: by mail-it0-x241.google.com with SMTP id f143so1111534itb.0;
        Tue, 12 Dec 2017 12:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=apHCxAFf3YZg2kateb8w3XvzMi3evO17MgPqlBXpnHQ=;
        b=fUi3qJWDvRxdCAXWG2dxAy4avv0T2sszdzsiq82n4ZMY7110UR3XM9CzV24e2j+IJs
         t1kN09WxcKi522AvClGkHulNXnO9aGugsEvOT1QSHsxDnKt4wSkVUoMWYvRTlmcPcioB
         bs4Syk58Ql2sh5gw0+RSFZxOWLZalLZPpwREemMbXFnlw74mMyRWj1MS9ZouHrEoTgGD
         h026lfI9i1MA5aVA+x02ZETliSQs2ybusCKarX+l4iWqkjAPIVpbocrokKqHQUStKdzt
         oBkeOuJclciHQIgkMFR7WrSgCUg4qjPDcjFNxxQf8Df6lD4ehEmAaUxYr14fg9F3ALR8
         5Trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=apHCxAFf3YZg2kateb8w3XvzMi3evO17MgPqlBXpnHQ=;
        b=qnhWfoRFlHBILNxTBp/mxV/ZsqD00itB6vRXve7KbDL0XKaHRHDqf2WooKi43c+qoz
         1OsOZVO04W3TUvdmLhkH+WSt6p4GmlvO52EKr9WEken7y3pNQMAjeGKvTHcJgwBAVUd8
         eZAu8Rb0jNPH4aojCe/SqL7mXKMgmLektWVAAzozQB97PM7BaPXjTuhYjt6rgtcOgk4k
         /rg3YGdlP0H8FqZlO5p21o/rfvM+quUa1FkoLDqov2bBAVQeEsxxGixei5R/frqSRwgp
         ZtOjSALbUu01BrTkbEd5mP2edCglNY76qLJUwY6qW3Cd6XqpPsGfPRt5YcPyE8cCZl9e
         1oeQ==
X-Gm-Message-State: AKGB3mIx9KOq3atUiZQR/KwqA0uNjqw50Mdsi1wFTXjc/fhmJkS/pWQW
        fNaLlgN7Fq4d002yeAv11ERObUu/hofbg/mAVKE=
X-Google-Smtp-Source: ACJfBotb/5LHGHWgajTpcHP1AU0jXQhOmzJDMz6IgWsgIr9qJEfQtfHH6BShGGdFZJUqnEebVBvVFobTjrxEcu6/X8M=
X-Received: by 10.36.213.67 with SMTP id a64mr118389itg.87.1513112008685; Tue,
 12 Dec 2017 12:53:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.43.6 with HTTP; Tue, 12 Dec 2017 12:53:28 -0800 (PST)
In-Reply-To: <20171205205926.GJ23510@bhelgaas-glaptop.roam.corp.google.com>
References: <1510697532-32828-1-git-send-email-jim2101024@gmail.com>
 <1510697532-32828-2-git-send-email-jim2101024@gmail.com> <20171205205926.GJ23510@bhelgaas-glaptop.roam.corp.google.com>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Tue, 12 Dec 2017 15:53:28 -0500
Message-ID: <CANCKTBvoXpF-H8Pck5TsH+7tNM=di1-uoedqACE+kjNEAUodYg@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] SOC: brcmstb: add memory API
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61451
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

On Tue, Dec 5, 2017 at 3:59 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Nov 14, 2017 at 05:12:05PM -0500, Jim Quinlan wrote:
>> From: Florian Fainelli <f.fainelli@gmail.com>
>>
>> This commit adds a memory API suitable for ascertaining the sizes of
>> each of the N memory controllers in a Broadcom STB chip.  Its first
>> user will be the Broadcom STB PCIe root complex driver, which needs
>> to know these sizes to properly set up DMA mappings for inbound
>> regions.
>>
>> We cannot use memblock here or anything like what Linux provides
>> because it collapses adjacent regions within a larger block, and here
>> we actually need per-memory controller addresses and sizes, which is
>> why we resort to manual DT parsing.
>>
>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>> ---
>>  drivers/soc/bcm/brcmstb/Makefile |   2 +-
>>  drivers/soc/bcm/brcmstb/memory.c | 172 +++++++++++++++++++++++++++++++++++++++
>>  include/soc/brcmstb/memory_api.h |  25 ++++++
>>  3 files changed, 198 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/soc/bcm/brcmstb/memory.c
>>  create mode 100644 include/soc/brcmstb/memory_api.h
>>
>> diff --git a/drivers/soc/bcm/brcmstb/Makefile b/drivers/soc/bcm/brcmstb/Makefile
>> index 9120b27..4cea7b6 100644
>> --- a/drivers/soc/bcm/brcmstb/Makefile
>> +++ b/drivers/soc/bcm/brcmstb/Makefile
>> @@ -1 +1 @@
>> -obj-y                                += common.o biuctrl.o
>> +obj-y                                += common.o biuctrl.o memory.o
>> diff --git a/drivers/soc/bcm/brcmstb/memory.c b/drivers/soc/bcm/brcmstb/memory.c
>> new file mode 100644
>> index 0000000..eb647ad9
>> --- /dev/null
>> +++ b/drivers/soc/bcm/brcmstb/memory.c
>
> I sort of assume based on [1] that every new file should have an SPDX
> identifier ("The Linux kernel requires the precise SPDX identifier in
> all source files") and that the actual text of the GPL can be omitted.
>
> Only a few files in drivers/pci currently have an SPDX identifier.  I
> don't know if that's oversight or work-in-progress or what.
>
> [1] https://lkml.kernel.org/r/20171204212120.484179273@linutronix.de
>

Bjorn, Did you get a chance to review the other commits of this
submission (V3)?  I would like any additional feedback before I send
out a V4 with SPDX fixes.  Thanks, JimQ

>> @@ -0,0 +1,172 @@
>> +/*
>> + * Copyright © 2015-2017 Broadcom
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
>> + *
>> + * A copy of the GPL is available at
>> + * http://www.broadcom.com/licenses/GPLv2.php or from the Free Software
>> + * Foundation at https://www.gnu.org/licenses/ .

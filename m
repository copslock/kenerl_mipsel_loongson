Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Dec 2017 00:29:14 +0100 (CET)
Received: from mail-qt0-x241.google.com ([IPv6:2607:f8b0:400d:c0d::241]:46719
        "EHLO mail-qt0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990436AbdLHX3DeIdH0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Dec 2017 00:29:03 +0100
Received: by mail-qt0-x241.google.com with SMTP id r39so28773128qtr.13;
        Fri, 08 Dec 2017 15:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kugTmgi9H01O7gBeivoM3yCZtpzsBHMdrrrEQTH+Sb8=;
        b=Zh+qkGwCuHv5dycKemi6nEzFUpufa+0jkUMNeGdelc9vgVaSQhvZCuJ840Y5sSci9M
         a0EDdgseS2VDDl1s2Xcz4XQhvU9263iiJXKQPE81eKn2t5ryh5S5CBkY30axJH0Jti8n
         bMAj9ARdA2ngBnVlHzXV6bi2ByuRIfsdua1kGLaOX6gqfHGkO1VbPLpCm/aspqaDP9jS
         CsN3G2am7w+ggHECJidwz9qeYa7kxoyIpLkmmGBk5ydYrzeEmSYv2V4lSSbwdtwyyF9Y
         6hpzh9/Ft4BWn2XPfzgzpj9piRuSOsHtcT3XAEzaOyvbIywDnjYVwCYZfIVj4qy6ZNUh
         KGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kugTmgi9H01O7gBeivoM3yCZtpzsBHMdrrrEQTH+Sb8=;
        b=gyGTQQ4n1S14IRrW0K6W37a2l23JXGPxwUT1jZn+0FKSb3YT3/Iq/YUaqsXCoLCRhg
         tT27DUc+g3Fojohn+BAqmFTWTmKZUQ+po9ZmWNh1lmoDQcuR5P9lnLvllKBjN10SS+56
         ZaqZTKgJ7o84OwBFghi84eqBqaBA/n7aK6aorru28A94JR8DLFvcRiOajGIVJwAfN4eW
         Ai49STA+czgGx596STSRu5XNq5TmM/gW8snAAaajbGsa+AFYNsFWw9fciRdxw4GoOiVn
         THC+M3cRYR+Wk40BwPmKQENyE/TFYTp1KrslgxLxEJfCn70vA4dHxJ1pdWRhOUEPpvPK
         ToHQ==
X-Gm-Message-State: AKGB3mIrAiI2Y26KMy19s9ce3HcPNkAakcpCYPGUPgUiau7IoYogvR6k
        PYhwV8Nn3xCMu+IK7q0K0e4=
X-Google-Smtp-Source: AGs4zMaGGuCm3fZnMu8kkBgKTKzmHIDjVFtmvgdfZco1ht2J9b+DnhSQUSPBvmur4sMyT9501ZjPYg==
X-Received: by 10.200.51.107 with SMTP id u40mr18256416qta.152.1512775737270;
        Fri, 08 Dec 2017 15:28:57 -0800 (PST)
Received: from ?IPv6:2001:470:d:73f:4d7d:8488:119c:738d? ([2001:470:d:73f:4d7d:8488:119c:738d])
        by smtp.gmail.com with ESMTPSA id j1sm721801qkc.5.2017.12.08.15.28.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Dec 2017 15:28:56 -0800 (PST)
Subject: Re: [PATCH v3 1/8] SOC: brcmstb: add memory API
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>
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
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-pci@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Gregory Fong <gregory.0xf0@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <1510697532-32828-1-git-send-email-jim2101024@gmail.com>
 <1510697532-32828-2-git-send-email-jim2101024@gmail.com>
 <20171205205926.GJ23510@bhelgaas-glaptop.roam.corp.google.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <12a4228d-ab5e-35e4-a65c-24b0e64b1300@gmail.com>
Date:   Fri, 8 Dec 2017 15:28:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171205205926.GJ23510@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61382
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



On 12/05/2017 12:59 PM, Bjorn Helgaas wrote:
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
>> -obj-y				+= common.o biuctrl.o
>> +obj-y				+= common.o biuctrl.o memory.o
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

This was submitted before SPDX was consistently enforced tree wide, so
yes we should fix this.

Any other comment besides that?
-- 
Florian

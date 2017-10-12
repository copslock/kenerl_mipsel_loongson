Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2017 18:53:54 +0200 (CEST)
Received: from mail-qk0-x241.google.com ([IPv6:2607:f8b0:400d:c09::241]:49687
        "EHLO mail-qk0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992241AbdJLQxrGnaMz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Oct 2017 18:53:47 +0200
Received: by mail-qk0-x241.google.com with SMTP id s14so1962793qks.6;
        Thu, 12 Oct 2017 09:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gw7uOZm9+6dW52mDSjBef0IVhxnsobKCtqTM4K/ScOw=;
        b=MahbZiOObnJErp2eVm3UeBxa6gPeMvKfSaxmteN8oedkgIhIp/x5YTbfNoPvgyiizT
         oSczbucidfazimVFvDKMGDsuZStRaZgLwytYFjaKGJHkOGxOg79GHg2n2uCcFR4lZRo4
         +2hG4FRruzxJyJZQ/k7YJKDMTei0grO+c79g1uk9zazgMreQsy5b7r6zs+nckms6dYba
         t5pwHViEAIj++K0G8tagVzRryU+Jffue6y3H7Jqs4oVCgTW2BGlZZVcUxld5k9Q+8JeB
         HBLxCDYpxcIBh/CpSo8JEGxhn30v5+Tf1sMlzJYYUF8/14K4mBbEdPvu/RGpaDOT/iYg
         lNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gw7uOZm9+6dW52mDSjBef0IVhxnsobKCtqTM4K/ScOw=;
        b=C0mvRdxxQVSiSrDtrydH+rx4Ym4aYvu9yeVvc6rbINaLAwId3WuWsaIlu4soWIHMGr
         sGM2M73108JEDgxIVPcsTpfvf4oZnLGxndNPm4kHycliMVrI9e1Iv0oR9x6OxSHqKlvc
         TtooXKfuZ/UNL4a/0mUFX1lajVmQm36rVWivf6vwfDZVzcU8IFy+d8tMLx4If2cEl73Q
         vvsse8E0YblyNXvBJuJ+mIRIwkQwHoqO9TV4jj9VcCJfiSqdacRDiHctvjQUmwaWXqOJ
         2xf1oMMW8HhiCBsAvY517xovkK4H6uCqi9ocFvKjBmTYskUZYBvE8nRnGOYX9P4SQv7o
         0cpQ==
X-Gm-Message-State: AMCzsaUnkXvRSvymosMWGkMYcHTYEayM1HnlZ1D3HWO9QnqPLNsjLzZV
        lv9QbZlfuLORMtkzv4eRMlA=
X-Google-Smtp-Source: ABhQp+THxxk3IOXT3wxZVNtrYY364iHqScDQcLCDlADr5Nb0Fl5eIQdZeOo6mgg2bppJf2LaR30KBA==
X-Received: by 10.55.139.70 with SMTP id n67mr1302333qkd.135.1507827220811;
        Thu, 12 Oct 2017 09:53:40 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id n24sm2648786qta.94.2017.10.12.09.53.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Oct 2017 09:53:39 -0700 (PDT)
Subject: Re: [PATCH 1/9] SOC: brcmstb: add memory API
To:     Julien Thierry <julien.thierry@arm.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-2-git-send-email-jim2101024@gmail.com>
 <b6be2073-7a90-f83f-4e25-79ef04827bd7@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <425b3363-1977-87e1-644e-68a28f648fb0@gmail.com>
Date:   Thu, 12 Oct 2017 09:53:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <b6be2073-7a90-f83f-4e25-79ef04827bd7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60386
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

On 10/12/2017 07:41 AM, Julien Thierry wrote:
> Hi Jim,
> 
> On 11/10/17 23:34, Jim Quinlan wrote:
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
>>   drivers/soc/bcm/brcmstb/Makefile |   2 +-
>>   drivers/soc/bcm/brcmstb/memory.c | 183
>> +++++++++++++++++++++++++++++++++++++++
>>   include/soc/brcmstb/memory_api.h |  25 ++++++
>>   3 files changed, 209 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/soc/bcm/brcmstb/memory.c
>>   create mode 100644 include/soc/brcmstb/memory_api.h
>>
>> diff --git a/drivers/soc/bcm/brcmstb/Makefile
>> b/drivers/soc/bcm/brcmstb/Makefile
>> index 9120b27..4cea7b6 100644
>> --- a/drivers/soc/bcm/brcmstb/Makefile
>> +++ b/drivers/soc/bcm/brcmstb/Makefile
>> @@ -1 +1 @@
>> -obj-y                += common.o biuctrl.o
>> +obj-y                += common.o biuctrl.o memory.o
>> diff --git a/drivers/soc/bcm/brcmstb/memory.c
>> b/drivers/soc/bcm/brcmstb/memory.c
>> new file mode 100644
>> index 0000000..cb6bf73
>> --- /dev/null
>> +++ b/drivers/soc/bcm/brcmstb/memory.c
>> @@ -0,0 +1,183 @@
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
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/io.h>
>> +#include <linux/libfdt.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_fdt.h>
>> +#include <linux/sizes.h>
>> +#include <soc/brcmstb/memory_api.h>
>> +
>> +/* -------------------- Constants -------------------- */
>> +
>> +/* Macros to help extract property data */
>> +#define U8TOU32(b, offs) \
>> +    ((((u32)b[0 + offs] << 0)  & 0x000000ff) | \
>> +     (((u32)b[1 + offs] << 8)  & 0x0000ff00) | \
>> +     (((u32)b[2 + offs] << 16) & 0x00ff0000) | \
>> +     (((u32)b[3 + offs] << 24) & 0xff000000))
>> +
>> +#define DT_PROP_DATA_TO_U32(b, offs) (fdt32_to_cpu(U8TOU32(b, offs)))
>> +
> 
> I fail to understand why this is not:
> 
> #define DT_PROP_DATA_TO_U32(b, offs) (fdt32_to_cpu(*(u32*)(b + offs)))
> 
> 
> If I understand correctly, fdt data is in big endian, the macro U8TOU32
> reads it as little endian. My guess is that this won't work on big
> endian kernels but should work on little endian since fdt32_to_cpu will
> revert the bytes again.
> 
> Am I missing something?

No, your point is valid, there is no reason why this cannot be
fdt32_to_cpu() here.
-- 
Florian

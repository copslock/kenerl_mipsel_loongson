Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2018 17:20:11 +0100 (CET)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42830 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992433AbeKGQTRboNbo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Nov 2018 17:19:17 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B17980D;
        Wed,  7 Nov 2018 08:19:15 -0800 (PST)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CFBD3F5BD;
        Wed,  7 Nov 2018 08:19:12 -0800 (PST)
Subject: Re: [PATCH] of/device: Really only set bus DMA mask when appropriate
To:     Rob Herring <robh@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
        aaro.koskinen@iki.fi, jean-philippe.brucker@arm.com,
        john.stultz@linaro.org, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-arm-kernel@lists.infradead.org
References: <b06321ac25a1211e572e650a630e5e1aa9f8173f.1541504601.git.robin.murphy@arm.com>
 <20181107080335.GA24511@lst.de>
 <22cbe798-612f-8c88-90e7-388202f603cf@arm.com> <20181107155235.GA18618@bogus>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <fead1118-9a19-5687-8679-60054727e898@arm.com>
Date:   Wed, 7 Nov 2018 16:19:10 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181107155235.GA18618@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <robin.murphy@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robin.murphy@arm.com
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

On 2018-11-07 3:52 pm, Rob Herring wrote:
> On Wed, Nov 07, 2018 at 12:56:49PM +0000, Robin Murphy wrote:
>> On 2018-11-07 8:03 am, Christoph Hellwig wrote:
>>> On Tue, Nov 06, 2018 at 11:54:15AM +0000, Robin Murphy wrote:
>>>> of_dma_configure() was *supposed* to be following the same logic as
>>>> acpi_dma_configure() and only setting bus_dma_mask if some range was
>>>> specified by the firmware. However, it seems that subtlety got lost in
>>>> the process of fitting it into the differently-shaped control flow, and
>>>> as a result the force_dma==true case ends up always setting the bus mask
>>>> to the 32-bit default, which is not what anyone wants.
>>>>
>>>> Make sure we only touch it if the DT actually said so.
>>>
>>> This looks good, but I think it could really use a comment as the use
>>> of ret all the way down the function isn't exactly obvious.
>>
>> Fair point.
>>
>>> Let me now if you want this picked up through the OF or DMA trees.
>>
>> I don't mind either way; I figure I'll wait a bit longer to see if Rob has
>> any preference, then resend with the comment and the tags picked up so it
>> can hopefully make rc2.
> 
> I have other fixes to send, so I can take it.

Cheers Rob, I'll send you that updated version momentarily.

Robin.

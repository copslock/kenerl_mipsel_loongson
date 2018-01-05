Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 19:04:12 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:59052 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990439AbeAESEEckVU8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jan 2018 19:04:04 +0100
Date:   Fri, 05 Jan 2018 19:03:52 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v5 13/15] MIPS: JZ4770: Workaround for corrupted DMA
 transfers
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Message-Id: <1515175432.2058.0@smtp.crapouillou.net>
In-Reply-To: <CANc+2y4mJMMiN4SPiPtcXMrQ0AM_2XGnVRk1Dvyv9VYpNN3x-g@mail.gmail.com>
References: <20180102150848.11314-1-paul@crapouillou.net>
        <20180102150848.11314-13-paul@crapouillou.net>
        <CANc+2y4mJMMiN4SPiPtcXMrQ0AM_2XGnVRk1Dvyv9VYpNN3x-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1515175441; bh=kqcTgmY1qUF/OCI1vXIcRP9voRazz8wMWK4X2pLIlqc=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type; b=USkE0W5oUQeMmVDN+siBEs8Z44RQlnEjFhgUjsUH4EFAmOICF0GHuY14x5h9s2uwzffw3hQJwsVdZD76yhKfTXht0KG3jnYtwsr0XWd17B8UNPtgMMOI2frJt7s9ZXurE0vZ5zt1VUvbpilLtLpo5owYhwQ2AXuIdbwoga3hJqo=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Hi,
Hi,

>> [...]
>> 
>>  +/*
>>  + * We have seen MMC DMA transfers read corrupted data from SDRAM 
>> when a burst
>>  + * interval ends at physical address 0x10000000. To avoid this 
>> problem, we
>>  + * remove the final page of low memory from the memory map.
>>  + */
>>  +void __init jz4770_reserve_unsafe_for_dma(void)
>>  +{
>>  +       int i;
>>  +
>>  +       for (i = 0; i < boot_mem_map.nr_map; i++) {
>>  +               struct boot_mem_map_entry *entry = boot_mem_map.map 
>> + i;
>>  +
>>  +               if (entry->type != BOOT_MEM_RAM)
>>  +                       continue;
>>  +
>>  +               if (entry->addr + entry->size != 0x10000000)
>>  +                       continue;
>>  +
>>  +               entry->size -= PAGE_SIZE;
>>  +               break;
>>  +       }
>>  +}
>>  +
> 
> Just a wild idea (probably bad too). Changing the memory node in the
> device tree to skip this physical address would work I think. What is
> your opinion about that?

I guess it would work as well, but I don't think this fix should be in 
devicetree.

-Paul

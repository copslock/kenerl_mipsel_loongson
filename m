Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2018 15:10:33 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:49830 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991096AbeAPOK0fi3GV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Jan 2018 15:10:26 +0100
Date:   Tue, 16 Jan 2018 15:10:20 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v6 13/15] MIPS: JZ4770: Workaround for corrupted DMA
 transfers
To:     James Hogan <james.hogan@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Message-Id: <1516111821.1648.1@smtp.crapouillou.net>
In-Reply-To: <20180110232045.GX27409@jhogan-linux.mipstec.com>
References: <20180102150848.11314-1-paul@crapouillou.net>
        <20180105182513.16248-1-paul@crapouillou.net>
        <20180105182513.16248-14-paul@crapouillou.net>
        <20180110232045.GX27409@jhogan-linux.mipstec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1516111825; bh=Mdt3xMoZbE0eLAEBI0cKUJbc4yGIWGasXP8MKpoPSjg=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=ORWah4iyBLXlbnmMEvQxgq1PnKlOxqyMIlIlkbt5SSgHwbol+UKkuIv72QxHDNF1WDauRgcX0tjuPAiRAU09W9WtPb735ZXKrslfrIfMH36SgF7P75XADygSDNqQcno6CROz6A9K7UejrOKNwRbs0PtAKK8XSMjne/IgIJV0KcA=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62172
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

Hi James,

Le jeu. 11 janv. 2018 à 0:20, James Hogan <james.hogan@mips.com> a 
écrit :
> On Fri, Jan 05, 2018 at 07:25:11PM +0100, Paul Cercueil wrote:
>>  [...]
>>  +
>>  +/*
>>  + * We have seen MMC DMA transfers read corrupted data from SDRAM 
>> when a burst
>>  + * interval ends at physical address 0x10000000. To avoid this 
>> problem, we
>>  + * remove the final page of low memory from the memory map.
>>  + */
>>  +void __init jz4770_reserve_unsafe_for_dma(void)
>>  +{
>>  +	int i;
>>  +
>>  +	for (i = 0; i < boot_mem_map.nr_map; i++) {
>>  +		struct boot_mem_map_entry *entry = boot_mem_map.map + i;
>>  +
>>  +		if (entry->type != BOOT_MEM_RAM)
>>  +			continue;
>>  +
>>  +		if (entry->addr + entry->size != 0x10000000)
>>  +			continue;
>>  +
>>  +		entry->size -= PAGE_SIZE;
>>  +		break;
>>  +	}
>>  +}
>>  diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
>>  index 85bc601e9a0d..5a2c20145aee 100644
>>  --- a/arch/mips/kernel/setup.c
>>  +++ b/arch/mips/kernel/setup.c
>>  @@ -879,6 +879,14 @@ static void __init arch_mem_init(char 
>> **cmdline_p)
>> 
>>   	parse_early_param();
>> 
>>  +#ifdef CONFIG_MACH_JZ4770
>>  +	if (current_cpu_type() == CPU_JZRISC &&
>>  +				mips_machtype == MACH_INGENIC_JZ4770) {
>>  +		extern void __init jz4770_reserve_unsafe_for_dma(void);
>>  +		jz4770_reserve_unsafe_for_dma();
>>  +	}
>>  +#endif
> 
> Hmm, a little bit ugly. I'm guessing the plat_mem_setup() callback is
> too early since mem= parameters won't have been taken into account yet
> from parse_early_param().
> 
> Is /memreserve/ in FDT of any value here or is it all too late due to
> old DTs?
> 
> Cheers
> James

When trying to test whether or not /memreserve/ fixes the corruption 
bug we were
having, we ran into the problem that we can't reproduce it anymore. 
Sigh.

So I'll skip this patch in the next patchset version, and handle this 
later if
it reappears.

-Paul

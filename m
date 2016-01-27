Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 11:22:25 +0100 (CET)
Received: from resqmta-ch2-08v.sys.comcast.net ([69.252.207.40]:51354 "EHLO
        resqmta-ch2-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010687AbcA0KWXXm0lB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 11:22:23 +0100
Received: from resomta-ch2-07v.sys.comcast.net ([69.252.207.103])
        by resqmta-ch2-08v.sys.comcast.net with comcast
        id AyNE1s0052EPM3101yNEPx; Wed, 27 Jan 2016 10:22:14 +0000
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-ch2-07v.sys.comcast.net with comcast
        id AyNB1s0010w5D3801yNBa2; Wed, 27 Jan 2016 10:22:14 +0000
Subject: Re: [PATCH 4/6] MIPS: tlbex: Fix bugs in tlbchange handler
To:     Huacai Chen <chenhc@lemote.com>, Ralf Baechle <ralf@linux-mips.org>
References: <1453814784-14230-1-git-send-email-chenhc@lemote.com>
 <1453814784-14230-5-git-send-email-chenhc@lemote.com>
 <56A85ABA.7000903@gentoo.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
From:   Joshua Kinard <kumba@gentoo.org>
X-Enigmail-Draft-Status: N1110
Message-ID: <56A89A49.3050502@gentoo.org>
Date:   Wed, 27 Jan 2016 05:22:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:42.0) Gecko/20100101
 Thunderbird/42.0
MIME-Version: 1.0
In-Reply-To: <56A85ABA.7000903@gentoo.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1453890134;
        bh=bf83LWMUVdeyJo2yrP34W/688lsKJ1ZQqmKTNnJJU1I=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=nZXcKfnBvBFzz48S7zi3W/6lC5Nv+afH3RUdG0bIaDP5S/BX7xQf8rZ3CWGtqotKX
         MD/O1tdXpqphQQBBe1n6dBNaORLz+bzkfic/RZsTlHOiQsCsQf0948f83Ekc27mFTw
         DcG4dlHEyJUtk8jK2JrCIb9fGBsD5TprClgcsJAZ2Hc70TaEIqNr362BdWHdmQ/Jxf
         Ea7VixAe/ZwS5xleWY1ryGzNMCba/Q9hayWdh/Ek2A8Jm+b4JYYUD6Q8xCOtIR3uJH
         SHv6jJEroaNp2EhNYMAx4EHIvv3vmwh0u959Phgf5bgdLqbInVTak3agwWO5A5Vu0S
         vSTHWJFA9iEhQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 01/27/2016 00:50, Joshua Kinard wrote:
> On 01/26/2016 08:26, Huacai Chen wrote:
>> If a tlb miss triggered when EXL=1, tlb refill exception is treated as
>> tlb invalid exception, so tlbp may fails. In this situation, CP0_Index
>> register doesn't contain a valid value. This may not be a problem for
>> VTLB since it is fully-associative. However, FTLB is set-associative so
>> not every tlb entry is valid for a specific address. Thus, we should
>> use tlbwr instead of tlbwi when tlbp fails.
>>
>> There is a similar case for huge page, so build_huge_tlb_write_entry()
>> is also modified. If wmode != tlb_random, that means the caller is tlb
>> invalid handler, we should select tlbr/tlbi depend on the tlbp result.
> 
> This patch triggered instruction bus errors on my Octane (R14000) once it
> switched to userland, using PAGE_SIZE_64KB, MAX_ORDER=14, and THP.  Without the
> patch, that same configuration boots fine, so I suspect this change isn't
> appropriate for all systems.
> 
> --J

Scratch that, it was the heisenbugs again.  Transparent Hugepages are
fundamentally broken on R10K CPUs, I'm fairly certain of that.  You have a
random chance of rebooting and getting a completely stable userland bringup,
and on a subsequent reboot, crash and burn with instruction bus errors.  It was
simple chance that I rebooted into a kernel with this patch applied and
triggered the IBE's.

So I retested this patch after killing THP in my kernel with fire, and am not
seeing any ill effects thus far.

--J

Tested-by: Joshua Kinard <kumba@gentoo.org>


>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> ---
>>  arch/mips/mm/tlbex.c | 31 ++++++++++++++++++++++++++++++-
>>  1 file changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
>> index d0975cd..da68ffb 100644
>> --- a/arch/mips/mm/tlbex.c
>> +++ b/arch/mips/mm/tlbex.c
>> @@ -173,7 +173,10 @@ enum label_id {
>>  	label_large_segbits_fault,
>>  #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
>>  	label_tlb_huge_update,
>> +	label_tail_huge_miss,
>> +	label_tail_huge_done,
>>  #endif
>> +	label_tail_miss,
>>  };
>>  
>>  UASM_L_LA(_second_part)
>> @@ -192,7 +195,10 @@ UASM_L_LA(_r3000_write_probe_fail)
>>  UASM_L_LA(_large_segbits_fault)
>>  #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
>>  UASM_L_LA(_tlb_huge_update)
>> +UASM_L_LA(_tail_huge_miss)
>> +UASM_L_LA(_tail_huge_done)
>>  #endif
>> +UASM_L_LA(_tail_miss)
>>  
>>  static int hazard_instance;
>>  
>> @@ -706,8 +712,24 @@ static void build_huge_tlb_write_entry(u32 **p, struct uasm_label **l,
>>  	uasm_i_ori(p, tmp, tmp, PM_HUGE_MASK & 0xffff);
>>  	uasm_i_mtc0(p, tmp, C0_PAGEMASK);
>>  
>> -	build_tlb_write_entry(p, l, r, wmode);
>> +	if (wmode == tlb_random) { /* Caller is TLB Refill Handler */
>> +		build_tlb_write_entry(p, l, r, wmode);
>> +		build_restore_pagemask(p, r, tmp, label_leave, restore_scratch);
>> +		return;
>> +	}
>> +
>> +	/* Caller is TLB Load/Store/Modify Handler */
>> +	uasm_i_mfc0(p, tmp, C0_INDEX);
>> +	uasm_il_bltz(p, r, tmp, label_tail_huge_miss);
>> +	uasm_i_nop(p);
>> +	build_tlb_write_entry(p, l, r, tlb_indexed);
>> +	uasm_il_b(p, r, label_tail_huge_done);
>> +	uasm_i_nop(p);
>> +
>> +	uasm_l_tail_huge_miss(l, *p);
>> +	build_tlb_write_entry(p, l, r, tlb_random);
>>  
>> +	uasm_l_tail_huge_done(l, *p);
>>  	build_restore_pagemask(p, r, tmp, label_leave, restore_scratch);
>>  }
>>  
>> @@ -2026,7 +2048,14 @@ build_r4000_tlbchange_handler_tail(u32 **p, struct uasm_label **l,
>>  	uasm_i_ori(p, ptr, ptr, sizeof(pte_t));
>>  	uasm_i_xori(p, ptr, ptr, sizeof(pte_t));
>>  	build_update_entries(p, tmp, ptr);
>> +	uasm_i_mfc0(p, ptr, C0_INDEX);
>> +	uasm_il_bltz(p, r, ptr, label_tail_miss);
>> +	uasm_i_nop(p);
>>  	build_tlb_write_entry(p, l, r, tlb_indexed);
>> +	uasm_il_b(p, r, label_leave);
>> +	uasm_i_nop(p);
>> +	uasm_l_tail_miss(l, *p);
>> +	build_tlb_write_entry(p, l, r, tlb_random);
>>  	uasm_l_leave(l, *p);
>>  	build_restore_work_registers(p);
>>  	uasm_i_eret(p); /* return from trap */
>>
> 
> 
> 


-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic

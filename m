Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2014 20:31:14 +0200 (CEST)
Received: from b.ns.miles-group.at ([95.130.255.144]:9062 "EHLO radon.swed.at"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822318AbaEOSbGc1nMX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 May 2014 20:31:06 +0200
Received: (qmail 30739 invoked by uid 89); 15 May 2014 18:31:05 -0000
Received: by simscan 1.3.1 ppid: 30732, pid: 30735, t: 0.0930s
         scanners: attach: 1.3.1 clamav: 0.96.5/m:
Received: from unknown (HELO ?192.168.0.11?) (richard@nod.at@213.47.235.169)
  by radon.swed.at with ESMTPA; 15 May 2014 18:31:05 -0000
Message-ID: <537507E8.1010600@nod.at>
Date:   Thu, 15 May 2014 20:31:04 +0200
From:   Richard Weinberger <richard@nod.at>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     linux-arch@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 16/27] mips: Use common bits from generic tlb.h
References: <1400093999-18703-1-git-send-email-richard@nod.at> <1400093999-18703-17-git-send-email-richard@nod.at> <53750129.6060902@imgtec.com>
In-Reply-To: <53750129.6060902@imgtec.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <richard@nod.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richard@nod.at
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

Am 15.05.2014 20:02, schrieb Leonid Yegoshin:
> On 05/14/2014 11:59 AM, Richard Weinberger wrote:
>> It is no longer needed to define them on our own.
>>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: John Crispin <blogic@openwrt.org>
>> Cc: Markos Chandras <markos.chandras@imgtec.com>
>> Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>> Cc: Richard Weinberger <richard@nod.at>
>> Cc: linux-mips@linux-mips.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Richard Weinberger <richard@nod.at>
>> ---
>>   arch/mips/include/asm/tlb.h | 7 -------
>>   1 file changed, 7 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/tlb.h b/arch/mips/include/asm/tlb.h
>> index 4a23493..5ea43ca 100644
>> --- a/arch/mips/include/asm/tlb.h
>> +++ b/arch/mips/include/asm/tlb.h
>> @@ -10,13 +10,6 @@
>>           if (!tlb->fullmm)                \
>>               flush_cache_range(vma, vma->vm_start, vma->vm_end); \
>>       }  while (0)
>> -#define tlb_end_vma(tlb, vma) do { } while (0)
>> -#define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
>> -
>> -/*
>> - * .. because we flush the whole mm when it fills up.
>> - */
>> -#define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
>>     #define UNIQUE_ENTRYHI(idx)                        \
>>           ((CKSEG0 + ((idx) << (PAGE_SHIFT + 1))) |        \
> 
> I would like to know why these functions are eliminated (don't find any clue).
> Is it just because there will be a generic one or the calls would be eliminated?

There will be a generic one.
See [PATCH 03/27] generic/tlb.h: Move common defines into generic tlb.h

> And if there are generic - can I tune it later?

Yes. You can always define your own and override the generic one.

Thanks,
//richard

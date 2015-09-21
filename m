Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Sep 2015 04:23:27 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:61291 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006916AbbIUCXZR0U4i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Sep 2015 04:23:25 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id t8L2NGcD000770
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 20 Sep 2015 19:23:16 -0700 (PDT)
Received: from [128.224.162.234] (128.224.162.234) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.235.1; Sun, 20 Sep 2015
 19:23:16 -0700
Message-ID: <55FF6A21.7030601@windriver.com>
Date:   Mon, 21 Sep 2015 10:23:29 +0800
From:   yjin <yanjiang.jin@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     <ralf@linux-mips.org>
CC:     <akpm@linux-foundation.org>, <mhuang@redhat.com>,
        <kexec@lists.infradead.org>, <chaowang@redhat.com>,
        <linux-kernel@vger.kernel.org>, <jinyanjiang@gmail.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH] mips: vmcore: forced convert 'hdr' in elf_check_arch()
References: <1442562171-21307-1-git-send-email-yanjiang.jin@windriver.com> <1442562171-21307-2-git-send-email-yanjiang.jin@windriver.com> <55FF6876.7080908@windriver.com>
In-Reply-To: <55FF6876.7080908@windriver.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <Yanjiang.Jin@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanjiang.jin@windriver.com
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

It seems the last mail has been blocked, resend it.

On 2015年09月21日 10:16, yjin wrote:
> The new version patch only modifies mips/elf.h, so add Ralf Baechle 
> and cc linux-mips@linux-mips.org.
> This is a V2 patch, attach the V1 patch for reference.
>
> Thanks!
> Yanjiang
>
> On 2015年09月18日 15:42, yanjiang.jin@windriver.com wrote:
>> From: Yanjiang Jin <yanjiang.jin@windriver.com>
>>
>> elf_check_arch() will be called both in parse_crash_elf64_headers()
>> and parse_crash_elf32_headers(). But in these two functions, the type of
>> the parameter ehdr is different: Elf32_Ehdr and Elf64_Ehdr.
>>
>> Function parse_crash_elf_headers() reads e_ident[EI_CLASS] then 
>> decides to
>> call parse_crash_elf64_headers() or parse_crash_elf32_headers().
>> This happens in run time, not compile time. So compiler will report
>> the below warning:
>>
>> In file included from include/linux/elf.h:4:0,
>>                   from fs/proc/vmcore.c:13:
>> fs/proc/vmcore.c: In function 'parse_crash_elf32_headers':
>> arch/mips/include/asm/elf.h:258:23: warning: initializatio
>> n from incompatible pointer type
>>    struct elfhdr *__h = (hdr);     \
>>                         ^
>> fs/proc/vmcore.c:1071:4: note: in expansion of macro 'elf_
>> check_arch'
>>     !elf_check_arch(&ehdr) ||
>>      ^
>>
>> Signed-off-by: Yanjiang Jin <yanjiang.jin@windriver.com>
>> ---
>>   arch/mips/include/asm/elf.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
>> index f19e890..ece490d 100644
>> --- a/arch/mips/include/asm/elf.h
>> +++ b/arch/mips/include/asm/elf.h
>> @@ -224,7 +224,7 @@ struct mips_elf_abiflags_v0 {
>>   #define elf_check_arch(hdr)                        \
>>   ({                                    \
>>       int __res = 1;                            \
>> -    struct elfhdr *__h = (hdr);                    \
>> +    struct elfhdr *__h = (struct elfhdr *)(hdr);            \
>>                                       \
>>       if (__h->e_machine != EM_MIPS)                    \
>>           __res = 0;                        \
>> @@ -255,7 +255,7 @@ struct mips_elf_abiflags_v0 {
>>   #define elf_check_arch(hdr)                        \
>>   ({                                    \
>>       int __res = 1;                            \
>> -    struct elfhdr *__h = (hdr);                    \
>> +    struct elfhdr *__h = (struct elfhdr *)(hdr);            \
>>                                       \
>>       if (__h->e_machine != EM_MIPS)                    \
>>           __res = 0;                        \
>

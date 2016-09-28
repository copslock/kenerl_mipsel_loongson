Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Sep 2016 08:58:17 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:25373 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990506AbcI1G6Jtry-8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Sep 2016 08:58:09 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 088FC37EAE87C;
        Wed, 28 Sep 2016 07:58:00 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 28 Sep 2016
 07:58:01 +0100
Received: from [10.80.2.5] (10.80.2.5) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 28 Sep
 2016 07:58:01 +0100
Subject: Re: [PATCH 2/2] MIPS: set NR_syscall_tables appropriately
To:     Ralf Baechle <ralf@linux-mips.org>
References: <1472463007-6469-1-git-send-email-marcin.nowakowski@imgtec.com>
 <1472463007-6469-2-git-send-email-marcin.nowakowski@imgtec.com>
 <20160927120442.GF12981@linux-mips.org>
CC:     "open list:MIPS" <linux-mips@linux-mips.org>,
        open list <linux-kernel@vger.kernel.org>
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <82120249-b6c9-2772-427a-d7318c019a8c@imgtec.com>
Date:   Wed, 28 Sep 2016 08:58:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160927120442.GF12981@linux-mips.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

On 27.09.2016 14:04, Ralf Baechle wrote:
> On Mon, Aug 29, 2016 at 11:30:07AM +0200, Marcin Nowakowski wrote:
>
>> Depending on the kernel configuration, up to 3 syscall tables can be
>> used in parallel - so set the number properly to ensure syscall tracing
>> is set up properly.
>>
>> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
>> ---
>>  arch/mips/include/asm/unistd.h | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
>> index e558130..71162f3d 100644
>> --- a/arch/mips/include/asm/unistd.h
>> +++ b/arch/mips/include/asm/unistd.h
>> @@ -22,6 +22,10 @@
>>  #define NR_syscalls  (__NR_O32_Linux + __NR_O32_Linux_syscalls)
>>  #endif
>>
>> +#define NR_syscall_tables (1 + \
>> +	IS_ENABLED(CONFIG_MIPS32_O32) + \
>> +	IS_ENABLED(CONFIG_MIPS32_N32))
>> +
>>  #ifndef __ASSEMBLY__
>
> NR_syscall_tables is a new symbol but I don't see any users of this
> symbol?
>

Hi Ralf,

Patch 1/2 from this series did make use of that symbol.
However, this patch has now been superseded by a slightly different 
approach following a discussion on the original proposal ...

https://lkml.org/lkml/2016/9/16/57

Marcin

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jan 2014 18:17:12 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:8019 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827334AbaA2RRK2K6VN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Jan 2014 18:17:10 +0100
Message-ID: <52E93795.8000205@imgtec.com>
Date:   Wed, 29 Jan 2014 17:17:09 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
MIME-Version: 1.0
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: mm: c-r4k: Detect instruction cache aliases
References: <1391001009-19580-1-git-send-email-markos.chandras@imgtec.com> <52E9029C.80300@cogentembedded.com> <52E90525.7010704@imgtec.com> <52E94404.8050303@cogentembedded.com>
In-Reply-To: <52E94404.8050303@cogentembedded.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_29_17_17_04
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 01/29/2014 06:10 PM, Sergei Shtylyov wrote:
> Hello.
>
> On 01/29/2014 04:41 PM, Markos Chandras wrote:
>
>>>> The *Aptiv cores can use the CONF7/IAR bit to detect if the core
>>>> has hardware support to remove instruction cache aliasing.
>
>>>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>>>> ---
>>>> This patch is for the upstream-sfr/mips-for-linux-next tree
>>> [...]
>
>>>> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
>>>> index 13b549a..e790524 100644
>>>> --- a/arch/mips/mm/c-r4k.c
>>>> +++ b/arch/mips/mm/c-r4k.c
>>>> @@ -1110,7 +1110,10 @@ static void probe_pcache(void)
>>>>       case CPU_PROAPTIV:
>>>>           if (current_cpu_type() == CPU_74K)
>>>>               alias_74k_erratum(c);
>>>> -        if ((read_c0_config7() & (1 << 16))) {
>>>> +        if (!(read_c0_config7() & MIPS_CONF7_IAR))
>>>> +            if (c->icache.waysize > PAGE_SIZE)
>
>>>     Why not fold these to a single *if*?
>
>> I suppose I could do that. Thanks
>
>>>> +                c->icache.flags |= MIPS_CACHE_ALIASES;
>>>> +        if (read_c0_config7() & MIPS_CONF7_AR) {
>
>>>     You didn't document this change. Ideally, it should be in a separate
>>> patch.
>
>> Nothing has changed. Instead of using the '16' magic value, I just
>> documented
>> that bit along with the IAR one.
>
>     You should have noted that in the changelog, at least.
>
> WBR, Sergei
>
>

Ok I will submit a v2 soon. Thanks for the review.

-- 
markos

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Feb 2017 20:19:08 +0100 (CET)
Received: from prod-mail-xrelay06.akamai.com ([96.6.114.98]:34598 "EHLO
        prod-mail-xrelay06.akamai.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992127AbdB0TTBu31ar (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Feb 2017 20:19:01 +0100
Received: from prod-mail-xrelay06.akamai.com (localhost.localdomain [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id 6169516C829;
        Mon, 27 Feb 2017 19:18:55 +0000 (GMT)
Received: from prod-mail-relay09.akamai.com (prod-mail-relay09.akamai.com [172.27.22.68])
        by prod-mail-xrelay06.akamai.com (Postfix) with ESMTP id 4AA2616C812;
        Mon, 27 Feb 2017 19:18:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; s=a1;
        t=1488223135; bh=LfX2cRquaGHezxM/TNUWzS5NQwm4D660ck9K9ySMUgQ=;
        l=2403; h=To:References:Cc:From:Date:In-Reply-To:From;
        b=wmyNDJNaXudtz0fjxDA9fiAclEeDjy84Vw9zkWfhG57N1+JJvQuoI5tuNEmug5+kr
         vjh8JFYSBu4lcIDUrrjg0RC4usY1GPQfJiIhE8SjOOAvU90gfrKbQNaG3S3+xBZ7am
         QKgfTzU64hTtv/9Xx2/xipScxMrbNr4xvS+ITljA=
Received: from [172.28.13.148] (bos-lpjec.kendall.corp.akamai.com [172.28.13.148])
        by prod-mail-relay09.akamai.com (Postfix) with ESMTP id 6EC621E07C;
        Mon, 27 Feb 2017 19:18:54 +0000 (GMT)
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
To:     David Daney <ddaney@caviumnetworks.com>, rostedt@goodmis.org
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anton Blanchard <anton@samba.org>,
        Rabin Vincent <rabin@rab.in>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Zhigang Lu <zlu@ezchip.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
Date:   Mon, 27 Feb 2017 14:18:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jbaron@akamai.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbaron@akamai.com
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



On 02/27/2017 01:57 PM, David Daney wrote:
> On 02/27/2017 10:49 AM, Jason Baron wrote:
>> The core jump_label code makes use of the 2 lower bits of the
>> static_key::[type|entries|next] field. Thus, ensure that the jump_entry
>> table is at least 4-byte aligned.
>>
> [...]
>> diff --git a/arch/mips/include/asm/jump_label.h
>> b/arch/mips/include/asm/jump_label.h
>> index e77672539e8e..243791f3ae71 100644
>> --- a/arch/mips/include/asm/jump_label.h
>> +++ b/arch/mips/include/asm/jump_label.h
>> @@ -31,6 +31,7 @@ static __always_inline bool
>> arch_static_branch(struct static_key *key, bool bran
>>      asm_volatile_goto("1:\t" NOP_INSN "\n\t"
>>          "nop\n\t"
>>          ".pushsection __jump_table,  \"aw\"\n\t"
>> +        ".balign 4\n\t"
>>          WORD_INSN " 1b, %l[l_yes], %0\n\t"
>>          ".popsection\n\t"
>>          : :  "i" (&((char *)key)[branch]) : : l_yes);
>> @@ -45,6 +46,7 @@ static __always_inline bool
>> arch_static_branch_jump(struct static_key *key, bool
>>      asm_volatile_goto("1:\tj %l[l_yes]\n\t"
>>          "nop\n\t"
>>          ".pushsection __jump_table,  \"aw\"\n\t"
>> +        ".balign 4\n\t"
>>          WORD_INSN " 1b, %l[l_yes], %0\n\t"
>>          ".popsection\n\t"
>>          : :  "i" (&((char *)key)[branch]) : : l_yes);
>
>
> I will speak only for the MIPS part.
>
> If the section is not already properly aligned, this change will add
> padding, which is probably not what we want.
>
> Have you ever seen a problem with misalignment in the real world?
>

Hi,

Yes, there was a WARN_ON() reported on POWER here:

https://lkml.org/lkml/2017/2/19/85

The WARN_ON() triggers if either of the 2 lsb are set. More 
specifically, its coming from 'static_key_set_entries()' from the 
following patch, which was recently added to linux-next:

https://lkml.org/lkml/2017/2/3/558

So this was not seen on mips, but I included all arches in this patch 
that I though might be affected.

> If so, I think a better approach might be to set properties on the
> __jump_table section to force the proper alignment, or do something in
> the linker script.
>

So in include/asm-generic/vmlinux.lds.h, we are already setting 
'ALIGN(8)', but that does not appear to be sufficient for POWER...

Also, I checked the size of the vmlinux generated after this change on 
all 4 arches, and it was rather minimal. I think POWER increased the 
most, but the other arches increased by only a few bytes.

Thanks,

-Jason

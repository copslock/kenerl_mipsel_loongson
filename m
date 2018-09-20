Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2018 16:07:14 +0200 (CEST)
Received: from pegase1.c-s.fr ([93.17.236.30]:1570 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992279AbeITOHHoThc3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Sep 2018 16:07:07 +0200
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42GJSg68nqz9ttRj;
        Thu, 20 Sep 2018 16:06:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id i9POh7THBRyS; Thu, 20 Sep 2018 16:06:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42GJSg5Xrtz9ttRd;
        Thu, 20 Sep 2018 16:06:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 215A58B86A;
        Thu, 20 Sep 2018 16:07:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id RNcyVHW_9iUG; Thu, 20 Sep 2018 16:07:00 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 845468B77F;
        Thu, 20 Sep 2018 16:06:59 +0200 (CEST)
Subject: Re: Checkpatch bad Warning (Re: [PATCH] powerpc/kgdb: add
 kgdb_arch_set/remove_breakpoint())
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>, paul.burton@mips.com,
        ralf@linux-mips.org, jhogan@kernel.org
Cc:     Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
References: <872199441fd43b05fc1c7d049098ef7c0e83f4c5.1537262646.git.christophe.leroy@c-s.fr>
 <2f5f572a-a28c-9d17-844b-9e1961febf64@c-s.fr>
 <595c96f5adcccd7eab9dc95eb48618981af66d3c.camel@perches.com>
 <87worgia60.fsf@concordia.ellerman.id.au>
 <f9ad7501-4d07-ddc2-6236-a7eb61283378@c-s.fr>
Message-ID: <d31bd0cb-b9da-6f1b-4f93-da71644668d6@c-s.fr>
Date:   Thu, 20 Sep 2018 01:23:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <f9ad7501-4d07-ddc2-6236-a7eb61283378@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <christophe.leroy@c-s.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: christophe.leroy@c-s.fr
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

Adding MIPS arch in the loop

On 09/20/2018 01:19 PM, Christophe LEROY wrote:
> 
> 
> Le 20/09/2018 à 15:13, Michael Ellerman a écrit :
>> Joe Perches <joe@perches.com> writes:
>>
>>> On Tue, 2018-09-18 at 09:33 +0000, Christophe Leroy wrote:
>>>> On the below patch, checkpatch reports
>>>>
>>>> WARNING: struct kgdb_arch should normally be const
>>>> #127: FILE: arch/powerpc/kernel/kgdb.c:480:
>>>> +struct kgdb_arch arch_kgdb_ops;
>>>>
>>>> But when I add 'const', I get compilation failure
>>>
>>> So don't add const.
>>>
>>> checkpatch is stupid.  You are not.
>>>
>>> _Always_ take checkpatch bleats with very
>>> large grains of salt.
>>>
>>> Perhaps send a patch to remove kgbd_arch
>>> from scripts/const_structs.checkpatch as
>>> it seems not ever to be const.
>>
>> I think it could/should be const though, it just requires updating all
>> arches.
>>
> 
> Yes I was thinking about doing it, but first thing is to change the way 
> MIPS initialises it:
> 
> 
> struct kgdb_arch arch_kgdb_ops;
> 
> int kgdb_arch_init(void)
> {
>      union mips_instruction insn = {
>          .r_format = {
>              .opcode = spec_op,
>              .func    = break_op,
>          }
>      };
>      memcpy(arch_kgdb_ops.gdb_bpt_instr, insn.byte, BREAK_INSTR_SIZE);
> 
> 
> Can this be done staticaly ?
> 
> Christophe

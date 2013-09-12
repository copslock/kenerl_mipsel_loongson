Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Sep 2013 17:13:26 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:61297 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818323Ab3ILPM6No-6t (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Sep 2013 17:12:58 +0200
Message-ID: <5231D9E5.2080002@imgtec.com>
Date:   Thu, 12 Sep 2013 16:12:37 +0100
From:   Paul Burton <paul.burton@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130806 Thunderbird/17.0.8
MIME-Version: 1.0
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Fix errata for some 1074K cores.
References: <1378929708-7253-1-git-send-email-Steven.Hill@imgtec.com> <52318BC6.7030903@imgtec.com> <j0d17e3bxlvp3famj4e32xv9.1378997855738@email.android.com> <CAGVrzcY_OWUSK4dfZ8fnV49ELSYE6exSYQi5AwxuGoKnvx5Rtg@mail.gmail.com>
In-Reply-To: <CAGVrzcY_OWUSK4dfZ8fnV49ELSYE6exSYQi5AwxuGoKnvx5Rtg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.79]
X-SEF-Processed: 7_3_0_01192__2013_09_12_16_12_51
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Agreed, my point is not about your code but your commit message. If I'm 
reading a commit which works around CPU errata I should not have to go 
and ask the hardware engineers or even read an errata document in order 
to know what you're doing. Your commit message should explain the 
errata, its effects and how your patch works around the problem.

Paul

On 12/09/13 16:05, Florian Fainelli wrote:
> 2013/9/12 Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>:
>> Treat it as is.
>>
>> It is a dirty laundry of HW engineers and you may need to communicate with them or read Errata docs on CPU.
>>
>> If it is about a way how it is written - ask Steven, initially it was in mainland probe code but he think it should be a separate function. I just corrected him, pointing that erratas on 74K and 1074K are different. But because he insist on having the same CPU_74K for both, so...
> If you take a look at another CPU company such as ARM, they provide
> lengthy explanations for their various Erratas:
>
> config PJ4B_ERRATA_4742
>          bool "PJ4B Errata 4742: IDLE Wake Up Commands can Cause the
> CPU Core to Cease Operation"
>          depends on CPU_PJ4B && MACH_ARMADA_370
>          default y
>          help
>            When coming out of either a Wait for Interrupt (WFI) or a Wait for
>            Event (WFE) IDLE states, a specific timing sensitivity exists between
>            the retiring WFI/WFE instructions and the newly issued subsequent
>            instructions.  This sensitivity can result in a CPU hang scenario.
>            Workaround:
>            The software must insert either a Data Synchronization Barrier (DSB)
>            or Data Memory Barrier (DMB) command immediately after the WFI/WFE
>            instruction
>
> I really think that you should aim for the same level of information
> so that people know whether this is relevant for their platform,
> whether they have the ECO applied etc...

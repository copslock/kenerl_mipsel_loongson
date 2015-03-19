Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Mar 2015 00:23:54 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11452 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009207AbbCSXXw7XY6W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Mar 2015 00:23:52 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0534BF281AA4A;
        Thu, 19 Mar 2015 23:23:44 +0000 (GMT)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 19 Mar
 2015 23:23:47 +0000
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Thu, 19 Mar
 2015 23:23:47 +0000
Received: from [10.20.3.79] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 19 Mar
 2015 16:23:44 -0700
Message-ID: <550B5A80.2060907@imgtec.com>
Date:   Thu, 19 Mar 2015 16:23:44 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "wangr@lemote.com" <wangr@lemote.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Qais Yousef <Qais.Yousef@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "davidlohr@hp.com" <davidlohr@hp.com>,
        "chenhc@lemote.com" <chenhc@lemote.com>,
        "manuel.lauss@gmail.com" <manuel.lauss@gmail.com>,
        "mingo@kernel.org" <mingo@kernel.org>
Subject: Re: [PATCH] MIPS: MSA: misaligned support
References: <20150318011630.2702.28882.stgit@ubuntu-yegoshin> <5509611D.80404@imgtec.com> <5509D62B.7030507@imgtec.com> <20150318221248.GB1116@jhogan-linux.le.imgtec.org> <550A097B.7020400@imgtec.com> <550A9C0F.6060505@imgtec.com>
In-Reply-To: <550A9C0F.6060505@imgtec.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 03/19/2015 02:51 AM, James Hogan wrote:
> On 18/03/15 23:25, Leonid Yegoshin wrote:
>> On 03/18/2015 03:12 PM, James Hogan wrote:
>>> Hi Leonid,
>>>
>>> On Wed, Mar 18, 2015 at 12:46:51PM -0700, Leonid Yegoshin wrote:
>>>
>>>> thread_msa_context_live() == check of TIF_MSA_CTX_LIVE == existence of
>>>> MSA context for thread.
>>>> It differs from MSA is owned by thread, it just says that thread has
>>>> already initialized MSA.
>>>>
>>>> Unfortunate choice of function name, I believe.
>>> Right (I mis-read when its cleared when i grepped). Still, that would
>>> make it even harder to hit since lose_fpu wouldn't clear it, and you
>>> already would've taken an MSA disabled exception first.
>> No, lose_fpu disables MSA now, saves MSA context and switches off
>> TIF_USEDMSA. See 33c771ba5c5d067f85a5a6c4b11047219b5b8f4e, "MIPS:
>> save/disable MSA in lose_fpu".
>>
>> However, a process still has MSA context initialized and it is indicated
>> by TIF_MSA_CTX_LIVE.
>> It should have it before it can get any AdE exception on MSA instruction.
> Yes, exactly.
>
>>> Anyway, my point was that there's nothing invalid about an unaligned
>>> load being the first MSA instruction. You might use it to load the
>>> initial vector state.
>> No, it is invalid. If MSA is disabled it should trigger "MSA Disabled"
>> exception.
> It's valid for the user to start their program with a ld.b.
> As you say, it'll raise an MSA disabled exception first though. The
> handler will own MSA, and set TIF_MSA_CTX_LIVE, which makes the check
> pointless?

"Unfortunately, some HW versions had AdE first and it may be logical 
from some HW point (if access is done before instruction is completely 
decoded). But that is wrong."

>
> I suppose an AdE from a normal unaligned load could still race with
> another thread modifying the instruction to an MSA ld.b, but even if it
> did, I don't think it would do any harm?
>
>> Unfortunately, some HW versions had AdE first and it may be logical from
>> some HW point (if access is done before instruction is completely
>> decoded). But that is wrong.
> Yes, MSA Disabled would clearly come under "Instruction Validity
> Exceptions", which is very sensibly higher priority than "Address error
> - Data access".
>
> Anyway, at the very least it needs a comment to justify what it is
> trying to catch and what harm it is trying to avoid, since it isn't
> obvious, and tbh seems pointless.
>
> Cheers
> James
>

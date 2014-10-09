Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 00:19:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47854 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010880AbaJIWTG5wji3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Oct 2014 00:19:06 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4B92645E0BA4;
        Thu,  9 Oct 2014 23:18:55 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 9 Oct
 2014 23:18:59 +0100
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by klmail02.kl.imgtec.org
 (10.40.60.222) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 9 Oct
 2014 23:18:59 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 9 Oct
 2014 23:18:58 +0100
Received: from [192.168.65.146] (192.168.65.146) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 9 Oct 2014
 15:18:56 -0700
Message-ID: <543709D0.6000501@imgtec.com>
Date:   Thu, 9 Oct 2014 15:18:56 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>, <Zubair.Kakakhel@imgtec.com>,
        <geert+renesas@glider.be>, <david.daney@cavium.com>,
        <peterz@infradead.org>, <paul.gortmaker@windriver.com>,
        <davidlohr@hp.com>, <macro@linux-mips.org>, <chenhc@lemote.com>,
        <richard@nod.at>, <zajec5@gmail.com>, <james.hogan@imgtec.com>,
        <keescook@chromium.org>, <alex@alex-smith.me.uk>,
        <tglx@linutronix.de>, <blogic@openwrt.org>,
        <jchandra@broadcom.com>, <paul.burton@imgtec.com>,
        <qais.yousef@imgtec.com>, <linux-kernel@vger.kernel.org>,
        <ralf@linux-mips.org>, <markos.chandras@imgtec.com>,
        <dengcheng.zhu@imgtec.com>, <manuel.lauss@gmail.com>,
        <akpm@linux-foundation.org>, <lars.persson@axis.com>
Subject: Re: [PATCH v2 0/3] MIPS executable stack protection
References: <20141009195030.31230.58695.stgit@linux-yegoshin> <5437015B.3010205@gmail.com>
In-Reply-To: <5437015B.3010205@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43174
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

On 10/09/2014 02:42 PM, David Daney wrote:
> On 10/09/2014 01:00 PM, Leonid Yegoshin wrote:
>> The following series implements an executable stack protection in MIPS.
>>
>> It sets up a per-thread 'VDSO' page and appropriate TLB support.
>> Page is set write-protected from user and is maintained via kernel VA.
>> MIPS FPU emulation is shifted to new page and stack is relieved for
>> execute protection as is as all data pages in default setup during ELF
>> binary initialization. The real protection is controlled by GLIBC and
>> it can do stack protected now as it is done in other architectures and
>> I learned today that GLIBC team is ready for this.
>
> What does it mean to be 'ready'?  If they committed patches before 
> there was kernel support, that it putting the cart before the horse.  
> GlibC's state cannot be used as valid reason for committing major 
> kernel changes.  There would be no regression in any GLibC based 
> system as a result of not merging this patch.
Rich Fuhler said me that they discussed it internally and have a 
solution to fix their problem (ignoring PT_GNU_STACK on first library 
load - they need to sort out the logic). But we need to split both issue 
- right now stack can't be protected because of emulation. If they set 
stack protected then emulation fails on CPU without FPU.

>
>>
>> Note: actual execute-protection depends from HW capability, of course.
>>
>> This patch is required for MIPS32/64 R2 emulation on MIPS R6 
>> architecture.
>> Without it 'ssh-keygen' crashes pretty fast on attempt to execute 
>> instruction
>> in stack.
>
> There is much more blocking MIPS32/64 R2 emulation on MIPS R6 than 
> just this patch isn't there?

This one is critical - ssh-keygen crashes during running MIPS R2. I have 
a patch in my R6 repository but GLIBC still can't set stack executable 
and security suffers.

>
> Also, if you are supporting MIPS R6, this patch doesn't even work, 
> because it doesn't handle PC relative instructions at all.

It seems like you missed my statement - adding support for PC-relative 
instruction is just 5 lines of code. I just refrain from this until 
toolchain starts generating that.

Besides that, this version 2 of patch just passed 20-22 hours on P5600 
and Virtuoso (no FPU on both) under SOAK test and it gets around 1 per 
hour of signal right at emulated instruction in VDSO and unwind works 
(as I can see in debug prints).

>
>
> The recent discussions on this subject, including many comments from 
> Imgtec e-mail addresses, brought to light the need to use an 
> instruction set emulator for newer MIPSr6 ISA processors.

In Imgtec I am only one who works on MIPS R6 SW and FPU branch emulation 
and I say you - it is not needed, this solution is enough.

>
> In light of this, why does it make sense to merge this patch, instead 
> of taking the approach of emulating the instructions in the delay slot?

Well, because it does exist now. But full MIPS emulator... for all 
ASEs... for any MIPS vendor... I even doesn't want to estimate an amount 
of time and code size to develop it.

Besides that, you missed my another statement - we don't force customer 
to disclose all details of their COP2 instructions.

- Leonid

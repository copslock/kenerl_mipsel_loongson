Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2016 12:34:36 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26064 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992166AbcF3Ke3nDePj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Jun 2016 12:34:29 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 3F4123AD7FC06;
        Thu, 30 Jun 2016 11:34:20 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 30 Jun 2016 11:34:22 +0100
Received: from [127.0.0.1] (10.100.200.138) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 30 Jun
 2016 11:34:22 +0100
Subject: Re: [RFC PATCH v3 2/2] MIPS: non-exec stack & heap when non-exec
 PT_GNU_STACK is present
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Faraz Shahbazker <Faraz.Shahbazker@imgtec.com>
References: <20160629143830.526-1-paul.burton@imgtec.com>
 <20160629143830.526-3-paul.burton@imgtec.com>
 <6D39441BF12EF246A7ABCE6654B023537E465A74@HHMAIL01.hh.imgtec.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Raghu Gandham" <Raghu.Gandham@imgtec.com>,
        Maciej Rozycki <Maciej.Rozycki@imgtec.com>
From:   Paul Burton <paul.burton@imgtec.com>
Message-ID: <fb77e2f2-801d-8dd5-6121-73909ebbd227@imgtec.com>
Date:   Thu, 30 Jun 2016 11:34:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <6D39441BF12EF246A7ABCE6654B023537E465A74@HHMAIL01.hh.imgtec.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.100.200.138]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54184
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

On 30/06/16 10:25, Matthew Fortune wrote:
> Paul Burton <Paul.Burton@imgtec.com> writes:
>> The stack and heap have both been executable by default on MIPS until
>> now. This patch changes the default to be non-executable, but only for
>> ELF binaries with a non-executable PT_GNU_STACK header present. This
>> does apply to both the heap & the stack, despite the name PT_GNU_STACK,
>> and this matches the behaviour of other architectures like ARM & x86.
>>
>> Current MIPS toolchains do not produce the PT_GNU_STACK header, which
>> means that we can rely upon this patch not changing the behaviour of
>> existing binaries. The new default will only take effect for newly
>> compiled binaries once toolchains are updated to support PT_GNU_STACK,
>> and since those binaries are newly compiled they can be compiled
>> expecting the change in default behaviour. Again this matches the way in
>> which the ARM & x86 architectures handled their implementations of
>> non-executable memory.
>
> There will be some extra work on top of this to inform user-mode that
> no-exec-stack support is actually safe. I'm a bit fuzzy on the exact
> details though as I have not been directly involved for a while.
>
> https://www.sourceware.org/ml/libc-alpha/2016-01/msg00719.html
>
> Adding Faraz who worked on the user-mode side and Maciej who has been
> reviewing.

Hi Matthew,

Interesting. That glibc patch seems to imply that the kernel already 
supports this, which isn't true. It makes use of a 
"AV_FLAGS_MIPS_GNU_STACK" constant & says that's taken from Linux, but 
it doesn't exist. Are you using an experimental patch for the kernel 
side (perhaps Leonid's?). I'm not sure why you'd use AT_FLAGS for this, 
which Linux currently unconditionally sets to 0 for all architectures. 
Would a HWCAP bit for RIXI perhaps be more suitable?

Thanks,
     Paul

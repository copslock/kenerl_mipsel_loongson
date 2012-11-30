Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Nov 2012 17:25:27 +0100 (CET)
Received: from mail-da0-f49.google.com ([209.85.210.49]:50545 "EHLO
        mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822197Ab2K3QZ0dLdeR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Nov 2012 17:25:26 +0100
Received: by mail-da0-f49.google.com with SMTP id v40so252501dad.36
        for <linux-mips@linux-mips.org>; Fri, 30 Nov 2012 08:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=lwUorNm7h3Ph3ZBWm6FeSX8xf2RhvljXKgZoOcruHAA=;
        b=XYWafHGYBc+9g51RziAEv5k4zo6uvnzQEgudY0x9V7JXyGTKHcMBDgrj4XQiYgw00L
         tUYerqaJiFU1TwL6HSyKlxYOmLjnICKxp3nJGiDAlG5jk3un3kpyFuZlRjLbcnhwY79N
         HIQLXm466LJNPgDotps96EZ3cyadqWhTaOG89aEykRl146zj6qkvMjYZdCFFCNK9w2jS
         nHJxT9HiAkNf4+JQhoaiw51BJ+bFLgzpC5VA9r0GQEVQG6SkBjZauPjgBxo8xoZsi/Tm
         ExHze1m99ZOjdn2rtPZ58A80Cuw4w1as7qj9H35r6kP9iSSBmVSf+zItu3CGHgNLLE6p
         eqAA==
Received: by 10.66.74.2 with SMTP id p2mr4448489pav.55.1354292718651;
        Fri, 30 Nov 2012 08:25:18 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id om10sm3249744pbc.73.2012.11.30.08.25.16
        (version=SSLv3 cipher=OTHER);
        Fri, 30 Nov 2012 08:25:17 -0800 (PST)
Message-ID: <50B8DDEC.30005@gmail.com>
Date:   Fri, 30 Nov 2012 08:25:16 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Alan Cooper <alcooperx@gmail.com>
CC:     linux-mips <linux-mips@linux-mips.org>
Subject: Re: MIPS Function Tracer question
References: <CAOGqxeUOrVFoqsmUV19h5tXsD6pw5creXP9aN1C-V7K3WL2EXA@mail.gmail.com> <50B7E91C.6070403@gmail.com> <CAOGqxeU=BumDt6jnVc=sKk=q_v1eywGu=_Eo9xo3r9av3Ky6kw@mail.gmail.com>
In-Reply-To: <CAOGqxeU=BumDt6jnVc=sKk=q_v1eywGu=_Eo9xo3r9av3Ky6kw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 11/30/2012 06:53 AM, Alan Cooper wrote:
> I needed to be more specific. The issues I'm seeing are only on 32BIT
> platforms with dynamic tracing.
> Let me explain the issue. When the compiler flag "-pg" is specified
> for 32BIT platforms to enable tracing, the compiler adds "addiu
> sp,sp,-8" in the delay slot after every call to _mcount (some legacy
> thing where 2 arguments used to be pushed on the stack). The _mcount
> routine is expected to adjust the sp by 8 before returning.

If the kernel's tracer infrastructure is broken for 32-bit kernels, then 
it should be fixed.  I think it was only really tested on 64-bit kernels.

It seems that the sp adjustment should be replaced by NOP as well if 
tracing is disabled.

> The
> problem is when tracing is disabled, all calls to _mcount are
> dynamically converted from "jal _mcount" to "nop" but the following
> "addiu sp,sp,-8" instruction is unchanged and when executed leaves the
> sp off by -8 for the remainder of the function. This bug is hidden
> when the compiler is told to use frame pointers because all offsets
> into the stack use the fp instead of the sp and the sp is restored
> from the frame pointer instead of just adding a constant to sp. When
> frame pointers are not enabled the code crashes. I don't think the
> toolchain version makes any difference because the _mcount assembly
> language routine adjusts the stack pointer by 8 if not CONFIG_64BIT
> regardless of the toolchain version.
>
> On Thu, Nov 29, 2012 at 6:00 PM, David Daney <ddaney.cavm@gmail.com> wrote:
>> On 11/29/2012 01:04 PM, Alan Cooper wrote:
>>>
>>> I've been doing some testing of the MIPS Function Tracer functionality
>>> on the 3.3 kernel. I was surprised to find that the option to generate
>>> frame pointers was required for tracing.
>>
>>
>> It is not really required for MIPS function tracing, but the Kconfigs for
>> some reason set it.
>>
>>
>>>   When I don't enable
>>> FRAME_POINTER along with FUNCTION_TRACER, the kernel hangs on boot. I
>>> also noticed that a checkin to the 3.4 kernel
>>> (b732d439cb43336cd6d7e804ecb2c81193ef63b0) no longer forces on
>>> FRAME_POINTER when FUNCTION_TRACER is selected. I was wondering how it
>>> works in 3.4 and beyond, so I built a Malta kernel from the latest
>>> MIPS tree with FUNCTION_TRACING enabled and tested it with QEMU. The
>>> kernel hung the same way. I can think of 2 reasons for this:
>>> 1. Function tracing is broken for MIPS in 3.4 and beyond.
>>> 2. The 4.5.3 GNU C compiler I'm using is generating different code for
>>> function tracing.
>>
>>
>> Function tracing works best with recent versions of GCC (those that support
>> -mmcount-ra-address).
>>
>>
>>> I was wondering if anyone has MIPS function tracing working in 3.4 or
>>> later?
>>
>>
>> Yes.  Using GCC 4.7.0 on an octeon kernel (based on 3.4.14):
>>
>> # tracer: function_graph
>> #
>> # CPU  DURATION                  FUNCTION CALLS
>> # |     |   |                     |   |   |   |
>>    1)               |  __fsnotify_parent() {
>>    1)   7.154 us    |  } /* __fsnotify_parent */
>>    1)               |  fsnotify() {
>>    1)               |    __srcu_read_lock() {
>>    1)               |      add_preempt_count() {
>>    1)   1.356 us    |      } /* add_preempt_count */
>>    1)               |      sub_preempt_count() {
>>    1)   1.385 us    |      } /* sub_preempt_count */
>>    1)   6.747 us    |    } /* __srcu_read_lock */
>>    1)               |    __srcu_read_unlock() {
>>    1)               |      add_preempt_count() {
>>    1)   1.383 us    |      } /* add_preempt_count */
>>    1)               |      sub_preempt_count() {
>>    1)   1.358 us    |      } /* sub_preempt_count */
>>    1)   6.642 us    |    } /* __srcu_read_unlock */
>>    1) + 17.861 us   |  } /* fsnotify */
>> .
>> .
>> .
>>
>>
>>
>>>
>>> I did figure out why it's hanging and I have some changes that will
>>> allow the function tracer to run without frame pointers, but before I
>>> proceed I want to rule out compiler differences.
>>>
>>> Thanks
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>>
>>

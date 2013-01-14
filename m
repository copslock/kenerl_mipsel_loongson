Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2013 23:12:48 +0100 (CET)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:55383 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816553Ab3ANWMp7KLta (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Jan 2013 23:12:45 +0100
Received: by mail-pa0-f47.google.com with SMTP id fa10so2472592pad.20
        for <multiple recipients>; Mon, 14 Jan 2013 14:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=cci795w+LrnfnvjjrxAaV+XhYQpnwB0+NX4FIpaLcX0=;
        b=r5lHZGKXYwM2LmuSbLEwtRLLpeQuwhHoUeRBcdZpm3Q3Wt0g1ZDY5S72SekRsyJDu9
         EYIHijGBoZ7F1bdGNU1B9oVJx51xwhqGIc7DV0ZCQaQb47yKOi+U+4XgAmDWCl34rsgF
         39j5F9AT9Ycal5JZevk+DcqJxuR4aZ1WV+jCnHdo6yjzFXGZEfGFqfh1/0Pa+ex4CZS+
         /h2yUm2b7chGJ+ochvQpgZ4SVcYr1etVaLY7qIbItnfXXI+/49+wvOOhaMT1x+1DA6Ag
         5YhdwrO13bSp87CKj0hj7xWOVgD5U/Yj0MvV1r3Rb8j34IxENk4xAjZ+haS5jOOoCtjW
         +xUg==
X-Received: by 10.66.88.37 with SMTP id bd5mr235900323pab.75.1358201559395;
        Mon, 14 Jan 2013 14:12:39 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id nm2sm8873081pbc.43.2013.01.14.14.12.33
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 14 Jan 2013 14:12:38 -0800 (PST)
Message-ID: <50F482D1.4090301@gmail.com>
Date:   Mon, 14 Jan 2013 14:12:33 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Alan Cooper <alcooperx@gmail.com>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: function tracer: Fix broken function tracing
References: <1357914810-20656-1-git-send-email-alcooperx@gmail.com> <50F0454D.5060109@gmail.com> <CAOGqxeU3zZuFfL_M1u-hgjbPHgm6MrzoCK1KqpbazwKC4td4ww@mail.gmail.com>
In-Reply-To: <CAOGqxeU3zZuFfL_M1u-hgjbPHgm6MrzoCK1KqpbazwKC4td4ww@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35434
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

On 01/14/2013 01:10 PM, Alan Cooper wrote:
> I already tried using "adddiu sp, sp, 8" and it caused the kernel to
> randomly crash. After many hours of debugging the reason occurred to
> me while in bed in the middle of the night. The problem is that if we
> get an interrupt between the add 8 and the add -8 instructions, we
> trash the existing stack.
>
> The problem with the 2 nop approach is that there are a series of
> subroutines used to write each nop and these nested subroutines are
> traceable.

This seems like a bug.  The low-level code used to do code patching 
probably should be CFLAGS_REMOVE_file.o = -pg


> This means on the second call to these subroutines they
> execute with only one nop and crash. I could  write  some new code
> that wrote the 2 nops at once, but (now that I understand
> "stop_machine") with the branch likely solution we should be able to
> stop using "stop_machine" when we write nops to the 20-30 thousand
> Linux functions. It looks like other platforms have stopped using
> stop_machine.

I don't particularly object to the 'branch likely solution', but I think 
the failures of the other approaches indicates underlying bugs in the 
tracing code.  Those bugs should probably be fixed.

David Daney


>
> Al
>
> On Fri, Jan 11, 2013 at 12:01 PM, David Daney <ddaney.cavm@gmail.com> wrote:
>> On 01/11/2013 06:33 AM, Al Cooper wrote:
>>>
>>> Function tracing is currently broken for all 32 bit MIPS platforms.
>>> When tracing is enabled, the kernel immediately hangs on boot.
>>> This is a result of commit b732d439cb43336cd6d7e804ecb2c81193ef63b0
>>> that changes the kernel/trace/Kconfig file so that is no longer
>>> forces FRAME_POINTER when FUNCTION_TRACING is enabled.
>>>
>>> MIPS frame pointers are generally considered to be useless because
>>> they cannot be used to unwind the stack. Unfortunately the MIPS
>>> function tracing code has bugs that are masked by the use of frame
>>> pointers. This commit fixes the bugs so that MIPS frame pointers do
>>> not need to be enabled.
>>>
>>> The bugs are a result of the odd calling sequence used to call the trace
>>> routine. This calling sequence is inserted into every tracable function
>>> when the tracing CONFIG option is enabled. This sequence is generated
>>> for 32bit MIPS platforms by the compiler via the "-pg" flag.
>>> Part of the sequence is "addiu sp,sp,-8" in the delay slot after every
>>> call to the trace routine "_mcount" (some legacy thing where 2 arguments
>>> used to be pushed on the stack). The _mcount routine is expected to
>>> adjust the sp by +8 before returning.
>>>
>>> One of the bugs is that when tracing is disabled for a function, the
>>> "jalr _mcount" instruction is replaced with a nop, but the
>>> "addiu sp,sp,-8" is still executed and the stack pointer is left
>>> trashed. When frame pointers are enabled the problem is masked
>>> because any access to the stack is done through the frame
>>> pointer and the stack pointer is restored from the frame pointer when
>>> the function returns. This patch uses a branch likely instruction
>>> "bltzl zero, f1" instead of "nop" to disable the call because this
>>> instruction will not execute the "addiu sp,sp,-8" instruction in
>>> the delay slot. The other possible solution would be to nop out both
>>> the jalr and the "addiu sp,sp,-8", but this would need to be interrupt
>>> and SMP safe and would be much more intrusive.
>>
>>
>> I thought all CPUs were in stop_machine() when the modifications were done,
>> so that there is no issue with multi-word instruction patching.
>>
>> Am I wrong about this?
>>
>> So really I think you can do two NOP just as easily.
>>
>> The only reason I bring this up is that I am not sure all 32-bit CPUs
>> implement the 'Likely' branch variants. Also there may be an affect on the
>> branch predictor.
>>
>> A third possibility would be to replace the JALR with 'ADDIU SP,SP,8' That
>> way the following adjustment would be canceled out.  This would work well on
>> single-issue CPUs, but the instructions may not be able to dual-issue on a
>> multi issue machine due to data dependencies.
>>
>> David Daney
>>
>>
>>>
>>> A few other bugs were fixed where the _mcount routine itself did not
>>> always fix the sp on return.
>>>
>>
>
>

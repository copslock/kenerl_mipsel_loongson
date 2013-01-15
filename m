Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2013 01:14:07 +0100 (CET)
Received: from mail-qc0-f177.google.com ([209.85.216.177]:40054 "EHLO
        mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816553Ab3AOAOGHMm8r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Jan 2013 01:14:06 +0100
Received: by mail-qc0-f177.google.com with SMTP id u28so2858859qcs.8
        for <multiple recipients>; Mon, 14 Jan 2013 16:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vFFcDAxHLW6nkEhPatD8Gm2WwaE598544FKJEzMHx6w=;
        b=KX08VgyTORdKm14LWVf8CT5fgHojpD6oF2OaRsLizc8thzQueTc73hAl1tgEUJigG0
         SbiACzqp6W+SgpgDFd7cZqH7edPZHCTgnTJFtVExlB0vSulbrsPqsGT0QZALCw14uDDK
         qFDsdJtdBRTMjl8iY9zUGeEE7PoDsp2hPCa3fUZ/4MkjHCqop8kdHXPif5Fndno4PFPL
         B34SnB/YKSDnHqD1O3EjT4ZmzL2KN3OcBlHKQCc2u+sztDBjNVBhubM1JsXQaiAOj/aB
         4459vkHj7j9QOl9EXzLWnAULnS1gAgDpH3vRV+Y2IzdGrtDTbGsjyKwcbVMHh75pzxZi
         9UKA==
MIME-Version: 1.0
Received: by 10.49.118.38 with SMTP id kj6mr86749940qeb.53.1358208840066; Mon,
 14 Jan 2013 16:14:00 -0800 (PST)
Received: by 10.49.117.161 with HTTP; Mon, 14 Jan 2013 16:13:59 -0800 (PST)
In-Reply-To: <50F482D1.4090301@gmail.com>
References: <1357914810-20656-1-git-send-email-alcooperx@gmail.com>
        <50F0454D.5060109@gmail.com>
        <CAOGqxeU3zZuFfL_M1u-hgjbPHgm6MrzoCK1KqpbazwKC4td4ww@mail.gmail.com>
        <50F482D1.4090301@gmail.com>
Date:   Mon, 14 Jan 2013 19:13:59 -0500
Message-ID: <CAOGqxeW+roq4opj_1+bFTeFk1=75qooBxNLB9JGJWrfs-GG7hQ@mail.gmail.com>
Subject: Re: [PATCH] mips: function tracer: Fix broken function tracing
From:   Alan Cooper <alcooperx@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 35435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alcooperx@gmail.com
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

On Mon, Jan 14, 2013 at 5:12 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> On 01/14/2013 01:10 PM, Alan Cooper wrote:
>>
>> I already tried using "adddiu sp, sp, 8" and it caused the kernel to
>> randomly crash. After many hours of debugging the reason occurred to
>> me while in bed in the middle of the night. The problem is that if we
>> get an interrupt between the add 8 and the add -8 instructions, we
>> trash the existing stack.
>>
>> The problem with the 2 nop approach is that there are a series of
>> subroutines used to write each nop and these nested subroutines are
>> traceable.
>
>
> This seems like a bug.  The low-level code used to do code patching probably
> should be CFLAGS_REMOVE_file.o = -pg

While tracing mcount cannot be done because it's recursive, allowing
tracing of the code to enable/disable the call to mcount can be done
and seems useful. Also, fixing the 2 nop solution this way will still
not allow us to stop using stop_machine() which is hugely disruptive
to a running system. Remember that when tracing is enabled and
disabled we end up modifying 20 to 30 thousand functions. Moving this
functionality out of stop_machine() seems like a big benefit.

>
>
>
>> This means on the second call to these subroutines they
>> execute with only one nop and crash. I could  write  some new code
>> that wrote the 2 nops at once, but (now that I understand
>> "stop_machine") with the branch likely solution we should be able to
>> stop using "stop_machine" when we write nops to the 20-30 thousand
>> Linux functions. It looks like other platforms have stopped using
>> stop_machine.
>
>
> I don't particularly object to the 'branch likely solution', but I think the
> failures of the other approaches indicates underlying bugs in the tracing
> code.  Those bugs should probably be fixed.

If a solution can be found that modifies a single 32bit instruction to
enable/disable tracing, I don't see any bugs in the underlying code.
Plus we can avoid using stop_machine().

>
> David Daney
>
>
>
>>
>> Al
>>
>> On Fri, Jan 11, 2013 at 12:01 PM, David Daney <ddaney.cavm@gmail.com>
>> wrote:
>>>
>>> On 01/11/2013 06:33 AM, Al Cooper wrote:
>>>>
>>>>
>>>> Function tracing is currently broken for all 32 bit MIPS platforms.
>>>> When tracing is enabled, the kernel immediately hangs on boot.
>>>> This is a result of commit b732d439cb43336cd6d7e804ecb2c81193ef63b0
>>>> that changes the kernel/trace/Kconfig file so that is no longer
>>>> forces FRAME_POINTER when FUNCTION_TRACING is enabled.
>>>>
>>>> MIPS frame pointers are generally considered to be useless because
>>>> they cannot be used to unwind the stack. Unfortunately the MIPS
>>>> function tracing code has bugs that are masked by the use of frame
>>>> pointers. This commit fixes the bugs so that MIPS frame pointers do
>>>> not need to be enabled.
>>>>
>>>> The bugs are a result of the odd calling sequence used to call the trace
>>>> routine. This calling sequence is inserted into every tracable function
>>>> when the tracing CONFIG option is enabled. This sequence is generated
>>>> for 32bit MIPS platforms by the compiler via the "-pg" flag.
>>>> Part of the sequence is "addiu sp,sp,-8" in the delay slot after every
>>>> call to the trace routine "_mcount" (some legacy thing where 2 arguments
>>>> used to be pushed on the stack). The _mcount routine is expected to
>>>> adjust the sp by +8 before returning.
>>>>
>>>> One of the bugs is that when tracing is disabled for a function, the
>>>> "jalr _mcount" instruction is replaced with a nop, but the
>>>> "addiu sp,sp,-8" is still executed and the stack pointer is left
>>>> trashed. When frame pointers are enabled the problem is masked
>>>> because any access to the stack is done through the frame
>>>> pointer and the stack pointer is restored from the frame pointer when
>>>> the function returns. This patch uses a branch likely instruction
>>>> "bltzl zero, f1" instead of "nop" to disable the call because this
>>>> instruction will not execute the "addiu sp,sp,-8" instruction in
>>>> the delay slot. The other possible solution would be to nop out both
>>>> the jalr and the "addiu sp,sp,-8", but this would need to be interrupt
>>>> and SMP safe and would be much more intrusive.
>>>
>>>
>>>
>>> I thought all CPUs were in stop_machine() when the modifications were
>>> done,
>>> so that there is no issue with multi-word instruction patching.
>>>
>>> Am I wrong about this?
>>>
>>> So really I think you can do two NOP just as easily.
>>>
>>> The only reason I bring this up is that I am not sure all 32-bit CPUs
>>> implement the 'Likely' branch variants. Also there may be an affect on
>>> the
>>> branch predictor.
>>>
>>> A third possibility would be to replace the JALR with 'ADDIU SP,SP,8'
>>> That
>>> way the following adjustment would be canceled out.  This would work well
>>> on
>>> single-issue CPUs, but the instructions may not be able to dual-issue on
>>> a
>>> multi issue machine due to data dependencies.
>>>
>>> David Daney
>>>
>>>
>>>>
>>>> A few other bugs were fixed where the _mcount routine itself did not
>>>> always fix the sp on return.
>>>>
>>>
>>
>>
>

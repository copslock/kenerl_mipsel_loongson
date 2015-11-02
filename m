Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Nov 2015 21:55:00 +0100 (CET)
Received: from mail-io0-f180.google.com ([209.85.223.180]:35319 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012127AbbKBUy6s7x3P convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 2 Nov 2015 21:54:58 +0100
Received: by iofz202 with SMTP id z202so156740591iof.2
        for <linux-mips@linux-mips.org>; Mon, 02 Nov 2015 12:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=kYa7X5rkuricnHy9gc70qR5EC0krZrQShlrueqlUJgM=;
        b=mRi9wov8dibYf/aIazr3rMI2GiuW1j+10MiKE9dVqptcArYAACNTU7xrzvlXnf2YSm
         +dlnpWrAzSueBE9H8mrN+1FvtMKP4RrxsGxA2YJIaLoTKcbG83Pk9rcz1qEiGr0mSCoX
         b0pqJzTJsbGyq1n6JJWh2yKy6/pBSNC5Nj562lwEkT7AHwO8TZQRKJXVVH4pBLY0Ltbt
         8ZzLj/TxF1riC3pgb3dRpXRWbqk1FESoPv/XO2KfuDDVhKLZ9KuBk5jF8oJXmKPWfonv
         b72wWoUH/CWeLh1jVAKhKPbdbBXawPqrrI22DvthuWDLWzxjrjupCN8M7TVdHW4CMN21
         QAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kYa7X5rkuricnHy9gc70qR5EC0krZrQShlrueqlUJgM=;
        b=MbboSo9UuT9m/wsy8F3XoyzR0nge55zPJJwoHjCkn4pZvGSBIjhi22lBb6UwVitzdL
         F0UBE3ym90r2t3cWHri/L4vDt89o5155HMIXb5kASEqlpsxpLCZ+kQgn15Ku77Hpjk2k
         HoHv0WKhNOjpLsqcYrBePWZmSoMS5xBl6nkzYem4HgwBUSoljBws/XyGA7uUr7P95yDz
         /uiHh+7Qy1ediMpgYQl+j8OS9klMa+usDl5gVO5i5EdVVbOc9bK8EQgDS67LShZP325P
         vSClpLMA5DghnMABLy9tHssOQj+rrr7m30UDS//FP6MfQrpS1qKp8/aR8aOT0QFeB8IZ
         492A==
X-Gm-Message-State: ALoCoQliEhKcZy+1ut2vAu35+u15i2VeoIEmzWxhvCBSXNTUpQ6EFtfjlJhDfV76d8aPKKxiUsJL
MIME-Version: 1.0
X-Received: by 10.107.131.88 with SMTP id f85mr23928413iod.89.1446497692912;
 Mon, 02 Nov 2015 12:54:52 -0800 (PST)
Received: by 10.64.228.37 with HTTP; Mon, 2 Nov 2015 12:54:52 -0800 (PST)
In-Reply-To: <5625B274.4010800@gmail.com>
References: <1445280264-42016-1-git-send-email-pgynther@google.com>
        <5625B274.4010800@gmail.com>
Date:   Mon, 2 Nov 2015 12:54:52 -0800
Message-ID: <CAGXr9JE_6_yG6=oMTe4poEP+tmnuW4z9KGAmMZmrTMJ-NUVhRg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: switch BMIPS5000 to use r4k_wait_irqoff()
From:   Petri Gynther <pgynther@google.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <pgynther@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pgynther@google.com
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

On Mon, Oct 19, 2015 at 8:18 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Le 19/10/2015 11:44, Petri Gynther a écrit :
>> BCM7425 CPU Interface Zephyr Processor, pages 5-309 and 5-310
>> BCM7428B0 CPU Interface Zephyr Processor, pages 5-337 and 5-338
>>
>> WAIT instruction:
>> Thread enters wait state. No instructions are executed until an
>> interrupt occurs. The processor's clocks are stopped if both threads
>> are in idle mode.
>>
>> Description:
>> Execution of this instruction puts the thread into wait state, an idle
>> mode in which no instructions are fetched or executed. The thread remains
>> in wait state until an interrupt occurs that is not masked by the
>> interrupt mask field in the Status register. Then, if interrupts are
>> enabled by the IE bit in the Status register, the interrupt is serviced.
>> The ERET instruction returns to the instruction following the WAIT
>> instruction. If interrupts are disabled, the processor resumes executing
>> instructions with the next sequential instruction.
>>
>> Programming notes:
>> The WAIT instruction should be executed while interrupts are disabled
>> by the IE bit in the Status register. This avoids a potential timing
>> hazard, which occurs if an interrupt is taken between testing the counter
>> and executing the WAIT instruction. In this hazard case, the interrupt
>> will have been completed before the WAIT instruction is executed, so
>> the processor will remain indefinitely in wait state until the next
>> interrupt.
>>
>> Signed-off-by: Petri Gynther <pgynther@google.com>
>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>

Thanks Florian.

We have been using this patch on our BMIPS5000 systems for a while
now. No issues.

>> ---
>>  arch/mips/kernel/idle.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
>> index ab1478d..d636c70 100644
>> --- a/arch/mips/kernel/idle.c
>> +++ b/arch/mips/kernel/idle.c
>> @@ -160,7 +160,6 @@ void __init check_wait(void)
>>       case CPU_BMIPS3300:
>>       case CPU_BMIPS4350:
>>       case CPU_BMIPS4380:
>> -     case CPU_BMIPS5000:
>>       case CPU_CAVIUM_OCTEON:
>>       case CPU_CAVIUM_OCTEON_PLUS:
>>       case CPU_CAVIUM_OCTEON2:
>> @@ -171,7 +170,9 @@ void __init check_wait(void)
>>       case CPU_XLP:
>>               cpu_wait = r4k_wait;
>>               break;
>> -
>> +     case CPU_BMIPS5000:
>> +             cpu_wait = r4k_wait_irqoff;
>> +             break;
>>       case CPU_RM7000:
>>               cpu_wait = rm7k_wait_irqoff;
>>               break;
>>
>
>
> --
> Florian

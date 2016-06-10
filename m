Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2016 04:01:54 +0200 (CEST)
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35482 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27033640AbcFJCBvsvO5W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jun 2016 04:01:51 +0200
Received: by mail-wm0-f44.google.com with SMTP id v199so129873715wmv.0
        for <linux-mips@linux-mips.org>; Thu, 09 Jun 2016 19:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2XGwTFpJcuY3Dhh09FtyuZgo1OpHiOr99oFxElnFFW8=;
        b=RNh2AHcU6hVYqNcCJHddm28LAfg8EVVdbOQBLfjLqt97OSliCFkbK5tbYGl2v0719z
         08VpnBtjkdGQgvSuegLWp5N+qfhcDPZgBmU1P5cjwzqLPNsS9L2pO5b+ugS9RKcwrD0J
         sRLTMfRsh3DeijGgIvc0uXw1U7/AASED16MQRd9wlh9R74dEal9j0q8BKgLx7uysJi42
         /lqQ/vsMSzKO4hReUCLKfELX+ZSAQy2DXjkAB8kK9emlWXoEJcJ37MnFbhKRNU2D5WE6
         EK/OIupzSJzvos7DcZlYfffCaxmYZRMRX1H+AjAZNc4ts7D6UXMhGv6Z40pNUDdcgwts
         /XZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2XGwTFpJcuY3Dhh09FtyuZgo1OpHiOr99oFxElnFFW8=;
        b=YToi/beXOV9xqoTb7XA2OAuQM73WdyqpEHCUdoTQy3w0ClNhoIs/UHl6laOYco0HpT
         G3nXVuF0cL6T0wzmP/hk67OKFBJIsTa6Va7nt/jbhRpauNM0mcdtWiGotxL5gKJNM/Wf
         S8QiC+XCUMDvV/0GtzYWY0XEC1WrOU7Cz0Xg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=2XGwTFpJcuY3Dhh09FtyuZgo1OpHiOr99oFxElnFFW8=;
        b=IQyhDgIHpRdwOdBlNObsQSFQ7wt13VN/s0UTIpc5Q6ya+BG+tqVJideD9xpszA/S6a
         V/7F4M6yVs4W+mZhwMGBhY+DXawxR2DCsoOJUCsP40JS2AIwXDckb4C5NLQ9PQ/I9o0L
         ml07MQz5LpH4elpM83vVcaJnk9dPxSl3xHXOTwiRsMdZICYyAMcU4jLhkVeNoNNuUFk7
         6ybHODEkc7+pDkMKk89LVkS3VgFk55xeocPcMaV7CuGhHOH8bQ2Vq8IDYyC+V8Cnybf1
         bHVvTVOSkMgOjvlBmrB2ehgj6tq7BTdy1r+z6jM41KZGC21xx3+2FZf2tS5ygFY3N2sC
         VtOg==
X-Gm-Message-State: ALyK8tIpIe55RdjJpfTnGd3BKnb9QumtnmZLEvO2WtH/cTUCVZbhreo/QH1jSbYFu4MbeJt+RmCKZMeO78Hv6Tkw
X-Received: by 10.194.90.177 with SMTP id bx17mr12042794wjb.107.1465524106305;
 Thu, 09 Jun 2016 19:01:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.157.83 with HTTP; Thu, 9 Jun 2016 19:01:45 -0700 (PDT)
In-Reply-To: <CALCETrVk-UauwaRtZZR0fKQO6kyAx-r=ZCurKRdhQk9nA-TqeQ@mail.gmail.com>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
 <1465506124-21866-7-git-send-email-keescook@chromium.org> <CALCETrVk-UauwaRtZZR0fKQO6kyAx-r=ZCurKRdhQk9nA-TqeQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 9 Jun 2016 19:01:45 -0700
X-Google-Sender-Auth: yLubv1J4JXVeaYiueAH0oGUWpqU
Message-ID: <CAGXu5jKzOzfzMuOqfVCpgyzXrPrKYC60-AOYQmRVQUiqFpB0JQ@mail.gmail.com>
Subject: Re: [PATCH 06/14] x86/ptrace: run seccomp after ptrace
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jeff Dike <jdike@addtoit.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-parisc <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        "user-mode-linux-devel@lists.sourceforge.net" 
        <user-mode-linux-devel@lists.sourceforge.net>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Thu, Jun 9, 2016 at 3:52 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Thu, Jun 9, 2016 at 2:01 PM, Kees Cook <keescook@chromium.org> wrote:
>> This moves seccomp after ptrace on x86 to that seccomp can catch changes
>> made by ptrace. Emulation should skip the rest of processing too.
>>
>> We can get rid of test_thread_flag because there's no longer any
>> opportunity for seccomp to mess with ptrace state before invoking
>> ptrace.
>>
>> Suggested-by: Andy Lutomirski <luto@kernel.org>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> Cc: x86@kernel.org
>> Cc: Andy Lutomirski <luto@kernel.org>
>> ---
>>  arch/x86/entry/common.c | 22 ++++++++++++----------
>>  1 file changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
>> index df56ca394877..81c0e12d831c 100644
>> --- a/arch/x86/entry/common.c
>> +++ b/arch/x86/entry/common.c
>> @@ -73,6 +73,7 @@ static long syscall_trace_enter(struct pt_regs *regs)
>>
>>         struct thread_info *ti = pt_regs_to_thread_info(regs);
>>         unsigned long ret = 0;
>> +       bool emulated = false;
>>         u32 work;
>>
>>         if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
>> @@ -80,11 +81,19 @@ static long syscall_trace_enter(struct pt_regs *regs)
>>
>>         work = ACCESS_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY;
>>
>> +       if (unlikely(work & _TIF_SYSCALL_EMU))
>> +               emulated = true;
>> +
>> +       if ((emulated || (work & _TIF_SYSCALL_TRACE)) &&
>> +           tracehook_report_syscall_entry(regs))
>> +               return -1L;
>> +
>> +       if (emulated)
>> +               return -1L;
>> +
>
> I think that this code will result in ptrace-induced skips calling the
> audit exit hook but not the audit entry hook.  I don't know whether
> this is a problem.  It's also worth making sure that ptracing a
> seccomp-skipped syscall calls the exit hook with the right regs.
>
> I suspect it's fine, but I want to think about it a little bit more.

I don't think this is true, since all architectures already needed to
handle an immediate return from seccomp, so audit shouldn't be touched
on the exit path either.

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security

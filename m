Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 16:18:39 +0200 (CEST)
Received: from mail-oa0-f50.google.com ([209.85.219.50]:42746 "EHLO
        mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861350AbaGROScqE9-1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2014 16:18:32 +0200
Received: by mail-oa0-f50.google.com with SMTP id g18so3284014oah.23
        for <linux-mips@linux-mips.org>; Fri, 18 Jul 2014 07:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=mfU+N/O6gOuchT5fQbNQS38N9wxTrIgzsHfsx2v5U/w=;
        b=jDRRFRbhKbnsN3pzyYoKs9GqlftxMl2Sft8NwisEB4GS3FrtdJIpRFdWIdCJ8HMUC0
         kgWzq6fW01c8KnG3IPF4rSpmhB/acPEfyRkd0htT+dXweVJyt3L3pGSNEe4pXkQLhv1x
         ajuqBQTKD7ZBZtGWI7bC/Kt+ttYQ1obCiReHiMHk5f5n0Ymqp/DmOBXiX2/ApUIKoXsM
         tfWFGcKPAAP52fFogx07Pq/FkqvLmg0wyH7fW7L8cb706CNjsYiT36f9C2WO89HT4b5e
         K4obVktuMxv+OBfATTdItDK7xQzTj7Hj1CKnF4W4yQHpuURCx0Z7/YoRG2j4hs7kuW6x
         VTgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=mfU+N/O6gOuchT5fQbNQS38N9wxTrIgzsHfsx2v5U/w=;
        b=VCSCkmxhIyAn+cgYkaHBZWvgHeiTTuLYMaW1o7K23XQXy/f4pLM/cKRX6QGOQjWlm9
         DrB1tXCX4Fzfli+h8rUh4PObx6gfBL2rGC7mfXZfOchDAOHSULowvufviA1ucaeFRs6K
         9Y0/RdP4Xp5kVxk3P4gZ+QtliD11zIQ0C1fqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=mfU+N/O6gOuchT5fQbNQS38N9wxTrIgzsHfsx2v5U/w=;
        b=OSFgVQQ1Yz6+A3yhfl49UqQhoBct3rqZUfSTwlxcz3Cw3fSxfWzDQAVDWwhRhDpvQe
         tp3VeBEtqVbsm/jOYLLdJhhxmLjHw3wVeHZbDjgQLW1k9E6ngOM5NVIzWlQoWl2TQXZQ
         Zi9HnfJGUJVr2n+cOkPEM02M5E3p0V+xqU2CWmA2Kw5lbAdUyd+RaIo5pAJHVvhASyjR
         g4l/RG3hBL9bNP8eDq/ZZ1SD05f5V73MB6Dyw8GoDIXn9L+PPUGn1PY9xACPw55rq4qg
         I4BYbd9iCvlKJ6qYu2sqK3HT66Gq0nAzg07Qaj4XcsQe4F70S8MwfNkXPeqRxOt880TC
         lSyA==
X-Gm-Message-State: ALoCoQm1EHssUhZZ1LXsUbHMMLLhyW4Oaxont0y1GHA1eLGicYcYxFBvzPtrH0Un2WZN/V3krp8v
MIME-Version: 1.0
X-Received: by 10.60.174.3 with SMTP id bo3mr7247829oec.31.1405693105368; Fri,
 18 Jul 2014 07:18:25 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Fri, 18 Jul 2014 07:18:25 -0700 (PDT)
In-Reply-To: <53C8F56C.5070706@imgtec.com>
References: <CAGXu5jJJ7dqC-or=ZhKKj8=eA5itKX4aLRsnxmFZvwnyRcrUrw@mail.gmail.com>
        <53C8F56C.5070706@imgtec.com>
Date:   Fri, 18 Jul 2014 07:18:25 -0700
X-Google-Sender-Auth: qVR6Cm9gA0zlK5VUgX9BGE36bE8
Message-ID: <CAGXu5j+TE_t1akY0v2LSMvAEHcmTf_1nXCJLuWRCdJQFeKmZJA@mail.gmail.com>
Subject: Re: MIPS seccomp and changing syscalls
From:   Kees Cook <keescook@chromium.org>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41316
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

On Fri, Jul 18, 2014 at 3:22 AM, Markos Chandras
<Markos.Chandras@imgtec.com> wrote:
> Hi Kees,
>
> On 07/17/2014 11:29 PM, Kees Cook wrote:
>> Hi,
>>
>> I recently fixed a bug in seccomp on ARM that I think may be present
>> in the MIPS implementation too. In arch/mips/kernel/ptrace.c
>> syscall_trace_enter, the syscall variable is used (and returned), but
>> the syscall may be changed by either secure_computing or
>> tracehook_report_syscall_entry (via ptracers which can block and
>> change the registers). (I would note that "ret" is also set but never
>> used, so tracehook_report_syscall_entry failures actually won't get
>> noticed.)
>>
>> The discussion about this bug on ARM is here:
>> https://lkml.org/lkml/2014/6/20/439
>
> Thanks for letting us know.
> Right, I believe MIPS will have the same problem and a similar patch to
> Will Deacon's one will fix it properly. Would you like to submit one for
> MIPS too? Otherwise I can do it myself.
>
>>
>> I don't yet have a working MIPS environment to test this on, but it
>> feels like the same bug. (Though, for testing, what's the right way to
>> change syscall during PTRACE_SYSCALL? On x86 it's the orig_ax
>> register, on ARM it's a arch-specific ptrace function
>> (PTRACE_SET_SYSCALL).
>
> For MIPS, the syscall numbers is in the v0 register ($2). But the o32
> ABI also has the syscall() system call. So in case of indirect system
> calls, the real system call is the first argument of syscall(), which is
> register a0 ($4). See syscall_get_nr in arch/mips/include/asm/syscall.h

I just spent some time reading the scall*.S code, and it looks like
there actually isn't a way to change syscall via a tracer on MIPS. The
syscall function pointer is calculated before the tracer call, and
then only the first four registers are restored.

It seems like providing this feature on MIPS would require reordering
the logic in the entry points, potentially doing a full register set
reload. (It looks like MIPS only has a "fastpath" and no "slowpath"
logic.)

So, strictly speaking, there's no bug in syscall_trace_enter, but
there is a missing trace feature. :)

Slightly related, it'd be great to add MIPS to the syscall(2)
man-page; most other architectures are in there now:
http://manpages.ubuntu.com/manpages/trusty/en/man2/syscall.2.html

-Kees

-- 
Kees Cook
Chrome OS Security

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jul 2017 16:50:34 +0200 (CEST)
Received: from mail-oi0-x244.google.com ([IPv6:2607:f8b0:4003:c06::244]:33969
        "EHLO mail-oi0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992036AbdGZOu1CWHTY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Jul 2017 16:50:27 +0200
Received: by mail-oi0-x244.google.com with SMTP id v11so13588815oif.1;
        Wed, 26 Jul 2017 07:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=6xJHHw/mj6eXPkDzuCZwe/WuiTPLyPreUSHZtBltYb4=;
        b=d2s9y/iiGPC082pbPP2eY0uYhPUsfNT/Pv7nsArmnA94/1wfzF+iK3mETkBq/znqJp
         6OChx/GSp5BwiUfP4QrbVJU3udoJBvl8OzGx7RaNCcaVzKdVEpXJYD5jsZVwwn9Gl2Ge
         l9O6CdjabmDQnX8cKJkImaDIs18vrovVA6QUA0R/MJoUXmTRxRwLg0FKGPje96WXpKEJ
         dV/tjsz8lYK/qsrw9wdJJg3X7g9vStqgjlRQvFQM5DeXnjazo3/6OHyoZB+bPKmEBm0v
         lWWvm4Ri9uCLTREU1R/aghZ7sYzd/ID+bJaTi4JKMF9EdK7n5vnif6jxyWLsspZA+osf
         NuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=6xJHHw/mj6eXPkDzuCZwe/WuiTPLyPreUSHZtBltYb4=;
        b=KKMbrs9dEUmpoRDdUvu2OC+AvnlYCQh8WnmnvACGM3hWSFnABZ3urS3QH5aNrnN2sH
         bu5xG3mBZtKBAL5403QO3k7kta8c7KGXeFPGNgftw9juYaEZMEUlbPl9QZhEgBpHXlPj
         OJbPyU9jNQWsFSeGN4mqod56GgaEbj2XegzVfrrhMZhQjJhpLjJgRES4P5rvq8nNEyii
         MO7w8cMee2bT9Ls0HMln7yMgWVPP61Yj/rLTaW2ZZNjRrNa/EI0KXRASv5PbXva0OxBR
         JNHTKMVGQ+EaxMmSCr+jCwZjgpy7ya9o8MrTTSZA10LcV4RRgR0Uzgd6i4Z7PnUT4PNd
         bE5w==
X-Gm-Message-State: AIVw113hZArL8raotEQnJJ0c70F8x0vF3Ow/PCafdDKx9ST5ekVcjL21
        XwOo2e3N0/26mtmMFPRChjy2332nWg==
X-Received: by 10.202.218.11 with SMTP id r11mr1026894oig.306.1501080621022;
 Wed, 26 Jul 2017 07:50:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.29.34 with HTTP; Wed, 26 Jul 2017 07:50:20 -0700 (PDT)
In-Reply-To: <cc227181-ef9f-dede-d478-ba0714e4bfbb@redhat.com>
References: <20170726133447.2056379-1-arnd@arndb.de> <cc227181-ef9f-dede-d478-ba0714e4bfbb@redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 26 Jul 2017 16:50:20 +0200
X-Google-Sender-Auth: zsrGNe1q8X3r4NLITEBEqirFsZ0
Message-ID: <CAK8P3a3Wch2mUGnWjYXTUR0tt0q6DqoN58q4eS5Q7shHi=iS-g@mail.gmail.com>
Subject: Re: [PATCH v2] smp_call_function: use inline helpers instead of macros
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Wed, Jul 26, 2017 at 4:42 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 26/07/2017 15:32, Arnd Bergmann wrote:
>> A new caller of smp_call_function() passes a local variable as the 'wait'
>> argument, and that variable is otherwise unused, so we get a warning
>> in non-SMP configurations:
>>
>> virt/kvm/kvm_main.c: In function 'kvm_make_all_cpus_request':
>> virt/kvm/kvm_main.c:195:7: error: unused variable 'wait' [-Werror=unused-variable]
>>   bool wait = req & KVM_REQUEST_WAIT;
>>
>> This addresses the warning by changing the two macros into inline functions.
>> As reported by the 0day build bot, a small change is required in the MIPS
>> r4k code for this, which then gets a warning about a missing variable.
>>
>> Fixes: 7a97cec26b94 ("KVM: mark requests that need synchronization")
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Link: https://patchwork.kernel.org/patch/9722063/
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> This is not needed anymore, I've fixed it in KVM:
>
>     commit b49defe83659cefbb1763d541e779da32594ab10
>     Author: Paolo Bonzini <pbonzini@redhat.com>
>     Date:   Fri Jun 30 13:25:45 2017 +0200
>
>     kvm: avoid unused variable warning for UP builds

Ok, that seems sufficient, thanks!

      Arnd

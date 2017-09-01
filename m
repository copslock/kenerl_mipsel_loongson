Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Sep 2017 18:57:52 +0200 (CEST)
Received: from mail-io0-x236.google.com ([IPv6:2607:f8b0:4001:c06::236]:38848
        "EHLO mail-io0-x236.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993918AbdIAQ5isCG-v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Sep 2017 18:57:38 +0200
Received: by mail-io0-x236.google.com with SMTP id 81so4798975ioj.5
        for <linux-mips@linux-mips.org>; Fri, 01 Sep 2017 09:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=NBKfw3oWiUFuzhy9PNef+DrCjl4BggTHQU7Yl5HF3ho=;
        b=f2b7/PWJffOG2vreYgBROmyHZfBJc/NNtQfmenjyXRZkPjsDwASP6R0IckCC+NN48p
         EqDKJvpR2PUS8/ytezgdXd+jdBSOCYThTu/I0slQxkNJzXUiSckGLVzdgHc6TdjyGTHt
         jU95pynryk2O6LJ/8EY28RG02Ex/Gyw4KD9/8WuEa9YysumabyHt3LdI7AL4YUNjJ87c
         EXcN6kcb28NgEGhCIkEO6ZnxJgjyys6c6AFpCD9rxqrgQtf1XGymnqBlbJzmZZMvqAmN
         PCvzZAR97EVxKyJwEpCGzLgB77RrBhvvQsN8iXhVbwWq4j+zizgcEzEjDubVhcP4qx++
         PTHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=NBKfw3oWiUFuzhy9PNef+DrCjl4BggTHQU7Yl5HF3ho=;
        b=COroPvyDil7/XGwrt9hKL57qgl8itHNK33+BJbAw7hfN0blfUzk13TMgP/buDkf+aP
         4Atc8sLkJjqRmv3+Dht2ypyfAFoAKbSpEfUzfr74S64rx+ZF8x/1/STfV0BWgLVp6v/o
         lsowvBZI4qFsfM3qlgqgF5JupgOL1sc1E1Qb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=NBKfw3oWiUFuzhy9PNef+DrCjl4BggTHQU7Yl5HF3ho=;
        b=khtTiUSvapsTksmB/xRbsj7hgUbDFm0mfmi2bjcmw3WBYmSR76SidoY28/5DtF3uHV
         ByvZ+8crD/YME3XLYYJjmeBVZO7t4zhC1dgOVcBefjoRwstEvoJdVej3WKBISas45XwH
         FGUQ+WadV0mzqwzAGHs6cvwNRRdpPqmT9tKZzJTmKpwIsxQRZudJp9xnJXThLlcaAzwc
         AR3WBOPME9osGmoSLSxnAy5AjYVWIqbYUI4Q0aEo3HBHgOjaUKgsNbwRSww1e+UcSPL1
         Gp1B/iuKwf+D0mdgg/d3Kp0V5RCX08JS4bIIh6/ZNxb4yUJGE+ZPdcC3bE0EevN/0cE8
         6jiw==
X-Gm-Message-State: AHPjjUh11b/iQftgK+R4yVxcucsZdUoeQ7H3wedJfmlr0shK1l4jqxGj
        tZN/vwf9tQZ4cAEESeW8jRVH66MLBmBC
X-Google-Smtp-Source: ADKCNb6f/5cP0PuuJ16f+mRu6IaVXiFlaw5k4b/Ga21mIL3uRU5BnXbtVaLlDmXFDDtSWKAssJlrsVYNjgz6jNMDHKA=
X-Received: by 10.36.208.210 with SMTP id m201mr1354843itg.77.1504285052977;
 Fri, 01 Sep 2017 09:57:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.7.101 with HTTP; Fri, 1 Sep 2017 09:57:32 -0700 (PDT)
In-Reply-To: <20170901065947.GA32117@linux-mips.org>
References: <1504222183-61202-1-git-send-email-keescook@chromium.org>
 <1504222183-61202-25-git-send-email-keescook@chromium.org> <20170901065947.GA32117@linux-mips.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 1 Sep 2017 09:57:32 -0700
X-Google-Sender-Auth: bW8Cl7R_XCNf9JFCRW9H7iiAwAk
Message-ID: <CAGXu5jJmZ3NMGcG5jz739ukgdWJ3+0krL=A-_C7ntWmwNcXn=A@mail.gmail.com>
Subject: Re: [PATCH 24/31] mips/sgi-ip22: Use separate static data field with
 with static timer
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        James Hogan <james.hogan@imgtec.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59912
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

On Thu, Aug 31, 2017 at 11:59 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Thu, Aug 31, 2017 at 04:29:36PM -0700, Kees Cook wrote:
>
>> In preparation for changing the timer callback argument to the timer
>> pointer, move to a separate static data variable.
>>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: James Hogan <james.hogan@imgtec.com>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
>> Cc: linux-mips@linux-mips.org
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  arch/mips/sgi-ip22/ip22-reset.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/mips/sgi-ip22/ip22-reset.c b/arch/mips/sgi-ip22/ip22-reset.c
>> index 196b041866ac..5cc32610e6d3 100644
>> --- a/arch/mips/sgi-ip22/ip22-reset.c
>> +++ b/arch/mips/sgi-ip22/ip22-reset.c
>> @@ -38,6 +38,7 @@
>>  #define PANIC_FREQ           (HZ / 8)
>>
>>  static struct timer_list power_timer, blink_timer, debounce_timer;
>> +static unsigned long blink_timer_timeout;
>
> You're removing power_timer and debounce_timer ...

Nope, I think you misread: this only adds blink_timer_timeout;

>
>>  #define MACHINE_PANICED              1
>>  #define MACHINE_SHUTTING_DOWN        2
>> @@ -86,13 +87,13 @@ static void power_timeout(unsigned long data)
>>       sgi_machine_power_off();
>>  }
>>
>> -static void blink_timeout(unsigned long data)
>> +static void blink_timeout(unsigned long unused)
>>  {
>>       /* XXX fix this for fullhouse  */
>>       sgi_ioc_reset ^= (SGIOC_RESET_LC0OFF|SGIOC_RESET_LC1OFF);
>>       sgioc->reset = sgi_ioc_reset;
>>
>> -     mod_timer(&blink_timer, jiffies + data);
>> +     mod_timer(&blink_timer, jiffies + blink_timer_timeout);
>>  }
>>
>>  static void debounce(unsigned long data)
>> @@ -128,8 +129,8 @@ static inline void power_button(void)
>>       }
>>
>>       machine_state |= MACHINE_SHUTTING_DOWN;
>> -     blink_timer.data = POWERDOWN_FREQ;
>> -     blink_timeout(POWERDOWN_FREQ);
>> +     blink_timer_timeout = POWERDOWN_FREQ;
>> +     blink_timeout(0);
>>
>>       setup_timer(&power_timer, power_timeout, 0UL);
>
> ... but don't remove the reference to power_timer nor use of debounce_timer.
>
>>       power_timer.expires = jiffies + POWERDOWN_TIMEOUT * HZ;
>> @@ -169,8 +170,8 @@ static int panic_event(struct notifier_block *this, unsigned long event,
>>               return NOTIFY_DONE;
>>       machine_state |= MACHINE_PANICED;
>>
>> -     blink_timer.data = PANIC_FREQ;
>> -     blink_timeout(PANIC_FREQ);
>> +     blink_timer_timeout = PANIC_FREQ;
>> +     blink_timeout(0);
>>
>>       return NOTIFY_DONE;
>>  }
>> @@ -193,8 +194,7 @@ static int __init reboot_setup(void)
>>               return res;
>>       }
>>
>> -     init_timer(&blink_timer);
>> -     blink_timer.function = blink_timeout;
>> +     setup_timer(&blink_timer, blink_timeout, 0);
>>       atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
>>
>>       return 0;
>
>   Ralf

-Kees


-- 
Kees Cook
Pixel Security

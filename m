Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2012 06:18:41 +0200 (CEST)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:37951 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1902244Ab2HBESe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Aug 2012 06:18:34 +0200
Received: by eekc13 with SMTP id c13so2110467eek.36
        for <multiple recipients>; Wed, 01 Aug 2012 21:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rPrqCzCQ6UuE9wlIutn/wDwkoOimdA/B2kqha8qkhDA=;
        b=U7i9MPMTbRMMsV8oB3GEFyPEUpDPWYCgB5rs/+wJUJ/U94YfXko41o+H0gQ8FCJ28m
         TpQaIsDDKY73M37FECbIaoYrY2reCDZ2qN2ewGyWqHtgNRuffOMi96biJQ3OrqczwNgV
         XApK8SLbrYcqwNb3i2Y3cw6q1Igu6DuJvPynEbCDwJlkyF05pK/vokvWK7092PHDsUtC
         TxjpHS+Ron7PKeNjixhAjRZTLI4v/oFWvo4N2UHhH8znC0KchQ3cuFIspA7qKeD1CW84
         q+J/crzefNwTVjwpd/lRwybbVfQjl2Yu16oeNASAUYnGvLQ26SXEx1agEtq8bZs7GGWv
         Q5pA==
MIME-Version: 1.0
Received: by 10.14.198.200 with SMTP id v48mr25465834een.3.1343881108452; Wed,
 01 Aug 2012 21:18:28 -0700 (PDT)
Received: by 10.14.48.201 with HTTP; Wed, 1 Aug 2012 21:18:28 -0700 (PDT)
In-Reply-To: <1343878276-4108-1-git-send-email-fdu@windriver.com>
References: <1343878276-4108-1-git-send-email-fdu@windriver.com>
Date:   Wed, 1 Aug 2012 21:18:28 -0700
Message-ID: <CAJiQ=7Abc2sR2E2FXmeTr_Hc+CWH+J25=juB3wL172Tn6-PYuA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: oops when show backtrace of all active cpu
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Fan Du <fdu@windriver.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        vincent wen <vincentwenlinux@gmail.com>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Wed, Aug 1, 2012 at 8:31 PM, Fan Du <fdu@windriver.com> wrote:
> show_backtrace must have an valid task when calling unwind_stack,
> so fix it by checking first.
[...]
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -151,6 +151,10 @@ static void show_backtrace(struct task_struct *task, const struct pt_regs *regs)
>                 show_raw_backtrace(sp);
>                 return;
>         }
> +
> +       if (task == NULL)
> +               task = current;
> +
>         printk("Call Trace:\n");
>         do {
>                 print_ip_sym(pc);

FYI, a slightly different version of this change was accepted:

https://patchwork.linux-mips.org/patch/3524/

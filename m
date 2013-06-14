Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jun 2013 07:46:20 +0200 (CEST)
Received: from mail-vb0-f52.google.com ([209.85.212.52]:54223 "EHLO
        mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822830Ab3FNFqJM6kxG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Jun 2013 07:46:09 +0200
Received: by mail-vb0-f52.google.com with SMTP id f12so128289vbg.25
        for <multiple recipients>; Thu, 13 Jun 2013 22:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Zu1tN0sLAb4AW4SwAvXRfThnUiF+DiqzsxML8l5Nr2k=;
        b=rg6u53OwieZnb4CGnTkLObgRNyjWAx/LTQh220HLWAHgRftw2Rl5F1dvQtqPUEi0X9
         SW6RK3IwZNaRpuJ9xLAfFhllU9nykSfweTQlAzuOP9fK3mPTN5pnIaO6FGsNCOtmTmMW
         7qotvKeXMuJiWWR3b9R+I+iKLpzPoE2s2FZks/G71IPFZMmST9Aja1i9GcEJgAnJD5Lf
         k8TALNCYBIVz/5pLd5k+YwvRMiR0rOrKFV0SO+evJDuxxCZWPvg2xDfrLQmK4Am80FTT
         oQ5xur14FnUcJhbYjKY+7ddbKBgRL1dE/CAyo5ffCE2Q6trNBu0RkEru9yD+q+AAC7M/
         fUCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Zu1tN0sLAb4AW4SwAvXRfThnUiF+DiqzsxML8l5Nr2k=;
        b=Jn9IzOzx/j87ZcA/BO4P0UBrmWIg5Ce9T2KdU4BHEtRBOMj2WtRDdEUTU4qBgqx80f
         fa1Uxd44eVXYdRJv49bem37cBtXWZP/th4a7KVqstm7qxqidCipGq/jjdK5yg1KQZAC3
         kufEZL7VqPigXfNqe/IzwwNbKwyW2OS6wYeos=
MIME-Version: 1.0
X-Received: by 10.58.187.4 with SMTP id fo4mr340504vec.55.1371188762419; Thu,
 13 Jun 2013 22:46:02 -0700 (PDT)
Received: by 10.220.8.71 with HTTP; Thu, 13 Jun 2013 22:46:02 -0700 (PDT)
In-Reply-To: <1371172023-16004-1-git-send-email-ddaney.cavm@gmail.com>
References: <1371172023-16004-1-git-send-email-ddaney.cavm@gmail.com>
Date:   Thu, 13 Jun 2013 22:46:02 -0700
X-Google-Sender-Auth: tWEb3uaffCgVTxnwnpixhXtPFjE
Message-ID: <CA+55aFziBGnSgLimDe7WBRPQ+f3RVAsrdbo212oj85c-XSz4oA@mail.gmail.com>
Subject: Re: [PATCH] smp.h: Use local_irq_{save,restore}() in !SMP version of on_each_cpu().
From:   Linus Torvalds <torvalds@linux-foundation.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus971@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
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

On Thu, Jun 13, 2013 at 6:07 PM, David Daney <ddaney.cavm@gmail.com> wrote:
>
> Suggested fix: Do what we already do in the SMP version of
> on_each_cpu(), and use local_irq_save/local_irq_restore.

I was going to apply this, but started looking a bit more.

Using "flags" as a variable name inside a macro like this is a
*really* bad idea.

Lookie here:

    [torvalds@pixel linux]$ git grep on_each_cpu.*flags
    arch/s390/kernel/perf_cpum_cf.c:        on_each_cpu(setup_pmc_cpu,
&flags, 1);
    arch/s390/kernel/perf_cpum_cf.c:        on_each_cpu(setup_pmc_cpu,
&flags, 1);

and ask yourself what happens when the "info" argument expands to
"&flags", and it all compiles perfectly fine, but the "&flags" takes
the address of the new _inner_ variable called "flags" from the macro
expansion. Not the one that the caller actually intends..

Oops.

Not a good idea.

So I would suggest trivially renaming "flags" as "__flags" or
something, or perhaps even just making it a real function and avoiding
the whole namespace issue.

And rather than doing that blindly by editing the patch at after -rc5,
I'm just going to ask you to re-send a tested patch. Ok?

                    Linus

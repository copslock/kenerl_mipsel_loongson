Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Feb 2015 03:01:18 +0100 (CET)
Received: from mail-vc0-f169.google.com ([209.85.220.169]:51887 "EHLO
        mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007597AbbB1CBRJgbuj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Feb 2015 03:01:17 +0100
Received: by mail-vc0-f169.google.com with SMTP id kv19so7707195vcb.0
        for <linux-mips@linux-mips.org>; Fri, 27 Feb 2015 18:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=jeKyPFKBXXQ2SljZF1DiXLKMguDZrTnK9rHtKCeCeUU=;
        b=CJd6Juq85ZdW4cnPrTREP+ULHyqIvixNp1UGuFxO+XV/JPObq8GlYwRSFe1zYKN9+y
         Lige1Uj4nIhldEFCRIYpF0o0VgM0k7wwCXLmxGJrxFBgxt8hWW8BA2g/WYkj/SE/bJVN
         GdzgchfUeQYr0zlCo6CkQ88o87jbqQfHtsvbLkK4iVdCdHLrTtpA8ObexP9vQRFy5vqq
         ODZPUEYm+bmoTmNrJYtSFngZwQyeuR22MPzQAo71X/Kk86rXTAfeSDQjRbqHNRB3P4rn
         atDVDDNrPbzwafqPd0Rz6qWQCP+8cWdzK6BrfGrDplasyWLryyrNsNfnzwCkWtjaRbIH
         flaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=jeKyPFKBXXQ2SljZF1DiXLKMguDZrTnK9rHtKCeCeUU=;
        b=lTYNmOUsiA77IPWy689kminIx53qpqvar4fn6FBjzkjG/HuF9r/aZUxVQZ2TEBuUgt
         CxGrMjh5av3Qf0RnQeqUdVeDFjSKWIfQmyRAftScrBjqr7FdHVr45WgJEphziMcq8tYM
         RQ8OU+IHHZGJWTrrY0ICgzAhjJk+31Qdxtqsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=jeKyPFKBXXQ2SljZF1DiXLKMguDZrTnK9rHtKCeCeUU=;
        b=Ld7QBTr6+H0s5h27AZ+B/O8j5jyXIHoQVwn9xjUGBW38NKFaArG+2PTcHWRzh3wFVt
         hih2aHjWamQt7ggMhHVKgp78uKhyzx9au58xPNEP6/+R9wchA8nNoSylwmn4WvAzn/4U
         dxqQyEmknaBmv5K6uv/zkFadhbGhESAOyZyMDlEgJ9snotWrVfqeJGelv4v4RJKJVUy/
         J7Zv0zZJ2n3dBoxxCGMx/0iQcxr9TDV4zJ3LNnnnFyiiN/mAvCIq7qocMLyk16vCK8UA
         7d4rz9k0eg6BWMurpyfXlqo+xtNgdEKaKpIlDJkKuJNLarQl7+2wcUS6NOG7SsajNRGo
         UQNA==
X-Gm-Message-State: ALoCoQkcmM/czod4HudEHPGarCT5gqrM4HP8KKM9MiKJHDqHrl02FNlTljII0JWehoykgXbnqGBq
MIME-Version: 1.0
X-Received: by 10.52.12.169 with SMTP id z9mr15633613vdb.69.1425088871631;
 Fri, 27 Feb 2015 18:01:11 -0800 (PST)
Received: by 10.52.116.135 with HTTP; Fri, 27 Feb 2015 18:01:11 -0800 (PST)
In-Reply-To: <20150228123656.538301ef@canb.auug.org.au>
References: <20150228005228.GA23638@www.outflux.net>
        <20150228123656.538301ef@canb.auug.org.au>
Date:   Fri, 27 Feb 2015 18:01:11 -0800
X-Google-Sender-Auth: eC67U_LB6kG_DeNmXHRiJ3HjAwk
Message-ID: <CAGXu5jLgbzzYQkeLmpgSGu7w7DKKTHpFE=F2_a=ayjkU6atBQQ@mail.gmail.com>
Subject: Re: [PATCH] seccomp: switch to using asm-generic for seccomp.h
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-sh@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
        linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
        Helge Deller <deller@gmx.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Hogan <james.hogan@imgtec.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46057
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

On Fri, Feb 27, 2015 at 5:36 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Kees,
>
> On Fri, 27 Feb 2015 16:52:29 -0800 Kees Cook <keescook@chromium.org> wrote:
>>
>> diff --git a/arch/arm/include/asm/seccomp.h b/arch/arm/include/asm/seccomp.h
>> index 52b156b341f5..66ca6a30bf5c 100644
>> --- a/arch/arm/include/asm/seccomp.h
>> +++ b/arch/arm/include/asm/seccomp.h
>> @@ -1,11 +1 @@
>> -#ifndef _ASM_ARM_SECCOMP_H
>> -#define _ASM_ARM_SECCOMP_H
>> -
>> -#include <linux/unistd.h>
>> -
>> -#define __NR_seccomp_read __NR_read
>> -#define __NR_seccomp_write __NR_write
>> -#define __NR_seccomp_exit __NR_exit
>> -#define __NR_seccomp_sigreturn __NR_rt_sigreturn
>> -
>> -#endif /* _ASM_ARM_SECCOMP_H */
>> +#include <asm-generic/seccomp.h>
>
> I think that these cases (where you replace the file by a stub that
> just include <asm-generic/seccomp.h>) can be replaced by removing the
> file completely and adding
>
> generic-y = seccomp.h
>
> to <ARCH>/include/asm/Kbuild

Ah-ha! I thought total removal was possible, but I lacked the Kbuild
piece. There are a lot of arch/ headers that are just the one line.
Maybe I should send a another patch to clean up those?

-Kees

-- 
Kees Cook
Chrome OS Security

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Nov 2018 06:13:51 +0100 (CET)
Received: from mail-it1-x144.google.com ([IPv6:2607:f8b0:4864:20::144]:54357
        "EHLO mail-it1-x144.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990509AbeK3FNsgDyiq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Nov 2018 06:13:48 +0100
Received: by mail-it1-x144.google.com with SMTP id i145so6563347ita.4
        for <linux-mips@linux-mips.org>; Thu, 29 Nov 2018 21:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mmo2hKAV4jn2oX+2Bz4e22r9nBzpV0vdm9tze62b+HA=;
        b=hpGGzU/u7PfYM1VnObh0+9oBriyoH2mjS0JQQe4Qig3CO+dObRB5a+aYq2eD8CHY2l
         +oyXrImgXWa2bwQGodDcEzrPc6DfJbnxNRmA+7Sgs6iz9OsDa8w3didHc09u0iXNrERj
         DcnSOSChyirZ8sQBkKyi55vkCQkL6fm9+S3Ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mmo2hKAV4jn2oX+2Bz4e22r9nBzpV0vdm9tze62b+HA=;
        b=uTM/EkRmz175p12Tf5gSprm9URzE0Uw5t7WocjWuZszdEc11ERp2k1vnEFJLs6oRzE
         hFWv45S/pNkk5uoCUEk0b0SovTHUm6F5+0nvd9+Kwvn11sJF37WZEIQbJWt3zwzqPxuj
         54BQ4SYRn8zkAcsTwXhmWkg5CcZocLUHnYagG2gumT3QY67eneHm3MYc4GG4dECdEmCF
         KyYmR8DggiiXNgOl/1cHT9jKVy24Dtj81uXbHcrmJW1gVnNDwS9BO65UloAve9X5JQ26
         cYtAq4HWXbAZAv1xM8NecdJdnqmJ4N88TYcXHUx0EcypIFekF/uCFvaJgp+vkYCpZQ+0
         Q1ZQ==
X-Gm-Message-State: AA+aEWZbyIHiqMUZfpHTUGd8KQtgLmDkSKl9JnlnKcxJafo042XeqMxT
        nr4qgDODs3ozVTyRJAjH07PEbPQgQ6LxqxQXwrWwVA==
X-Google-Smtp-Source: AFSGD/UT3ygBFYlKlGEqgjU/8qShMsQdIcuOqBWrAbUZIk5dzJ5UmupaZQojQxLBFdFpm5CEWxnpsPJHm8p8+d1tIBM=
X-Received: by 2002:a02:f42:: with SMTP id h63mr3942243jad.133.1543554827820;
 Thu, 29 Nov 2018 21:13:47 -0800 (PST)
MIME-Version: 1.0
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
 <1543481016-18500-7-git-send-email-firoz.khan@linaro.org> <CAK8P3a0rTwm_pCtQXyn_fyJttihKJ6Gpq97mw-r5ySUNBksCig@mail.gmail.com>
In-Reply-To: <CAK8P3a0rTwm_pCtQXyn_fyJttihKJ6Gpq97mw-r5ySUNBksCig@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Fri, 30 Nov 2018 10:43:36 +0530
Message-ID: <CALxhOnhkQo-qx54E-sbhQG=LiZcJS549sxYpzmGbiMn2YJVhkA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] mips: generate uapi header and system call table files
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <firoz.khan@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: firoz.khan@linaro.org
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

Hi Arnd,

Thanks for the email,

On Thu, 29 Nov 2018 at 19:52, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Nov 29, 2018 at 9:45 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> > diff --git a/arch/mips/include/uapi/asm/Kbuild b/arch/mips/include/uapi/asm/Kbuild
> > index 7a4becd..ed4bd03 100644
> > --- a/arch/mips/include/uapi/asm/Kbuild
> > +++ b/arch/mips/include/uapi/asm/Kbuild
> > @@ -1,5 +1,11 @@
> >  # UAPI Header export list
> >  include include/uapi/asm-generic/Kbuild.asm
> >
> > +generated-y += unistd_n32.h
> > +generated-y += unistd_n64.h
> > +generated-y += unistd_o32.h
> > +generated-y += unistd_nr_n32.h
> > +generated-y += unistd_nr_n64.h
> > +generated-y += unistd_nr_o32.h
> >  generic-y += bpf_perf_event.h
> >  generic-y += ipcbuf.h
>
> I'd argue that the unistd_nr_*.h headers should not be in the uapi directory
> but instead be included only from the in-kernel header.

That is also fine. I can update in v4.
Paul, Do you have any comment on this and could you confirm user
space doesn't need this macros - __NR_N32/N64/O32_Linux,
__NR_N32/N64/O32_Linux_syscalls ?

>
>
> > diff --git a/arch/mips/kernel/scall64-n64.S b/arch/mips/kernel/scall64-n64.S
> > new file mode 100644
> > index 0000000..402a085
> > --- /dev/null
> > +++ b/arch/mips/kernel/scall64-n64.S
> > @@ -0,0 +1,117 @@
> > +/*
> > + * This file is subject to the terms and conditions of the GNU General Public
> > + * License.  See the file "COPYING" in the main directory of this archive
> > + * for more details.
> > + *
> > + * Copyright (C) 1995, 96, 97, 98, 99, 2000, 01, 02 by Ralf Baechle
> > + * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
> > + * Copyright (C) 2001 MIPS Technologies, Inc.
> > + */
> > +#include <linux/errno.h>
> > +#include <asm/asm.h>
> > +#include <asm/asmmacro.h>
> > +#include <asm/irqflags.h>
>
> It looks like you change and rename this file at the same time.
> Generally speaking, I would not do that in one patch. Either
> leave the slightly inconsistent name unchanged, or rename
> it in a separate patch.

Ah, you catch this one.I thought it will go with out notice.
Ok, I create one more patch in my v4.

Paul, FYI, you asked me to convert 64 to n64. Here I'm changing file
name - scall64-n64.S (previously it was scall64-64.S) also.

Thanks
Firoz


>
>          Arnd

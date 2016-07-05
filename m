Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jul 2016 12:07:34 +0200 (CEST)
Received: from mail-it0-f66.google.com ([209.85.214.66]:34775 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992770AbcGEKH2Ji8Fx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jul 2016 12:07:28 +0200
Received: by mail-it0-f66.google.com with SMTP id f6so10888879ith.1;
        Tue, 05 Jul 2016 03:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lY93vK4ALqi0t1dQBSeJIAWfP1ZtUqHKUgNoStgTXLQ=;
        b=wV1k5Y6SmlHuUnvexyEqJzA2CoiIQBkmlHCzPcQb2T5g+U0YdKz0ed/j0pFTivynf1
         bux874cDbLOxl+Pu6iXJxUVi0WGT/OLz6gEl3F19GA7CNEw9Jyb1mee8B0KFGYn7fHl6
         mXpK2EAnJmAVdqebLyz9wuNzCCu+RmGW4xq0bgdny6CXWrM7HdTYGtI8krgEhaDDIhQx
         xLEgppAvLKtGd5KyPwktLPgwqLYvBns+Ss7VcPX6ByCmxnS2IO/h0SZo+8UYRAR8JoFd
         vP9iGXHlvTDl7ggTvJDriGfKmMzjgsDx9ncaPw+rJ/53cmKGPlhxlnC5dar6KtZJYm5D
         KHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lY93vK4ALqi0t1dQBSeJIAWfP1ZtUqHKUgNoStgTXLQ=;
        b=LDmJqfl9xYM6nsj4DuHd9/kimjhx7aU0fZWkJjYhMMXdLTNMLr6IFoJ+zY8LXxwyNx
         6bRo7JjK2MhXZ8UHcSff3K+8Jazi0LJ98GzemljTBmTcdgvfUKG/6Cf1HhApjaD+jvG/
         EfNdFJ2YiiMj5KzZn3pfKtz53mJpNmsU7RmFDEGj57tDzjh16db4yj8ZjYw2jWxPIfAd
         lIgDNdTpvz0e69upZmij3lfUDCOfpYZjkUTnGC7+3kI4RIkqvTSipMF4489JY3dbDNi4
         fU5qNC2BkeNcwjMOdluOrDdGGCjgcgoiwZjIbuw4wfdg7JenlMwiRkHRQ42e6SHpxE93
         VPaQ==
X-Gm-Message-State: ALyK8tKpkp1KHHXmiP12FIu2PWCycLbQu1nh2acvh3dIt3e6jbARtV7Pe4NfPyAy51gWaxFZCVAEtI26TF7sBA==
X-Received: by 10.36.200.196 with SMTP id w187mr12129782itf.74.1467713242170;
 Tue, 05 Jul 2016 03:07:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.168.168 with HTTP; Tue, 5 Jul 2016 03:07:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1607042317480.4076@tp.orcam.me.uk>
References: <1466856870-17153-1-git-send-email-prasannatsmkumar@gmail.com> <alpine.DEB.2.00.1607042317480.4076@tp.orcam.me.uk>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Tue, 5 Jul 2016 15:37:21 +0530
Message-ID: <CANc+2y7meDYJyrHbbKWGsTNwangKCLB+kWLC6bys89PSXj-TdQ@mail.gmail.com>
Subject: Re: [RFC] mips: Add MXU context switching support
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        John Stultz <john.stultz@linaro.org>, mguzik@redhat.com,
        athorlton@sgi.com, mhocko@suse.com, ebiederm@xmission.com,
        gorcunov@openvz.org, luto@kernel.org, cl@linux.com,
        serge.hallyn@ubuntu.com, Kees Cook <keescook@chromium.org>,
        jslaby@suse.cz, Andrew Morton <akpm@linux-foundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>, mingo@kernel.org,
        alex.smith@imgtec.com, markos.chandras@imgtec.com,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        david.daney@cavium.com, zhaoxiu.zeng@gmail.com, chenhc@lemote.com,
        Zubair.Kakakhel@imgtec.com, James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

On 5 July 2016 at 04:00, Maciej W. Rozycki <macro@imgtec.com> wrote:
> On Sat, 25 Jun 2016, PrasannaKumar Muralidharan wrote:
>
>> diff --git a/arch/mips/include/asm/mxu.h b/arch/mips/include/asm/mxu.h
>> new file mode 100644
>> index 0000000..cf77cbd
>> --- /dev/null
>> +++ b/arch/mips/include/asm/mxu.h
>> @@ -0,0 +1,157 @@
>> +/*
>> + * Copyright (C) Ingenic Semiconductor
>> + * File taken from Ingenic Semiconductor's linux repo available in github
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License as published by the
>> + * Free Software Foundation;  either version 2 of the  License, or (at your
>> + * option) any later version.
>> + */
>> +#ifndef _ASM_MXU_H
>> +#define _ASM_MXU_H
>> +
>> +#include <asm/cpu.h>
>> +#include <asm/cpu-features.h>
>> +#include <asm/hazards.h>
>> +#include <asm/mipsregs.h>
>> +
>> +static inline void __enable_mxu(void)
>> +{
>> +     unsigned int register val asm("t0");
>> +     val = 3;
>> +     asm volatile(".word     0x7008042f\n\t"::"r"(val));
>
>  Can you please document your manually generated machine code, i.e. what
> instruction 0x7008042f actually is?

I have taken this header from vendor kernel. This instruction saves 3
to xr16 register. I will document them in the next revision.

>  Also our convention has been to separate asm operands with spaces, and
> there's no need for a new line or a tab character at the end of an
> inline as GCC will add these automatically as needed, i.e.:
>
>         asm volatile(".word     0x7008042f" : : "r" (val));
>
> Likewise throughout.

Will follow the convention.

>> +static inline void __save_mxu(void *tsk_void)
>> +{
>> +     struct task_struct *tsk = tsk_void;
>> +
>> +     register unsigned int reg_val asm("t0");
>> +
>> +     asm volatile(".word     0x7008042e\n\t");
>> +     tsk->thread.mxu.xr[0] = reg_val;
>> +     asm volatile(".word     0x7008006e\n\t");
>> +     tsk->thread.mxu.xr[1] = reg_val;
>> +     asm volatile(".word     0x700800ae\n\t");
>> +     tsk->thread.mxu.xr[2] = reg_val;
>> +     asm volatile(".word     0x700800ee\n\t");
>> +     tsk->thread.mxu.xr[3] = reg_val;
>> +     asm volatile(".word     0x7008012e\n\t");
>> +     tsk->thread.mxu.xr[4] = reg_val;
>> +     asm volatile(".word     0x7008016e\n\t");
>> +     tsk->thread.mxu.xr[5] = reg_val;
>> +     asm volatile(".word     0x700801ae\n\t");
>> +     tsk->thread.mxu.xr[6] = reg_val;
>> +     asm volatile(".word     0x700801ee\n\t");
>> +     tsk->thread.mxu.xr[7] = reg_val;
>> +     asm volatile(".word     0x7008022e\n\t");
>> +     tsk->thread.mxu.xr[8] = reg_val;
>> +     asm volatile(".word     0x7008026e\n\t");
>> +     tsk->thread.mxu.xr[9] = reg_val;
>> +     asm volatile(".word     0x700802ae\n\t");
>> +     tsk->thread.mxu.xr[10] = reg_val;
>> +     asm volatile(".word     0x700802ee\n\t");
>> +     tsk->thread.mxu.xr[11] = reg_val;
>> +     asm volatile(".word     0x7008032e\n\t");
>> +     tsk->thread.mxu.xr[12] = reg_val;
>> +     asm volatile(".word     0x7008036e\n\t");
>> +     tsk->thread.mxu.xr[13] = reg_val;
>> +     asm volatile(".word     0x700803ae\n\t");
>> +     tsk->thread.mxu.xr[14] = reg_val;
>> +     asm volatile(".word     0x700803ee\n\t");
>> +     tsk->thread.mxu.xr[15] = reg_val;
>> +}
>
>  Not using an output operand with asms here?

I think the instruction saves the xr* register value to reg_val
without need for output operand.

Thanks for your review, appreciate it.

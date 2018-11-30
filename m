Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Nov 2018 06:05:19 +0100 (CET)
Received: from mail-io1-xd41.google.com ([IPv6:2607:f8b0:4864:20::d41]:45886
        "EHLO mail-io1-xd41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990421AbeK3FFPRWC2q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Nov 2018 06:05:15 +0100
Received: by mail-io1-xd41.google.com with SMTP id w7so3508431iom.12
        for <linux-mips@linux-mips.org>; Thu, 29 Nov 2018 21:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eY5ldt/nvbSFXjThNmQjCgsUcV0slJ0eCOAORjgvOko=;
        b=VZ3ISqG7vJiHteR3Wc9v9zOLEZdAQyQstRiI782J1G5n1ySMxWCSYKka3klsSovgZG
         366zRvN/ZHhlb9zmcu6yYzzunhA+UVExfUuwzH4kU4uiekLb7khZdOu/7gbOy+Lgl6Xu
         NJr7gk5SCjikRFCsd430lskS/ZSnrr2IBySMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eY5ldt/nvbSFXjThNmQjCgsUcV0slJ0eCOAORjgvOko=;
        b=kapx8w/adFTHuUniT54JITM+Raxpf9uOLAgzAsDeTL/BlQvoaQTT8JJh4ZZp9GFiRK
         nMGcZQrPm3JJwKq1Jenve1BAdKlg9VgZm4UU5QsO9daIQNIFqklYl7+5/oryGcvVhHxC
         8Yg4xV6pnxUhixXCZlNPRAmly+ODzDUSfDq48CzNenkwT2T8eIkEMhYOZ4le01vNmrN2
         OjzhPkEfTwQV1Arz0puDN01slrOh1Ja3VbsiV7JxjcWLMtFqjIcEY4uSBmTwaQXHDgfa
         gmUn+GukidhV96Epz0uIqexvH4pk/Sm3T2HUyQI4KBu70BFfFw4/eC0CV5NZv2fdtvm+
         SwQQ==
X-Gm-Message-State: AA+aEWYKt6b+SEjH0XL7I9ekEHpyPMIixb282KpppQsnfsdMCbe5zojW
        C/Jd/JYAOVa1J4U88hewz9m+N98esZ22Z2hSsWJLyg==
X-Google-Smtp-Source: AFSGD/VHy2GoglJpf5KuZifXucd+0itkqTW5MYI4S1kTr8TRo8fZu9CyYUvzL/AT/AQzuL9fEx7BQB9MwypD8kU4EF8=
X-Received: by 2002:a6b:6919:: with SMTP id e25mr3440101ioc.119.1543554314477;
 Thu, 29 Nov 2018 21:05:14 -0800 (PST)
MIME-Version: 1.0
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
 <1543481016-18500-6-git-send-email-firoz.khan@linaro.org> <CAK8P3a1KcUQEbavu1eZaoKXTmbdbxiKgVqt6XF-PeeSSbpVEVg@mail.gmail.com>
In-Reply-To: <CAK8P3a1KcUQEbavu1eZaoKXTmbdbxiKgVqt6XF-PeeSSbpVEVg@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Fri, 30 Nov 2018 10:35:02 +0530
Message-ID: <CALxhOnivqOdpZ8WRK3Lx9ScApa34MS6riTwFz15aS7GTGf6QQA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] mips: add system call table generation support
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
X-archive-position: 67554
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

Thanks for your email.

On Thu, 29 Nov 2018 at 19:46, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Nov 29, 2018 at 9:44 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> > The system call tables are in different format in all
> > architecture and it will be difficult to manually add,
> > modify or delete the syscall table entries in the res-
> > pective files. To make it easy by keeping a script and
> > which will generate the uapi header and syscall table
> > file. This change will also help to unify the implemen-
> > tation across all architectures.
> >
> > The system call table generation script is added in
> > kernel/syscalls directory which contain the scripts to
> > generate both uapi header file and system call table
> > files. The syscall.tbl will be input for the scripts.
> >
> > syscall.tbl contains the list of available system calls
> > along with system call number and corresponding entry
> > point. Add a new system call in this architecture will
> > be possible by adding new entry in the syscall.tbl file.
> >
> > Adding a new table entry consisting of:
> >         - System call number.
> >         - ABI.
> >         - System call name.
> >         - Entry point name.
> >         - Compat entry name, if required.
> >
> > syscallhdr.sh and syscalltbl.sh will generate uapi
> > header unistd_64/n32/o32.h and syscall_table_32_o32/-
> > 64_64/64-n32/64-o32.h files respectively. Both .sh files
> > will parse the content syscall.tbl to generate the header
> > and table files. unistd_64/n32/o32.h will be included by
> > uapi/asm/unistd.h and syscall_table_32_o32/64_64/64-n32-
> > /64-o32.h is included by kernel/syscall_table32_o32/64-
> > _64/64-n32/64-o32.S - the real system call table.
> >
> > ARM, s390 and x86 architecuture does have similar support.
> > I leverage their implementation to come up with a generic
> > solution.
> >
> > Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
>
> Ah, I see you added the syscallnr.sh script from ARM.  I guess
> that is one way to handle it, and the implementation seems
> fine. It would be good to mention it in the changelog text above
> though.

I came across the file name - syscallnr.sh  in ARM long back and I
used it here.

Everyone - Arnd pointed out __NR_syscalls assignment issue in my
v2 patches. For that, I came across those macros to be part of the
generated file. So I created another script - syscallnr.sh just write
__NR_N32/N64/O32_Linux, __NR_N32/N64/O32_Linux_syscalls
to the generated file. I had 1:1 chat with Paul also and he share few
concerns to convert above macros to be variable.

The advantage of adding another script is the other two scripts -
syscallhdr.sh and syscalltbl.sh are identical across all other 10
architecture. If we are trying to come up with a common script,
hopefully the effort will be minimal.

Yes, I can update the change log.

Paul, Could you help me to review this patch series and perform
the boot test on actual platform.

FYI, I could send v4 (clean one) next week mid as I'm on a vacation
couple of days.

Thanks
Firoz





>
>       Arnd

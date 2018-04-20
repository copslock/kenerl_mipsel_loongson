Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Apr 2018 15:53:20 +0200 (CEST)
Received: from mail-oi0-x241.google.com ([IPv6:2607:f8b0:4003:c06::241]:40237
        "EHLO mail-oi0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990480AbeDTNxNQ2m8w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Apr 2018 15:53:13 +0200
Received: by mail-oi0-x241.google.com with SMTP id x9-v6so8081834oig.7;
        Fri, 20 Apr 2018 06:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WkzCoDQr2LgEEY/VlEAKYAmL9GoWZ5T0Ux8T7CXBreI=;
        b=ky5q1DgT0BWWzgrWwPvXxg7J0OsBrp6g8vCPmO3qCniLrPP7MSPLf+1qZEcG37AfK/
         em08MNBL10Tl/2GGlYzKnutEsyRYZPfGj3i1Dfm0RXqKEJMfDnt59ZrAMTdf9SuZayFl
         ZtwbldNqfLVbKmwX1NHyC803IRPIxTZQ69S0olfm6AqJwn0+hmjI5wtErPrMqhb36FqU
         L24dHCy3yiyqHU7z/NZiHdhDfJ4Stxc8KU9I3qjwgN0BE8+gO1F4Yw9g9suKsQrGCUTL
         db4oCNjvvJ/zq3DszauxdYDO4R0QCOaEk6WsCCTzaTT0wJwr26GC526s1B9H+DtECU6e
         XdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=WkzCoDQr2LgEEY/VlEAKYAmL9GoWZ5T0Ux8T7CXBreI=;
        b=BWyxWrZ1p1t74PlSTG+BlbDjV+u5ggGkTi8PvsJbxjbYbrC+J+bwHyP2cmrv6pw+Qr
         W81IqJHzO95cFXxfzeQyyUJu2PNsBYdilofzvMZVyPCuhriipAigSzm94u7A7pOqS4pG
         RxQ1QSHAQfwUkc1oGZrCWDmVgeS1D8UvzKhxx2E6XM6ZaW4yGIpnbWDXvtq6SvGV0Bu4
         wqlrn0g76DLi1lSdK7eD/F6uJFf+TNluSp/bHOylycTZQ1UUtM1vljSYQZqQP7+QxvaA
         M4DncB+pRBdwVVLN/nW9gUGzhGTjiYtz0BPP5H+ZG4tA6X+w/XNUQU2WH1R4IMqhOPOy
         JYTw==
X-Gm-Message-State: ALQs6tDsEmG3vkae9UraBm2JT/jthXsiyh/y32Dg2RJDaAHBbhdMjbJu
        JkvDnBpGhq+L3FJykOeX5nHE5IwS1V2j2n6b1MI=
X-Google-Smtp-Source: AIpwx49jyll5my2GriVtLebDvaIpwBLMgHssYfaN8K8ujlJuaj//ldjMG0YrdHb83vCykbhLtL7QnY98YGCcxq5b+jE=
X-Received: by 2002:aca:4dcc:: with SMTP id a195-v6mr5931269oib.259.1524232386769;
 Fri, 20 Apr 2018 06:53:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.62.141 with HTTP; Fri, 20 Apr 2018 06:53:05 -0700 (PDT)
Reply-To: noloader@gmail.com
In-Reply-To: <20180420130346.3178914-1-arnd@arndb.de>
References: <CAK8P3a3qAoR1afmTTK1CAp1L81dzwtBL+SKj=QMqD=dBr_8oRQ@mail.gmail.com>
 <20180420130346.3178914-1-arnd@arndb.de>
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Fri, 20 Apr 2018 09:53:05 -0400
Message-ID: <CAH8yC8mnfNnG86kgjnfwiZJ0=qN+w=5PVcLcxddaJdDtYbSanA@mail.gmail.com>
Subject: Re: [PATCH] x86: ipc: fix x32 version of shmid64_ds and msqid64_ds
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, ebiederm@xmission.com,
        y2038 Mailman List <y2038@lists.linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Albert ARIBAUD <albert.aribaud@3adev.fr>,
        linux-s390@vger.kernel.org, schwidefsky@de.ibm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-mips@linux-mips.org,
        jhogan@kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Daniel Schepler <dschepler@gmail.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Adam Borowski <kilobyte@angband.pl>, tg@mirbsd.de,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        stable@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <noloader@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noloader@gmail.com
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

One comment here:

> +#if !defined(__x86_64__) || !defined(__ilp32__)
>  #include <asm-generic/msgbuf.h>
> +#else

I understand there's some progress having Clang compile the kernel.
Clang treats __ILP32__ and friends differently than GCC. I believe
ILP32 shows up just about everywhere there are 32-bit ints, longs and
pointers. You might find it on Aarch64 or you might find it on MIPS64
when using Clang.

I think that means this may be a little suspicious:

    > +#if !defined(__x86_64__) || !defined(__ilp32__)

I kind of felt LLVM was wandering away from the x32 ABI, but the LLVM
devs insisted they were within their purview. Also see
https://lists.llvm.org/pipermail/cfe-dev/2015-December/046300.html.

Sorry about the top-post. I just wanted to pick out that one piece.

Jeff

On Fri, Apr 20, 2018 at 9:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> A bugfix broke the x32 shmid64_ds and msqid64_ds data structure layout
> (as seen from user space)  a few years ago: Originally, __BITS_PER_LONG
> was defined as 64 on x32, so we did not have padding after the 64-bit
> __kernel_time_t fields, After __BITS_PER_LONG got changed to 32,
> applications would observe extra padding.
>
> In other parts of the uapi headers we seem to have a mix of those
> expecting either 32 or 64 on x32 applications, so we can't easily revert
> the path that broke these two structures.
>
> Instead, this patch decouples x32 from the other architectures and moves
> it back into arch specific headers, partially reverting the even older
> commit 73a2d096fdf2 ("x86: remove all now-duplicate header files").
>
> It's not clear whether this ever made any difference, since at least
> glibc carries its own (correct) copy of both of these header files,
> so possibly no application has ever observed the definitions here.
>
> There are other UAPI interfaces that depend on __BITS_PER_LONG and
> that might suffer from the same problem on x32, but I have not tried to
> analyse them in enough detail to be sure. If anyone still cares about x32,
> that may be a useful thing to do.
>
> Fixes: f4b4aae18288 ("x86/headers/uapi: Fix __BITS_PER_LONG value for x32 builds")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This came out of the y2038 ipc syscall series but can be applied
> and backported independently.
> ---
>  arch/x86/include/uapi/asm/msgbuf.h | 29 +++++++++++++++++++++++++++
>  arch/x86/include/uapi/asm/shmbuf.h | 40 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)
>
> diff --git a/arch/x86/include/uapi/asm/msgbuf.h b/arch/x86/include/uapi/asm/msgbuf.h
> index 809134c644a6..5f1604961e6d 100644
> --- a/arch/x86/include/uapi/asm/msgbuf.h
> +++ b/arch/x86/include/uapi/asm/msgbuf.h
> @@ -1 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef __ASM_X64_MSGBUF_H
> +#define __ASM_X64_MSGBUF_H
> +
> +#if !defined(__x86_64__) || !defined(__ilp32__)
>  #include <asm-generic/msgbuf.h>
> +#else
> +/*
> + * The msqid64_ds structure for x86 architecture with x32 ABI.
> + *
> + * On x86-32 and x86-64 we can just use the generic definition, but
> + * x32 uses the same binary layout as x86_64, which is differnet
> + * from other 32-bit architectures.
> + */
> +
> +struct msqid64_ds {
> +       struct ipc64_perm msg_perm;
> +       __kernel_time_t msg_stime;      /* last msgsnd time */
> +       __kernel_time_t msg_rtime;      /* last msgrcv time */
> +       __kernel_time_t msg_ctime;      /* last change time */
> +       __kernel_ulong_t msg_cbytes;    /* current number of bytes on queue */
> +       __kernel_ulong_t msg_qnum;      /* number of messages in queue */
> +       __kernel_ulong_t msg_qbytes;    /* max number of bytes on queue */
> +       __kernel_pid_t msg_lspid;       /* pid of last msgsnd */
> +       __kernel_pid_t msg_lrpid;       /* last receive pid */
> +       __kernel_ulong_t __unused4;
> +       __kernel_ulong_t __unused5;
> +};
> +
> +#endif /* __ASM_GENERIC_MSGBUF_H */
> diff --git a/arch/x86/include/uapi/asm/shmbuf.h b/arch/x86/include/uapi/asm/shmbuf.h
> index 83c05fc2de38..cdd7eec878fa 100644
> --- a/arch/x86/include/uapi/asm/shmbuf.h
> +++ b/arch/x86/include/uapi/asm/shmbuf.h
> @@ -1 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef __ASM_X86_SHMBUF_H
> +#define __ASM_X86_SHMBUF_H
> +
> +#if !defined(__x86_64__) || !defined(__ilp32__)
>  #include <asm-generic/shmbuf.h>
> +#else
> +/*
> + * The shmid64_ds structure for x86 architecture with x32 ABI.
> + *
> + * On x86-32 and x86-64 we can just use the generic definition, but
> + * x32 uses the same binary layout as x86_64, which is differnet
> + * from other 32-bit architectures.
> + */
> +
> +struct shmid64_ds {
> +       struct ipc64_perm       shm_perm;       /* operation perms */
> +       size_t                  shm_segsz;      /* size of segment (bytes) */
> +       __kernel_time_t         shm_atime;      /* last attach time */
> +       __kernel_time_t         shm_dtime;      /* last detach time */
> +       __kernel_time_t         shm_ctime;      /* last change time */
> +       __kernel_pid_t          shm_cpid;       /* pid of creator */
> +       __kernel_pid_t          shm_lpid;       /* pid of last operator */
> +       __kernel_ulong_t        shm_nattch;     /* no. of current attaches */
> +       __kernel_ulong_t        __unused4;
> +       __kernel_ulong_t        __unused5;
> +};
> +
> +struct shminfo64 {
> +       __kernel_ulong_t        shmmax;
> +       __kernel_ulong_t        shmmin;
> +       __kernel_ulong_t        shmmni;
> +       __kernel_ulong_t        shmseg;
> +       __kernel_ulong_t        shmall;
> +       __kernel_ulong_t        __unused1;
> +       __kernel_ulong_t        __unused2;
> +       __kernel_ulong_t        __unused3;
> +       __kernel_ulong_t        __unused4;
> +};
> +
> +#endif /* __ASM_X86_SHMBUF_H */

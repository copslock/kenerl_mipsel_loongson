Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Mar 2018 18:40:48 +0100 (CET)
Received: from mail-io0-x244.google.com ([IPv6:2607:f8b0:4001:c06::244]:37107
        "EHLO mail-io0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994683AbeCRRk3HGVGh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Mar 2018 18:40:29 +0100
Received: by mail-io0-x244.google.com with SMTP id y128so645962iod.4;
        Sun, 18 Mar 2018 10:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ayHr0tN3oKZgFNK024pG0W2SJKZoaqE2zLUHnEWV6rs=;
        b=OuM5iJ1OCx92W+d/eBUZN5JCk32IJvgqEV/uoaYHOkxhSzIgzFb1SyjPye9lSXp/so
         cBSr9GhHq2HMD6t2Unm3m29SmwBUZ0ut6QqCrqJtoNEakZTM+8io/AzeNj3vUXRrUC6k
         IiCGbYFN9SpXpvAeg3FR3Bewj5BcFhfbfj//A9k9HQ5oWqyl3XMxTzHo4GgnnGTQGJAU
         VU74/CW/PFWtLV0AmcbVvxq29Dz6ckX/k8QC8ufEclx0NV03UZeCWH6ov6FSyOdx2udU
         hWA1AC1MouUixasvOUNdJJqRtDHsrwclGrToo3Ub/X5xSDSU6yhI5Ir8MnvGzv04MZri
         UJqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ayHr0tN3oKZgFNK024pG0W2SJKZoaqE2zLUHnEWV6rs=;
        b=JkkiNBfXDTm1RoLSlNZx5LGw/vrapiJkqGJH/w2+lucD9UncFKAD3SWLgns6eISgiL
         F8rSWdmb/nFjpGr4RrGAONiarAea6l22W8b6l02U5acuHcA82hrKrnFpOT6A+qscsjiF
         XB06SDy2sR3BRGEV5lkx1RR6HsPhf4VjiSrmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ayHr0tN3oKZgFNK024pG0W2SJKZoaqE2zLUHnEWV6rs=;
        b=MSlbIir/jpfTdvBZ2gJGafxBO9pgtE9Z8Ygvji5T0Z338jO9XDnqEFEx5BGJE3IV9Z
         yYJdpFsXXGjexXDpXP7+eWFYitcdrlaVZtSfU1G1ti3Ckw6yS3xYVljMqTT7sBbjai5R
         NpzyOWshRHkHas97FiofzAAf19mGy7Y2B7lfiEyfPZzGxJkb1Qou/SiPrv6KVnLezyd+
         pZwiiyd8yvZjSFv2GRWGGpvKYPwXcmaODWdin45kAiXvgcc4SxjqgPqL+4ntM5H8jUpu
         NkcT2DhrupvtaIMzA9i5bv10Z5mAoAzRemQNezBfSvBAFiEDZnEufVUt48THxFpaLjSn
         PDPQ==
X-Gm-Message-State: AElRT7HLvOpy5iCr8zxARGSvlvwQBvnn/18rgpzVKTk3fC4JLrZDq/1R
        xGvvkrYx+5oCFFjl0/MzpyaKPlYlkfuOymjYMYo=
X-Google-Smtp-Source: AG47ELtp+ZtSjno2QRZURAtvB+Zb3P48PBlPsOnXQ9Hb40SVl30znRkU/2wGbuA6eiG6EaAT6Ioy9IQ71Bb70hko1K0=
X-Received: by 10.107.182.214 with SMTP id g205mr9683982iof.203.1521394822658;
 Sun, 18 Mar 2018 10:40:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.95.15 with HTTP; Sun, 18 Mar 2018 10:40:22 -0700 (PDT)
In-Reply-To: <20180318161056.5377-4-linux@dominikbrodowski.net>
References: <20180318161056.5377-1-linux@dominikbrodowski.net> <20180318161056.5377-4-linux@dominikbrodowski.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 18 Mar 2018 10:40:22 -0700
X-Google-Sender-Auth: cABkl9pHVqZjAOxfCbjTK6dSsQQ
Message-ID: <CA+55aFy3THY_nw7NNeUZYoGcszSDkGW-DFK0K063uFMUEO9w=g@mail.gmail.com>
Subject: Re: [RFC PATCH 3/6] fs: provide generic compat_sys_p{read,write}64() implementations
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jiri Slaby <jslaby@suse.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus971@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63033
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

Honestly, I think the patches like this are disgusting:

On Sun, Mar 18, 2018 at 9:10 AM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> +#ifdef __ARCH_WANT_COMPAT_SYS_PREADWRITE64
> +#if defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +       defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE6(pread64, unsigned int, fd, char __user *, ubuf,
> +                      u32, count, u32, padding, u32, poslo, u32, poshi)
> +#elif defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +       !defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE6(pread64, unsigned int, fd, char __user *, ubuf,
> +                      u32, count, u32, padding, u32, poshi, u32, poslo)
> +#elif !defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +       defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE5(pread64, unsigned int, fd, char __user *, ubuf,
> +                      u32, count, u32, poslo, u32, poshi)
> +#else /* no padding, big endian */
> +COMPAT_SYSCALL_DEFINE5(pread64, unsigned int, fd, char __user *, ubuf,
> +                      u32, count, u32, poshi, u32, poslo)
> +#endif
> +{
> +#ifdef CONFIG_S390
> +       if ((compat_ssize_t) count < 0)
> +               return -EINVAL;
> +#endif /* CONFIG_S390 */

and we should just keep code like this entirely architecture-dependent.

It doesn't save all that many lines:

 19 files changed, 97 insertions(+), 106 deletions(-)

and the lines it adds are an unreadable mess compared to the lines it removes.

So please keep the high/low/padding stuff in the arch wrapper, and
just make them use "do_pwrite64()" and friends instead (or
"kern_pwrite64()", or whatever we ended up using as the kernel naming
for in-kernel system call wrappers).

                Linus

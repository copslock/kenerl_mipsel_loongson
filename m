Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Mar 2018 19:21:39 +0100 (CET)
Received: from mail-it0-x236.google.com ([IPv6:2607:f8b0:4001:c0b::236]:35462
        "EHLO mail-it0-x236.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994685AbeCRSVdKFEIh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Mar 2018 19:21:33 +0100
Received: by mail-it0-x236.google.com with SMTP id v194-v6so7652091itb.0;
        Sun, 18 Mar 2018 11:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=av9ATbX5S3ocfyFPt9BAvkcZZFTXguC/FZR6vo5WPY8=;
        b=R+bObYMyOWgbJO7BFDSC68fEeZWAKMF6kHQ9riBMtHJJ9DGKEavLasny4aqWvnJKAJ
         sQFQ9zG6sHe35q4jsTc6zQwOagTjC5tFO/rY2WQR/HyCvozX8NcQndyyTx/0R/bHGV7X
         uUi2f0xiBbxqKSp3pZU2ZnG+/6ayljFE+j6jzz5J0+vVc8glCHqd4bdVkuNvCUSKhDDT
         7wMc1A2+rxVNOJuDgsOZc7JVxcWVtalcEDBlph2bUFfdfsniT1wcjCON/JCpDgPs3wnc
         tj8Uu3l/MslpHhHhv+/5rP9Y8+PYo2koppxomeyon/5EUeuL8IcRoDXYLs8YT5lMgDoM
         x4Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=av9ATbX5S3ocfyFPt9BAvkcZZFTXguC/FZR6vo5WPY8=;
        b=JK9oOKtnqlNkjX/QVj4gnKDzkHe1fEtvw9Xkodex7694OEFOaU5Q6eB+8qpE2IB+Hb
         a5okR1eehXEnqfRttqGir64K9p4qrhOfPbFpNZt96QOc9ykUWUNSYMEAdkzFbmGGUV+v
         y0eqnf08aQhh9zrjl+52TI24Qhcbv15Ybtd/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=av9ATbX5S3ocfyFPt9BAvkcZZFTXguC/FZR6vo5WPY8=;
        b=rtC3MyoxmLadaVOrO8uuA3mIyub9ppBoKITkYXUuqoo1PTvEfWr2F9PVM64VYQZGNY
         xbKkHea342HsoJ1TlrQLJISr+ACcznu+MFVWoquMlUESGFjC9kg3Vdb6ACOOWvpyGmgw
         hIlNC9tzClA3V/YqfoXw8g9NZ90SPNkhrwWStAh7axtFIo5Xff1IXtDNe7ZGnfXaFPFR
         jBGWAdIuxWhBuQlp+dfti2dgI978VKcaFaM9iOoMPALkVHUMcwYHg6NRv0xCEhpAcW6L
         eDhNwcrAoZ4yDNZ68tZH1L8ASPY3qShRPS/lnMvlZDY5jQBOdejRGrOT7jVqjgDnRdbe
         RAQg==
X-Gm-Message-State: AElRT7Fdphz6gYf2Kn3Bksv0WUvR+pryJn5oeYANsU1Fqt8BR4MYRWya
        z26LiNxMZn71r1/yzPKtTFlwbBAsckxmfZE9dXk=
X-Google-Smtp-Source: AG47ELtoXk0KkEXxkGDw8FdlmJIVlOK0jvwfyXRan5W5W+Gei0PL4fmvVJLPvcl7WgCTLVpq80RO8vxMx3ya5JZCMOA=
X-Received: by 2002:a24:9985:: with SMTP id a127-v6mr3809395ite.108.1521397286690;
 Sun, 18 Mar 2018 11:21:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.95.15 with HTTP; Sun, 18 Mar 2018 11:21:26 -0700 (PDT)
In-Reply-To: <20180318161056.5377-3-linux@dominikbrodowski.net>
References: <20180318161056.5377-1-linux@dominikbrodowski.net> <20180318161056.5377-3-linux@dominikbrodowski.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 18 Mar 2018 11:21:26 -0700
X-Google-Sender-Auth: Z-ypqIZ2YXmTq0IEfnREj8CbBnc
Message-ID: <CA+55aFz+WARfpwuWmr+-F1tDVzoyWpN9naZJfTq25Q2WT=9CyQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] fs: provide a generic compat_sys_truncate64() implementation
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
X-archive-position: 63038
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

On Sun, Mar 18, 2018 at 9:10 AM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> +#ifdef __ARCH_WANT_COMPAT_SYS_TRUNCATE64
> +#if defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +       defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE4(truncate64, const char __user *, filename, u32 padding,
> +                      unsigned int, offset_low, unsigned int, offset_high)
> +#elif defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +       !defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE4(truncate64, const char __user *, filename, u32 padding,
> +                      unsigned int, offset_high, unsigned int, offset_low)
> +#elif !defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +       defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE3(truncate64, const char __user *, filename,
> +                      unsigned int, offset_low, unsigned int, offset_high)
> +#else /* no padding, big endian */
> +COMPAT_SYSCALL_DEFINE3(truncate64, const char __user *, filename,
> +                      unsigned int, offset_high, unsigned int, offset_low)
> +#endif
> +{
> +#ifdef CONFIG_SPARC
> +       if ((int) offset_high < 0)
> +               return -EINVAL;
> +#endif
> +       return do_sys_truncate(filename,
> +                              ((loff_t) offset_high << 32) | offset_low);
> +}
> +#endif /* __ARCH_WANT_COMPAT_SYS_TRUNCATE64 */

This really screams out for a sparc-specific wrapper, or maybe that
#ifdef CONFIG_SPARC should just happen for everybody.

But regardless, code like the above is completely unacceptable.

And yes, it also shows that my suggested alternative doesn't really
work, because of the way the padding changes the number of arguments,
giving that whole COMPAT_SYSCALL_DEFINE 3-vs-4 argument version.

So I think just making it be arch-specific is the right thing.

Alternatively, the COMPAT_SYSCALL_DEFINE() macro could be made smarter
and do self-counting. There are generally tricks to count macro
arguments, particularly when you know that they are limited. Things
like

    #define NARG(...) __NARG(__VA_ARGS__##, 6,5,4,3,2,1)
    #define _NARG(a,b,c,d,e,f,...) f

or something (I may have screwed that up, you get the idea).

                Linus

Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Mar 2018 19:06:57 +0100 (CET)
Received: from mail-it0-x243.google.com ([IPv6:2607:f8b0:4001:c0b::243]:35729
        "EHLO mail-it0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994685AbeCRSGujddih (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Mar 2018 19:06:50 +0100
Received: by mail-it0-x243.google.com with SMTP id v194-v6so7627910itb.0;
        Sun, 18 Mar 2018 11:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=R2mdIDiX0O2X6zQ+Um6PJojTvpx92Iclh0EKvgLNrzU=;
        b=SDtniej/3DA7LpMnIKoa2mQ8ZKUaGmXYhpliZ+vFBILa/jNXsUqX6GvEUSsuW2ya89
         //tHLhKU/IGkWP9/SkPeOh3WuQLDFqrwADSLX/oixD/4PppDsTuINWdway3fPgbtaIaR
         o+sb1XyKWTnwwjmvbHdAnaRmiVmgKw21sj4yiBGC+pq1rIghzXkPOJHQ4cx3NNW8QQAp
         PWEhv1BGJrIx1akJQtF7FawI/lfQex7kJS40GY6Due3bTZH69yDd/Yn4pWStuftY4Oo/
         K6n8/Mx+8yrWbpcQ9AUUJIEUI5dUB2WHn3vkK/tmDYGISjkW4IsrAHgvH0vJ0WS3wDNb
         SHMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=R2mdIDiX0O2X6zQ+Um6PJojTvpx92Iclh0EKvgLNrzU=;
        b=Rol8KollVeYUA390Tmo6JcYiDqqKI4NB3IRSsPIkWAm+dKzKS9G19DGD9Mh+X8nk0R
         SYwj2eD1oGDyHqt101xlleWlzTHPO44DBWN89suQVs+Za23sRZ8TD4Hdiox7fD0ym1XJ
         xhXY8TrQ85lw1O/Nwatdr2h7qjhWNkyEdvBVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=R2mdIDiX0O2X6zQ+Um6PJojTvpx92Iclh0EKvgLNrzU=;
        b=f0KVON5sE2ag/I3fOtmJWARMuNgD2Ay/SVjSKxtOqWpaVIxOmv4RxM/EOVQmDMjuZV
         coAol2x7enf1umxxsr+rh/+IYdM/gnUaWxB6zjdU6UPJwb9h1iLcK+T5NHVNWIii8o5/
         bC10nt5hG/3KVkbK0dJGBgA1TSoQZ+cHOLzkOvqu4JeBPQVY7AtVLVSje/Bg4jegsa0W
         PIZvr22krSz6eeOjtEP54uyUplHhNm6SVMTXrD8mmK/qGFG9W+9pf64aIbaXz/rwCyyl
         GhujHtfpNDIn8UnSv4lahgEvur7DLs6HfRC4sDaWqQF8pJWyekbQwidbXtG6s3ojyv0V
         qmrw==
X-Gm-Message-State: AElRT7E62/bkE4HwxrVTw90voJTJUjfhsUvTSUOLpMDujc7S0UJdzmYG
        AmK7lUuQopgY9Ud13zanRWnJtsL0EsF1lwDEVSI=
X-Google-Smtp-Source: AG47ELuZHdidbGn0SLWpOMPLUurEa5c6zUsYIag66hep7FE/04yBgPOTDFe9hX0HfJV/1VJT74Dvrne/vXs5h5n4U44=
X-Received: by 2002:a24:9985:: with SMTP id a127-v6mr3780976ite.108.1521396403072;
 Sun, 18 Mar 2018 11:06:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.95.15 with HTTP; Sun, 18 Mar 2018 11:06:42 -0700 (PDT)
In-Reply-To: <20180318174014.GR30522@ZenIV.linux.org.uk>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-5-linux@dominikbrodowski.net> <20180318174014.GR30522@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 18 Mar 2018 11:06:42 -0700
X-Google-Sender-Auth: MuT1J1o-KOERyus1oFemTYP053A
Message-ID: <CA+55aFwuZCpAZRpsTGiUmG065ZHHpj+03_NeWiy-OGkMGw7e3g@mail.gmail.com>
Subject: Re: [RFC PATCH 4/6] mm: provide generic compat_sys_readahead() implementation
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
X-archive-position: 63036
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

On Sun, Mar 18, 2018 at 10:40 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> *UGH*
>
> static inline compat_to_u64(u32 w0, u32 w1)
> {
> #ifdef __BIG_ENDIAN
>         return ((u64)w0 << 32) | w1;
> #else
>         return ((u64)w1 << 32) | w0;
> #endif
> }
>
> in compat.h, then this turns into
>
> #ifdef __ARCH_WANT_COMPAT_SYS_WITH_PADDING
> COMPAT_SYSCALL_DEFINE5(readahead, int, fd, unsigned int, padding,
>                        u32, off0, u32 off1,
>                        compat_size_t, count)
> #else
> COMPAT_SYSCALL_DEFINE4(readahead, int, fd,
>                        u32, off0, u32 off1,
>                        compat_size_t, count)
> #endif

No. This is still too ugly to live.

What *may* be acceptable is if architectures defined something like this:

x86:

    /* Little endian registers - low bits first, no padding for odd
register numbers necessary */
    #define COMPAT_ARG_64BIT(x) unsigned int x##_lo, unsigned int x##_hi
    #define COMPAT_ARG_64BIT_ODD(x) COMPAT_ARG_64BIT(x)

ppc BE:

    /* Big-endian registers - high bits first, odd argument pairs
padded up to the next even register */
    #define COMPAT_ARG_64BIT(x) unsigned int x##_hi, unsigned int x##_lo
    #define COMPAT_ARG_64BIT_ODD(x) unsigned int  x##_padding,
COMPAT_ARG_64BIT(x)

and then we can do

  COMPAT_SYSCALL_DEFINE5(readahead, int, fd,
COMPAT_ARG_64BIT_ODD(off), compat_size_t, count)
  {
      return do_readahead(fd, off_lo + ((u64)off_hi << 64), count);
  }

which at least looks reasonably legible, and has *zero* ifdef's anywhere.

I do *not* want to see those disgusting __ARCH_WANT_LE_COMPAT_SYS
things and crazy #ifdef's in code.

So either let the architectures do their own trivial wrappers
entirely, or do something clean like the above. Do *not* do
#ifdef'fery at the system call declaration time.

Also note that the "ODD" arguments may not be the ones that need
padding. I could easily see a system call argument numbering scheme
like

   r0 - system call number
   r1 - first argument
   r2 - second argument
   ...

and then it's the *EVEN* 64-bit arguments that would need the padding
(because they are actually odd in the register numbers). The above
COMPAT_ARG_64BIT[_ODD]() model allows for that too.

Of course, if some architecture then has some other arbitrary rules (I
could see register pairing rules that aren't the usual "even register"
ones), then such an architecture would really have to have its own
wrapper, but the above at least would handle the simple cases, and
doesn't look disgusting to use.

                   Linus

PS. It is possible that we should then add a

   #define COMPAT_ARG_64BIT_VAL(x) (x_##lo + ((u64)x_##hi << 32))

and then do

  COMPAT_SYSCALL_DEFINE5(readahead, int, fd,
COMPAT_ARG_64BIT_ODD(off), compat_size_t, count)
  {
      return do_readahead(fd, COMPAT_ARG_64BIT_VAL(off), count);
  }

because then we could perhaps generate the *non*compat system calls
this way too, just using

    #define COMPAT_ARG_64BIT(x) unsigned long x
    #define COMPAT_ARG_64BIT_VAL(x) (x)

instead (there might also be a "compat" mode that actually has access
to 64-bit registers, like x32 does, but I suspect it would have other
issues).

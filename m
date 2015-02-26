Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2015 08:47:51 +0100 (CET)
Received: from mail-ig0-f178.google.com ([209.85.213.178]:63810 "EHLO
        mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007218AbbBZHrtt3QAN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Feb 2015 08:47:49 +0100
Received: by mail-ig0-f178.google.com with SMTP id hl2so12536377igb.5
        for <linux-mips@linux-mips.org>; Wed, 25 Feb 2015 23:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XzTT1BqGp+KnErwV7YOUAhUnhLbkGYfV647Ya6zz2xY=;
        b=HK/bb8u/yBuKGDOfHfcY3+J0lHKjZOXe2RsaJbvvivA6WziP9y0W5loGrALGXqG9Q4
         LJXDP7+PNc0Ab6eKgnoKFUoFg8uDdy+7/5r6MjvIzaOyvflh4L2/MBm3gzV6xsxtA67p
         QWmluMME5wE+7UTMwT4T/v3YnfoIs07n43n9CyUwOb3Ofs02j6eRI87uipPg6GmCpQhG
         0UYE1Ju9FAmdRFJ5hi6Cmn8xPBll/2/8v96M//r/pZblAYg6AROnLU75Nech3y9Orc8H
         DV8Qr3d4sE7la647qYUrpLdYUMEctKdjtFwalcc1U/LBomRtkrgU+NrIAAhW038A/RUu
         CGIg==
MIME-Version: 1.0
X-Received: by 10.42.29.133 with SMTP id r5mr8128712icc.17.1424936864251; Wed,
 25 Feb 2015 23:47:44 -0800 (PST)
Received: by 10.64.176.238 with HTTP; Wed, 25 Feb 2015 23:47:44 -0800 (PST)
In-Reply-To: <20150219194617.GT544@vapier>
References: <20150219194617.GT544@vapier>
Date:   Thu, 26 Feb 2015 15:47:44 +0800
Message-ID: <CAAhV-H5+kQm_qAz7DLV4Rk9EqB4xJjmu1NV7kKd46aneKFZO-A@mail.gmail.com>
Subject: Re: custom kernel on lemote-3a-itx (Loongson-3A) crashes in userspace
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Mike Frysinger <vapier@gentoo.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

Please try the toolchain here:
http://dev.lemote.com/files/resource/toolchain/cross-compile/

On Fri, Feb 20, 2015 at 3:46 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> i've got a lemote desktop with a quad core Loongson-3A in it:
> http://www.lemote.com/products/computer/fulong/348.html
>
> i'm trying to build my own kernel for it, but userspace just crashes on me :(.
>
> the current kernel is a precompiled one from lemote themselves, and things are
> compiling/running fine with it.  but it's a bit stale and missing features i
> want (like namespaces & seccomp).
> $ uname -a
> Linux lemote 3.5.0-9.lemote #1465 SMP PREEMPT Mon Aug 26 14:23:38 CST 2013 mips64 ICT Loongson-3A V0.5 FPU V0.1 lemote-3a-itx-a1101 GNU/Linux
>
> the userland is Gentoo.  it's an o32/n32/n64 multilib with n32 as the default.
> most (if not all) of userland has been built with gcc-4.8.2 using
> "-O2 -march=mips64 -mplt -pipe".
> $ file /bin/bash
> /bin/bash: ELF 32-bit LSB executable, MIPS, N32 MIPS64 version 1 (SYSV), dynamically linked, interpreter /lib32/ld.so.1, for GNU/Linux 2.6.16, stripped
> $ /lib/libc.so.6
> GNU C Library (Gentoo 2.19-r1 p3) stable release version 2.19, by Roland McGrath et al.
> Copyright (C) 2014 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.
> There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
> PARTICULAR PURPOSE.
> Compiled by GNU CC version 4.8.2.
> Compiled on a Linux 3.14.0 system on 2014-09-09.
> Available extensions:
>         C stubs add-on version 2.1.2
>         crypt add-on version 2.1 by Michael Glad and others
>         GNU Libidn by Simon Josefsson
>         Native POSIX Threads Library by Ulrich Drepper et al
>         BIND-8.2.3-T5B
> libc ABIs: MIPS_PLT UNIQUE
> For bug reporting instructions, please see:
> <http://bugs.gentoo.org/>.
>
> i first tried lemote's sources, which i grabbed their git tree from
> dev.lemote.com.  i started at the same git tag (3.5.0-9.lemote) and used the
> same .config as their precompiled kernel.  once it booted, most userland progs
> would crash.  some would survive (like simple ones), but most would crash.
>
> i moved up to vanilla linux-3.18, starting with the same config, but got the
> same behavior.
>
> i tried booting with the nofpu command line, but that didn't help.  i also
> tried manually setting cpu_has_fpu to 0 in
> arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h, but that didn't
> help.
>
> i tried gcc-4.7.4, gcc-4.8.4, and gcc-4.9.2, but none of that helped.
>
> i enabled the debugging in arch/mips/mm/fault.c, and you can see the attached
> dmesg with some of the example crashes.  when i looked at proc maps from other
> binaries, it looks like those crashing addresses are close to real ones, but
> slightly off (like a byte shift?).  i'm just guessing since i'm not actually
> looking at the crashing app itself ... just assuming the maps are largely stable
> (since they seem to be in other ones).
>
> i tried to use strace/gdb to narrow things down, but those both crash early, so
> couldn't get anywhere :).
>
> any pointers ?
> -mike

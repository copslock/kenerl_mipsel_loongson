Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Aug 2013 14:07:44 +0200 (CEST)
Received: from mail-pd0-f172.google.com ([209.85.192.172]:50040 "EHLO
        mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6832092Ab3HUMHjvci3l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Aug 2013 14:07:39 +0200
Received: by mail-pd0-f172.google.com with SMTP id z10so363508pdj.31
        for <multiple recipients>; Wed, 21 Aug 2013 05:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=05sirAunjVadsVL6jKj/5OceQ6kiGRtEJ+BWq8N1sv8=;
        b=RsSvlIev6xuqbGGyOb4P6l0x442tPnbcBiZJFKZzyHghrRspaWgWAMZMJJfo4/l1Nq
         X9eqRgEo7FWxHgRfm1kR+HynuVbRt+Yy0OeUox+Xox6xqYU1wiUkVpBvqtflpQvA8TOn
         JLPsU9HkM7q9ar7VYYqtXINNS2wCy5oFODDxEbygb66y3fVqJmndzOCUj0Tpi/Y+6Xhn
         C1EgmbU1XxtSNMq8OthNb222hG7nOdtAxCB9eZgoJZ7QqPe+Y/eC14jxoeo/NvVM4hJX
         PvNPMXG4XFXE5dNVvilsz76p07XtLWE5JlPRXfpgzboO+vdQEzQWP7gQXqPDu3Q4Kd3f
         6hUw==
MIME-Version: 1.0
X-Received: by 10.68.164.1 with SMTP id ym1mr7566840pbb.33.1377086853096; Wed,
 21 Aug 2013 05:07:33 -0700 (PDT)
Received: by 10.70.18.229 with HTTP; Wed, 21 Aug 2013 05:07:33 -0700 (PDT)
In-Reply-To: <1377073172-3662-1-git-send-email-richard@nod.at>
References: <1377073172-3662-1-git-send-email-richard@nod.at>
Date:   Wed, 21 Aug 2013 14:07:33 +0200
X-Google-Sender-Auth: rZlOwrYgrqfYnchIhDuMmQKgwG0
Message-ID: <CAMuHMdWk-EPTNmPB1O1+F7YVQLjhQsFJznYwA3t6UCGUU1T9PQ@mail.gmail.com>
Subject: Re: [RFC] Get rid of SUBARCH
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        Michal Marek <mmarek@suse.cz>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Jeff Dike <jdike@addtoit.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37619
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Wed, Aug 21, 2013 at 10:19 AM, Richard Weinberger <richard@nod.at> wrote:
> This series is an attempt to remove the SUBARCH make parameter.
> It as introduced at the times of Linux 2.5 for UML to tell the UML
> build system what the real architecture is.
>
> But we actually don't need SUBARCH, we can store this information
> in the .config file.

Haha, now you have OS_ARCH (shouldn't that be called HOST_ARCH?) instead,
which is available only for UM?

> The series touches also m68k, sh, mips and unicore32.
> These architectures magically select a cross compiler if ARCH != SUBARCH.
> Do really need that behavior?

This does remove functionality.
It allows to build a kernel using e.g. "make ARCH=m68k".

Perhaps this can be moved to generic code? Most (not all!) cross-toolchains
are called $ARCH-{unknown-,}linux{,-gnu}.
Exceptions are e.g. am33_2.0-linux and bfin-uclinux.

> [PATCH 1/8] um: Create defconfigs for i386 and x86_64
> [PATCH 3/8] um: Remove old defconfig

Why not merge these two, so git copy/rename detection will show only the real
changes?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

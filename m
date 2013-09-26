Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Sep 2013 16:36:52 +0200 (CEST)
Received: from mail-ie0-f181.google.com ([209.85.223.181]:49723 "EHLO
        mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822195Ab3IZOgsEazcg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Sep 2013 16:36:48 +0200
Received: by mail-ie0-f181.google.com with SMTP id tp5so1467865ieb.12
        for <multiple recipients>; Thu, 26 Sep 2013 07:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QutY6xpUOUq7IPp/lIvqW0uEwMswNSa919tbWPZI2qs=;
        b=rXff0JGCubEGI9rFP1MNm1KAzR+1tuDNc4hK2YRdtqIWyjLwSmB8W3wOkn3UtY7YFS
         UtDF3s+QGwWJeq/9OsdD/QFpucXwzGb3yvLaW0dLHzUCyMncfZhG3swpUz5XFBXqhOSr
         24Mkpng8I1v39Olwt3FF3PoGrlOjwVeWjXCLovyfR0uDvoLCjDB/Etznkw13bao2x3g+
         eJitPE9yb3UTkq8lCk19122FcbFEuG25pQvk8ac32uismkZjlHPLym74IICMNA3qA6Qv
         8sEJMVJ+Zthbi3ANpvwDcF0OewzXd81JeEGVTX1r7yR5TmpjaYpP1WHg6l3SEBksyUVb
         PB0w==
X-Received: by 10.43.149.137 with SMTP id kk9mr297059icc.109.1380206201323;
 Thu, 26 Sep 2013 07:36:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.73.36 with HTTP; Thu, 26 Sep 2013 07:36:01 -0700 (PDT)
In-Reply-To: <524443AC.3040409@nod.at>
References: <1377073172-3662-1-git-send-email-richard@nod.at>
 <1377073172-3662-3-git-send-email-richard@nod.at> <CALkWK0kCrQ9hPABD_XQ9QFG-vByP+xZWZs+RkVK77+cX7Odz7g@mail.gmail.com>
 <52441025.9030308@nod.at> <CALkWK0k5neR50h+AWEF5AgnpbgWMitZUnbv_caVzt6HiUA6mXg@mail.gmail.com>
 <52441407.9010603@nod.at> <CALkWK0=FG4COEjv5+mu1JRiiFQ2k6vop1mhFPmAT4bjtYeK6nA@mail.gmail.com>
 <52442108.1020304@nod.at> <CALkWK0nm=9n7DiV0MaGKVLMs=vxAiiQUx=OFuOg-DinkdMej5A@mail.gmail.com>
 <CALkWK0ndMtyQxE0uK4H-Ly6oy+tRn-SFc=_1WoC2QAp2uy0dtw@mail.gmail.com>
 <CAMuHMdU3LdDhbp_AKjD7b8Wytbqfp29DrPwTdtwQa2hUNdcy3Q@mail.gmail.com> <524443AC.3040409@nod.at>
From:   Ramkumar Ramachandra <artagnon@gmail.com>
Date:   Thu, 26 Sep 2013 20:06:01 +0530
Message-ID: <CALkWK0kcd03t9W4O24wiVBQ8SZQ8ZcrbvQaUkcCm+y5n=d1wPw@mail.gmail.com>
Subject: Re: [PATCH 2/8] um: Do not use SUBARCH
To:     Richard Weinberger <richard@nod.at>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
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
        LKML <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Content-Type: text/plain; charset=UTF-8
Return-Path: <artagnon@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: artagnon@gmail.com
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

Richard Weinberger wrote:
>> Sorry for chiming in, but... what about cross compiling?
>> SUBARCH=x86 should give you a 32-bit ia32 kernel, right?
>
> Correct.
> Users expect from SUBARCH=x86 a i386 32bit UML kernel.

This is an insane expectation. This is kernel convention (it has
nothing to do with uml):

SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
 -e s/sun4u/sparc64/ \
 -e s/arm.*/arm/ -e s/sa110/arm/ \
 -e s/s390x/s390/ -e s/parisc64/parisc/ \
 -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
 -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ )

config 64BIT
bool "64-bit kernel" if ARCH = "x86"
default ARCH != "i386"
---help---
 Say yes to build a 64-bit kernel - formerly known as x86_64
 Say no to build a 32-bit kernel - formerly known as i386

If you want to stand on your head and demand that all these
conventions be changed against all reason, I have nothing further to
say.

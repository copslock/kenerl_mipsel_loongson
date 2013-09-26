Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Sep 2013 15:58:19 +0200 (CEST)
Received: from mail-ie0-f169.google.com ([209.85.223.169]:59386 "EHLO
        mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822345Ab3IZN6Nsazbw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Sep 2013 15:58:13 +0200
Received: by mail-ie0-f169.google.com with SMTP id tp5so1417784ieb.0
        for <multiple recipients>; Thu, 26 Sep 2013 06:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aM4LSCcqtsnDrgsKlcg79LWBS6xCvRjN0ByoxaJ6X7E=;
        b=ojfeoVbiKDFGBZ5s/JQ3RbfDIbqijT7ugRWBLB6GuPg7yWl08T1gUI+E9d+9leoxF4
         HKv17mda7WJ+0b+iInsRB67XoayXjLdcKL4/kfmBx79jzaIYD9zIGxdBzB58G/rSXciv
         SKYu2Yi1HOU0Wc0lcBggVj+8Y+UZFD9Q5ThIw76vBVF4XGoo04j6DXkaxwc4z4/nS1RH
         9zX34+pZOXda89WoMN+hnGfbifEptsypcIPc/TSioq+H18L+ZYeunCYP1GTcsfFlg8i0
         0YhiiAmOIdHUCAqR5sQMpXz/0blyr0NW3eeTHuOuLEDkreU/aD4TenCterVfGx1G1/jX
         U+Og==
X-Received: by 10.42.37.202 with SMTP id z10mr1147451icd.77.1380203887365;
 Thu, 26 Sep 2013 06:58:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.73.36 with HTTP; Thu, 26 Sep 2013 06:57:27 -0700 (PDT)
In-Reply-To: <CAMuHMdU3LdDhbp_AKjD7b8Wytbqfp29DrPwTdtwQa2hUNdcy3Q@mail.gmail.com>
References: <1377073172-3662-1-git-send-email-richard@nod.at>
 <1377073172-3662-3-git-send-email-richard@nod.at> <CALkWK0kCrQ9hPABD_XQ9QFG-vByP+xZWZs+RkVK77+cX7Odz7g@mail.gmail.com>
 <52441025.9030308@nod.at> <CALkWK0k5neR50h+AWEF5AgnpbgWMitZUnbv_caVzt6HiUA6mXg@mail.gmail.com>
 <52441407.9010603@nod.at> <CALkWK0=FG4COEjv5+mu1JRiiFQ2k6vop1mhFPmAT4bjtYeK6nA@mail.gmail.com>
 <52442108.1020304@nod.at> <CALkWK0nm=9n7DiV0MaGKVLMs=vxAiiQUx=OFuOg-DinkdMej5A@mail.gmail.com>
 <CALkWK0ndMtyQxE0uK4H-Ly6oy+tRn-SFc=_1WoC2QAp2uy0dtw@mail.gmail.com> <CAMuHMdU3LdDhbp_AKjD7b8Wytbqfp29DrPwTdtwQa2hUNdcy3Q@mail.gmail.com>
From:   Ramkumar Ramachandra <artagnon@gmail.com>
Date:   Thu, 26 Sep 2013 19:27:27 +0530
Message-ID: <CALkWK0=6ThJtdu_tqqQFisJSFGE=bfsXAzEo+Yys7wjQS_eYCw@mail.gmail.com>
Subject: Re: [PATCH 2/8] um: Do not use SUBARCH
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Richard Weinberger <richard@nod.at>,
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
X-archive-position: 37993
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

Geert Uytterhoeven wrote:
> Sorry for chiming in, but... what about cross compiling?
> SUBARCH=x86 should give you a 32-bit ia32 kernel, right?

User-Mode Linux only supports two host architectures (called $SUBARCH)
at the moment: i386 and x86_64. If you leave out the $SUBARCH on
either an i386 or x86_64 machine, my patch will automatically pick the
$(uname -m) architecture to build with. To cross-compile, specify the
$SUBARCH explicitly.

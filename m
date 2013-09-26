Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Sep 2013 18:07:50 +0200 (CEST)
Received: from mail-ie0-f178.google.com ([209.85.223.178]:53019 "EHLO
        mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819473Ab3IZQHndynn0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Sep 2013 18:07:43 +0200
Received: by mail-ie0-f178.google.com with SMTP id to1so1648234ieb.9
        for <multiple recipients>; Thu, 26 Sep 2013 09:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cILoH0dy0CXm07UPW1a3CMztF9uoUUd0vj9A2gCWMA8=;
        b=Q1d3HKCYRJmh8b97fUY45aCMdkhmlDbDX5/lziddjHZ76B0zRzCtb/kW0orkL+0ing
         zSrqsoroG/NiDRFKWYRXGvcvUezhNMhpae4e2F03fC7BNPxamcL0QJRuPSMSbweBWHbV
         CdUGTU/rCIaNc1zkYg9ea8DH/gr1Z1kR310PaEzM3CC05V6byeXggGybBdKdZOR0Ap8w
         HlQ931zfs3bnWachNJy2LlquYz9ZB4QK+0iRKb/BVINtSM3okWARW/jemIpoOBy3cz3B
         34/JASVU2D68M/Y0oDVJ02kHBZ2YsD5Er+L4KJl4olMcHWlnog9635AMzn3WxiH32aFh
         BA6g==
X-Received: by 10.42.49.134 with SMTP id w6mr1845145icf.65.1380211655075; Thu,
 26 Sep 2013 09:07:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.73.36 with HTTP; Thu, 26 Sep 2013 09:06:54 -0700 (PDT)
In-Reply-To: <52444CED.40401@nod.at>
References: <1377073172-3662-1-git-send-email-richard@nod.at>
 <1377073172-3662-3-git-send-email-richard@nod.at> <CALkWK0kCrQ9hPABD_XQ9QFG-vByP+xZWZs+RkVK77+cX7Odz7g@mail.gmail.com>
 <52441025.9030308@nod.at> <CALkWK0k5neR50h+AWEF5AgnpbgWMitZUnbv_caVzt6HiUA6mXg@mail.gmail.com>
 <52441407.9010603@nod.at> <CALkWK0=FG4COEjv5+mu1JRiiFQ2k6vop1mhFPmAT4bjtYeK6nA@mail.gmail.com>
 <52442108.1020304@nod.at> <CALkWK0nm=9n7DiV0MaGKVLMs=vxAiiQUx=OFuOg-DinkdMej5A@mail.gmail.com>
 <CALkWK0ndMtyQxE0uK4H-Ly6oy+tRn-SFc=_1WoC2QAp2uy0dtw@mail.gmail.com>
 <CAMuHMdU3LdDhbp_AKjD7b8Wytbqfp29DrPwTdtwQa2hUNdcy3Q@mail.gmail.com>
 <524443AC.3040409@nod.at> <CALkWK0kcd03t9W4O24wiVBQ8SZQ8ZcrbvQaUkcCm+y5n=d1wPw@mail.gmail.com>
 <52444CED.40401@nod.at>
From:   Ramkumar Ramachandra <artagnon@gmail.com>
Date:   Thu, 26 Sep 2013 21:36:54 +0530
Message-ID: <CALkWK0=u8CdtmbaOtA5=jxuWsei2ZQhxDwSsnhAR=ZRBNyoH6Q@mail.gmail.com>
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
X-archive-position: 37998
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
> And, of course, this makes your patch valid.
> Can you also please ensure that your new defconfigs are minimal?

Yeah, it's close to a minimal configuration for the 3.10 kernel
(latest at the time of patch submission). I was aiming to minimize the
diff between the current defconfig and the two new defconfigs in
configs/. The slim diffstat does the talking:

 arch/um/Kconfig.common                          |   5 -
 arch/um/Makefile                                |  11 ++
 arch/um/{defconfig => configs/i386_defconfig}   | 209 +++++++++++++-------
 arch/um/{defconfig => configs/x86_64_defconfig} | 250 +++++++++++++++---------
 arch/x86/um/Kconfig                             |   5 +
 5 files changed, 306 insertions(+), 174 deletions(-)
 copy arch/um/{defconfig => configs/i386_defconfig} (86%)
 rename arch/um/{defconfig => configs/x86_64_defconfig} (83%)

If we find some deficiencies, we can always update it. For now, please
commit these two patches.

Thanks.

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 May 2013 16:27:44 +0200 (CEST)
Received: from mail-wi0-f175.google.com ([209.85.212.175]:49410 "EHLO
        mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817318Ab3EFO1h4VtLR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 May 2013 16:27:37 +0200
Received: by mail-wi0-f175.google.com with SMTP id h11so2605280wiv.14
        for <multiple recipients>; Mon, 06 May 2013 07:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=SVYs2UeHd0NvgFmu2Iv6ev0XSB67xfbktOlgAbgU8g0=;
        b=yjNIhV3hw19KTScRZOgHddom/V1n/vTB9kXKLyxche0ETEoWnTBZ0v6xerpokM3Ayq
         1bgJqvtb8rcgMkm73Khyjm+2hLTaGvBdp4qtCFLLjtytEmxrFDgY1neCyaXccFctQZZF
         /93/Pr2acOPs03P+UJSqhCUczNC1nHBR4Sv1nYHSp89Sex3a84kKlz0WKGwMXXQKKhvm
         VRaY/4z1Ktef2BnJ+sRAD4Tnrb+MgiYw0iFo25DBhNTUDz+tM0UAR8m0PyDvC9uyrcSJ
         1WD5IV0LGOjKvCG+kK2Uz2n/TvDtmI9Kuf3nR8Rb8OHO+Jk1jiY78glGHI8+O8Oa4ddV
         IjUw==
X-Received: by 10.180.198.49 with SMTP id iz17mr9119025wic.19.1367850452501;
 Mon, 06 May 2013 07:27:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.217.62.137 with HTTP; Mon, 6 May 2013 07:26:52 -0700 (PDT)
In-Reply-To: <1367527692-25809-1-git-send-email-ddaney.cavm@gmail.com>
References: <CA+55aFwDGyHOzu=Qh7SJOBK6QvAwAh7pMDL6LfMUE=AW_kapAw@mail.gmail.com>
 <1367527692-25809-1-git-send-email-ddaney.cavm@gmail.com>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Mon, 6 May 2013 16:26:52 +0200
Message-ID: <CAOLZvyFo8OWD4qXDCQwJOWn0Hgs35XEF2pDppSbPt3Fnb3j9GQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Enable interrupts before WAIT instruction.
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonas Gorski <jogo@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

Hi David,

On Thu, May 2, 2013 at 10:48 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> From: David Daney <david.daney@cavium.com>
>
> As noted by Thomas Gleixner:
>
>    commit cdbedc61c8 (mips: Use generic idle loop) broke MIPS as I did
>    not realize that MIPS wants to invoke the wait instructions with
>    interrupts enabled.
>
> Instead of enabling interrupts in arch_cpu_idle() as Thomas' initial
> patch does, we follow Linus' suggestion of doing it in the assembly
> code to prevent the compiler from rearranging things.
>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Reported-by: EunBong Song <eunb.song@samsung.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jonas Gorski <jogo@openwrt.org>
> ---
>
> This is only very lightly tested, we need more testing before
> declaring it the definitive fix.
>
>  arch/mips/kernel/genex.S | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Unfortunately this patch doesn't work for me, system just hangs at
certain points
during kernel startup.  Reverting the patch above fixes it, but with
this warning:

ehci-platform ehci-platform.0: irq 98, io mem 0x14020000
------------[ cut here ]------------
WARNING: at /home/mano/db1200/kernel/linux/kernel/cpu/idle.c:96
cpu_startup_entry+0x138/0x184()
CPU: 0 PID: 0 Comm: swapper Not tainted 3.9.0-db1235-10522-g6295a89 #2
Stack : 00000000 00000000 809b4462 00000046 80929c20 00000000 808c6504 00000000
          808c3428 80929b27 80929dc8 00000000 809b3c04 00000000
00000000 00000000
          80093348 807d1000 2cb41780 8011f458 00000000 00000000
808c4a28 8091fe24
          00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000
          00000000 00000000 00000000 00000000 00000000 00000000
00000000 8091fdb0
          ...
Call Trace:
[<8010a1fc>] show_stack+0x64/0x7c
[<8011f614>] warn_slowpath_common+0x70/0xa0
[<8011f700>] warn_slowpath_null+0x18/0x28
[<80150464>] cpu_startup_entry+0x138/0x184
[<809658f0>] start_kernel+0x360/0x378

---[ end trace 19427144468f733d ]---
ehci-platform ehci-platform.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found


Thanks,
      Manuel

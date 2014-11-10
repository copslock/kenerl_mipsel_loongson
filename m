Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Nov 2014 09:13:58 +0100 (CET)
Received: from mail-la0-f49.google.com ([209.85.215.49]:39845 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013170AbaKJINzXOcf1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Nov 2014 09:13:55 +0100
Received: by mail-la0-f49.google.com with SMTP id ge10so7277932lab.36
        for <multiple recipients>; Mon, 10 Nov 2014 00:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=TfYtljAxafclvPkU6FIrkQ6hsQQmJsm/YTDbNqXWEo8=;
        b=x0abNwjDoy8MKbb2c2PXh6or330SyDYNYBZw89SAKTHD1938d+moCetQU7ovNIBQzz
         g3bL2pFSTCX7O+f8Ge0gd5Z7eJol2KhuPm4L5CAc3lexN/rdbeQX7cCO/GItxu12lwwN
         euqHFfGH8gFzFK3+zpKXgfwgQ1mRGQ7wWM/oqHuANaP/5m2T4abF7WL6GO2JOvQT1won
         vCTDOhdeM/UkFS9lQZ3im+m0jl46cPRz3pHT0UzeTtezSvEPO7MxVs4LgbEGwZinLxXm
         Us0Y8hZPHHl/LUtxWV0fpgGaNoDFTA+ZlODcQx1znU9zS3mfPdXZljy2GiSb6sv1SPA0
         n52A==
MIME-Version: 1.0
X-Received: by 10.112.138.196 with SMTP id qs4mr1031584lbb.83.1415607229807;
 Mon, 10 Nov 2014 00:13:49 -0800 (PST)
Received: by 10.152.30.34 with HTTP; Mon, 10 Nov 2014 00:13:49 -0800 (PST)
In-Reply-To: <1415342669-30640-2-git-send-email-cernekee@gmail.com>
References: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
        <1415342669-30640-2-git-send-email-cernekee@gmail.com>
Date:   Mon, 10 Nov 2014 09:13:49 +0100
X-Google-Sender-Auth: 9_HLBUHKFsUX7h9xMC4VvLrdqYs
Message-ID: <CAMuHMdW+L8YbE8Z8jrtnm8xWk63sRGaFdM7TPM6MmrDg9XwHuQ@mail.gmail.com>
Subject: Re: [PATCH V4 01/14] sh: Eliminate unused irq_reg_{readl,writel} accessors
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43941
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

On Fri, Nov 7, 2014 at 7:44 AM, Kevin Cernekee <cernekee@gmail.com> wrote:
> Defining these macros way down in arch/sh/.../irq.c doesn't cause
> kernel/irq/generic-chip.c to use them.  As far as I can tell this code
> has no effect.
>
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Compared preprocessor and asm output before and after, no difference
except for line numbers, so

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

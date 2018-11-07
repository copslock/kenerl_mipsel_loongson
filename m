Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2018 10:34:10 +0100 (CET)
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41602 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992446AbeKGJcIhdgUK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Nov 2018 10:32:08 +0100
Received: by mail-vs1-f68.google.com with SMTP id t17so9039096vsc.8
        for <linux-mips@linux-mips.org>; Wed, 07 Nov 2018 01:32:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0PTAwvwE9BIbnaRX41s7Rk6bx0jnGua/fNYdJp4hVAg=;
        b=L1PZElSi6GaGkF5o35ByghUwZVizR+i7hkav+qXNXAKd7tTaERyY54DDmBzqF0x6oF
         NMtu/ildKO/YbMRoXG9D3RyzYjRW/ZEnL7GM76Ka8yuWcCdtAohPKi+0G3YH/rQMQFuz
         weirvrBuOIojdGukVvRXxaKFmSM0VYnLpONJ/saFAPwIWWqmu4Cz6qYxxLqd52JHfPp4
         uSPwrFk+HVVpRtSLOdjWsTCkw8hHN2mrwu5e/AGLi0CiXxDsncM7uNUyxg8996OOz6Eu
         d5k3UVvE3QWOaDZriEJyBgpS3G5Ty7f8oFVzRK7a+BqlrrB0BbKckG6nsdj9UbQv2O13
         VP4w==
X-Gm-Message-State: AGRZ1gLRbTrlIQbTb13hHv8AUc4BznIUoqroSpJ1Uz45t0rQuLcV9Hdu
        Zj3m9f2UOjMvbn8tWRykabMtZWhUXssTHqgdyk0=
X-Google-Smtp-Source: AJdET5cIlxhrTsu4NiaZsbghHh/c0zpB/sQVDrCnIbHSfRNZw18i7U78foYVLjptMnUg1bZv9251OQ8isow6IqOALbI=
X-Received: by 2002:a67:3885:: with SMTP id n5mr373236vsi.96.1541583127798;
 Wed, 07 Nov 2018 01:32:07 -0800 (PST)
MIME-Version: 1.0
References: <201811071730.l9oHq1qJ%fengguang.wu@intel.com> <CAMuHMdVO1kAVnsGFD6mc2Z-0RqT=w=mP4Et0iBRzhbBrF7CF3A@mail.gmail.com>
In-Reply-To: <CAMuHMdVO1kAVnsGFD6mc2Z-0RqT=w=mP4Et0iBRzhbBrF7CF3A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 7 Nov 2018 10:31:56 +0100
Message-ID: <CAMuHMdWf1Lv_pd4EmL7ORwZ9oNZDuSV_kc8CZ+QMjAfDGA7TBg@mail.gmail.com>
Subject: Re: [renesas-drivers:topic/pinctrl-rza2-v2 1/2] drivers//pinctrl/pinctrl-rza2.c:25:43:
 error: 'RZA2_NPORTS' undeclared here (not in a function); did you mean 'RZA2_NPINS'?
To:     kbuild test robot <lkp@intel.com>
Cc:     Chris Brandt <chris.brandt@renesas.com>, kbuild-all@01.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67124
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

On Wed, Nov 7, 2018 at 10:22 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Nov 7, 2018 at 10:12 AM kbuild test robot <lkp@intel.com> wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git topic/pinctrl-rza2-v2
> > head:   bb0f488fb2907f47250f7f34af60a482fd3dbfe4
> > commit: feac9e8cb1ad7b4979e4b553fcdf2d8582049227 [1/2] pinctrl: Add RZ/A2 pin and gpio controller
> > config: mips-allmodconfig (attached as .config)
> > compiler: mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout feac9e8cb1ad7b4979e4b553fcdf2d8582049227
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.2.0 make.cross ARCH=mips
> >
> > All error/warnings (new ones prefixed by >>):
> >
> >    In file included from arch/mips/include/asm/ptrace.h:19:0,
> >                     from include/linux/irq.h:24,
> >                     from include/linux/gpio/driver.h:7,
> >                     from include/asm-generic/gpio.h:13,
> >                     from include/linux/gpio.h:62,
> >                     from drivers//pinctrl/pinctrl-rza2.c:14:
> > >> arch/mips/include/uapi/asm/ptrace.h:17:13: error: expected identifier before numeric constant
> >     #define PC  64
> >                 ^
>
> Great, so MIPS defines PC, precluding it use in any driver that includes
> <asm/ptrace.h> in some way.
>
> However, it looks like <linux/gpio/driver.h> doesn't really need <linux/irq.h>.
> Will send a patch to try that...

Doesn't work, as it also includes <irqchip/chained_irq.h>, which is needed.

Anyway, drivers//pinctrl/pinctrl-rza2.c doesn't really use the enum
values it defines,
so they can be renamed (PC -> PORTC, or PORT_C).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

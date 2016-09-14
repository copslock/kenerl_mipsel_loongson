Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2016 21:25:46 +0200 (CEST)
Received: from mail-it0-f67.google.com ([209.85.214.67]:36263 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991932AbcINTZkX1Kx6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Sep 2016 21:25:40 +0200
Received: by mail-it0-f67.google.com with SMTP id n143so2448396ita.3
        for <linux-mips@linux-mips.org>; Wed, 14 Sep 2016 12:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=zHBfzpJjEXPgrMij/EuULdIrk29x/mgFMSFu6xnbdMk=;
        b=i+UuFYzrkYV5qM3v7lHu6UKJppXJ5Ve9jA3hbZ8OSjxi/8iSm7CWvCiM0JD/g8cGNv
         VxfmK2zFJjjzaJKIzYC+CpO63QEG3b0dx04W0pRLsPGU40Uw4LOulfmsH/xmHhD/mVKa
         0+Z3MT3gVu9LfZGM/DuQ2M0phiqiuHn9/xWPN7hxPu5J9QyoPdpuuwOpjyghtBSO0/Dz
         ZYh/V5/kn+JFQCTYzK+Z9hCnP1ulMTXCG0y1IMudLOhzweSI5231u8RTvgsVTYao+LED
         UYAL52UONxe+jO/t+I4yK9pV3JoW2G5pEgae8tfZ5iYZpLykf4xXaADyTJFTJ/u4xmwm
         AYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=zHBfzpJjEXPgrMij/EuULdIrk29x/mgFMSFu6xnbdMk=;
        b=f7gmJILYoXns4l7umA3jhZLiEU4+XeHlUMEWfYDM2X089uVD87PDd5Cyv/irx0VXFY
         sAwzgTj8vEr8AQmywDzZW28ZEE7cKYvXCmZQ0eo7dDhjhhR0+lf/xm54tFEIlXfuKSm8
         ZsIZHaOqhcn4YdxBj1oK+vrbHFqbyQPoe8XGtZH3+eOqnf44s4IqGYGGKwc8kx6FR7yE
         Wk/2Kkwck7UkLO8XpucxfxsD8KGEXR6NTzdy2Xx3bx08VV4TosxTYX768yZq41SEH9Iz
         bWfe5uBmnJfu5awKsMws8pUX+p3rsDe3bH1au3wm1ZwAApIxnPXgxJ5phjzoEt+O8C2Y
         ZGdQ==
X-Gm-Message-State: AE9vXwPSObojI6ZmYzm67YtBEwCumJ9DxBSbMlC73mS4Ke4Dj7u8LkHLxbNss8TpffH0Thr5sdso+j8B9RGtbQ==
X-Received: by 10.107.17.36 with SMTP id z36mr9533348ioi.1.1473881134182; Wed,
 14 Sep 2016 12:25:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.91 with HTTP; Wed, 14 Sep 2016 12:25:33 -0700 (PDT)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 14 Sep 2016 21:25:33 +0200
X-Google-Sender-Auth: ZlwqWNZ0klQmDTWNxth74hkHlJU
Message-ID: <CAMuHMdVW1eTn20=EtYcJ8hkVwohaSuH_yQXrY2MGBEvZ8fpFOg@mail.gmail.com>
Subject: genirq: Setting trigger mode 0 for irq 11 failed (txx9_irq_set_type+0x0/0xb8)
To:     Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55141
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

Hi Nemoto-san,

JFYI, with v4.8-rc6 I'm seeing

    genirq: Setting trigger mode 0 for irq 11 failed
(txx9_irq_set_type+0x0/0xb8)

on rbtx4927. This did not happen with v4.8-rc3.

No idea yet if this has any ill effects...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

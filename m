Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Apr 2016 21:06:14 +0200 (CEST)
Received: from mail-io0-f194.google.com ([209.85.223.194]:35375 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026498AbcDNTGLMrNjG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Apr 2016 21:06:11 +0200
Received: by mail-io0-f194.google.com with SMTP id u185so12294781iod.2
        for <linux-mips@linux-mips.org>; Thu, 14 Apr 2016 12:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:cc;
        bh=23OvFgGywyZgGSaXQgQemx8XfVTeYmXjXt5TabkMSBg=;
        b=Vlbg2eQG1a8AwTE483LgLthqYwyXdm0HuPlriFdIl9RRQBAKhL4QKBLeY6x+SL3vQL
         K1YMpJdUxibiu33n056A26qN4vJAISOuokvUdbgAjcpF0sy1dZF1fnNd8nqo5qHDAqOc
         zHUGBx+p3XTcdd1vnbJnwWFWctXMg4Fhubzn0wrbeEQ0RB87ff7g0WZX4DIiAh3myCkr
         1jSIN75KJRdKtRkVqAyuacCpHoXX3lmfBixT0DdVHwEBtJS3WVDEPPRDvyXG6kTYRH8B
         /95CB1XNcBw9Qfy6lwwCB6UB5YN2vJ8A3x9eeBv4voEq9kMvZGYoaAJWXPkWAgz+F/+v
         K6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:date:message-id:subject:from
         :to:cc;
        bh=23OvFgGywyZgGSaXQgQemx8XfVTeYmXjXt5TabkMSBg=;
        b=B/4QAkOxEuw2F4L1Fa7bs7YVODpzN5MKvj8VSLftU2aUKNhFB7r/pLUS/WIHUtX9gB
         bgOzaHiK8FHKFLNYdXfCnCW9g0W6R1YKEPrN6WC/rovAD/XxopEyJMFVQBuGO9XN8+4V
         yw2f0iQfxzvrkCBvbig8c7EAOmCULlYuX+rwCB39Fp4x9pEmTBWrfVuZhyojXN+8AEm4
         yDMlLcacTL0lWgETYFM2bvstBa+9OeJVh3eG+c7Xt0eVsGxA7JwZXdEsx+oSedlTUBVh
         lMbqda1rN2EzYTTiXkpCl4cSBD4JF4jzN7LvB84y2WcAYs+v3wYdxUKiasvPR8BLaOC4
         dXwA==
X-Gm-Message-State: AOPr4FUbZs8GkThIfx21Fci72RUFU02NynnZhsepgRjx3CmvjwT86t/1fUujPETokIOxKcuJ1xozPtYZP5Hjug==
MIME-Version: 1.0
X-Received: by 10.107.26.203 with SMTP id a194mr20569465ioa.115.1460660765183;
 Thu, 14 Apr 2016 12:06:05 -0700 (PDT)
Received: by 10.107.31.77 with HTTP; Thu, 14 Apr 2016 12:06:05 -0700 (PDT)
Date:   Thu, 14 Apr 2016 21:06:05 +0200
X-Google-Sender-Auth: CwMrKcsFND7H_II-vkP2nQsxBuY
Message-ID: <CAMuHMdUARn_SxhkWiTsGdSixFv9a=VjKLLgQMfPTtxufrjepCg@mail.gmail.com>
Subject: Revisiting rbtx4927: gpiod_direction_output_raw: invalid GPIO
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52985
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

I've just updated my old rbtx4927 from v3.13-rc3 to v4.6-rc3.
Surprisingly, it boots to nfsroot without any kernel changes.

However, there's an annoying warning in the boot log:

        gpiod_direction_output_raw: invalid GPIO

This is caused by the following code in arch/mips/txx9/rbtx4927/setup.c:

        static void __init rbtx4927_mem_setup(void)
        {

                /* TX4927-SIO DTR on (PIO[15]) */
                gpio_request(15, "sio-dtr");

returns -EPROBE_DEFER

                gpio_direction_output(15, 1);

VALIDATE_DESC triggers the warning.

Probably a silly GPIO conversion was missed during the last 2+ years?

I can bisect (which may take a while), but perhaps this immediately rings a bell
with someone?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

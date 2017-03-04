Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Mar 2017 15:37:33 +0100 (CET)
Received: from mail-qk0-x242.google.com ([IPv6:2607:f8b0:400d:c09::242]:36048
        "EHLO mail-qk0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992111AbdCDOhYgyG6X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Mar 2017 15:37:24 +0100
Received: by mail-qk0-x242.google.com with SMTP id n141so10190736qke.3
        for <linux-mips@linux-mips.org>; Sat, 04 Mar 2017 06:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=phU+iWoxbR9RgmYCrjA/cDswrfaz5+UulK9CgHO6nGE=;
        b=C3sBCGGYmrOSpOZIKevyOBhjGxSjfxCCqjINaSdvaS2ddpt5iAiIsiXoo4hI4ijmav
         WeFXuWER79oxfvJj/ku+2UFe0QASx6tFjzpSsUpMr+xutljgUI1Wx0pTQJX42SMjypBJ
         qqpWIqecO0dbU32bEwgrLX/CnWTeOd+XLV6lK/I1USDuaf/Cz0iLcomNYFyP/KmhrIQc
         PrM5SrO4pRaBDQPNfgOaz4HjpQ078uLzkxfC2NR445xnTSk6pYt05wATtMaUKhcpRUi1
         ogWpvp4hw3vLz6ZDrzD7qKn+7Rc5tTuGE9jUncjvKMIBzCEmwJrp2jIY0NLx576OLKoV
         CufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=phU+iWoxbR9RgmYCrjA/cDswrfaz5+UulK9CgHO6nGE=;
        b=iT55+R1yEny3PG3TdowkUQbPbkWLzPPBqlUKbFQRhcaYkPpzdAP/sMdsbyQNrMOQU+
         Xa9GzI6pOgp/EFyWyqGKM8Kx/epToMZYR5bvXj9d4AOpjUQf812U6T4Rx+6KN3nMmqYp
         dOmIFLijSwLyu4mDq33j/bowA3P3GjXsZ7hbAJpIsBHBmSn7K+zKFRNk1KAIg2/Q3le3
         G7Z1rPR/FZLQd1ip0eoCjROg5jCluqO0uxK7SBlAJdvP5LgJmVFJpfZc3IMeD/ZRtBOG
         2mdnYhNvYKUFJwzm417AuuV8t57ACGyUMXMLWh9sE3L9nCC8EBWSTayQOZMQNO+qywbh
         B10g==
X-Gm-Message-State: AMke39nQvpLLNy79ZdDevPF2stkmdHmyG25m6C0Fwv24Xfw2f+jNBhd3XSNs8u7bEkzLAm8knPY4m8PZiEMi9A==
X-Received: by 10.200.42.151 with SMTP id b23mr7737050qta.163.1488638237892;
 Sat, 04 Mar 2017 06:37:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.153.113 with HTTP; Sat, 4 Mar 2017 06:37:17 -0800 (PST)
In-Reply-To: <20170304130958.23655-1-james.hogan@imgtec.com>
References: <CAHp75Ved2h2WyWBokEOsDmAyB3w3iM=uh-9Bq01mU1ST4FapWQ@mail.gmail.com>
 <20170304130958.23655-1-james.hogan@imgtec.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 4 Mar 2017 16:37:17 +0200
Message-ID: <CAHp75Vc=VmxvkqjP7nY6K4CKXBJC-NND0CUMbzwjV2nmQ-5OTw@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_dw: Fix breakage when HAVE_CLK=n
To:     James Hogan <james.hogan@imgtec.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jason Uy <jason.uy@broadcom.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Heiko Stuebner <heiko@sntech.de>,
        David Daney <david.daney@cavium.com>,
        Russell King <linux@armlinux.org.uk>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <andy.shevchenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.shevchenko@gmail.com
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

On Sat, Mar 4, 2017 at 3:09 PM, James Hogan <james.hogan@imgtec.com> wrote:
> Commit 6a171b299379 ("serial: 8250_dw: Allow hardware flow control to be
> used") recently broke the 8250_dw driver on platforms which don't select
> HAVE_CLK, as dw8250_set_termios() gets confused by the behaviour of the
> fallback HAVE_CLK=n clock API in linux/clk.h which pretends everything
> is fine but returns (valid) NULL clocks and 0 HZ clock rates.
>
> That 0 rate is written into the uartclk resulting in a crash at boot,
> e.g. on Cavium Octeon III based UTM-8 we get something like this:
>
> 1180000000800.serial: ttyS0 at MMIO 0x1180000000800 (irq = 41, base_baud = 25000000) is a OCTEON
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 1 at drivers/tty/serial/serial_core.c:441 uart_get_baud_rate+0xfc/0x1f0
> ...
> Call Trace:
> ...
> [<ffffffff8149c2e4>] uart_get_baud_rate+0xfc/0x1f0
> [<ffffffff814a5098>] serial8250_do_set_termios+0xb0/0x440
> [<ffffffff8149c710>] uart_set_options+0xe8/0x190
> [<ffffffff814a6cdc>] serial8250_console_setup+0x84/0x158
> [<ffffffff814a11ec>] univ8250_console_setup+0x54/0x70
> [<ffffffff811901a0>] register_console+0x1c8/0x418
> [<ffffffff8149f004>] uart_add_one_port+0x434/0x4b0
> [<ffffffff814a1af8>] serial8250_register_8250_port+0x2d8/0x440
> [<ffffffff814aa620>] dw8250_probe+0x388/0x5e8
> ...
>
> The clock API is defined such that NULL is a valid clock handle so it
> wouldn't be right to check explicitly for NULL. Instead treat a
> clk_round_rate() return value of 0 as an error which prevents uartclk
> being overwritten.
>

You forgot to add that it is dependent to Heiko's patch
http://www.spinics.net/lists/linux-serial/msg25314.html

Patch looks good to me and shouldn't bring any regression to Intel
hardware (x86 is using clock framework).

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: 6a171b299379 ("serial: 8250_dw: Allow hardware flow control to be used")
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Jason Uy <jason.uy@broadcom.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: David Daney <david.daney@cavium.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-serial@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: bcm-kernel-feedback-list@broadcom.com
> ---
>  drivers/tty/serial/8250/8250_dw.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 223ac234ddb2..e65808c482f1 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -267,6 +267,8 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
>         rate = clk_round_rate(d->clk, baud * 16);
>         if (rate < 0)
>                 ret = rate;
> +       else if (rate == 0)
> +               ret = -ENOENT;
>         else
>                 ret = clk_set_rate(d->clk, rate);
>         clk_prepare_enable(d->clk);
> --
> 2.11.1
>



-- 
With Best Regards,
Andy Shevchenko

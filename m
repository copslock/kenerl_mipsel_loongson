Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Mar 2017 00:39:03 +0100 (CET)
Received: from mail-oi0-x22d.google.com ([IPv6:2607:f8b0:4003:c06::22d]:36511
        "EHLO mail-oi0-x22d.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993887AbdCFXi5D0UEi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Mar 2017 00:38:57 +0100
Received: by mail-oi0-x22d.google.com with SMTP id 126so42273397oig.3
        for <linux-mips@linux-mips.org>; Mon, 06 Mar 2017 15:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=nHQts+SkyPXx3/UuaGXVUUcs8tv6ALsZua2vAcTNmog=;
        b=f7dgnoOuUsKMhRa//zM1CuAdBvt6ADN4krBCnHZJ3x9yA29gcsXHWSkt+FhcxS1+oF
         /oZ4C+jFIijV7DpRqmPvZSj8V83ljIMN/L5tgynZWi1KkZV5qY7cCvTDaVuVGuZqrgoY
         lWuqarhN/aKvLrPvy/b6UUQ+agpOuvZyNCp3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=nHQts+SkyPXx3/UuaGXVUUcs8tv6ALsZua2vAcTNmog=;
        b=qPtMd3dfLH/Ib0AlduLEMpyjwVo3YyiqQdMXhflbw9gm21W39hqk7nNvql1QTc5AbN
         lItrn4WUsa5PYL1mpSYNUAko0GUBmTjADICW2Aw8hxFKzBKA9QXwdGZqKx8p8upmgLsp
         o3MejPs9p8XQWxx5jHbuq+Bwb6LkVhC4/FGN6Koo2ewIYQ7ucxwjDI8IW0oglfgBkgYq
         rxKZlKQb0vNHsehNKPYT9fxwgRbvAVSMQPuD4fm8oEs9XzppO3kg77QW3NiB+OAzDBMo
         rVUiF8GizDfxBOhUvH8W0hmKXCMSfYdUJXMWwd11clpXDBSXnC67KUdMPe6Qk+uKGgyl
         o1og==
X-Gm-Message-State: AMke39lMNZZGNEuGQbCUj1Ccvt/rZd1NBEZ0+mlYte3AYWh/83vO5W4vfOjDaRLNuBLCp3XgXJKsi7diFPX59OmF
X-Received: by 10.202.74.213 with SMTP id x204mr2825809oia.159.1488843529462;
 Mon, 06 Mar 2017 15:38:49 -0800 (PST)
From:   Jason Uy <jason.uy@broadcom.com>
References: <CAHp75Ved2h2WyWBokEOsDmAyB3w3iM=uh-9Bq01mU1ST4FapWQ@mail.gmail.com>
 <20170304130958.23655-1-james.hogan@imgtec.com> <CAHp75Vc=VmxvkqjP7nY6K4CKXBJC-NND0CUMbzwjV2nmQ-5OTw@mail.gmail.com>
 <20170306101603.GW996@jhogan-linux.le.imgtec.org>
In-Reply-To: <20170306101603.GW996@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQLIZbgW9Bvy6eKawokZdQ+hem2wcAHBgSYUAtxZ/WwBGOEh459vJBGw
Date:   Mon, 6 Mar 2017 15:38:47 -0800
Message-ID: <18720dd546d32a1455fb17ad46ee73e4@mail.gmail.com>
Subject: RE: [PATCH] serial: 8250_dw: Fix breakage when HAVE_CLK=n
To:     James Hogan <james.hogan@imgtec.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Heiko Stuebner <heiko@sntech.de>,
        David Daney <david.daney@cavium.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-serial@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mips@linux-mips.org,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jason.uy@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason.uy@broadcom.com
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

Looks good
Reviewed-by: Jason Uy <jason.uy@broadcom.com>

-----Original Message-----
From: James Hogan [mailto:james.hogan@imgtec.com]
Sent: March-06-17 2:16 AM
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org; Greg Kroah-Hartman
<gregkh@linuxfoundation.org>; Andy Shevchenko
<andriy.shevchenko@linux.intel.com>; Jason Uy <jason.uy@broadcom.com>;
Kefeng Wang <wangkefeng.wang@huawei.com>; Heiko Stuebner <heiko@sntech.de>;
David Daney <david.daney@cavium.com>; Russell King <linux@armlinux.org.uk>;
linux-serial@vger.kernel.org; linux-clk@vger.kernel.org;
linux-mips@linux-mips.org; bcm-kernel-feedback-list
<bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH] serial: 8250_dw: Fix breakage when HAVE_CLK=n

On Sat, Mar 04, 2017 at 04:37:17PM +0200, Andy Shevchenko wrote:
> On Sat, Mar 4, 2017 at 3:09 PM, James Hogan <james.hogan@imgtec.com>
> wrote:
> > Commit 6a171b299379 ("serial: 8250_dw: Allow hardware flow control
> > to be
> > used") recently broke the 8250_dw driver on platforms which don't
> > select HAVE_CLK, as dw8250_set_termios() gets confused by the
> > behaviour of the fallback HAVE_CLK=n clock API in linux/clk.h which
> > pretends everything is fine but returns (valid) NULL clocks and 0 HZ
> > clock rates.
> >
> > That 0 rate is written into the uartclk resulting in a crash at
> > boot, e.g. on Cavium Octeon III based UTM-8 we get something like this:
> >
> > 1180000000800.serial: ttyS0 at MMIO 0x1180000000800 (irq = 41,
> > base_baud = 25000000) is a OCTEON ------------[ cut here
> > ]------------
> > WARNING: CPU: 2 PID: 1 at drivers/tty/serial/serial_core.c:441
> > uart_get_baud_rate+0xfc/0x1f0 ...
> > Call Trace:
> > ...
> > [<ffffffff8149c2e4>] uart_get_baud_rate+0xfc/0x1f0
> > [<ffffffff814a5098>] serial8250_do_set_termios+0xb0/0x440
> > [<ffffffff8149c710>] uart_set_options+0xe8/0x190
> > [<ffffffff814a6cdc>] serial8250_console_setup+0x84/0x158
> > [<ffffffff814a11ec>] univ8250_console_setup+0x54/0x70
> > [<ffffffff811901a0>] register_console+0x1c8/0x418
> > [<ffffffff8149f004>] uart_add_one_port+0x434/0x4b0
> > [<ffffffff814a1af8>] serial8250_register_8250_port+0x2d8/0x440
> > [<ffffffff814aa620>] dw8250_probe+0x388/0x5e8 ...
> >
> > The clock API is defined such that NULL is a valid clock handle so
> > it wouldn't be right to check explicitly for NULL. Instead treat a
> > clk_round_rate() return value of 0 as an error which prevents
> > uartclk being overwritten.
> >
>
> You forgot to add that it is dependent to Heiko's patch
> http://www.spinics.net/lists/linux-serial/msg25314.html

Indeed I did. Sorry about that.

>
> Patch looks good to me and shouldn't bring any regression to Intel
> hardware (x86 is using clock framework).
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks
James

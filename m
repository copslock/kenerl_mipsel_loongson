Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2014 10:41:24 +0200 (CEST)
Received: from mail-ig0-f178.google.com ([209.85.213.178]:58211 "EHLO
        mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818990AbaETIlVq3Rlr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 May 2014 10:41:21 +0200
Received: by mail-ig0-f178.google.com with SMTP id hl10so435263igb.5
        for <linux-mips@linux-mips.org>; Tue, 20 May 2014 01:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=5IP0hGR7aCZpVqocIPNWqUT3PuGsoKj+kxa4ok6LIXw=;
        b=piH/8wVLhJ+oTN4YZ3nrPZdg2g3p1zAaFR0TOj2pO8ZfVvcUa9GmfE5Mh1NS3aadqX
         UsoQ9yN/7wpK9xXuL91O1NGkUBYGJK9g+G4kw2LVmJ3otkx3dzJjtPeGcIPTWoqClEjK
         8BJG4HyZU+m86dRbA7KBsg8aK+OWgX2FkJPIMQuzEReK8JRCUTlgtgB5xbqf5S/IRVy+
         f0R6pt2j8BIs4R4kQhuMDbpx1lkRke6bB4erBcEMusUym6OUCZKdYQJjo038YeVjXnVE
         RBmFeM9a1M5J0BIoD+RQXfVBetT+IARArnf4apM5xnI3RzwS6flLynH4Aew7J3KUTwW5
         Ljjg==
MIME-Version: 1.0
X-Received: by 10.42.27.147 with SMTP id j19mr7725814icc.81.1400575275702;
 Tue, 20 May 2014 01:41:15 -0700 (PDT)
Received: by 10.64.17.199 with HTTP; Tue, 20 May 2014 01:41:15 -0700 (PDT)
In-Reply-To: <20140520082116.GB618@waldemar-brodkorb.de>
References: <20140516134904.GW618@waldemar-brodkorb.de>
        <CAMuHMdVPSzYkUumqMY78zxVcoQ6=W9Vfm_tyM_T3W8DFzCztVw@mail.gmail.com>
        <20140520082116.GB618@waldemar-brodkorb.de>
Date:   Tue, 20 May 2014 10:41:15 +0200
X-Google-Sender-Auth: d9NwF-Wx_9h4m8lx1FU62BKKX9U
Message-ID: <CAMuHMdUZuwA45-m8HL8PXDMXrrhp2DA71P5-jLwke0i5TLFSYw@mail.gmail.com>
Subject: Re: serial console on rb532 disabled on boot (linux 3.15rc5)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Waldemar Brodkorb <wbx@openadk.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40162
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

Hi Waldemar,

On Tue, May 20, 2014 at 10:21 AM, Waldemar Brodkorb <wbx@openadk.org> wrote:
> Geert Uytterhoeven wrote,
>> On Fri, May 16, 2014 at 3:49 PM, Waldemar Brodkorb <wbx@openadk.org> wrote:
>> > I am trying to bootup my Mikrotik RB532 board with the latest
>> > kernel, but my serial console is disabled after boot:
>> > ..
>> > Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
>> > serial8250: ttyS0 at MMIO 0x0 (irq = 104, base_baud = 12499875) is a
>> > 16550A
>> > console [ttyS0] enabled
>> > console [ttyS0] disabled
>> >
>> > I used git bisect to find the problematic commit:
>> > commit 5f5c9ae56c38942623f69c3e6dc6ec78e4da2076
>> > Author: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>> > Date:   Fri Feb 28 14:21:32 2014 +0100
>> >
>> >     serial_core: Unregister console in uart_remove_one_port()
>> >
>> >     If the serial port being removed is used as a console, it must
>> > also be
>> >     unregistered from the console subsystem using
>> > unregister_console().
>> >
>> >     uart_ops.release_port() will release resources (e.g. iounmap()
>> > the serial
>> >     port registers), causing a crash on subsequent kernel output if
>> > the console
>> >     is still registered.
>> >
>> >     Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>> >     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> >
>> > After reverting the change, everything is fine.
>>
>> Does this patch help? https://lkml.org/lkml/2014/5/10/9
>
> The second change in printk.c didn't help.

>> Your serial driver may need to set port.type too, if it doesn't already do so
>> and the type is PORT_UNKNOWN on re-registration.
>
> Tried following patch, but it didn't work:
>
> diff -Nur linux-3.15-rc5.orig/arch/mips/rb532/serial.c
> linux-3.15-rc5/arch/mips/rb532/serial.c
> --- linux-3.15-rc5.orig/arch/mips/rb532/serial.c        2014-05-09
> 22:10:52.000000000 +0200
> +++ linux-3.15-rc5/arch/mips/rb532/serial.c     2014-05-19
> 20:35:08.000000000 +0200
> @@ -37,7 +37,7 @@
>  extern unsigned int idt_cpu_freq;
>
>  static struct uart_port rb532_uart = {
> -       .flags = UPF_BOOT_AUTOCONF,
> +       .type = PORT_16550A,

I'm afraid this is not gonna help. When the port is unregistered, its
type will be reset to PORT_UNKNOWN.
So before registering it again, its type must be set againin the actual
serial driver, cfr. the change to of_serial.c.

>         .line = 0,
>         .irq = UART0_IRQ,
>         .iotype = UPIO_MEM,
> diff -Nur linux-3.15-rc5.orig/kernel/printk/printk.c
> linux-3.15-rc5/kernel/printk/printk.c
> --- linux-3.15-rc5.orig/kernel/printk/printk.c  2014-05-09
> 22:10:52.000000000 +0200
> +++ linux-3.15-rc5/kernel/printk/printk.c       2014-05-20
> 09:39:54.000000000 +0200
> @@ -2413,6 +2413,7 @@
>         if (console_drivers != NULL && console->flags & CON_CONSDEV)
>                 console_drivers->flags |= CON_CONSDEV;
>
> +       console->flags &= ~CON_ENABLED;
>         console_unlock();
>         console_sysfs_notify();
>         return res;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Sep 2011 14:44:32 +0200 (CEST)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:43606 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491130Ab1IRMo0 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 18 Sep 2011 14:44:26 +0200
Received: by iaep9 with SMTP id p9so5669751iae.36
        for <linux-mips@linux-mips.org>; Sun, 18 Sep 2011 05:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=PPOKiwbrnA8xz1SkMpVVGNDxf3Tcp3EQvRJfGO9rkjs=;
        b=I/PTZrRmoM+ZMn4vMO3EXlKzFradRI1uQ8lcjzvQsgpaFmw6k46eMWtWXdFlgMKjyt
         uAlAZ117xnxu9194Jz23279+81Eyd9BmuKXy4CcoWi2VEVriYxaxuvZP5ETaWvouj2ME
         8ud9126sT7Bqp7P+ufEQiXvZunQm13ERlL6nc=
MIME-Version: 1.0
Received: by 10.42.146.138 with SMTP id j10mr2451020icv.105.1316349859436;
 Sun, 18 Sep 2011 05:44:19 -0700 (PDT)
Received: by 10.42.213.197 with HTTP; Sun, 18 Sep 2011 05:44:19 -0700 (PDT)
In-Reply-To: <20110914191016.GT15003@mails.so.argh.org>
References: <20110914191016.GT15003@mails.so.argh.org>
Date:   Sun, 18 Sep 2011 20:44:19 +0800
Message-ID: <CAD+V5Y+erY_5c_5ksC1G_TB=vCcwg3TOm1UvShgVaUwLjRo3sg@mail.gmail.com>
Subject: Re: i8042_enable_kbd_port in arch/mips/loongson/lemote-2f/pm.c?
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Andreas Barth <aba@not.so.argh.org>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 31101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9302

On Thu, Sep 15, 2011 at 3:10 AM, Andreas Barth <aba@not.so.argh.org> wrote:
> Hi,
>
> I just noticed that i8042_enable_kbd_port in
> arch/mips/loongson/lemote-2f/pm.c is almost equal to
> i8042_enable_kbd_port in drivers/input/serio/i8042.c
> (+ is pm.c - the error message in pm.c contains the string i8042.c,
> the one in i8042.c not):
>
>  static int i8042_enable_kbd_port(void)
>  {
> +       if (i8042_command(&i8042_ctr, I8042_CMD_CTL_RCTR)) {
> +               pr_err("i8042.c: Can't read CTR while enabling i8042 kbd port."
> +                      "\n");
> +               return -EIO;
> +       }
> +
>        i8042_ctr &= ~I8042_CTR_KBDDIS;
>        i8042_ctr |= I8042_CTR_KBDINT;
>
>        if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
>                i8042_ctr &= ~I8042_CTR_KBDINT;
>                i8042_ctr |= I8042_CTR_KBDDIS;
> -               pr_err("Failed to enable KBD port\n");
> +               pr_err("i8042.c: Failed to enable KBD port.\n");
>                return -EIO;
>        }
>
> (called as part of setup_wakeup_events
>               outb((0xff & ~(1 << I8042_KBD_IRQ)), PIC_MASTER_IMR);
>               irq_mask = inb(PIC_MASTER_IMR);
>               i8042_enable_kbd_port();
> )
>
>
>
> This was added within 94d0b0e3 with this comment:
>    MIPS: Yeeloong 2F: Add board specific suspend support
>
>    Lemote Loongson 2F family machines need an external interrupt to wake the
>    system from the suspend mode.
>
>    For YeeLoong 2F and Mengloong 2F setup the keyboard interrupt as the wakeup
>    interrupt.
>
>    The new Fuloong 2F and LingLoong 2F have a button to directly send an
>    interrupt to the CPU so there is no need to setup an interrupt.
>
>    Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
>    Cc: linux-mips@linux-mips.org
>    Cc: yanh@lemote.com
>    Cc: huhb@lemote.com
>    Cc: Wu Zhangjin <wuzhangjin@gmail.com>
>    Cc: Len Brown <len.brown@intel.com>
>    Cc: Rafael J. Wysocki <rjw@sisk.pl>
>    Cc: linux-pm@lists.linux-foundation.org
>    Patchwork: http://patchwork.linux-mips.org/patch/630/
>    Acked-by: Pavel Machek <pavel@ucw.cz>
>    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>
>
> My question now is: Could we migrate some way or other to use the standard
> i8042_enable_kbd_port?

Perhaps we can: export that function and make our suspend support
depends on that driver.

Thanks,
Wu Zhangjin

>
>
>
> Andi
>

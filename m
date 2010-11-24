Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2010 18:24:23 +0100 (CET)
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:47858 "HELO
        na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491050Ab0KXRYT convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Nov 2010 18:24:19 +0100
Received: from source ([209.85.216.41]) by na3sys009aob107.postini.com ([74.125.148.12]) with SMTP
        ID DSNKTO1KQL48HCDA6lLB4d2YDDaoPOf+tVc5@postini.com; Wed, 24 Nov 2010 09:24:19 PST
Received: by mail-qw0-f41.google.com with SMTP id 7so123200qwf.28
        for <multiple recipients>; Wed, 24 Nov 2010 09:24:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.224.185.129 with SMTP id co1mr6907370qab.232.1290619455259;
 Wed, 24 Nov 2010 09:24:15 -0800 (PST)
Received: by 10.220.194.74 with HTTP; Wed, 24 Nov 2010 09:24:15 -0800 (PST)
In-Reply-To: <1290524800-21419-10-git-send-email-juhosg@openwrt.org>
References: <1290524800-21419-1-git-send-email-juhosg@openwrt.org>
        <1290524800-21419-10-git-send-email-juhosg@openwrt.org>
Date:   Wed, 24 Nov 2010 12:24:15 -0500
Message-ID: <AANLkTikQ=oen3jmz=BfY7y=s6Qo7R8DQ1-79puby-Snt@mail.gmail.com>
Subject: Re: [PATCH 09/18] input: add input driver for polled GPIO buttons
From:   Ben Gardiner <bengardiner@nanometrics.ca>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kaloz@openwrt.org, "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@atheros.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <bengardiner@nanometrics.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bengardiner@nanometrics.ca
Precedence: bulk
X-list: linux-mips

Hello Gabor,

On Tue, Nov 23, 2010 at 10:06 AM, Gabor Juhos <juhosg@openwrt.org> wrote:
> The existing gpio-keys driver can be usable only for GPIO lines with
> interrupt support. Several devices have buttons connected to a GPIO
> line which is not capable to generate interrupts. This patch adds a
> new input driver using the generic GPIO layer and the input-polldev
> to support such buttons.
>
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Mike Frysinger <vapier@gentoo.org>
> Cc: linux-input@vger.kernel.org
> ---

I've tested this driver with the da850-evm pushbuttons and switches
connected to i2c gpio expanders. It works well. The changes to the
patch series were straightforward: .config, "gpio-keys" ->
"gpio-buttons", struct gpio_key -> struct gpio_button etc.

I do have some comments about this patch. But the new driver is
functional as-is.

Tested-by: Ben Gardiner <bengardiner@nanometrics.ca>

>  drivers/input/misc/Kconfig        |   16 +++
>  drivers/input/misc/Makefile       |    1 +
>  drivers/input/misc/gpio_buttons.c |  232 +++++++++++++++++++++++++++++++++++++

Since the new gpio_buttons.c driver presents the same input event
device as the gpio_keys.c driver, I think it should also be a
drivers/input/keys device.

>  [...]
> diff --git a/drivers/input/misc/gpio_buttons.c b/drivers/input/misc/gpio_buttons.c

When I was converting the da850-evm platform code to use the new
driver I felt that the changes did not indicate a switch to a polled
driver as seems to be the intent with the introduction of a separate
driver. All that was different in the platform code was 'button' where
there use to be 'key' and button does not itself convey the knowledge
that it is a polled input device.

I know names of drivers can be contentions but I will propose
regardless that this driver be called gpio-polled-keys /
gpio_polled_keys.c

> new file mode 100644
> index 0000000..51288a3
> --- /dev/null
> +++ b/drivers/input/misc/gpio_buttons.c
> [...]
> +static void gpio_buttons_poll(struct input_polled_dev *dev)
> +{
> +       struct gpio_buttons_dev *bdev = dev->private;
> +       struct gpio_buttons_platform_data *pdata = bdev->pdata;
> +       struct input_dev *input = dev->input;
> +       int i;
> +
> +       for (i = 0; i < bdev->pdata->nbuttons; i++) {
> +               struct gpio_button *button = &pdata->buttons[i];
> +               struct gpio_button_data *bdata = &bdev->data[i];
> +
> +               if (bdata->count < button->threshold)
> +                       bdata->count++;
> +               else
> +                       gpio_buttons_check_state(input, button, bdata);

I think that a count-theshold can still be performed here, but using
the debounce_interval and polling_interval field specified in the
gpio_button and gpio_buttons_platform_data structures, respectively,
to calculate a threshold value.

In this way the gpio_button and gpio_keys_button structs are made more
similar -- differing only in the presence of .wakeup in
gpio_keys_button but not in gpio_button. Which may make it possible to
re-use the gpio_keys_button structure.

> [...]
> diff --git a/include/linux/gpio_buttons.h b/include/linux/gpio_buttons.h
> new file mode 100644
> index 0000000..f85b993
> --- /dev/null
> +++ b/include/linux/gpio_buttons.h
> @@ -0,0 +1,33 @@
> +/*
> + *  Definitions for the GPIO buttons interface driver
> + *
> + *  Copyright (C) 2007-2010 Gabor Juhos <juhosg@openwrt.org>
> + *
> + *  This file was based on: /include/linux/gpio_keys.h
> + *     The original gpio_keys.h seems not to have a license.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef _GPIO_BUTTONS_H_
> +#define _GPIO_BUTTONS_H_
> +
> +struct gpio_button {
> +       int     gpio;           /* GPIO line number */
> +       int     active_low;
> +       char    *desc;          /* button description */
> +       int     type;           /* input event type (EV_KEY, EV_SW) */
> +       int     code;           /* input event code (KEY_*, SW_*) */
> +       int     threshold;      /* count threshold */

Could we instead use the existing struct gpio_keys_button; we could
transform debounce_interval into a threshold as described above and
add an error when a gpio_button_probe() sees a gpio_key with .wakeup
== TRUE? It seems that this structure duplicates alot of the
gpio_keys_button structure.

> [...]
> +struct gpio_buttons_platform_data {
> +       struct gpio_button *buttons;
> +       int     nbuttons;               /* number of buttons */
> +       int     poll_interval;          /* polling interval */
> +};

I think the units of poll_interval should be included in the comment.
i.e. /* polling interval in msecs */

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jul 2017 17:07:53 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:43964 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992214AbdGJPHqJdYbK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jul 2017 17:07:46 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id C215AB805D0;
        Mon, 10 Jul 2017 17:07:44 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-ua0-f177.google.com (mail-ua0-f177.google.com [209.85.217.177])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 22F62B90E96;
        Mon, 10 Jul 2017 17:07:39 +0200 (CEST)
Received: by mail-ua0-f177.google.com with SMTP id w19so56492294uac.0;
        Mon, 10 Jul 2017 08:07:39 -0700 (PDT)
X-Gm-Message-State: AIVw110Y66AA0XPmeQlTc3u8fgQ738OtkfIsOtd2fILBIMi2/1v+nqVQ
        nYyKnMZXLKBJanAKdH2c3m1HO3Fc+A==
X-Received: by 10.159.48.214 with SMTP id k22mr8991105uab.31.1499699257933;
 Mon, 10 Jul 2017 08:07:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.85.222 with HTTP; Mon, 10 Jul 2017 08:07:17 -0700 (PDT)
In-Reply-To: <1498664922-28493-10-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1498664922-28493-1-git-send-email-aleksandar.markovic@rt-rk.com> <1498664922-28493-10-git-send-email-aleksandar.markovic@rt-rk.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Mon, 10 Jul 2017 17:07:17 +0200
X-Gmail-Original-Message-ID: <CAOiHx=kuePK6pmwNzOk-HwuzjJmKVB_LOowoXEcSvWHJJnenLQ@mail.gmail.com>
Message-ID: <CAOiHx=kuePK6pmwNzOk-HwuzjJmKVB_LOowoXEcSvWHJJnenLQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] MIPS: i8042: Probe this device only if it exists
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-input@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Hi,

On 28 June 2017 at 17:47, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
> From: Miodrag Dinic <miodrag.dinic@imgtec.com>
>
> ARCH_MIGHT_HAVE_PC_SERIO is selected by default for MIPS platforms.
> As a consequence SERIO_I8042 would be automatically selected for any
> MIPS board which wants to enable input support like keyboard
> (INPUT_KEYBOARD) regardless of i8042 controller existence.
>
> The dependency is as follows :
>
> config ARCH_MIGHT_HAVE_PC_SERIO [=y]
>     Defined at drivers/input/serio/Kconfig:19
>     Depends on: !UML
>     Selected by: MIPS [=y]
>
> config SERIO
>     Defined at drivers/input/serio/Kconfig:4
>     default y
>     Depends on: !UML
>     Selected by: KEYBOARD_ATKBD [=y] && !UML && INPUT [=y] &&
>                  INPUT_KEYBOARD [=y]
>
> config SERIO_I8042
>     Defined at drivers/input/serio/Kconfig:28
>     tristate "i8042 PC Keyboard controller"
>     default y
>     Depends on: !UML && SERIO [=y] && ARCH_MIGHT_HAVE_PC_SERIO [=y]
>     Selected by: KEYBOARD_ATKBD [=y] && !UML && INPUT [=y] &&
>                  INPUT_KEYBOARD [=y] && ARCH_MIGHT_HAVE_PC_SERIO [=y]
>
> If this driver probes the I8042_DATA_REG not knowing if the device
> exists it can cause a kernel to crash. Using check_legacy_ioport()
> interface we can selectively enable this driver only for the MIPS
> boards which actually have the i8042 controller.
>
> New "Ranchu" virtual platform does not support i8042 controller
> so it's added to the blacklist match table.
>
> Each MIPS machine should update this table with it's compatible strings
> if it does not support i8042 controller.
>
> In order to utilize this mechanism, each MIPS machine that do not
> have i8042 controller should update the blacklist table with its
> compatible strings.
>
> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> ---
>  arch/mips/kernel/setup.c       | 16 ++++++++++++++++
>  drivers/input/serio/i8042-io.h |  2 +-
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index c22cde8..c3e0d2b 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -79,6 +79,15 @@ const unsigned long mips_io_port_base = -1;
>  EXPORT_SYMBOL(mips_io_port_base);
>
>  /*
> + * Here we blacklist all MIPS boards which do not have i8042 controller
> + */
> +static const struct of_device_id i8042_blacklist_of_match[] = {
> +       { .compatible = "mti,ranchu", },
> +       {},
> +};
> +#define I8042_DATA_REG 0x60
> +
> +/*
>   * Check for existence of legacy devices
>   *
>   * Some drivers may try to probe some I/O ports which can lead to
> @@ -90,9 +99,16 @@ EXPORT_SYMBOL(mips_io_port_base);
>   */
>  int check_legacy_ioport(unsigned long base_port)
>  {
> +       struct device_node *np;
>         int ret = 0;
>
>         switch (base_port) {
> +       case I8042_DATA_REG:
> +               np = of_find_matching_node(NULL, i8042_blacklist_of_match);
> +               if (np)
> +                       ret = -ENODEV;
> +               of_node_put(np);
> +               break;

Wouldn't it make more sense to require boards to describe their i8042
device(s) in device tree if USE_OF is enabled? And maybe a whitelist
for those preexisting ones that don't. Much less maintenance overhead
for new boards, as I suspect the amount of boards with i8042 support
is much less than those that don't.

At least PowerPC seems to do it this way.


Regards
Jonas

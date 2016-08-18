Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 14:57:59 +0200 (CEST)
Received: from albert.telenet-ops.be ([195.130.137.90]:55407 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993039AbcHRM5wT8ftL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 14:57:52 +0200
Received: from ayla.of.borg ([84.193.137.253])
        by albert.telenet-ops.be with bizsmtp
        id Ycxr1t00B5UCtCs06cxr8H; Thu, 18 Aug 2016 14:57:51 +0200
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1baMtL-0001gA-6x; Thu, 18 Aug 2016 14:57:51 +0200
Received: from geert by ramsan with local (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1baMtN-0000PF-0z; Thu, 18 Aug 2016 14:57:53 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-mips@linux-mips.org, linux-gpio@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/2] MIPS: TXx9: Move GPIO setup from .mem_setup() to .arch_init()
Date:   Thu, 18 Aug 2016 14:57:46 +0200
Message-Id: <1471525068-1525-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 1.9.1
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54622
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

	Hi Ralf, Nemoto-san,

After upgrading my good old rbtx4927 from v3.13-rc3 to v4.6-rc3, I
noticed the following warning:

        gpiod_direction_output_raw: invalid GPIO

This is caused by the following code in arch/mips/txx9/rbtx4927/setup.c:

        static void __init rbtx4927_mem_setup(void)
        {

                /* TX4927-SIO DTR on (PIO[15]) */
                gpio_request(15, "sio-dtr");

returns -EPROBE_DEFER

                gpio_direction_output(15, 1);

VALIDATE_DESC triggers the warning.

Note that as of commit 54d77198fdfbc4f0 ("gpio: bail out silently on
NULL descriptors") the warning message is no longer printed, but the
underlying issue is still there.

Nemoto-san pointed out that the GPIO setup may now be done too early,
and that indeed is the case.  Hence the following patch series postpones
GPIO setup from .mem_setup() time to .arch_init() time to fix it, for
all TXx9 platforms.

This has been tested on RBTX4927 only.

Thanks!

Geert Uytterhoeven (2):
  MIPS: TXx9: tx39xx: Move GPIO setup from .mem_setup() to .arch_init()
  MIPS: TXx9: tx49xx: Move GPIO setup from .mem_setup() to .arch_init()

 arch/mips/txx9/generic/setup_tx3927.c |  1 -
 arch/mips/txx9/generic/setup_tx4927.c |  1 -
 arch/mips/txx9/generic/setup_tx4938.c |  1 -
 arch/mips/txx9/jmr3927/setup.c        | 11 +++++++++--
 arch/mips/txx9/rbtx4927/setup.c       | 32 ++++++++++++++++++++++----------
 arch/mips/txx9/rbtx4938/setup.c       |  1 +
 6 files changed, 32 insertions(+), 15 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

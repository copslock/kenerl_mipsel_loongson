Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Nov 2018 16:02:11 +0100 (CET)
Received: from relmlor2.renesas.com ([210.160.252.172]:7057 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991063AbeKPO7yfivk9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Nov 2018 15:59:54 +0100
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie6.idc.renesas.com with ESMTP; 16 Nov 2018 23:59:50 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id B6F9C10021F;
        Fri, 16 Nov 2018 23:59:50 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.56,240,1539615600"; 
   d="scan'208";a="297674423"
Received: from unknown (HELO vbox.ree.adwin.renesas.com) ([10.226.37.67])
  by relmlii2.idc.renesas.com with ESMTP; 16 Nov 2018 23:59:45 +0900
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>, Guan Xuetao <gxt@pku.edu.cn>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 0/6] clk: Add functions to get optional clocks
Date:   Fri, 16 Nov 2018 14:59:31 +0000
Message-Id: <20181116145937.27660-1-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.17.1
Return-Path: <phil.edworthy@renesas.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: phil.edworthy@renesas.com
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

Quite a few drivers get an optional clock, e.g. a bus clock required to 
access peripheral's registers that is always enabled on some devices. This
series adds of_clk_get_by_name_optional(), clk_get_optional() and
devm_clk_get_optional() functions for this purpose.

The functions behave the same as of_clk_get_by_name(), clk_get() and
devm_clk_get() except that they will return NULL instead of -ENOENT. This
allows for simpler error handling in the callers.

*Note*
This changes the return values for of_clk_get_by_name() in some cases, see
[PATCH 1/6] clk: Add of_clk_get_by_name_optional() function.

v6:
 - Rework the __of_clk_get_by_name() logic so as to avoid duplicate tests.
 - Add doxygen style comment for devm_clk_get_optional() args
 - Add clk_get_optional() to archs that don't use the commom clk framework.

Phil Edworthy (6):
  clk: Add of_clk_get_by_name_optional() function
  clk: Add functions to get optional clocks
  m68k: coldfire: Add clk_get_optional() function
  MIPS: AR7: Add clk_get_optional() function
  MIPS: Loongson 2F: Add clk_get_optional() function
  arch/unicore32/kernel/clock.c: Add clk_get_optional() function

 arch/m68k/coldfire/clk.c               | 11 ++++
 arch/mips/ar7/clock.c                  | 11 ++++
 arch/mips/loongson64/lemote-2f/clock.c | 11 ++++
 arch/unicore32/kernel/clock.c          | 11 ++++
 drivers/clk/clk-devres.c               | 18 ++++-
 drivers/clk/clkdev.c                   | 91 ++++++++++++++++++++++----
 include/linux/clk.h                    | 38 +++++++++++
 7 files changed, 175 insertions(+), 16 deletions(-)

-- 
2.17.1

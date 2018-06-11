Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jun 2018 10:44:57 +0200 (CEST)
Received: from leibniz.telenet-ops.be ([195.130.137.77]:49330 "EHLO
        leibniz.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990475AbeFKIocSP00b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jun 2018 10:44:32 +0200
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by leibniz.telenet-ops.be (Postfix) with ESMTPS id 41465C62HBzMqh9b
        for <linux-mips@linux-mips.org>; Mon, 11 Jun 2018 10:44:31 +0200 (CEST)
Received: from ayla.of.borg ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id xLkS1x00i3XaVaC01LkSjr; Mon, 11 Jun 2018 10:44:31 +0200
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fSIR8-0006xM-F3; Mon, 11 Jun 2018 10:44:26 +0200
Received: from geert by ramsan with local (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fSIR8-0005OA-DS; Mon, 11 Jun 2018 10:44:26 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Greg Ungerer <gerg@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/3] Legacy clock drivers: Normalize clk API
Date:   Mon, 11 Jun 2018 10:44:20 +0200
Message-Id: <1528706663-20670-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64219
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

	Hi all,

When seeing commit bde4975310eb1982 ("net: stmmac: fix build failure due
to missing COMMON_CLK dependency"), I wondered why this dependency is
needed, as all implementations of the clock API should implement all
required functionality, or provide dummies.

It turns out there were still two implementations that lacked the
clk_set_rate() function: Coldfire and AR7.

This series contains three patches:
  - The first two patches add dummies for clk_set_rate(),
    clk_set_rate(), clk_set_parent(), and clk_get_parent() to the
    Coldfire and AR7, like Arnd has done for other legacy clock
    implementations a while ago.
  - The second patch removes the COMMON_CLK dependency from the stmmac
    network drivers again, as it is no longer needed.
    Obviously this patch has a hard dependency on the first two patches.

Thanks!

Geert Uytterhoeven (3):
  m68k: coldfire: Normalize clk API
  MIPS: AR7: Normalize clk API
  [RFC] Revert "net: stmmac: fix build failure due to missing COMMON_CLK
    dependency"

 arch/m68k/coldfire/clk.c                    | 29 +++++++++++++++++++++++++++++
 arch/mips/ar7/clock.c                       | 29 +++++++++++++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig | 10 +++++-----
 3 files changed, 63 insertions(+), 5 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

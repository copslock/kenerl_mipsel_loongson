Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jun 2018 10:44:39 +0200 (CEST)
Received: from leibniz.telenet-ops.be ([195.130.137.77]:49328 "EHLO
        leibniz.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990473AbeFKIocKIjSb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jun 2018 10:44:32 +0200
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by leibniz.telenet-ops.be (Postfix) with ESMTPS id 41465C6X94zMqh9f
        for <linux-mips@linux-mips.org>; Mon, 11 Jun 2018 10:44:31 +0200 (CEST)
Received: from ayla.of.borg ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id xLkS1x00T3XaVaC01LkSsu; Mon, 11 Jun 2018 10:44:31 +0200
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fSIR8-0006xQ-Fo; Mon, 11 Jun 2018 10:44:26 +0200
Received: from geert by ramsan with local (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fSIR8-0005OH-Ep; Mon, 11 Jun 2018 10:44:26 +0200
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
Subject: [PATCH 2/3] MIPS: AR7: Normalize clk API
Date:   Mon, 11 Jun 2018 10:44:22 +0200
Message-Id: <1528706663-20670-3-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528706663-20670-1-git-send-email-geert@linux-m68k.org>
References: <1528706663-20670-1-git-send-email-geert@linux-m68k.org>
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64218
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

Coldfire still provides its own variant of the clk API rather than using
the generic COMMON_CLK API.  This generally works, but it causes some
link errors with drivers using the clk_round_rate(), clk_set_rate(),
clk_set_parent(), or clk_get_parent() functions when a platform lacks
those interfaces.

This adds empty stub implementations for each of them, and I don't even
try to do something useful here but instead just print a WARN() message
to make it obvious what is going on if they ever end up being called.

The drivers that call these won't be used on these platforms (otherwise
we'd get a link error today), so the added code is harmless bloat and
will warn about accidental use.

Based on commit bd7fefe1f06ca6cc ("ARM: w90x900: normalize clk API").

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/mips/ar7/clock.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/mips/ar7/clock.c b/arch/mips/ar7/clock.c
index 0137656107a9c5b5..6b64fd96dba8fb26 100644
--- a/arch/mips/ar7/clock.c
+++ b/arch/mips/ar7/clock.c
@@ -476,3 +476,32 @@ void __init ar7_init_clocks(void)
 	/* adjust vbus clock rate */
 	vbus_clk.rate = bus_clk.rate / 2;
 }
+
+/* dummy functions, should not be called */
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	WARN_ON(clk);
+	return 0;
+}
+EXPORT_SYMBOL(clk_round_rate);
+
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	WARN_ON(clk);
+	return 0;
+}
+EXPORT_SYMBOL(clk_set_rate);
+
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	WARN_ON(clk);
+	return 0;
+}
+EXPORT_SYMBOL(clk_set_parent);
+
+struct clk *clk_get_parent(struct clk *clk)
+{
+	WARN_ON(clk);
+	return NULL;
+}
+EXPORT_SYMBOL(clk_get_parent);
-- 
2.7.4

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Oct 2012 01:03:29 +0200 (CEST)
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50277 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6872812Ab2JJXDSeCYfC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Oct 2012 01:03:18 +0200
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
        by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 63B2020C73;
        Wed, 10 Oct 2012 19:03:17 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Wed, 10 Oct 2012 19:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references; s=smtpout; bh=xm9ssfjDXNPmazK+CnSqXauTk
        84=; b=Qa0rU5jq++Pbh5p45uK2cuo+JT1bPf/W/bvS1EW6nkBGuq24ldps0X18t
        BDnxxuw7e9vApxmTHr1vQBeKgl0cwNn2hgC5/wIxz7ppztHjbXe69ynhZn4fqHqH
        lnNkk1EXFoDJCQI7OlzsTxvbMTKGcyw9zTO9105CYXmOicLj1M=
X-Sasl-enc: FWLgquWDS+P5w7jDILVeP9NVX1uOZOMiBGC3kbbwJX+7 1349910196
Received: from localhost (unknown [222.106.197.2])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9BFEA4827DC;
        Wed, 10 Oct 2012 19:03:16 -0400 (EDT)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alan@lxorguk.ukuu.org.uk, Gabor Juhos <juhosg@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [ 063/122] MIPS: ath79: use correct fractional dividers for {CPU,DDR}_PLL on AR934x
Date:   Thu, 11 Oct 2012 07:53:49 +0900
Message-Id: <20121010225349.499192961@linuxfoundation.org>
X-Mailer: git-send-email 1.8.0.rc0.18.gf84667d
In-Reply-To: <20121010225337.989799482@linuxfoundation.org>
References: <20121010225337.989799482@linuxfoundation.org>
User-Agent: quilt/0.60-2.1.2
X-archive-position: 34680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

3.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabor Juhos <juhosg@openwrt.org>

commit 65fc7f9957c52ad4fdf4ee5dfe3a75aa0a633d39 upstream.

The current dividers in the code are wrong and this
leads to broken CPU frequency calculation on boards
where the fractional part is used.

For example, if the SoC is running from a 40MHz
reference clock, refdiv=1, nint=14, outdiv=0 and
nfrac=31 the real frequency is 579.375MHz but the
current code calculates 569.687MHz instead.

Because the system time is indirectly related to
the CPU frequency the broken computation causes
drift in the system time.

The correct divider is 2^6 for the CPU PLL and 2^10
for the DDR PLL. Use the correct values to fix the
issue.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/4305/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ath79/clock.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -189,7 +189,7 @@ static void __init ar934x_clocks_init(vo
 	       AR934X_PLL_CPU_CONFIG_NFRAC_MASK;
 
 	cpu_pll = nint * ath79_ref_clk.rate / ref_div;
-	cpu_pll += frac * ath79_ref_clk.rate / (ref_div * (2 << 6));
+	cpu_pll += frac * ath79_ref_clk.rate / (ref_div * (1 << 6));
 	cpu_pll /= (1 << out_div);
 
 	pll = ath79_pll_rr(AR934X_PLL_DDR_CONFIG_REG);
@@ -203,7 +203,7 @@ static void __init ar934x_clocks_init(vo
 	       AR934X_PLL_DDR_CONFIG_NFRAC_MASK;
 
 	ddr_pll = nint * ath79_ref_clk.rate / ref_div;
-	ddr_pll += frac * ath79_ref_clk.rate / (ref_div * (2 << 10));
+	ddr_pll += frac * ath79_ref_clk.rate / (ref_div * (1 << 10));
 	ddr_pll /= (1 << out_div);
 
 	clk_ctrl = ath79_pll_rr(AR934X_PLL_CPU_DDR_CLK_CTRL_REG);

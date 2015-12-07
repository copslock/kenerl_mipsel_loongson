Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2015 15:37:19 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:38698 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007796AbbLGOhRZw0jc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Dec 2015 15:37:17 +0100
Received: from localhost (unknown [66.228.68.140])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3F0DFBC6;
        Mon,  7 Dec 2015 14:37:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.1 32/95] MIPS: lantiq: add clk_round_rate()
Date:   Mon,  7 Dec 2015 09:35:26 -0500
Message-Id: <20151207142740.913723404@linuxfoundation.org>
X-Mailer: git-send-email 2.6.3
In-Reply-To: <20151207142739.317088107@linuxfoundation.org>
References: <20151207142739.317088107@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50358
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

4.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hauke Mehrtens <hauke@hauke-m.de>

commit 4e7d30dba493b60a80e9b590add1b4402265cc83 upstream.

This adds a basic implementation of clk_round_rate()
The clk_round_rate() function is called by multiple drivers and
subsystems now and the lantiq clk driver is supposed to export this,
but doesn't do so, this causes linking problems like this one:
ERROR: "clk_round_rate" [drivers/media/v4l2-core/videodev.ko] undefined!

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Acked-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/11358/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lantiq/clk.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/arch/mips/lantiq/clk.c
+++ b/arch/mips/lantiq/clk.c
@@ -99,6 +99,23 @@ int clk_set_rate(struct clk *clk, unsign
 }
 EXPORT_SYMBOL(clk_set_rate);
 
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	if (unlikely(!clk_good(clk)))
+		return 0;
+	if (clk->rates && *clk->rates) {
+		unsigned long *r = clk->rates;
+
+		while (*r && (*r != rate))
+			r++;
+		if (!*r) {
+			return clk->rate;
+		}
+	}
+	return rate;
+}
+EXPORT_SYMBOL(clk_round_rate);
+
 int clk_enable(struct clk *clk)
 {
 	if (unlikely(!clk_good(clk)))

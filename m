Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jul 2017 15:39:48 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:37526 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993942AbdGCNiXFjAOi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Jul 2017 15:38:23 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E572E8FF;
        Mon,  3 Jul 2017 13:38:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.4 041/101] MIPS: ralink: fix USB frequency scaling
Date:   Mon,  3 Jul 2017 15:34:41 +0200
Message-Id: <20170703133341.415913336@linuxfoundation.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170703133334.237346187@linuxfoundation.org>
References: <20170703133334.237346187@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58993
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Crispin <blogic@openwrt.org>

commit fad2522272ed5ed451d2d7b1dc547ddf3781cc7e upstream.

Commit 418d29c87061 ("MIPS: ralink: Unify SoC id handling") was not fully
correct. The logic for the SoC check got inverted. We need to check if it
is not a MT76x8.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/11992/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ralink/mt7620.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -459,7 +459,7 @@ void __init ralink_clk_init(void)
 	ralink_clk_add("10000c00.uartlite", periph_rate);
 	ralink_clk_add("10180000.wmac", xtal_rate);
 
-	if (IS_ENABLED(CONFIG_USB) && is_mt76x8()) {
+	if (IS_ENABLED(CONFIG_USB) && !is_mt76x8()) {
 		/*
 		 * When the CPU goes into sleep mode, the BUS clock will be
 		 * too low for USB to function properly. Adjust the busses

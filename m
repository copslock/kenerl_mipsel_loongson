Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jul 2017 15:40:13 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:37534 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993857AbdGCNiZROzli (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Jul 2017 15:38:25 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 19D1E927;
        Mon,  3 Jul 2017 13:38:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.4 042/101] MIPS: ralink: Fix invalid assignment of SoC type
Date:   Mon,  3 Jul 2017 15:34:42 +0200
Message-Id: <20170703133341.564426155@linuxfoundation.org>
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
X-archive-position: 58994
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

commit 0af3a40f09a2a85089037a0b5b51471fa48b229e upstream.

Commit 418d29c87061 ("MIPS: ralink: Unify SoC id handling") introduced
broken code. We obviously need to assign the value.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/11993/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ralink/rt288x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/ralink/rt288x.c
+++ b/arch/mips/ralink/rt288x.c
@@ -109,5 +109,5 @@ void prom_soc_init(struct ralink_soc_inf
 	soc_info->mem_size_max = RT2880_MEM_SIZE_MAX;
 
 	rt2880_pinmux_data = rt2880_pinmux_data_act;
-	ralink_soc == RT2880_SOC;
+	ralink_soc = RT2880_SOC;
 }

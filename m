Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Apr 2013 12:47:36 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:52576 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835132Ab3DOKplLk2nJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Apr 2013 12:45:41 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 7/7] MIPS: ralink: make use of the new memory detection code
Date:   Mon, 15 Apr 2013 12:41:34 +0200
Message-Id: <1366022494-8355-7-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1366022494-8355-1-git-send-email-blogic@openwrt.org>
References: <1366022494-8355-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Call detect_memory_region() from plat_mem_setup() unless the size was already
read from the system controller.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/of.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
index 4165e70..d285ea8 100644
--- a/arch/mips/ralink/of.c
+++ b/arch/mips/ralink/of.c
@@ -85,6 +85,13 @@ void __init plat_mem_setup(void)
 	 * parsed resulting in our memory appearing
 	 */
 	__dt_setup_arch(&__dtb_start);
+
+	if (soc_info.mem_size)
+		add_memory_region(soc_info.mem_base, soc_info.mem_size,
+				  BOOT_MEM_RAM);
+	else
+		detect_memory_region(soc_info.mem_base, soc_info.mem_size_min,
+				     soc_info.mem_size_max);
 }
 
 static int __init plat_of_setup(void)
-- 
1.7.10.4

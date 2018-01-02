Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 16:13:42 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:58552 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993124AbeABPJKTWEx9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 16:09:10 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 09/15] MIPS: platform: add machtype IDs for more Ingenic SoCs
Date:   Tue,  2 Jan 2018 16:08:42 +0100
Message-Id: <20180102150848.11314-9-paul@crapouillou.net>
In-Reply-To: <20180102150848.11314-1-paul@crapouillou.net>
References: <20180102150848.11314-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1514905747; bh=A2VmP7QlyPSuA8Uu7CyFVZHYV/6hQG7pc41Azovb+Ow=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tHra0ljdXVFtASVdEDqKW0UbQZBpiJbIb1KWOrFBCs4/AstD6IpEMG12ooQgMTWJgT/k+m47gAZ3922A9blx6fxbcJE5kaNvoWFXdmM8pM9OxEU/7q9Y4yE0W54whZKsJyoRUaadAykFl6UGUl7DMKHBrOrP6TUR+oo+ffUGJQQ=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Add a machtype ID for the JZ4780 SoC, which was missing, and one for the
newly supported JZ4770 SoC.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/include/asm/bootinfo.h | 2 ++
 1 file changed, 2 insertions(+)

 v2: No change
 v3: No change
 v5: No change

diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index e26a093bb17a..a301a8f4bc66 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -79,6 +79,8 @@ enum loongson_machine_type {
  */
 #define  MACH_INGENIC_JZ4730	0	/* JZ4730 SOC		*/
 #define  MACH_INGENIC_JZ4740	1	/* JZ4740 SOC		*/
+#define  MACH_INGENIC_JZ4770	2	/* JZ4770 SOC		*/
+#define  MACH_INGENIC_JZ4780	3	/* JZ4780 SOC		*/
 
 extern char *system_type;
 const char *get_system_type(void);
-- 
2.11.0

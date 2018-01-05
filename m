Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 19:29:10 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:36434 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993153AbeAESZaqep5s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jan 2018 19:25:30 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Maarten ter Huurne <maarten@treewalker.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v6 09/15] MIPS: platform: add machtype IDs for more Ingenic SoCs
Date:   Fri,  5 Jan 2018 19:25:07 +0100
Message-Id: <20180105182513.16248-10-paul@crapouillou.net>
In-Reply-To: <20180105182513.16248-1-paul@crapouillou.net>
References: <20180102150848.11314-1-paul@crapouillou.net>
 <20180105182513.16248-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1515176730; bh=w1FJsL95BAGmc8ENuYmYIHjgeHwr+F3k99ivUTVu6DY=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RX45Y4+gdD/GWYM1iMraCiOEW8Be7eT2gmfhlsHzWLMQSqJqr22vSOb6sQGVMKVgRoJCnKqTnoB5D2tnpxfJVpEYnVnbOEGP+yuZX7Wj4xc2COyDJcru9Z38gyGL/l5IVnBbAH2Vd2+yFV9PIb9Ca98F6wmsa4Hucco2Lwi3i+k=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61930
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
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
 arch/mips/include/asm/bootinfo.h | 2 ++
 1 file changed, 2 insertions(+)

 v2: No change
 v3: No change
 v4: No change
 v5: No change
 v6: No change

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

Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Oct 2014 00:30:41 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:36772
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27011129AbaJJW3RHdUoL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Oct 2014 00:29:17 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 05/10] MIPS: lantiq: export soc type
Date:   Sat, 11 Oct 2014 00:02:29 +0200
Message-Id: <1412978554-31344-6-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1412978554-31344-1-git-send-email-blogic@openwrt.org>
References: <1412978554-31344-1-git-send-email-blogic@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43230
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

The voice and dsl drivers need to know which SoC we are running on.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 arch/mips/include/asm/mach-lantiq/lantiq.h |    2 ++
 arch/mips/lantiq/prom.c                    |    5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/mips/include/asm/mach-lantiq/lantiq.h b/arch/mips/include/asm/mach-lantiq/lantiq.h
index f196cce..4e5ae65 100644
--- a/arch/mips/include/asm/mach-lantiq/lantiq.h
+++ b/arch/mips/include/asm/mach-lantiq/lantiq.h
@@ -48,6 +48,8 @@ extern struct clk *clk_get_ppe(void);
 extern unsigned char ltq_boot_select(void);
 /* find out what caused the last cpu reset */
 extern int ltq_reset_cause(void);
+/* find out the soc type */
+extern int ltq_soc_type(void);
 
 #define IOPORT_RESOURCE_START	0x10000000
 #define IOPORT_RESOURCE_END	0xffffffff
diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 7447d32..157f590 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -36,6 +36,11 @@ const char *get_system_type(void)
 	return soc_info.sys_type;
 }
 
+int ltq_soc_type(void)
+{
+	return soc_info.type;
+}
+
 void prom_free_prom_memory(void)
 {
 }
-- 
1.7.10.4

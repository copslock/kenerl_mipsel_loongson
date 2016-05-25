Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 May 2016 13:58:54 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16640 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27029060AbcEYL6v3GY00 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 May 2016 13:58:51 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id F3C4A81F9207B;
        Wed, 25 May 2016 12:58:41 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 25 May 2016 12:58:45 +0100
Received: from mredfearn-linux.kl.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 25 May 2016 12:58:44 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-mips@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>
Subject: [PATCH v2] MIPS: Pistachio: Enable KASLR
Date:   Wed, 25 May 2016 12:58:40 +0100
Message-ID: <1464177520-19751-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.5.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Allow KASLR to be selected on Pistachio based systems. Tested on a
Creator Ci40.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>

---

Changes in v2:
Add SYS_SUPPORTS_RELOCATABLE to Kconfig in alphabetical order

 arch/mips/Kconfig          | 1 +
 arch/mips/pistachio/init.c | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c5bedce4122d..b8613c251d72 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -397,6 +397,7 @@ config MACH_PISTACHIO
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_MIPS_CPS
 	select SYS_SUPPORTS_MULTITHREADING
+	select SYS_SUPPORTS_RELOCATABLE
 	select SYS_SUPPORTS_ZBOOT
 	select SYS_HAS_EARLY_PRINTK
 	select USE_GENERIC_EARLY_PRINTK_8250
diff --git a/arch/mips/pistachio/init.c b/arch/mips/pistachio/init.c
index 96ba2cc9ad3e..95f8767ce52e 100644
--- a/arch/mips/pistachio/init.c
+++ b/arch/mips/pistachio/init.c
@@ -52,12 +52,16 @@ static void __init plat_setup_iocoherency(void)
 	}
 }
 
-void __init plat_mem_setup(void)
+void __init *plat_get_fdt(void)
 {
 	if (fw_arg0 != -2)
 		panic("Device-tree not present");
+	return (void *)fw_arg1;
+}
 
-	__dt_setup_arch((void *)fw_arg1);
+void __init plat_mem_setup(void)
+{
+	__dt_setup_arch(plat_get_fdt());
 
 	plat_setup_iocoherency();
 }
-- 
2.5.0

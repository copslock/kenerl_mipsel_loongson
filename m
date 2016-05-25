Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 May 2016 12:49:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57197 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27029097AbcEYKt5oq9st (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 May 2016 12:49:57 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 892B7E76A16C6;
        Wed, 25 May 2016 11:49:48 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 25 May 2016 11:49:51 +0100
Received: from mredfearn-linux.kl.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 25 May 2016 11:49:51 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-mips@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>
Subject: [PATCH] MIPS: Pistachio: Enable KASLR
Date:   Wed, 25 May 2016 11:49:47 +0100
Message-ID: <1464173387-16847-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.5.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53654
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

---

 arch/mips/Kconfig          | 1 +
 arch/mips/pistachio/init.c | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c5bedce4122d..f1e59cbf5fe4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -398,6 +398,7 @@ config MACH_PISTACHIO
 	select SYS_SUPPORTS_MIPS_CPS
 	select SYS_SUPPORTS_MULTITHREADING
 	select SYS_SUPPORTS_ZBOOT
+	select SYS_SUPPORTS_RELOCATABLE
 	select SYS_HAS_EARLY_PRINTK
 	select USE_GENERIC_EARLY_PRINTK_8250
 	select USE_OF
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

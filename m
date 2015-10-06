Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Oct 2015 16:13:00 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59952 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009668AbbJFOMlu68ik (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Oct 2015 16:12:41 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 228FB5E27C790;
        Tue,  6 Oct 2015 15:12:33 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 6 Oct 2015 15:12:36 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 6 Oct 2015 15:12:35 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: [PATCH 1/2] MIPS: CDMM: Add builtin_mips_cdmm_driver() macro
Date:   Tue, 6 Oct 2015 15:12:05 +0100
Message-ID: <1444140726-5740-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.9
In-Reply-To: <1444140726-5740-1-git-send-email-james.hogan@imgtec.com>
References: <1444140726-5740-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Add helper macro builtin_mips_cdmm_driver() for builtin CDMM drivers
that don't do anything special in init and have no exit. The
module_mips_cdmm_driver() helper isn't really appropriate for drivers
that can't be built as a module.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.2.x-
---
 arch/mips/include/asm/cdmm.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/mips/include/asm/cdmm.h b/arch/mips/include/asm/cdmm.h
index bece2064cc8c..c06dbf8ba937 100644
--- a/arch/mips/include/asm/cdmm.h
+++ b/arch/mips/include/asm/cdmm.h
@@ -84,6 +84,17 @@ void mips_cdmm_driver_unregister(struct mips_cdmm_driver *);
 	module_driver(__mips_cdmm_driver, mips_cdmm_driver_register, \
 			mips_cdmm_driver_unregister)
 
+/*
+ * builtin_mips_cdmm_driver() - Helper macro for drivers that don't do anything
+ * special in init and have no exit. This eliminates some boilerplate. Each
+ * driver may only use this macro once, and calling it replaces device_initcall
+ * (or in some cases, the legacy __initcall). This is meant to be a direct
+ * parallel of module_mips_cdmm_driver() above but without the __exit stuff that
+ * is not used for builtin cases.
+ */
+#define builtin_mips_cdmm_driver(__mips_cdmm_driver) \
+	builtin_driver(__mips_cdmm_driver, mips_cdmm_driver_register)
+
 /* drivers/tty/mips_ejtag_fdc.c */
 
 #ifdef CONFIG_MIPS_EJTAG_FDC_EARLYCON
-- 
2.4.9

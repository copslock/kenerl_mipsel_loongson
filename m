Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2012 21:49:56 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:47695 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904069Ab2AKUtH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Jan 2012 21:49:07 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH RESEND 12/17] MAINTAINERS: add entry for Lantiq related files
Date:   Wed, 11 Jan 2012 21:44:29 +0100
Message-Id: <1326314674-9899-12-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1326314674-9899-1-git-send-email-blogic@openwrt.org>
References: <1326314674-9899-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Adds new entry to MAINTAINERS file for Lantiq SoC related code.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 MAINTAINERS |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4475602..caf9d00 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4362,6 +4362,18 @@ S:	Supported
 F:	Documentation/mips/
 F:	arch/mips/
 
+MIPS/LANTIQ
+M:	John Crispin <blogic@openwrt.org>
+M:	Thomas Langer <thomas.langer@lantiq.com>
+S:	Maintained
+F:	arch/mips/lantiq/*
+F:	drivers/i2c/busses/i2c-falcon.c 
+F:	drivers/mtd/maps/lantiq-flash.c
+F:	drivers/net/ethernet/lantiq_etop.c
+F:	drivers/spi/spi-falcon.c 
+F:	drivers/tty/serial/lantiq.c
+F:	drivers/watchdog/lantiq_wdt.c
+
 MISCELLANEOUS MCA-SUPPORT
 M:	James Bottomley <James.Bottomley@HansenPartnership.com>
 S:	Maintained
-- 
1.7.7.1

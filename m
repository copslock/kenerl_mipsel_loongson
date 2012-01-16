Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2012 17:45:55 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:56227 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903626Ab2APQoY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Jan 2012 17:44:24 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 12/17] MAINTAINERS: add entry for Lantiq related files
Date:   Mon, 16 Jan 2012 17:43:41 +0100
Message-Id: <1326732224-21336-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1326732224-21336-1-git-send-email-blogic@openwrt.org>
References: <1326732224-21336-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32256
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
Changes in V2
* only add entry for MIPS until all drivers are merged

 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4475602..99a0a96 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4362,6 +4362,12 @@ S:	Supported
 F:	Documentation/mips/
 F:	arch/mips/
 
+MIPS/LANTIQ
+M:	John Crispin <blogic@openwrt.org>
+M:	Thomas Langer <thomas.langer@lantiq.com>
+S:	Maintained
+F:	arch/mips/lantiq/*
+
 MISCELLANEOUS MCA-SUPPORT
 M:	James Bottomley <James.Bottomley@HansenPartnership.com>
 S:	Maintained
-- 
1.7.7.1

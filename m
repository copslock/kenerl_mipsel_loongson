Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Mar 2013 11:40:02 +0100 (CET)
Received: from cpsmtpb-ews04.kpnxchange.com ([213.75.39.7]:49409 "EHLO
        cpsmtpb-ews04.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834974Ab3CYKkAoc4zE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Mar 2013 11:40:00 +0100
Received: from cpsps-ews07.kpnxchange.com ([10.94.84.174]) by cpsmtpb-ews04.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 25 Mar 2013 11:39:55 +0100
Received: from CPSMTPM-TLF101.kpnxchange.com ([195.121.3.4]) by cpsps-ews07.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 25 Mar 2013 11:39:55 +0100
Received: from [192.168.1.100] ([212.123.139.93]) by CPSMTPM-TLF101.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 25 Mar 2013 11:39:54 +0100
Message-ID: <1364207994.1390.273.camel@x61.thuisdomein>
Subject: [PATCH] MIPS: Kconfig: Rename SNIPROM too
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:   Mon, 25 Mar 2013 11:39:54 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.4.4 (3.4.4-2.fc17) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Mar 2013 10:39:54.0436 (UTC) FILETIME=[16534040:01CE2945]
X-RcptDomain: linux-mips.org
X-archive-position: 35975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
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
Return-Path: <linux-mips-bounce@linux-mips.org>

CONFIG_SNIPROM was renamed to CONFIG_FW_SNIPROM in v3.8. Let's rename
SNIPROM itself too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested. Should this go into stable (for v3.8.y)?

 arch/mips/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index cd2e21f..b2df476 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -657,7 +657,7 @@ config SNI_RM
 	bool "SNI RM200/300/400"
 	select FW_ARC if CPU_LITTLE_ENDIAN
 	select FW_ARC32 if CPU_LITTLE_ENDIAN
-	select SNIPROM if CPU_BIG_ENDIAN
+	select FW_SNIPROM if CPU_BIG_ENDIAN
 	select ARCH_MAY_HAVE_PC_FDC
 	select BOOT_ELF32
 	select CEVT_R4K
@@ -1144,7 +1144,7 @@ config DEFAULT_SGI_PARTITION
 config FW_ARC32
 	bool
 
-config SNIPROM
+config FW_SNIPROM
 	bool
 
 config BOOT_ELF32
-- 
1.7.11.7

Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Aug 2015 14:04:14 +0200 (CEST)
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:38797 "EHLO
        mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010881AbbHAMDmcDwAt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 1 Aug 2015 14:03:42 +0200
X-IronPort-AV: E=Sophos;i="5.15,591,1432623600"; 
   d="scan'208";a="71359084"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw2-out.broadcom.com with ESMTP; 01 Aug 2015 05:22:55 -0700
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.235.1; Sat, 1 Aug 2015 05:03:37 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.3.235.1; Sat, 1 Aug 2015 05:03:37 -0700
Received: from netl-snoppy.ban.broadcom.com (unknown [10.132.128.129])  by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 303A340FE6;  Sat,  1 Aug
 2015 05:01:20 -0700 (PDT)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Kamlakant Patel <kamlakant.patel@broadcom.com>,
        Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 3/4] MIPS: Netlogic: set ARCH_REQUIRE_GPIOLIB for XLP platform
Date:   Sat, 1 Aug 2015 17:44:22 +0530
Message-ID: <1438431263-12427-4-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1438431263-12427-1-git-send-email-jchandra@broadcom.com>
References: <1438431263-12427-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

From: Kamlakant Patel <kamlakant.patel@broadcom.com>

This is needed to enable GPIO framework support for Netlogic XLP platform.

Signed-off-by: Kamlakant Patel <kamlakant.patel@broadcom.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index cee5f93..1920141 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -899,6 +899,7 @@ config NLM_XLP_BOARD
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select ARCH_PHYS_ADDR_T_64BIT
+	select ARCH_REQUIRE_GPIOLIB
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_HIGHMEM
-- 
1.9.1

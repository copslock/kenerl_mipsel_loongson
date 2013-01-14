Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2013 17:11:58 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:2063 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831956Ab3ANQKSZ-rDk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Jan 2013 17:10:18 +0100
Received: from [10.9.200.131] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 14 Jan 2013 08:04:51 -0800
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Mon, 14 Jan 2013 08:09:37 -0800
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id B168340FE5; Mon, 14
 Jan 2013 08:09:36 -0800 (PST)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 07/10] MIPS: Netlogic: No hazards needed for XLR/XLS
Date:   Mon, 14 Jan 2013 21:41:59 +0530
Message-ID: <1358179922-26663-8-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1358179922-26663-1-git-send-email-jchandra@broadcom.com>
References: <1358179922-26663-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7CEAF3283Q42009767-16-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35424
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
Return-Path: <linux-mips-bounce@linux-mips.org>

TLB and COP0 hazards are handled in hardware for Netlogic XLR/XLS
SoCs. Update hazards.h to pick more optimal set of definitions when
compiling for XLR/XLS.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/hazards.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/hazards.h b/arch/mips/include/asm/hazards.h
index f0324e9..9c309ae 100644
--- a/arch/mips/include/asm/hazards.h
+++ b/arch/mips/include/asm/hazards.h
@@ -141,7 +141,7 @@ do {									\
 
 #elif defined(CONFIG_MIPS_ALCHEMY) || defined(CONFIG_CPU_CAVIUM_OCTEON) || \
 	defined(CONFIG_CPU_LOONGSON2) || defined(CONFIG_CPU_R10000) || \
-	defined(CONFIG_CPU_R5500)
+	defined(CONFIG_CPU_R5500) || defined(CONFIG_CPU_XLR)
 
 /*
  * R10000 rocks - all hazards handled in hardware, so this becomes a nobrainer.
-- 
1.7.9.5

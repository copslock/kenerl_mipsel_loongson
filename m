Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2011 01:33:40 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:2323 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904284Ab1KJAdI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Nov 2011 01:33:08 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ebb1c150003>; Wed, 09 Nov 2011 16:34:29 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 9 Nov 2011 16:33:06 -0800
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 9 Nov 2011 16:33:06 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAA0X5WZ024240;
        Wed, 9 Nov 2011 16:33:05 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAA0X5nL024239;
        Wed, 9 Nov 2011 16:33:05 -0800
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 2/2] MIPS: Randomize PIE load address
Date:   Wed,  9 Nov 2011 16:32:58 -0800
Message-Id: <1320885178-24201-2-git-send-email-david.daney@cavium.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1320885178-24201-1-git-send-email-david.daney@cavium.com>
References: <1320885178-24201-1-git-send-email-david.daney@cavium.com>
X-OriginalArrivalTime: 10 Nov 2011 00:33:06.0059 (UTC) FILETIME=[50490DB0:01CC9F40]
X-archive-position: 31489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8372

... by selecting ARCH_BINFMT_ELF_RANDOMIZE_PIE

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8f1b76a..64934ad 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -25,6 +25,7 @@ config MIPS
 	select GENERIC_IRQ_SHOW
 	select HAVE_ARCH_JUMP_LABEL
 	select IRQ_FORCED_THREADING
+	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
 
 menu "Machine selection"
 
-- 
1.7.2.3

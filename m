Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2011 22:23:38 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17650 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491147Ab1EKUWn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 May 2011 22:22:43 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4dcaf04f0001>; Wed, 11 May 2011 13:23:43 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 11 May 2011 13:22:41 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 11 May 2011 13:22:41 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p4BKMZEU032646;
        Wed, 11 May 2011 13:22:35 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p4BKMYCP032644;
        Wed, 11 May 2011 13:22:34 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 1/3] MIPS: lantiq: Add missing include to mach-easy50712.c
Date:   Wed, 11 May 2011 13:22:25 -0700
Message-Id: <1305145347-32605-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1305145347-32605-1-git-send-email-ddaney@caviumnetworks.com>
References: <1305145347-32605-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 11 May 2011 20:22:41.0152 (UTC) FILETIME=[2D8FB000:01CC1019]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Without this we fail building with a missing definition for
PHY_INTERFACE_MODE_MII.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Cc: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/xway/mach-easy50712.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/lantiq/xway/mach-easy50712.c b/arch/mips/lantiq/xway/mach-easy50712.c
index 2512561..30b8000 100644
--- a/arch/mips/lantiq/xway/mach-easy50712.c
+++ b/arch/mips/lantiq/xway/mach-easy50712.c
@@ -12,6 +12,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/input.h>
+#include <linux/phy.h>
 
 #include <lantiq_soc.h>
 #include <irq.h>
-- 
1.7.2.3

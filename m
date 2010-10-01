Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Oct 2010 22:29:28 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8590 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492023Ab0JAU1w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Oct 2010 22:27:52 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ca644660001>; Fri, 01 Oct 2010 13:28:22 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 1 Oct 2010 13:27:52 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 1 Oct 2010 13:27:52 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o91KRiCU028716;
        Fri, 1 Oct 2010 13:27:44 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o91KRiRU028715;
        Fri, 1 Oct 2010 13:27:44 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 4/8] MIPS: Octeon: Select ZONE_DMA32
Date:   Fri,  1 Oct 2010 13:27:30 -0700
Message-Id: <1285964854-28659-5-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.2
In-Reply-To: <1285964854-28659-1-git-send-email-ddaney@caviumnetworks.com>
References: <1285964854-28659-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 01 Oct 2010 20:27:52.0189 (UTC) FILETIME=[1F3FAAD0:01CB61A7]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Give us a nice place to allocate coherent DMA memory for 32-bit
devices.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5526faa..6c33709 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -693,6 +693,7 @@ config CAVIUM_OCTEON_REFERENCE_BOARD
 	select SWAP_IO_SPACE
 	select HW_HAS_PCI
 	select ARCH_SUPPORTS_MSI
+	select ZONE_DMA32
 	help
 	  This option supports all of the Octeon reference boards from Cavium
 	  Networks. It builds a kernel that dynamically determines the Octeon
-- 
1.7.2.2

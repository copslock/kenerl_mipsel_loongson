Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Mar 2015 18:03:14 +0200 (CEST)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:41441 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014775AbbC3QBVrv7KM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Mar 2015 18:01:21 +0200
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id A4C49460BD6
        for <linux-mips@linux-mips.org>; Mon, 30 Mar 2015 17:01:22 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Wm1KfV1qEd57 for <linux-mips@linux-mips.org>;
        Mon, 30 Mar 2015 17:01:20 +0100 (BST)
Received: from pm-laptop.codethink.co.uk (pm-laptop.dyn.ducie.codethink.co.uk [10.24.1.94])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id A4E4F460C47
        for <linux-mips@linux-mips.org>; Mon, 30 Mar 2015 17:01:04 +0100 (BST)
Received: from pm by pm-laptop.codethink.co.uk with local (Exim 4.84)
        (envelope-from <paul.martin@codethink.co.uk>)
        id 1Ycc7c-0007oP-EV
        for linux-mips@linux-mips.org; Mon, 30 Mar 2015 17:01:04 +0100
From:   Paul Martin <paul.martin@codethink.co.uk>
To:     linux-mips@linux-mips.org
Subject: [PATCH 10/10] MIPS: OCTEON: Fix Kconfig file typo
Date:   Mon, 30 Mar 2015 17:01:03 +0100
Message-Id: <1427731263-29950-11-git-send-email-paul.martin@codethink.co.uk>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1427731263-29950-1-git-send-email-paul.martin@codethink.co.uk>
References: <1427731263-29950-1-git-send-email-paul.martin@codethink.co.uk>
Return-Path: <paul.martin@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.martin@codethink.co.uk
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

Signed-off-by: Paul Martin <paul.martin@codethink.co.uk>
---
 arch/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 68e64cb..c4d0229 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -780,7 +780,7 @@ config CAVIUM_OCTEON_SOC
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select EDAC_SUPPORT
 	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_SUPPORTS_HOTPLUG_CPU if CONFIG_CPU_BIG_ENDIAN
+	select SYS_SUPPORTS_HOTPLUG_CPU if CPU_BIG_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
 	select SYS_HAS_CPU_CAVIUM_OCTEON
 	select SWAP_IO_SPACE
-- 
2.1.4

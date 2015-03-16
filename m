Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Mar 2015 19:21:06 +0100 (CET)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:38153 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013952AbbCPSTJ0YVIL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Mar 2015 19:19:09 +0100
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id BEAD546088B
        for <linux-mips@linux-mips.org>; Mon, 16 Mar 2015 18:19:04 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hqB1R2Mwp1pY; Mon, 16 Mar 2015 18:19:02 +0000 (GMT)
Received: from pm-laptop.codethink.co.uk (pm-laptop.dyn.ducie.codethink.co.uk [10.24.1.94])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 62DF44608DE;
        Mon, 16 Mar 2015 18:18:53 +0000 (GMT)
Received: from pm by pm-laptop.codethink.co.uk with local (Exim 4.84)
        (envelope-from <paul.martin@codethink.co.uk>)
        id 1YXZbJ-0003UJ-0j; Mon, 16 Mar 2015 18:18:53 +0000
From:   Paul Martin <paul.martin@codethink.co.uk>
To:     linux-mips@linux-mips.org
Cc:     Paul Martin <paul.martin@codethink.co.uk>
Subject: [PATCH 7/7] MIPS: OCTEON: Tell the kernel build system we can do Little Endian
Date:   Mon, 16 Mar 2015 18:18:43 +0000
Message-Id: <1426529923-13340-8-git-send-email-paul.martin@codethink.co.uk>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426529923-13340-1-git-send-email-paul.martin@codethink.co.uk>
References: <1426529923-13340-1-git-send-email-paul.martin@codethink.co.uk>
Return-Path: <paul.martin@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46412
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

Update the Kconfig file so that the configure system will
allow us to build the kernel little endian.

Signed-off-by: Paul Martin <paul.martin@codethink.co.uk>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f7804e9..a3687fa 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -778,6 +778,7 @@ config CAVIUM_OCTEON_SOC
 	select DMA_COHERENT
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select EDAC_SUPPORT
 	select SYS_SUPPORTS_HOTPLUG_CPU
 	select SYS_HAS_EARLY_PRINTK
-- 
2.1.4

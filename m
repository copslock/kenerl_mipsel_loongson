Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2015 22:16:10 +0100 (CET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:42651 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011192AbbJ2VQAe8tVr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Oct 2015 22:16:00 +0100
Received: from localhost.localdomain (85-76-112-16-nat.elisa-mobile.fi [85.76.112.16])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id D5EFF23403C;
        Thu, 29 Oct 2015 23:15:59 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     linux-mips@linux-mips.org,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>
Subject: [PATCH] MIPS: vmlinux: discard .MIPS.abiflags
Date:   Thu, 29 Oct 2015 23:15:59 +0200
Message-Id: <1446153359-12039-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.4.0
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Discard .MIPS.abiflags from vmlinux. It's not needed and will cause
issues e.g. with old OCTEON bootloaders.

Suggested-by: Matthew Fortune <matthew.fortune@imgtec.com>
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/kernel/vmlinux.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 07d32a4..06632d6 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -181,6 +181,7 @@ SECTIONS
 	DISCARDS
 	/DISCARD/ : {
 		/* ABI crap starts here */
+		*(.MIPS.abiflags)
 		*(.MIPS.options)
 		*(.options)
 		*(.pdr)
-- 
2.4.0

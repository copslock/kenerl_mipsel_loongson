Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2013 11:23:02 +0200 (CEST)
Received: from jacques.telenet-ops.be ([195.130.132.50]:41201 "EHLO
        jacques.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822451Ab3IEJXAXeEU3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Sep 2013 11:23:00 +0200
Received: from ayla.of.borg ([84.193.72.141])
        by jacques.telenet-ops.be with bizsmtp
        id MMNw1m01X32ts5g0JMNwz8; Thu, 05 Sep 2013 11:22:59 +0200
Received: from geert by ayla.of.borg with local (Exim 4.76)
        (envelope-from <geert@linux-m68k.org>)
        id 1VHVm7-0007AX-W3; Thu, 05 Sep 2013 11:22:52 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] MIPS: Export copy_from_user_page() (needed by lustre)
Date:   Thu,  5 Sep 2013 11:22:45 +0200
Message-Id: <1378372965-27213-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

ERROR: "copy_from_user_page" [drivers/staging/lustre/lustre/libcfs/libcfs.ko] undefined!

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/mips/mm/init.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 4e73f10..e205ef5 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -254,6 +254,7 @@ void copy_from_user_page(struct vm_area_struct *vma,
 			SetPageDcacheDirty(page);
 	}
 }
+EXPORT_SYMBOL_GPL(copy_from_user_page);
 
 void __init fixrange_init(unsigned long start, unsigned long end,
 	pgd_t *pgd_base)
-- 
1.7.9.5

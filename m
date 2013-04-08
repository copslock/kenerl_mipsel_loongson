Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Apr 2013 18:54:37 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:1389 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834999Ab3DHQxZLKY7R (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 8 Apr 2013 18:53:25 +0200
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <kevink@paralogos.com>, <macro@linux-mips.org>, <john@phrozen.org>
CC:     <Steven.Hill@imgtec.com>, <dengcheng.zhu@imgtec.com>
Subject: [PATCH v4 3/5] MIPS: APRP (APSP): remove kspd.h
Date:   Mon, 8 Apr 2013 09:53:00 -0700
Message-ID: <1365439982-4117-4-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1365439982-4117-1-git-send-email-dengcheng.zhu@imgtec.com>
References: <1365439982-4117-1-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-SEF-Processed: 7_3_0_01181__2013_04_08_17_53_20
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36029
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>

Now that KSPD is gone, kspd.h has no reason to be there.

Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
 arch/mips/include/asm/kspd.h |   32 --------------------------------
 1 files changed, 0 insertions(+), 32 deletions(-)
 delete mode 100644 arch/mips/include/asm/kspd.h

diff --git a/arch/mips/include/asm/kspd.h b/arch/mips/include/asm/kspd.h
deleted file mode 100644
index ec68329..0000000
--- a/arch/mips/include/asm/kspd.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- * Copyright (C) 2005 MIPS Technologies, Inc.  All rights reserved.
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- */
-
-#ifndef _ASM_KSPD_H
-#define _ASM_KSPD_H
-
-struct kspd_notifications {
-	void (*kspd_sp_exit)(int sp_id);
-
-	struct list_head list;
-};
-
-static inline void kspd_notify(struct kspd_notifications *notify)
-{
-}
-
-#endif
-- 
1.7.1

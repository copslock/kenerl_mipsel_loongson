Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2014 12:51:19 +0200 (CEST)
Received: from andre.telenet-ops.be ([195.130.132.53]:41803 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825879AbaDVKvRrYsiv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Apr 2014 12:51:17 +0200
Received: from ayla.of.borg ([84.193.72.141])
        by andre.telenet-ops.be with bizsmtp
        id syrG1n00e32ts5g01yrG22; Tue, 22 Apr 2014 12:51:17 +0200
Received: from geert by ayla.of.borg with local (Exim 4.76)
        (envelope-from <geert@linux-m68k.org>)
        id 1WcYIG-00058j-Ni; Tue, 22 Apr 2014 12:51:16 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] mips: Update the email address of Geert Uytterhoeven
Date:   Tue, 22 Apr 2014 12:51:13 +0200
Message-Id: <1398163873-19728-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39886
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

All my Sony addresses are defunct.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/mips/include/asm/nile4.h |    2 +-
 arch/mips/pci/ops-pmcmsp.c    |    2 +-
 arch/mips/pci/ops-tx3927.c    |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/nile4.h b/arch/mips/include/asm/nile4.h
index 2e2436d0e94e..99e97f8bfbca 100644
--- a/arch/mips/include/asm/nile4.h
+++ b/arch/mips/include/asm/nile4.h
@@ -1,7 +1,7 @@
 /*
  *  asm-mips/nile4.h -- NEC Vrc-5074 Nile 4 definitions
  *
- *  Copyright (C) 2000 Geert Uytterhoeven <geert@sonycom.com>
+ *  Copyright (C) 2000 Geert Uytterhoeven <geert@linux-m68k.org>
  *		       Sony Software Development Center Europe (SDCE), Brussels
  *
  *  This file is based on the following documentation:
diff --git a/arch/mips/pci/ops-pmcmsp.c b/arch/mips/pci/ops-pmcmsp.c
index 3d27800edba2..50034f985be1 100644
--- a/arch/mips/pci/ops-pmcmsp.c
+++ b/arch/mips/pci/ops-pmcmsp.c
@@ -7,7 +7,7 @@
  * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
  *
  * Much of the code is derived from the original DDB5074 port by
- * Geert Uytterhoeven <geert@sonycom.com>
+ * Geert Uytterhoeven <geert@linux-m68k.org>
  *
  * This program is free software; you can redistribute	it and/or modify it
  * under  the terms of	the GNU General	 Public License as published by the
diff --git a/arch/mips/pci/ops-tx3927.c b/arch/mips/pci/ops-tx3927.c
index 02d64f77e967..d35dc9c9ab9d 100644
--- a/arch/mips/pci/ops-tx3927.c
+++ b/arch/mips/pci/ops-tx3927.c
@@ -11,7 +11,7 @@
  *     Define the pci_ops for TX3927.
  *
  * Much of the code is derived from the original DDB5074 port by
- * Geert Uytterhoeven <geert@sonycom.com>
+ * Geert Uytterhoeven <geert@linux-m68k.org>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
-- 
1.7.9.5

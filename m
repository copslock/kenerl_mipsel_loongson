Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2011 22:40:02 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45608 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492153Ab1HRUj6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Aug 2011 22:39:58 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p7IKdv7q001875
        for <linux-mips@linux-mips.org>; Thu, 18 Aug 2011 21:39:57 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p7IKdvWa001874
        for linux-mips@linux-mips.org; Thu, 18 Aug 2011 21:39:57 +0100
Resent-From: Ralf Baechle <ralf@linux-mips.org>
Resent-Date: Thu, 18 Aug 2011 21:39:57 +0100
Resent-Message-ID: <20110818203957.GA1866@linux-mips.org>
Resent-To: linux-mips@linux-mips.org
Date:   Thu, 18 Aug 2011 21:39:28 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     nbd@openwrt.org, florian@openwrt.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] NET: Korina: Don't include <asm/segment.h>
Message-ID: <20110818203928.GA745@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13656

Korina.c is a MIPS-specific SOC driver and <asm/segment> is empty on
MIPS since 2.1.7 ...

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

---
I have another patch to remove the MIPS <asm/segment.h> which will be
unused after this patch, therefore I'd like to merge this patch through
the MIPS tree.

 drivers/net/korina.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/net/korina.c b/drivers/net/korina.c
index 763844c..2fc3d4a 100644
--- a/drivers/net/korina.c
+++ b/drivers/net/korina.c
@@ -58,7 +58,6 @@
 #include <asm/system.h>
 #include <asm/bitops.h>
 #include <asm/pgtable.h>
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <asm/dma.h>
 

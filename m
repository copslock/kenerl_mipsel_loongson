Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Sep 2009 09:14:48 +0200 (CEST)
Received: from mail-px0-f176.google.com ([209.85.216.176]:63664 "EHLO
	mail-px0-f176.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492097AbZIRHOl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 18 Sep 2009 09:14:41 +0200
Received: by pxi6 with SMTP id 6so681178pxi.21
        for <multiple recipients>; Fri, 18 Sep 2009 00:14:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=xn0cI6J/xR+NtmvDKlzecuTqp/TO+cAHInSZbLhcZaI=;
        b=FKoVeOvLt6KL3pj/5Y5Q2vQGChIpQF18mtybE6IjcsjLskkFbvhD2i2UG5oNcOQ9kf
         sTDMKBObmGMOscGLPBN10Rdxxg+Zy/SM5H2j3u39PtZL6B9prq6wAjGDvsfBEth1OWjS
         cDhy6zz3oexC6V3O0Pq9cS7xJ5xpnGDjoCD0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=EPiUAX8wjvA2Tl3ga/Xu3Hs8J5UvJvW3RHsv+IJrkCJxPu8fmafeJ/zlsobgURG4wg
         fehElCFRI59HxTftyU9v3gM7mwbvh8Z4z9PjapNh0LCRbTShlhGu5//OLzyFdHmuD7PB
         LE5Sn5Mt0e1E2QKaGBW6H8WbqhrqNJ95Yga2s=
Received: by 10.114.162.20 with SMTP id k20mr1892903wae.135.1253258072736;
        Fri, 18 Sep 2009 00:14:32 -0700 (PDT)
Received: from localhost.localdomain ([58.212.86.177])
        by mx.google.com with ESMTPS id 20sm762569pxi.12.2009.09.18.00.14.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Sep 2009 00:14:31 -0700 (PDT)
From:	Huang Weiyi <weiyi.huang@gmail.com>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Huang Weiyi <weiyi.huang@gmail.com>
Subject: [PATCH 1/2] MIPS: BCM63xx: remove duplicated #include
Date:	Fri, 18 Sep 2009 15:14:19 +0800
Message-Id: <1253258059-3340-1-git-send-email-weiyi.huang@gmail.com>
X-Mailer: git-send-email 1.6.1.2
Return-Path: <weiyi.huang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: weiyi.huang@gmail.com
Precedence: bulk
X-list: linux-mips

Remove duplicated #include('s) in
  arch/mips/bcm63xx/boards/board_bcm963xx.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/mips/bcm63xx/boards/board_bcm963xx.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index fd77f54..12add0c 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -20,7 +20,6 @@
 #include <bcm63xx_cpu.h>
 #include <bcm63xx_regs.h>
 #include <bcm63xx_io.h>
-#include <bcm63xx_board.h>
 #include <bcm63xx_dev_pci.h>
 #include <bcm63xx_dev_enet.h>
 #include <bcm63xx_dev_dsp.h>
-- 
1.6.1.3

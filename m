Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Oct 2009 13:54:16 +0200 (CEST)
Received: from mail-fx0-f225.google.com ([209.85.220.225]:61107 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492419AbZJQLyK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 17 Oct 2009 13:54:10 +0200
Received: by fxm25 with SMTP id 25so3501127fxm.0
        for <linux-mips@linux-mips.org>; Sat, 17 Oct 2009 04:54:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Rm6xSFhoyEKB82ALlhgCN7wIXK2/OA4K5qP3RWPE0fM=;
        b=nF91tuMMLEkZpLuTqCi2Gt6Sfr9qs/Aw/BUnnsffifmHlLkLYuZIhk0Mb499J5UVZB
         zvBVSvbSd1FarKZ+ztSmN22a6Iyr031qAf70xl/ZzCq0W6otztdrQwu2G/X+qnro8iWJ
         KqGZ6ehb+Dxy+jmd7IL+IsFWHNxuyaMMt+Xrs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=n4GbD3DwU5VrgQlVOcZenhgcKiKfMT8KTUJ0Au8n8Csttm0gC3SJVsDGklN8oTckrh
         FYt39lL6lqU2+XJNZPbQ+wX/2b/rNFEmGX6IqMsGWaRSJjWxHJdtzb/35DBr+NC72WuE
         moDPlJzjxt3F8qTyyMuWi1AoFPRk8oRcJsZB0=
Received: by 10.204.13.204 with SMTP id d12mr2415736bka.61.1255780444504;
        Sat, 17 Oct 2009 04:54:04 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id 13sm343004bwz.10.2009.10.17.04.54.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Oct 2009 04:54:03 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	linux-netdev@vger.kernel.org
Cc:	linux-mips@linux-mips.org, Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] net: au1000_eth: add missing capability.h
Date:	Sat, 17 Oct 2009 13:54:34 +0200
Message-Id: <1255780474-944-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.rc2
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

fixes the following build failure:
  CC      drivers/net/au1000_eth.o
/drivers/net/au1000_eth.c: In function 'au1000_set_settings':
/drivers/net/au1000_eth.c:623: error: implicit declaration of function 'capable'
/drivers/net/au1000_eth.c:623: error: 'CAP_NET_ADMIN' undeclared (first use in this function)
/drivers/net/au1000_eth.c:623: error: (Each undeclared identifier is reported only once
/drivers/net/au1000_eth.c:623: error: for each function it appears in.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 drivers/net/au1000_eth.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/au1000_eth.c b/drivers/net/au1000_eth.c
index 04f63c7..ce6f1ac 100644
--- a/drivers/net/au1000_eth.c
+++ b/drivers/net/au1000_eth.c
@@ -34,6 +34,7 @@
  *
  *
  */
+#include <linux/capability.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-- 
1.6.5.rc2

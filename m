Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Oct 2009 17:31:31 +0200 (CEST)
Received: from mail-ew0-f214.google.com ([209.85.219.214]:57601 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493437AbZJGPbZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Oct 2009 17:31:25 +0200
Received: by ewy10 with SMTP id 10so5176065ewy.33
        for <multiple recipients>; Wed, 07 Oct 2009 08:31:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=+SPv8ow2U0YLVo0qZYkHN6lkXoNBUlwvfUusiEBt6pw=;
        b=BGXib3BtpsaqsxcS8Suuf0quF/e/injDrkv0MXYTKtoEuYIpfzNk/ROsKxKSCXS9jN
         dM/ovzt+hcvWwAaVfFUtZVmzeIy9j7qlEAyQRnnQpDaYE8hvlb/mttPi4KvSMsGeqQdt
         nQtIrbxvGsTgf80xkApetu0iRQdRa6HifHw7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=iBqFSMG7kYb9QGlAMUH7f9IX00Qr7AD7imro6exTotUE8YHHbH8cBVmcyRfQ1VKoV1
         4KyNk6kONHVhf9GKj5Pal01lUw5po3RbUUrlx7LIwrSek1eF1XAKD3WNNbVDQXitQT0J
         MOf/gyUDQtSCRFVETGQEGJ8hre2576QGVAGlY=
Received: by 10.216.91.82 with SMTP id g60mr12943wef.98.1254929479616;
        Wed, 07 Oct 2009 08:31:19 -0700 (PDT)
Received: from localhost.localdomain (p5496B5E8.dip.t-dialin.net [84.150.181.232])
        by mx.google.com with ESMTPS id t12sm161148gvd.7.2009.10.07.08.31.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Oct 2009 08:31:18 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH -queue] Alchemy: fix pb1100/pb1500 compile failures
Date:	Wed,  7 Oct 2009 17:31:17 +0200
Message-Id: <1254929477-6697-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.rc2
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

forgot to remove inclusion of removed headers and add required ones.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
Extends  "MIPS: Alchemy: devboards: wire up new PCMCIA driver" in
Ralf's linux-queue tree.

Please apply or fold into the above mentioned patch!
Thanks!

 arch/mips/alchemy/devboards/pb1100/board_setup.c |    1 -
 arch/mips/alchemy/devboards/pb1100/platform.c    |    2 ++
 arch/mips/alchemy/devboards/pb1500/board_setup.c |    1 -
 arch/mips/alchemy/devboards/pb1500/platform.c    |    1 +
 4 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/alchemy/devboards/pb1100/board_setup.c b/arch/mips/alchemy/devboards/pb1100/board_setup.c
index aad424a..b282d93 100644
--- a/arch/mips/alchemy/devboards/pb1100/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1100/board_setup.c
@@ -29,7 +29,6 @@
 #include <linux/interrupt.h>
 
 #include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-pb1x00/pb1100.h>
 #include <asm/mach-db1x00/bcsr.h>
 
 #include <prom.h>
diff --git a/arch/mips/alchemy/devboards/pb1100/platform.c b/arch/mips/alchemy/devboards/pb1100/platform.c
index 8aefecd..8487da5 100644
--- a/arch/mips/alchemy/devboards/pb1100/platform.c
+++ b/arch/mips/alchemy/devboards/pb1100/platform.c
@@ -20,6 +20,8 @@
 
 #include <linux/init.h>
 
+#include <asm/mach-au1x00/au1000.h>
+
 #include "../platform.h"
 
 static int __init pb1100_dev_init(void)
diff --git a/arch/mips/alchemy/devboards/pb1500/board_setup.c b/arch/mips/alchemy/devboards/pb1500/board_setup.c
index 4c4facb..a148802 100644
--- a/arch/mips/alchemy/devboards/pb1500/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1500/board_setup.c
@@ -29,7 +29,6 @@
 #include <linux/interrupt.h>
 
 #include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-pb1x00/pb1500.h>
 #include <asm/mach-db1x00/bcsr.h>
 
 #include <prom.h>
diff --git a/arch/mips/alchemy/devboards/pb1500/platform.c b/arch/mips/alchemy/devboards/pb1500/platform.c
index beb21e4..6c00cbe 100644
--- a/arch/mips/alchemy/devboards/pb1500/platform.c
+++ b/arch/mips/alchemy/devboards/pb1500/platform.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/init.h>
+#include <asm/mach-au1x00/au1000.h>
 
 #include "../platform.h"
 
-- 
1.6.5.rc2

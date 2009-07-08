Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jul 2009 00:15:00 +0200 (CEST)
Received: from mail-px0-f178.google.com ([209.85.216.178]:36788 "EHLO
	mail-px0-f178.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492555AbZGHWOy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Jul 2009 00:14:54 +0200
Received: by pxi8 with SMTP id 8so1441816pxi.22
        for <multiple recipients>; Wed, 08 Jul 2009 15:14:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=R9HM4avZCStq1PST7mLZCYSCOjsxiBShf3nhQv299FU=;
        b=G44woeA/xdem2yNGAqETlnK0OeLxQURwNqxTrugu22pb4q0COkYHgq3l3xaBep+OeI
         h4XZviHpbjOdnR3cZGiqGRXp43pGKpV8hWORjnhyBh5Q5+yGl51Him66O0xr9tH7zISX
         7zDLXO22W+qhDbFISzGhBVNKCLlps1UQKp3cA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Jx/YwKdqLVoLPS9m8UttPE5aTKwWgnCKKiAOINRxepLl7/M6vhzxEJsA4EYGPYAq3Y
         69XPXAr5UEKFsot46Cn3a1n8VfDpi8vkmZYTX8vg1jtppW9p1v463uzB1TjLqbqY8Gbp
         dPBbvPNn8vA9cfXkvxSSehDSH5wS1Eqx32h+k=
Received: by 10.115.58.20 with SMTP id l20mr76358wak.2.1247091285309;
        Wed, 08 Jul 2009 15:14:45 -0700 (PDT)
Received: from localhost.localdomain ([222.95.172.206])
        by mx.google.com with ESMTPS id j15sm5306782waf.51.2009.07.08.15.14.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Jul 2009 15:14:44 -0700 (PDT)
From:	Huang Weiyi <weiyi.huang@gmail.com>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Huang Weiyi <weiyi.huang@gmail.com>
Subject: [PATCH] MIPS: remove unused #include <linux/version.h>'s
Date:	Thu,  9 Jul 2009 06:14:37 +0800
Message-Id: <1247091277-3612-1-git-send-email-weiyi.huang@gmail.com>
X-Mailer: git-send-email 1.6.1.2
Return-Path: <weiyi.huang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23685
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: weiyi.huang@gmail.com
Precedence: bulk
X-list: linux-mips

Remove unused #include <linux/version.h>('s) in
  arch/mips/ar7/platform.c
  arch/mips/ar7/setup.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/mips/ar7/platform.c |    1 -
 arch/mips/ar7/setup.c    |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index 5422449..c4d71fb 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -28,7 +28,6 @@
 #include <linux/serial_8250.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
-#include <linux/version.h>
 #include <linux/vlynq.h>
 #include <linux/leds.h>
 #include <linux/string.h>
diff --git a/arch/mips/ar7/setup.c b/arch/mips/ar7/setup.c
index 6ebb5f1..39f6b5b 100644
--- a/arch/mips/ar7/setup.c
+++ b/arch/mips/ar7/setup.c
@@ -15,7 +15,6 @@
  *  with this program; if not, write to the Free Software Foundation, Inc.,
  *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
  */
-#include <linux/version.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/pm.h>
-- 
1.6.1.2

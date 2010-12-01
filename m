Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2010 17:34:58 +0100 (CET)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:47541 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493026Ab0LAQez (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Dec 2010 17:34:55 +0100
Received: by pwj8 with SMTP id 8so1387749pwj.36
        for <multiple recipients>; Wed, 01 Dec 2010 08:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=MroLykGlReq/tIZgiDgM9slRnup+A+Uqn1Cm2l9Yzx8=;
        b=uJoU+uKxgd0f6r9I7a/CL461xRwVOOldHCQY1cfXHvlVILCINbw4ORokDRdCUR65gL
         b2/TkvbeAUUu9uUb0B9aGPML4lMxQnCbMez6Z8G7KzZVV+0/e5hrGk3bZF/irZEexNd9
         vyNqhpucvJNtWIFHRx2NwGPS2ijRm3iuJr8lc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=SBtUKUia2YBPC4CIwIbhFobNk0zJdx+znFY0N4Kr4rKMa73OkfAwFlX+uKzNk0ItLX
         +GYYzath/CacsPl7b2NRz/F+WaFxnb+ayFZFiFHEHkFPD1SXl9ODsaDRtZgO5Apvz9zu
         3mmwjNdg7Oeok11QJqzu7eY6QxkfAyZpYoTss=
Received: by 10.142.192.20 with SMTP id p20mr9104526wff.42.1291221288617;
        Wed, 01 Dec 2010 08:34:48 -0800 (PST)
Received: from localhost.localdomain ([211.201.183.198])
        by mx.google.com with ESMTPS id w42sm183330wfh.15.2010.12.01.08.34.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 08:34:47 -0800 (PST)
From:   Namhyung Kim <namhyung@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Fix build failure on mips_sc_is_activated()
Date:   Thu,  2 Dec 2010 01:34:42 +0900
Message-Id: <1291221282-9056-1-git-send-email-namhyung@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <namhyung@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: namhyung@gmail.com
Precedence: bulk
X-list: linux-mips

The commit ea31a6b20371 ("MIPS: Honor L2 bypass bit") breaks
malta build as follows. Looks like not compile-tested :(

  CC      arch/mips/mm/sc-mips.o
arch/mips/mm/sc-mips.c: In function 'mips_sc_is_activated':
arch/mips/mm/sc-mips.c:77:7 error: 'config2' undeclared (first use in this function)
arch/mips/mm/sc-mips.c:77:7 note: each undeclared identifier is reported only once
arch/mips/mm/sc-mips.c:77:7       for each function it appears in
arch/mips/mm/sc-mips.c:81:2 error: 'tmp' undeclared (first use in this function)
arch/mips/mm/sc-mips.c:86:1 warning: control reaches end of non-void function
make[3]: *** [arch/mips/mm/sc-mips.o] Error 1
make[2]: *** [arch/mips/mm/sc-mips.o] Error 2
make[1]: *** [sub-make] Error 2
make: *** [all] Error 2

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 arch/mips/mm/sc-mips.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 505feca..a168f52 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -66,8 +66,11 @@ static struct bcache_ops mips_sc_ops = {
  * 12..15 as implementation defined so below function will eventually have
  * to be replaced by a platform specific probe.
  */
-static inline int mips_sc_is_activated(struct cpuinfo_mips *c)
+static inline int mips_sc_is_activated(struct cpuinfo_mips *c,
+				       unsigned int config2)
 {
+	unsigned int tmp;
+
 	/* Check the bypass bit (L2B) */
 	switch (c->cputype) {
 	case CPU_34K:
@@ -83,6 +86,8 @@ static inline int mips_sc_is_activated(struct cpuinfo_mips *c)
 		c->scache.linesz = 2 << tmp;
 	else
 		return 0;
+
+	return 1;
 }
 
 static inline int __init mips_sc_probe(void)
@@ -108,7 +113,7 @@ static inline int __init mips_sc_probe(void)
 
 	config2 = read_c0_config2();
 
-	if (!mips_sc_is_activated(c))
+	if (!mips_sc_is_activated(c, config2))
 		return 0;
 
 	tmp = (config2 >> 8) & 0x0f;
-- 
1.7.0.4

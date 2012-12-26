Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Dec 2012 21:54:13 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:52703 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823426Ab2LZUxpN6EKo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Dec 2012 21:53:45 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id E70768F60;
        Wed, 26 Dec 2012 21:53:44 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t37HPpRCHfcj; Wed, 26 Dec 2012 21:53:41 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id D21368E1C;
        Wed, 26 Dec 2012 21:53:40 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     john@phrozen.org, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, zajec5@gmail.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] MIPS: BCM47XX: trim the nvram values for parsing
Date:   Wed, 26 Dec 2012 21:53:26 +0100
Message-Id: <1356555206-1329-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 35331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Some nvram values on some devices have a newline character at the end
of the value, that caused read errors. Trim the string before reading
the number.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/sprom.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index 89b9bf4..3849230 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -71,7 +71,7 @@ static void nvram_read_ ## type (const char *prefix,			\
 			    fallback);					\
 	if (err < 0)							\
 		return;							\
-	err = kstrto ## type (buf, 0, &var);				\
+	err = kstrto ## type(strim(buf), 0, &var);			\
 	if (err) {							\
 		pr_warn("can not parse nvram name %s%s%s with value %s got %i\n",	\
 			prefix, name, postfix, buf, err);		\
@@ -99,7 +99,7 @@ static void nvram_read_u32_2(const char *prefix, const char *name,
 	err = get_nvram_var(prefix, NULL, name, buf, sizeof(buf), fallback);
 	if (err < 0)
 		return;
-	err = kstrtou32(buf, 0, &val);
+	err = kstrtou32(strim(buf), 0, &val);
 	if (err) {
 		pr_warn("can not parse nvram name %s%s with value %s got %i\n",
 			prefix, name, buf, err);
@@ -120,7 +120,7 @@ static void nvram_read_leddc(const char *prefix, const char *name,
 	err = get_nvram_var(prefix, NULL, name, buf, sizeof(buf), fallback);
 	if (err < 0)
 		return;
-	err = kstrtou32(buf, 0, &val);
+	err = kstrtou32(strim(buf), 0, &val);
 	if (err) {
 		pr_warn("can not parse nvram name %s%s with value %s got %i\n",
 			prefix, name, buf, err);
-- 
1.7.10.4

Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Nov 2014 12:40:23 +0100 (CET)
Received: from smtp5-g21.free.fr ([212.27.42.5]:64061 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012977AbaKHLkKeYkHq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 8 Nov 2014 12:40:10 +0100
Received: from localhost.localdomain (unknown [78.50.171.175])
        (Authenticated sender: albeu)
        by smtp5-g21.free.fr (Postfix) with ESMTPA id 6DBDFD480B9;
        Sat,  8 Nov 2014 12:37:40 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Alban Bedel <albeu@free.fr>
Subject: [PATCH v2 2/2] MIPS: FW: Use kstrtoul() to parse unsigned long from the fw environment
Date:   Sat,  8 Nov 2014 12:39:39 +0100
Message-Id: <1415446779-11984-2-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1415446779-11984-1-git-send-email-albeu@free.fr>
References: <1415446779-11984-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

Fix some value corruptions with values that can't be represented in a
signed long.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
v2: * No changes since v1
---
 arch/mips/fw/lib/cmdline.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/fw/lib/cmdline.c b/arch/mips/fw/lib/cmdline.c
index a0c361e..6ecda64 100644
--- a/arch/mips/fw/lib/cmdline.c
+++ b/arch/mips/fw/lib/cmdline.c
@@ -88,13 +88,13 @@ unsigned long fw_getenvl(char *envname)
 {
 	unsigned long envl = 0UL;
 	char *str;
-	long val;
 	int tmp;
 
 	str = fw_getenv(envname);
 	if (str) {
-		tmp = kstrtol(str, 0, &val);
-		envl = (unsigned long)val;
+		tmp = kstrtoul(str, 0, &envl);
+		if (tmp)
+			envl = 0;
 	}
 
 	return envl;
-- 
2.0.0

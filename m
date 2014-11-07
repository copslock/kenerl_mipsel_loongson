Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 12:26:18 +0100 (CET)
Received: from dotsec.net ([62.75.224.215]:49346 "EHLO styx.dotsec.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012737AbaKGLZ7JKf6F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Nov 2014 12:25:59 +0100
Received: from e177050201.adsl.alicedsl.de ([85.177.50.201] helo=localhost.localdomain)
        by styx.dotsec.net with esmtpa (Exim 4.71)
        (envelope-from <albeu@free.fr>)
        id 1Xmhez-0000i1-Gn; Fri, 07 Nov 2014 12:25:15 +0100
From:   Alban Bedel <albeu@free.fr>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Alban Bedel <albeu@free.fr>
Subject: [PATCH 2/2] MIPS: FW: Use kstrtoul() to parse unsigned long from the fw environment
Date:   Fri,  7 Nov 2014 12:23:01 +0100
Message-Id: <1415359381-27257-2-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1415359381-27257-1-git-send-email-albeu@free.fr>
References: <1415359381-27257-1-git-send-email-albeu@free.fr>
X-SA-Score: -1.0
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43911
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
 arch/mips/fw/lib/cmdline.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/fw/lib/cmdline.c b/arch/mips/fw/lib/cmdline.c
index cc5d168..e680624 100644
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

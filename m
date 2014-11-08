Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Nov 2014 12:40:06 +0100 (CET)
Received: from smtp5-g21.free.fr ([212.27.42.5]:63764 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012739AbaKHLkFS0nhJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 8 Nov 2014 12:40:05 +0100
Received: from localhost.localdomain (unknown [78.50.171.175])
        (Authenticated sender: albeu)
        by smtp5-g21.free.fr (Postfix) with ESMTPA id 71D9CD48002;
        Sat,  8 Nov 2014 12:37:36 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Alban Bedel <albeu@free.fr>
Subject: [PATCH v2 1/2] MIPS: FW: Fix parsing u-boot environment
Date:   Sat,  8 Nov 2014 12:39:38 +0100
Message-Id: <1415446779-11984-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43930
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

When reading u-boot's key=value pairs it should skip the '=' and not
use the next argument.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
v2: * Removed the useless outer parenthesis
---
 arch/mips/fw/lib/cmdline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/fw/lib/cmdline.c b/arch/mips/fw/lib/cmdline.c
index ffd0345..a0c361e 100644
--- a/arch/mips/fw/lib/cmdline.c
+++ b/arch/mips/fw/lib/cmdline.c
@@ -68,7 +68,7 @@ char *fw_getenv(char *envname)
 					result = fw_envp(index + 1);
 					break;
 				} else if (fw_envp(index)[i] == '=') {
-					result = (fw_envp(index + 1) + i);
+					result = fw_envp(index) + i + 1;
 					break;
 				}
 			}
-- 
2.0.0

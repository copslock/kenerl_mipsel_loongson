Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 12:26:00 +0100 (CET)
Received: from dotsec.net ([62.75.224.215]:49226 "EHLO styx.dotsec.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012736AbaKGLZ7AsosM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Nov 2014 12:25:59 +0100
Received: from e177050201.adsl.alicedsl.de ([85.177.50.201] helo=localhost.localdomain)
        by styx.dotsec.net with esmtpa (Exim 4.71)
        (envelope-from <albeu@free.fr>)
        id 1XmheC-0000i1-Rr; Fri, 07 Nov 2014 12:24:57 +0100
From:   Alban Bedel <albeu@free.fr>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Alban Bedel <albeu@free.fr>
Subject: [PATCH 1/2] MIPS: FW: Fix parsing u-boot environment
Date:   Fri,  7 Nov 2014 12:23:00 +0100
Message-Id: <1415359381-27257-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
X-SA-Score: -1.0
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43910
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
 arch/mips/fw/lib/cmdline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/fw/lib/cmdline.c b/arch/mips/fw/lib/cmdline.c
index ffd0345..cc5d168 100644
--- a/arch/mips/fw/lib/cmdline.c
+++ b/arch/mips/fw/lib/cmdline.c
@@ -68,7 +68,7 @@ char *fw_getenv(char *envname)
 					result = fw_envp(index + 1);
 					break;
 				} else if (fw_envp(index)[i] == '=') {
-					result = (fw_envp(index + 1) + i);
+					result = (fw_envp(index) + i + 1);
 					break;
 				}
 			}
-- 
2.0.0

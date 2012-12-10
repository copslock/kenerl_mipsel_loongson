Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Dec 2012 15:58:49 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:36700 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831922Ab2LJO6sHakmk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Dec 2012 15:58:48 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 9ACC7B8786B;
        Mon, 10 Dec 2012 15:58:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1kjiged+3EJY; Mon, 10 Dec 2012 15:58:47 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 419DAB83F79;
        Mon, 10 Dec 2012 15:58:47 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, blogic@openwrt.org,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 3.7-rc8] MIPS: MT: fix build with CONFIG_UIDGID_STRICT_TYPE_CHECKS=y
Date:   Mon, 10 Dec 2012 15:56:44 +0100
Message-Id: <1355151404-7499-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 35250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

When CONFIG_UIDGID_STRICT_TYPE_CHECKS is enabled, plain integer checking
between different uids/gids is explicitely turned into a build failure
by making the k{uid,gid}_t types a structure containing a value:

arch/mips/kernel/mips-mt-fpaff.c: In function 'check_same_owner':
arch/mips/kernel/mips-mt-fpaff.c:53:22: error: invalid operands to
binary == (have 'kuid_t' and 'kuid_t')
arch/mips/kernel/mips-mt-fpaff.c:54:15: error: invalid operands to
binary == (have 'kuid_t' and 'kuid_t')

This problem got introduced with commit 17c04139 (MIPS: MT: Fix FPU affinity.)

In order to ensure proper comparison between uids, using the helper
function uid_eq() which performs the right thing whenever this config
option is turned on or off.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Ralf, I think you might want to sneak this into 3.7-rc8 if possible at all.

 arch/mips/kernel/mips-mt-fpaff.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
index 33f63ba..fd814e0 100644
--- a/arch/mips/kernel/mips-mt-fpaff.c
+++ b/arch/mips/kernel/mips-mt-fpaff.c
@@ -50,8 +50,8 @@ static bool check_same_owner(struct task_struct *p)
 
 	rcu_read_lock();
 	pcred = __task_cred(p);
-	match = (cred->euid == pcred->euid ||
-		 cred->euid == pcred->uid);
+	match = (uid_eq(cred->euid, pcred->euid) ||
+		 uid_eq(cred->euid, pcred->uid));
 	rcu_read_unlock();
 	return match;
 }
-- 
1.7.10.4

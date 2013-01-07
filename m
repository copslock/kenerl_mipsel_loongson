Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jan 2013 15:19:24 +0100 (CET)
Received: from mms2.broadcom.com ([216.31.210.18]:3101 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817419Ab3AGOTWKTzBC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Jan 2013 15:19:22 +0100
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 07 Jan 2013 06:16:01 -0800
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Mon, 7 Jan 2013 06:18:52 -0800
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 21BAB40FE4; Mon, 7
 Jan 2013 06:19:02 -0800 (PST)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Netlogic: Fix UP compilation on XLR
Date:   Mon, 7 Jan 2013 19:51:08 +0530
Message-ID: <1357568468-1876-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-WSS-ID: 7CF4072B3Q41524953-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

The commit 2a37b1a "MIPS: Netlogic: Move from u32 cpumask to cpumask_t"
breaks uniprocessor compilation on XLR with:

arch/mips/netlogic/xlr/setup.c: In function 'prom_init':
arch/mips/netlogic/xlr/setup.c:196:6: error: unused variable 'i'

Fix by defining 'i' only when CONFIG_SMP is defined.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/xlr/setup.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/netlogic/xlr/setup.c b/arch/mips/netlogic/xlr/setup.c
index 4e7f49d..c5ce699 100644
--- a/arch/mips/netlogic/xlr/setup.c
+++ b/arch/mips/netlogic/xlr/setup.c
@@ -193,8 +193,11 @@ static void nlm_init_node(void)
 
 void __init prom_init(void)
 {
-	int i, *argv, *envp;		/* passed as 32 bit ptrs */
+	int *argv, *envp;		/* passed as 32 bit ptrs */
 	struct psb_info *prom_infop;
+#ifdef CONFIG_SMP
+	int i;
+#endif
 
 	/* truncate to 32 bit and sign extend all args */
 	argv = (int *)(long)(int)fw_arg1;
-- 
1.7.9.5

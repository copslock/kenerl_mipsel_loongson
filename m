Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 May 2013 04:23:35 +0200 (CEST)
Received: from mo11.iij4u.or.jp ([210.138.174.79]:55034 "EHLO mo.iij4u.or.jp"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822517Ab3E1CX3t9-gp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 May 2013 04:23:29 +0200
Received: by mo.iij4u.or.jp (mo11) id r4S2NPYf000464; Tue, 28 May 2013 11:23:25 +0900
Received: from delta (sannin29190.nirai.ne.jp [203.160.29.190])
        by mbox.iij4u.or.jp (mbox11) id r4S2NMF1024373
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 28 May 2013 11:23:24 +0900
Date:   Tue, 28 May 2013 11:23:22 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     ralf@linux-mips.org
Cc:     yuasa@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: fix implicit declaration of function set_vi_handler()
Message-Id: <20130528112322.6d71ac0db2ed1b23f908dc40@linux-mips.org>
X-Mailer: Sylpheed 3.2.0beta5 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36618
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
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

arch/mips/kernel/rtlx.c: In function 'rtlx_module_init':
arch/mips/kernel/rtlx.c:523:3: error: implicit declaration of function 'set_vi_handler' [-Werror=implicit-function-declaration]

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/kernel/rtlx.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/rtlx.c b/arch/mips/kernel/rtlx.c
index dd8e542..d763f11 100644
--- a/arch/mips/kernel/rtlx.c
+++ b/arch/mips/kernel/rtlx.c
@@ -40,6 +40,7 @@
 #include <asm/processor.h>
 #include <asm/vpe.h>
 #include <asm/rtlx.h>
+#include <asm/setup.h>
 
 static struct rtlx_info *rtlx;
 static int major;
-- 
1.7.9.5

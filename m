Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2012 08:44:28 +0200 (CEST)
Received: from mo11.iij4u.or.jp ([210.138.174.79]:52689 "EHLO mo.iij4u.or.jp"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903788Ab2HAGna (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Aug 2012 08:43:30 +0200
Received: by mo.iij4u.or.jp (mo11) id q716hSRd031006; Wed, 1 Aug 2012 15:43:28 +0900
Received: from delta (UQ1-221-171-15-92.tky.mesh.ad.jp [221.171.15.92])
        by mbox.iij4u.or.jp (mbox10) id q716hQK3030339
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 1 Aug 2012 15:43:27 +0900
Date:   Wed, 1 Aug 2012 15:41:06 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     ralf@linux-mips.org
Cc:     yuasa@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 3/4] MIPS: txx9: add select HAVE_CLK
Message-Id: <20120801154106.70d9b84c066a9fa11bcaf8bb@linux-mips.org>
In-Reply-To: <20120801153800.22d81b6d674d6722b2392574@linux-mips.org>
References: <20120801153800.22d81b6d674d6722b2392574@linux-mips.org>
X-Mailer: Sylpheed 3.2.0beta5 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 34009
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
Return-Path: <linux-mips-bounce@linux-mips.org>

fix redefinition of clk_*

arch/mips/txx9/generic/setup.c:87:13: error: redefinition of 'clk_get'
include/linux/clk.h:281:27: note: previous definition of 'clk_get' was here
arch/mips/txx9/generic/setup.c:97:5: error: redefinition of 'clk_enable'
include/linux/clk.h:295:19: note: previous definition of 'clk_enable' was here
arch/mips/txx9/generic/setup.c:103:6: error: redefinition of 'clk_disable'
include/linux/clk.h:300:20: note: previous definition of 'clk_disable' was here
arch/mips/txx9/generic/setup.c:108:15: error: redefinition of 'clk_get_rate'
include/linux/clk.h:302:29: note: previous definition of 'clk_get_rate' was here
arch/mips/txx9/generic/setup.c:114:6: error: redefinition of 'clk_put'
include/linux/clk.h:291:20: note: previous definition of 'clk_put' was here
make[3]: *** [arch/mips/txx9/generic/setup.o] Error 1

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/txx9/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/txx9/Kconfig b/arch/mips/txx9/Kconfig
index 852ae4b..6d40bc7 100644
--- a/arch/mips/txx9/Kconfig
+++ b/arch/mips/txx9/Kconfig
@@ -20,6 +20,7 @@ config MACH_TXX9
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_BIG_ENDIAN
+	select HAVE_CLK
 
 config TOSHIBA_JMR3927
 	bool "Toshiba JMR-TX3927 board"
-- 
1.7.0.4

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2017 17:51:53 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.135]:60507 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992078AbdARQvWtHOjd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jan 2017 17:51:22 +0100
Received: from wuerfel.lan ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue003 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MRhPx-1c17DO471l-00SwVq; Wed, 18 Jan 2017 17:51:08 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: actually add asm/asm-prototypes.h
Date:   Wed, 18 Jan 2017 17:50:50 +0100
Message-Id: <20170118165105.3860173-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:nyp5HND+yEwWn5OSw0DdpR5hGGDr+dsxYql7ExXcKzhTx9ZE+2G
 yV0kfBryKJGQ/uKhMhOBVkj1oq3FXO1sEJvgsUgEN+zNxvrXR4jbXX1Q8fdBoFDeCDSM2b7
 JZhhJKXgZMaXFGMEo10iZL0COJ2VClI7FJhlyJrsxaaxCYquoPsP63tNPtXHlhuEZ7iUIst
 nqsfI533dhtzqmdrgNjAQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3Czu/GmxEyE=:uLT2H0Od7EaKiaWJdBRis7
 r2cjGz5IhWbGGqeTGUJKO1wjOi1/Y3QblYOQibNDm7hgsP9g+VyIHzxdaKHRynumo+5YZUDYi
 UUQWq2EyecX0PITWY8CW7kwkr2KRtYHGBp+PjLXPdleTtHZMFGXOKK+22529vZweXXwmQBfPt
 qN1rJ+/6VnA//VHftalIk6B+altNrOSHLo+s4T82g7WI8HAWpunEG6fNw+9t7g0R882FE7Z+h
 vzofre3GAKuIh9CVsFxG3H2b6l81RyiFJCODH9CRXGz3Sbd+WX6Sz9/yYP3xORdYseNsZTI/B
 uavf9yj1/OH3GEhOi764CNa72P3lRx8B1BQMGs9UwOGiiMaD4uNzryVWmnBO5ZLRuyGjCXAox
 pJHTLbkP0NzAZCkh6Q4O6XaPA1wqWmcFomPsUkekPmqDvaME9I/SlIYZe8hc4H5jYvuqa65NI
 jkoJOrOgHDbQEzlJEBF56EhsMUhkx+HWXbS0Y0dgppVmcX/QaeX9kLb+PkQDpAJnO2ITbcPMz
 Op3NwOf5/+Y96Zxlrhccx9WbXvzgbCLQhdo4bS65YFciTpwAN/6WC82r2B1S/ZZhVkSJ6a+EL
 FQ6tIPd4kruEJ+KL3mXKkTu4y3YX7/g8bh7sRR4naFDHMr9IM2PBJ8pcKxmHg4G169xzfMu4n
 jxGdkUh37sKLWskPufvlP4JL0lMGOaqF9gA9uqQMcXyfMTLlWYz+8wEWNEkp0gf0A1Uc=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

The last patch correctly modified some other files, but
I forgot to actually add the important asm/asm-prototypes.h
that makes it all work.

Fixes: ac8c8176387f ("MIPS: Fix modversions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/asm-prototypes.h | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 arch/mips/include/asm/asm-prototypes.h

diff --git a/arch/mips/include/asm/asm-prototypes.h b/arch/mips/include/asm/asm-prototypes.h
new file mode 100644
index 000000000000..a160cf69bb92
--- /dev/null
+++ b/arch/mips/include/asm/asm-prototypes.h
@@ -0,0 +1,5 @@
+#include <asm/checksum.h>
+#include <asm/page.h>
+#include <asm/fpu.h>
+#include <asm-generic/asm-prototypes.h>
+#include <asm/uaccess.h>
-- 
2.9.0

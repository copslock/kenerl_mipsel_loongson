Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Aug 2013 15:55:11 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38992 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822682Ab3HANzJK0vW0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Aug 2013 15:55:09 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r71Dt7h9003638;
        Thu, 1 Aug 2013 15:55:07 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r71Dt58L003637;
        Thu, 1 Aug 2013 15:55:05 +0200
Date:   Thu, 1 Aug 2013 15:55:05 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH V2] MIPS: BMIPS: fix compilation for BMIPS5000
Message-ID: <20130801135505.GA3466@linux-mips.org>
References: <1375350938-16554-1-git-send-email-jogo@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1375350938-16554-1-git-send-email-jogo@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, Aug 01, 2013 at 11:55:38AM +0200, Jonas Gorski wrote:

> Commit 02b849f7613003fe5f9e58bf233d49b0ebd4a5e8 ("MIPS: Get rid of the
> use of .macro in C code.") replaced the macro usage but missed
> the accessors in bmips.h, causing the following build error:
> 
>   CC      arch/mips/kernel/smp-bmips.o
> {standard input}: Assembler messages:
> {standard input}:951: Error: Unrecognized opcode `_ssnop'
> {standard input}:952: Error: Unrecognized opcode `_ssnop'
> (...)
> make[6]: *** [arch/mips/kernel/smp-bmips.o] Error 1
> 
> Fix this by also replacing the macros here, fixing the last occurrence
> in mips.

How about getting rid of the entire inline assembler code by something
like below patch?

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/include/asm/bmips.h | 56 ++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/arch/mips/include/asm/bmips.h b/arch/mips/include/asm/bmips.h
index 552a65a..6483d26 100644
--- a/arch/mips/include/asm/bmips.h
+++ b/arch/mips/include/asm/bmips.h
@@ -13,6 +13,7 @@
 #include <linux/compiler.h>
 #include <linux/linkage.h>
 #include <asm/addrspace.h>
+#include <asm/r4kcache.h>
 #include <asm/mipsregs.h>
 #include <asm/hazards.h>
 
@@ -65,44 +66,33 @@ static inline unsigned long bmips_read_zscm_reg(unsigned int offset)
 {
 	unsigned long ret;
 
-	__asm__ __volatile__(
-		".set push\n"
-		".set noreorder\n"
-		"cache %1, 0(%2)\n"
-		"sync\n"
-		"_ssnop\n"
-		"_ssnop\n"
-		"_ssnop\n"
-		"_ssnop\n"
-		"_ssnop\n"
-		"_ssnop\n"
-		"_ssnop\n"
-		"mfc0 %0, $28, 3\n"
-		"_ssnop\n"
-		".set pop\n"
-		: "=&r" (ret)
-		: "i" (Index_Load_Tag_S), "r" (ZSCM_REG_BASE + offset)
-		: "memory");
+	barrier();
+	cache_op(Index_Load_Tag_S, ZSCM_REG_BASE + offset);
+	__sync();
+	__ssnop();
+	__ssnop();
+	__ssnop();
+	__ssnop();
+	__ssnop();
+	__ssnop();
+	__ssnop();
+	ret = read_c0_ddatalo();
+	__ssnop();
+
 	return ret;
 }
 
 static inline void bmips_write_zscm_reg(unsigned int offset, unsigned long data)
 {
-	__asm__ __volatile__(
-		".set push\n"
-		".set noreorder\n"
-		"mtc0 %0, $28, 3\n"
-		"_ssnop\n"
-		"_ssnop\n"
-		"_ssnop\n"
-		"cache %1, 0(%2)\n"
-		"_ssnop\n"
-		"_ssnop\n"
-		"_ssnop\n"
-		: /* no outputs */
-		: "r" (data),
-		  "i" (Index_Store_Tag_S), "r" (ZSCM_REG_BASE + offset)
-		: "memory");
+	write_c0_ddatalo(3);
+	__ssnop();
+	__ssnop();
+	__ssnop();
+	cache_op(Index_Store_Tag_S, ZSCM_REG_BASE + offset);
+	__ssnop();
+	__ssnop();
+	__ssnop();
+	barrier();
 }
 
 #endif /* !defined(__ASSEMBLY__) */

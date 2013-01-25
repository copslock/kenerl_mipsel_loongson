Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jan 2013 19:13:27 +0100 (CET)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:26588 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6833479Ab3AYSNWZEE8M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Jan 2013 19:13:22 +0100
X-Authority-Analysis: v=2.0 cv=QcjkT7nv c=1 sm=0 a=rXTBtCOcEpjy1lPqhTCpEQ==:17 a=mNMOxpOpBa8A:10 a=O-wSPx1J_xoA:10 a=5SG0PmZfjMsA:10 a=Q9fys5e9bTEA:10 a=meVymXHHAAAA:8 a=Vn_n-_WOfk4A:10 a=q0367S1zEWU0cg8Ot-YA:9 a=PUjeQqilurYA:10 a=jeBq3FmKZ4MA:10 a=rXTBtCOcEpjy1lPqhTCpEQ==:117
X-Cloudmark-Score: 0
X-Authenticated-User: 
X-Originating-IP: 74.67.115.198
Received: from [74.67.115.198] ([74.67.115.198:52253] helo=[192.168.23.10])
        by hrndva-oedge03.mail.rr.com (envelope-from <rostedt@goodmis.org>)
        (ecelerity 2.2.3.46 r()) with ESMTP
        id 37/67-06396-B3BC2015; Fri, 25 Jan 2013 18:13:16 +0000
Message-ID: <1359137595.21576.246.camel@gandalf.local.home>
Subject: [PATCH] mips: Move __virt_addr_valid() to a place for MIPS 64
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>
Date:   Fri, 25 Jan 2013 13:13:15 -0500
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.4.4-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-archive-position: 35562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
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

Commit d3ce88431892 "MIPS: Fix modpost error in modules attepting to use
virt_addr_valid()" moved __virt_addr_valid() from a macro in a header
file to a function in ioremap.c. But ioremap.c is only compiled for MIPS
32, and not for MIPS 64.

When compiling for my yeeloong2, which supposedly supports hibernation,
which compiles kernel/power/snapshot.c which calls virt_addr_valid(), I
got this error:

  LD      init/built-in.o
kernel/built-in.o: In function `memory_bm_free':
snapshot.c:(.text+0x4c9c4): undefined reference to `__virt_addr_valid'
snapshot.c:(.text+0x4ca58): undefined reference to `__virt_addr_valid'
kernel/built-in.o: In function `snapshot_write_next':
(.text+0x4e44c): undefined reference to `__virt_addr_valid'
kernel/built-in.o: In function `snapshot_write_next':
(.text+0x4e890): undefined reference to `__virt_addr_valid'
make[1]: *** [vmlinux] Error 1
make: *** [sub-make] Error 2

I suspect that __virt_addr_valid() is fine for mips 64. I moved it to
mmap.c such that it gets compiled for mips 64 and 32.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/arch/mips/mm/ioremap.c b/arch/mips/mm/ioremap.c
index 7657fd2..cacfd31 100644
--- a/arch/mips/mm/ioremap.c
+++ b/arch/mips/mm/ioremap.c
@@ -190,9 +190,3 @@ void __iounmap(const volatile void __iomem *addr)
 
 EXPORT_SYMBOL(__ioremap);
 EXPORT_SYMBOL(__iounmap);
-
-int __virt_addr_valid(const volatile void *kaddr)
-{
-	return pfn_valid(PFN_DOWN(virt_to_phys(kaddr)));
-}
-EXPORT_SYMBOL_GPL(__virt_addr_valid);
diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
index d9be754..7e5fe27 100644
--- a/arch/mips/mm/mmap.c
+++ b/arch/mips/mm/mmap.c
@@ -192,3 +192,9 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
 
 	return ret;
 }
+
+int __virt_addr_valid(const volatile void *kaddr)
+{
+	return pfn_valid(PFN_DOWN(virt_to_phys(kaddr)));
+}
+EXPORT_SYMBOL_GPL(__virt_addr_valid);

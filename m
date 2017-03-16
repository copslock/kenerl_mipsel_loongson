Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2017 15:40:50 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:34178 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993895AbdCPOfGgoI50 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Mar 2017 15:35:06 +0100
Received: from localhost (unknown [183.98.136.252])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 78888B2F;
        Thu, 16 Mar 2017 14:35:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.10 07/48] MIPS: VDSO: avoid duplicate CAC_BASE definition
Date:   Thu, 16 Mar 2017 23:29:51 +0900
Message-Id: <20170316142921.151503864@linuxfoundation.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170316142920.761502205@linuxfoundation.org>
References: <20170316142920.761502205@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 1742ac265046f34223e06d5d283496f0291be259 upstream.

vdso.h includes <spaces.h> implicitly after defining CONFIG_32BITS.
This defeats the override in mach-ip27/spaces.h, leading to
a build error that shows up in kernelci.org:

In file included from arch/mips/include/asm/mach-ip27/spaces.h:29:0,
                 from arch/mips/include/asm/page.h:12,
                 from arch/mips/vdso/vdso.h:26,
                 from arch/mips/vdso/gettimeofday.c:11:
arch/mips/include/asm/mach-generic/spaces.h:28:0: error: "CAC_BASE" redefined [-Werror]
 #define CAC_BASE  _AC(0x80000000, UL)

An earlier patch tried to make the second definition conditional,
but that patch had the #ifdef in the wrong place, and would lead
to another warning:

arch/mips/include/asm/io.h: In function 'phys_to_virt':
arch/mips/include/asm/io.h:138:9: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]

For all I can tell, there is no other reason than vdso32 to ever
include this file with CONFIG_32BITS set, and the vdso itself should
never refer to the base addresses as it is running in user space,
so adding an #ifdef here is safe.

Link: https://patchwork.kernel.org/patch/9418187/
Fixes: 3ffc17d8768b ("MIPS: Adjust MIPS64 CAC_BASE to reflect Config.K0")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/15039/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/mach-ip27/spaces.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/mips/include/asm/mach-ip27/spaces.h
+++ b/arch/mips/include/asm/mach-ip27/spaces.h
@@ -12,14 +12,16 @@
 
 /*
  * IP27 uses the R10000's uncached attribute feature.  Attribute 3 selects
- * uncached memory addressing.
+ * uncached memory addressing. Hide the definitions on 32-bit compilation
+ * of the compat-vdso code.
  */
-
+#ifdef CONFIG_64BIT
 #define HSPEC_BASE		0x9000000000000000
 #define IO_BASE			0x9200000000000000
 #define MSPEC_BASE		0x9400000000000000
 #define UNCAC_BASE		0x9600000000000000
 #define CAC_BASE		0xa800000000000000
+#endif
 
 #define TO_MSPEC(x)		(MSPEC_BASE | ((x) & TO_PHYS_MASK))
 #define TO_HSPEC(x)		(HSPEC_BASE | ((x) & TO_PHYS_MASK))

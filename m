Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2018 19:02:51 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:57708 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994240AbeICRCaCiNbH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Sep 2018 19:02:30 +0200
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 79617CFB;
        Mon,  3 Sep 2018 17:02:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 4.4 76/80] MIPS: lib: Provide MIPS64r6 __multi3() for GCC < 7
Date:   Mon,  3 Sep 2018 18:49:54 +0200
Message-Id: <20180903164937.181652831@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164934.171677301@linuxfoundation.org>
References: <20180903164934.171677301@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65902
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@mips.com>

commit 690d9163bf4b8563a2682e619f938e6a0443947f upstream.

Some versions of GCC suboptimally generate calls to the __multi3()
intrinsic for MIPS64r6 builds, resulting in link failures due to the
missing function:

    LD      vmlinux.o
    MODPOST vmlinux.o
  kernel/bpf/verifier.o: In function `kmalloc_array':
  include/linux/slab.h:631: undefined reference to `__multi3'
  fs/select.o: In function `kmalloc_array':
  include/linux/slab.h:631: undefined reference to `__multi3'
  ...

We already have a workaround for this in which we provide the
instrinsic, but we do so selectively for GCC 7 only. Unfortunately the
issue occurs with older GCC versions too - it has been observed with
both GCC 5.4.0 & GCC 6.4.0.

MIPSr6 support was introduced in GCC 5, so all major GCC versions prior
to GCC 8 are affected and we extend our workaround accordingly to all
MIPS64r6 builds using GCC versions older than GCC 8.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Fixes: ebabcf17bcd7 ("MIPS: Implement __multi3 for GCC7 MIPS64r6 builds")
Patchwork: https://patchwork.linux-mips.org/patch/20297/
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # 4.15+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lib/multi3.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/mips/lib/multi3.c
+++ b/arch/mips/lib/multi3.c
@@ -4,12 +4,12 @@
 #include "libgcc.h"
 
 /*
- * GCC 7 suboptimally generates __multi3 calls for mips64r6, so for that
- * specific case only we'll implement it here.
+ * GCC 7 & older can suboptimally generate __multi3 calls for mips64r6, so for
+ * that specific case only we implement that intrinsic here.
  *
  * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82981
  */
-#if defined(CONFIG_64BIT) && defined(CONFIG_CPU_MIPSR6) && (__GNUC__ == 7)
+#if defined(CONFIG_64BIT) && defined(CONFIG_CPU_MIPSR6) && (__GNUC__ < 8)
 
 /* multiply 64-bit values, low 64-bits returned */
 static inline long long notrace dmulu(long long a, long long b)

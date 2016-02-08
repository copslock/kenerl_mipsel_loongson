Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 16:45:25 +0100 (CET)
Received: from mail.bmw-carit.de ([62.245.222.98]:47646 "EHLO
        linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011491AbcBHPougDsXk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 16:44:50 +0100
Received: from localhost (handman.bmw-carit.intra [192.168.101.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linuxmail.bmw-carit.de (Postfix) with ESMTPS id 1D1B65C43F;
        Mon,  8 Feb 2016 16:27:59 +0100 (CET)
From:   Daniel Wagner <daniel.wagner@bmw-carit.de>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v3 1/3] mips: Use arch specific auxvec.h instead of generic-asm version
Date:   Mon,  8 Feb 2016 16:44:36 +0100
Message-Id: <1454946278-13859-2-git-send-email-daniel.wagner@bmw-carit.de>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1454946278-13859-1-git-send-email-daniel.wagner@bmw-carit.de>
References: <alpine.DEB.2.00.1602061624460.15885@tp.orcam.me.uk>
 <1454946278-13859-1-git-send-email-daniel.wagner@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.wagner@oss.bmw-carit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.wagner@bmw-carit.de
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

The generic auxvec.h is used instead the arch specific version.
This happens when cross compiling the kernel.

mips64-linux-gnu-gcc (GCC) 5.2.1 20151104 (Red Hat Cross 5.2.1-4)

arch/mips/kernel/../../../fs/binfmt_elf.c: In function ‘create_elf_tables’:
./arch/mips/include/asm/elf.h:425:14: error: ‘AT_SYSINFO_EHDR’ undeclared (first use in this function)
  NEW_AUX_ENT(AT_SYSINFO_EHDR,     \
              ^
arch/mips/kernel/../../../fs/binfmt_elf.c:222:26: note: in definition of macro ‘NEW_AUX_ENT’
   elf_info[ei_index++] = id; \
                          ^
arch/mips/kernel/../../../fs/binfmt_elf.c:233:2: note: in expansion of macro ‘ARCH_DLINFO’
  ARCH_DLINFO;
  ^
./arch/mips/include/asm/elf.h:425:14: note: each undeclared identifier is reported only once for each function it appears in
  NEW_AUX_ENT(AT_SYSINFO_EHDR,     \
              ^
arch/mips/kernel/../../../fs/binfmt_elf.c:222:26: note: in definition of macro ‘NEW_AUX_ENT’
   elf_info[ei_index++] = id; \
                          ^
arch/mips/kernel/../../../fs/binfmt_elf.c:233:2: note: in expansion of macro ‘ARCH_DLINFO’
  ARCH_DLINFO;
  ^

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 arch/mips/include/asm/auxvec.h | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 arch/mips/include/asm/auxvec.h

diff --git a/arch/mips/include/asm/auxvec.h b/arch/mips/include/asm/auxvec.h
new file mode 100644
index 0000000..fbd388c
--- /dev/null
+++ b/arch/mips/include/asm/auxvec.h
@@ -0,0 +1 @@
+#include <uapi/asm/auxvec.h>
-- 
2.5.0

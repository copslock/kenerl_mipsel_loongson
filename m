Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2007 10:25:30 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.172]:34355 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022306AbXGTJZ2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jul 2007 10:25:28 +0100
Received: by ug-out-1314.google.com with SMTP id u2so614614uge
        for <linux-mips@linux-mips.org>; Fri, 20 Jul 2007 02:25:10 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=qBYC0ZYelqatteZMWHLriIU3ZyOT5QMaUM+9+ftNM+qhCKfrqn6/fP4bi4q4GzcaaNk5Gnjx1/wuJRNIZthXd6asQvmuedPDIzHWkGJX0eg99KzPaeKMuaRlwgNENvpy5GfwvKDG8gufFEMUxG0hGjjNAiNyQhohIo2343AQLOY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=oz+l3JmQ6D35I0sggw5XzPJ6NN1SMBQxkQR9+ALl/3B8I40shJZN8bQtmJXK/cJckbCcRkZoQrVvWV/2Wbt1TIZ8OC+Ad6vrR53r3pT532nziZ9J8+JDUVTbZNivmpvbq6c8SjLtLhkQZrMhO3AJRP6NqcZwL+8GVpAVLBap2lY=
Received: by 10.66.218.3 with SMTP id q3mr1833432ugg.1184923510915;
        Fri, 20 Jul 2007 02:25:10 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id y1sm295612uge.2007.07.20.02.25.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Jul 2007 02:25:09 -0700 (PDT)
Message-ID: <46A07F67.8050506@gmail.com>
Date:	Fri, 20 Jul 2007 11:24:55 +0200
From:	Franck Bui-Huu <fbuihuu@gmail.com>
User-Agent: Thunderbird 2.0.0.4 (X11/20070615)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips <linux-mips@linux-mips.org>, nigel@mips.com
Subject: [PATCH] Improve previous user stack pointer randomisation patch
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fbuihuu@gmail.com
Precedence: bulk
X-list: linux-mips

This patch improves commit acc6f0110cf735e6c6e0f53736dbb054eafcd13c
by:
    - not using ALMASK to align stack pointer because this macro
      is used for kernel context. The kernel and the application
      are not always compiled with the same ABI.

    - testing PF_RANDOMIZE process flag which is raised when the
      old condition we tested is true.

The first improvement was suggested by Nigel Stephens.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/process.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index bd05f5a..b5b2f31 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -27,7 +27,6 @@
 #include <linux/kallsyms.h>
 #include <linux/random.h>
 
-#include <asm/asm.h>
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
 #include <asm/dsp.h>
@@ -464,13 +463,14 @@ out:
 }
 
 /*
- * Don't forget that the stack pointer must be aligned on a 8 bytes
- * boundary for 32-bits ABI and 16 bytes for 64-bits ABI.
+ * The stack pointer must be aligned on a 8 bytes boundary for 32-bits
+ * ABI and 16 bytes for 64-bits ABI. To make things simple we force to
+ * the maximum alignment required by any ABI.
  */
 unsigned long arch_align_stack(unsigned long sp)
 {
-	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
+	if (current->flags & PF_RANDOMIZE)
 		sp -= get_random_int() & ~PAGE_MASK;
 
-	return sp & ALMASK;
+	return sp & ~0xf;
 }
-- 
1.5.2.3

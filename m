Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Feb 2008 22:00:19 +0000 (GMT)
Received: from smtp4.pp.htv.fi ([213.243.153.38]:39653 "EHLO smtp4.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S20036186AbYBQWAQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 17 Feb 2008 22:00:16 +0000
Received: from cs181133002.pp.htv.fi (cs181133002.pp.htv.fi [82.181.133.2])
	by smtp4.pp.htv.fi (Postfix) with ESMTP id 51B115BC002;
	Mon, 18 Feb 2008 00:00:16 +0200 (EET)
Date:	Sun, 17 Feb 2008 23:59:48 +0200
From:	Adrian Bunk <bunk@kernel.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [2.6.25 patch] mips: fix SNI_RM EISA=n compilation
Message-ID: <20080217215948.GL1403@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

This patch fixes the following build error with CONFIG_EISA=n caused by 
commit 231a35d37293ab88d325a9cb94e5474c156282c0:

<--  snip -->

...
  LD      .tmp_vmlinux1
arch/mips/sni/built-in.o: In function `snirm_a20r_setup_devinit':
a20r.c:(.init.text+0x42c): undefined reference to `sni_eisa_root_init'
a20r.c:(.init.text+0x42c): relocation truncated to fit: R_MIPS_26 against `sni_eisa_root_init'
arch/mips/sni/built-in.o: In function `snirm_setup_devinit':
rm200.c:(.init.text+0x52c): undefined reference to `sni_eisa_root_init'
rm200.c:(.init.text+0x52c): relocation truncated to fit: R_MIPS_26 against `sni_eisa_root_init'
make[1]: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
f6a6c34454cbe463e2d8d567d9e0659161a82a72 diff --git a/include/asm-mips/sni.h b/include/asm-mips/sni.h
index e716447..8c1eb02 100644
--- a/include/asm-mips/sni.h
+++ b/include/asm-mips/sni.h
@@ -228,7 +228,14 @@ extern void sni_pcimt_irq_init(void);
 extern void sni_cpu_time_init(void);
 
 /* eisa init for RM200/400 */
+#ifdef CONFIG_EISA
 extern int sni_eisa_root_init(void);
+#else
+static inline int sni_eisa_root_init(void)
+{
+	return 0;
+}
+#endif
 
 /* common irq stuff */
 extern void (*sni_hwint)(void);

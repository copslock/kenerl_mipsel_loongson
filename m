Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2005 11:32:24 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:13331
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224974AbVINKcH>; Wed, 14 Sep 2005 11:32:07 +0100
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 14 Sep 2005 10:33:39 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id AC60E1F67D;
	Wed, 14 Sep 2005 19:33:36 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 976831F66F;
	Wed, 14 Sep 2005 19:33:36 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j8EAXaoj053574;
	Wed, 14 Sep 2005 19:33:36 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 14 Sep 2005 19:33:36 +0900 (JST)
Message-Id: <20050914.193336.108120347.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: module.h build fix
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Please insert "B".

diff -u linux-mips/include/asm-mips/module.h linux/include/asm-mips/module.h 
--- linux-mips/include/asm-mips/module.h	2005-09-14 10:14:31.000000000 +0900
+++ linux/include/asm-mips/module.h	2005-09-14 19:29:49.000000000 +0900
@@ -119,7 +119,7 @@
 
 #ifdef CONFIG_32BIT
 #define MODULE_KERNEL_TYPE "32BIT "
-#elif defined CONFIG_64IT
+#elif defined CONFIG_64BIT
 #define MODULE_KERNEL_TYPE "64BIT "
 #endif
 

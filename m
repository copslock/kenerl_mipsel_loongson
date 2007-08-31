Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Aug 2007 10:06:31 +0100 (BST)
Received: from sakura.staff.proxad.net ([213.228.1.107]:14479 "EHLO
	sakura.staff.proxad.net") by ftp.linux-mips.org with ESMTP
	id S20022372AbXHaJG3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 31 Aug 2007 10:06:29 +0100
Received: from max by sakura.staff.proxad.net with local (Exim 3.36 #1 (Debian))
	id 1IR2PL-0001Al-00; Fri, 31 Aug 2007 11:03:15 +0200
Subject: Suspicious test in dma-default.c
From:	Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Freebox
Date:	Fri, 31 Aug 2007 11:03:14 +0200
Message-Id: <1188550994.29619.10.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.1 
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips


Hello,


I don't know exactly why cpu_is_noncoherent_r10000() is needed, but the
test looks wrong:

	return !plat_device_is_coherent(dev) &&
	       (current_cpu_data.cputype == CPU_R10000 &&
	       current_cpu_data.cputype == CPU_R12000);


I suggest the following patch:

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>

--- linux-git/arch/mips/mm/dma-default.c.orig	2007-08-31 10:55:17.000000000 +0200
+++ linux-git/arch/mips/mm/dma-default.c	2007-08-31 10:55:25.000000000 +0200
@@ -35,7 +35,7 @@
 static inline int cpu_is_noncoherent_r10000(struct device *dev)
 {
 	return !plat_device_is_coherent(dev) &&
-	       (current_cpu_data.cputype == CPU_R10000 &&
+	       (current_cpu_data.cputype == CPU_R10000 ||
 	       current_cpu_data.cputype == CPU_R12000);
 }
 

-- 
Maxime

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2007 19:18:36 +0000 (GMT)
Received: from [66.201.51.66] ([66.201.51.66]:62546 "EHLO ripper.onstor.net")
	by ftp.linux-mips.org with ESMTP id S20022456AbXCWTSe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2007 19:18:34 +0000
Received: from andys by ripper.onstor.net with local (Exim 4.63)
	(envelope-from <andy.sharp@onstor.com>)
	id 1HUpEM-0002gC-7l
	for linux-mips@linux-mips.org; Fri, 23 Mar 2007 12:15:18 -0700
Date:	Fri, 23 Mar 2007 12:15:18 -0700
From:	Andrew Sharp <tigerand@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] 64-bit TO_PHYS_MASK macro for RM9000 processors
Message-ID: <20070323191511.GA10277@onstor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <andy.sharp@onstor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tigerand@gmail.com
Precedence: bulk
X-list: linux-mips

Either I'm missing something, or people don't run their RM9Ks in 64 bit
mode too often.

Signed off by Andrew Sharp <tigerand@gmail.com>

diff --git a/include/asm-mips/addrspace.h b/include/asm-mips/addrspace.h
index c627508..964c5ed 100644
--- a/include/asm-mips/addrspace.h
+++ b/include/asm-mips/addrspace.h
@@ -133,6 +133,7 @@
     || defined (CONFIG_CPU_R4X00)					\
     || defined (CONFIG_CPU_R5000)					\
     || defined (CONFIG_CPU_RM7000)					\
+    || defined (CONFIG_CPU_RM9000)					\
     || defined (CONFIG_CPU_NEVADA)					\
     || defined (CONFIG_CPU_TX49XX)					\
     || defined (CONFIG_CPU_MIPS64)

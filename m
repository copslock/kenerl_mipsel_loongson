Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA98EVZ27473
	for linux-mips-outgoing; Fri, 9 Nov 2001 00:14:31 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA98EP027469;
	Fri, 9 Nov 2001 00:14:26 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 9 Nov 2001 08:14:25 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 2FC85B46B; Fri,  9 Nov 2001 17:14:23 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id RAA69002; Fri, 9 Nov 2001 17:14:22 +0900 (JST)
Date: Fri, 09 Nov 2001 17:19:09 +0900 (JST)
Message-Id: <20011109.171909.88468256.nemoto@toshiba-tops.co.jp>
To: linux-mips@oss.sgi.com
Cc: ralf@oss.sgi.com
Subject: pci_map_page patch
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

pci_map_page() (added in 2.4.14) ignores offset value.

--- linux-sgi-cvs/include/asm-mips/pci.h	Thu Nov  8 16:27:01 2001
+++ linux.new/include/asm-mips/pci.h	Fri Nov  9 16:54:46 2001
@@ -130,6 +130,7 @@
 		BUG();
 
 	addr = (unsigned long) page_address(page);
+	addr += offset;
 #ifndef CONFIG_COHERENT_IO
 	dma_cache_wback_inv(addr, size);
 #endif
---
Atsushi Nemoto

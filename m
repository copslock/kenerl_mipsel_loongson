Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9H2XvL15863
	for linux-mips-outgoing; Tue, 16 Oct 2001 19:33:57 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9H2XrD15860
	for <linux-mips@oss.sgi.com>; Tue, 16 Oct 2001 19:33:53 -0700
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 17 Oct 2001 02:33:53 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 13732B46D; Wed, 17 Oct 2001 11:33:50 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id LAA23995; Wed, 17 Oct 2001 11:33:50 +0900 (JST)
Date: Wed, 17 Oct 2001 11:38:42 +0900 (JST)
Message-Id: <20011017.113842.41627007.nemoto@toshiba-tops.co.jp>
To: hli@quicklogic.com
Cc: linux-mips@oss.sgi.com
Subject: Re: IDE DMA mode in Big endian for mips
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <APEOLACBIPNAFKJDDFIIEECJCBAA.hli@quicklogic.com>
References: <20011012225433.A10523@lucon.org>
	<APEOLACBIPNAFKJDDFIIEECJCBAA.hli@quicklogic.com>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Tue, 16 Oct 2001 10:28:56 -0400, "Hanks Li" <hli@quicklogic.com> said:
hli> We are working on the IDE/ATAPI for mips. When I changed to Big
hli> endian mode, the following information appared, and the program
hli> hang.

When I tried PCI-IDE in BigEndian (with 2.4.6 kernel), this patch
solved my problem.

--- linux/drivers/ide/ide-dma.c:1.1.1.1	Fri Jul  6 11:24:54 2001
+++ linux/drivers/ide/ide-dma.c	Fri Aug 17 20:17:30 2001
@@ -492,7 +492,11 @@
 			SELECT_READ_WRITE(hwif,drive,func);
 			if (!(count = ide_build_dmatable(drive, func)))
 				return 1;	/* try PIO instead of DMA */
+#if defined(__mips__) && defined(__BIG_ENDIAN) /* XXX mips only? */
+			outl(cpu_to_le32(hwif->dmatable_dma), dma_base + 4); /* PRD table */
+#else
 			outl(hwif->dmatable_dma, dma_base + 4); /* PRD table */
+#endif
 			outb(reading, dma_base);			/* specify r/w */
 			outb(inb(dma_base+2)|6, dma_base+2);		/* clear INTR & ERROR flags */
 			drive->waiting_for_dma = 1;
---
Atsushi Nemoto

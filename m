Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7593XRw001556
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 5 Aug 2002 02:03:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7593X43001555
	for linux-mips-outgoing; Mon, 5 Aug 2002 02:03:33 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7593MRw001509
	for <linux-mips@oss.sgi.com>; Mon, 5 Aug 2002 02:03:23 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA19252;
	Mon, 5 Aug 2002 11:05:40 +0200 (MET DST)
Date: Mon, 5 Aug 2002 11:05:40 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@oss.sgi.com
Subject: [patch] 2.4: Revert interface removal
Message-ID: <Pine.GSO.3.96.1020805105624.18894C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

 A recent change to include/asm-mips/scatterlist.h broke
drivers/scsi/dec_esp.c.  Since 2.4.19 is not the proper version to remove
interfaces, I'm going to check in the following patch to the 2.4 branch to
revert the change (with a slightly sanitized type for the dvma_address
member). 

 Any objections?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.19-rc1-20020802-sg-2
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020802.macro/include/asm-mips/scatterlist.h linux-mips-2.4.19-rc1-20020802/include/asm-mips/scatterlist.h
--- linux-mips-2.4.19-rc1-20020802.macro/include/asm-mips/scatterlist.h	2002-08-01 15:57:53.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020802/include/asm-mips/scatterlist.h	2002-08-03 20:43:35.000000000 +0000
@@ -10,6 +10,13 @@ struct scatterlist {
 	unsigned int length;
 };
 
+struct mmu_sglist {
+	char *addr;
+	char *__dont_touch;
+	unsigned int len;
+	dma_addr_t dvma_address;
+};
+
 #define ISA_DMA_THRESHOLD (0x00ffffff)
 
 #endif /* __ASM_SCATTERLIST_H */
diff -up --recursive --new-file linux-mips-2.4.19-rc1-20020802.macro/include/asm-mips64/scatterlist.h linux-mips-2.4.19-rc1-20020802/include/asm-mips64/scatterlist.h
--- linux-mips-2.4.19-rc1-20020802.macro/include/asm-mips64/scatterlist.h	2002-08-01 15:57:54.000000000 +0000
+++ linux-mips-2.4.19-rc1-20020802/include/asm-mips64/scatterlist.h	2002-08-03 20:43:44.000000000 +0000
@@ -10,6 +10,13 @@ struct scatterlist {
 	unsigned long length;
 };
 
+struct mmu_sglist {
+	char *addr;
+	char *__dont_touch;
+	unsigned long len;
+	dma_addr_t dvma_address;
+};
+
 #define ISA_DMA_THRESHOLD (0x00ffffff)
 
 #endif /* __ASM_SCATTERLIST_H */

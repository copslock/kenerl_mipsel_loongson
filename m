Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jun 2010 09:52:46 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:57917 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491969Ab0FPHwm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jun 2010 09:52:42 +0200
Received: by pxi6 with SMTP id 6so763934pxi.36
        for <multiple recipients>; Wed, 16 Jun 2010 00:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=M7FK2ZGFMRfgJ4yGHNjH/agFMrWhoPBWW6ZHKCQTb6A=;
        b=G8AbjD+zQze/HWkwnCBJatmezE7g4n9BPwucpMM/21Y4+wByCJR/7L9P8SgeHSGWUe
         TdXpvQJsY3pm93YWJP/dz648pjAxjZO0aNusD0Q1klCsrj4PQPBO1VM0s1aX/skZcdtv
         5X1waLsw1lkgbcFG9c/+s3b2ZOkdG60nL214s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=QUr47+YpVRRj7sjWIgUEY1/ggA3raixZuzmTYXrtG2HgoRpgYg2D7D6r7jE1XqE87j
         KO5ewuSFsGId9IoIbv8/ApSjQanw50VsYxAodQSrZzMLHb1OCz9TXVwWFMRE1igRWQT8
         rAelN2k1z4FPBCxyI9Rd+t/cNUu9ezl/xJAGM=
Received: by 10.114.33.8 with SMTP id g8mr6729829wag.225.1276674753278;
        Wed, 16 Jun 2010 00:52:33 -0700 (PDT)
Received: from localhost.localdomain ([182.18.29.11])
        by mx.google.com with ESMTPS id c1sm78670395wam.7.2010.06.16.00.52.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Jun 2010 00:52:32 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] MIPS: Clean up arch/mips/boot/compressed/ld.script
Date:   Wed, 16 Jun 2010 15:52:19 +0800
Message-Id: <7a966ffadcf2a4600c098c3ac47ef1f645790946.1276674390.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
X-archive-position: 27141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 11028

From: Wu Zhangjin <wuzhangjin@gmail.com>

- Remove un-needed symbols: _fdata, _text, only _edata and _end are
needed by head.S
- Remove un-needed sections: .sbss, .stab, .gptab.sdata, .gptab.sbss
- Change the alignment to 16bytes: ensure it is greater than any
standard data types by a MIPS compiler
- Clear the comments

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/boot/compressed/ld.script |   51 +++++++++++-----------------------
 1 files changed, 17 insertions(+), 34 deletions(-)

diff --git a/arch/mips/boot/compressed/ld.script b/arch/mips/boot/compressed/ld.script
index c4b6491..8e6b07c 100644
--- a/arch/mips/boot/compressed/ld.script
+++ b/arch/mips/boot/compressed/ld.script
@@ -2,61 +2,44 @@
  * ld.script for compressed kernel support of MIPS
  *
  * Copyright (C) 2009 Lemote Inc.
- * Author: Wu Zhangjin <wuzhangjin@gmail.com>
+ * Author: Wu Zhangjin <wuzhanjing@gmail.com>
+ * Copyright (C) 2010 "Wu Zhangjin" <wuzhanjing@gmail.com>
  */
 
 OUTPUT_ARCH(mips)
 ENTRY(start)
 SECTIONS
 {
-	/* . = VMLINUZ_LOAD_ADDRESS */
-	/* read-only */
-	_text = .;	/* Text and read-only data */
-	.text	: {
-		_ftext = . ;
+	/* Text and read-only data */
+	/* . = VMLINUZ_LOAD_ADDRESS; */
+	.text : {
 		*(.text)
 		*(.rodata)
-	} = 0
-	_etext = .;	/* End of text section */
+	}
+	/* End of text section */
 
-	/* writable */
-	.data	: {	/* Data */
-		_fdata = . ;
+	/* Writable data */
+	.data : {
 		*(.data)
-		/* Put the compressed image here, so bss is on the end. */
+		/* Put the compressed image here */
 		__image_begin = .;
 		*(.image)
 		__image_end = .;
 		CONSTRUCTORS
 	}
-	.sdata	: { *(.sdata) }
-	. = ALIGN(4);
-	_edata  =  .;	/* End of data section */
+	. = ALIGN(16);
+	_edata = .;
+	/* End of data section */
 
 	/* BSS */
-	__bss_start = .;
-	_fbss = .;
-	.sbss	: { *(.sbss) *(.scommon) }
-	.bss	: {
-		*(.dynbss)
+	.bss : {
 		*(.bss)
-		*(COMMON)
 	}
-	.  = ALIGN(4);
-	_end = . ;
-
-	/* These are needed for ELF backends which have not yet been converted
-	 * to the new style linker.  */
-
-	.stab 0 : { *(.stab) }
-	.stabstr 0 : { *(.stabstr) }
-
-	/* These must appear regardless of  .  */
-	.gptab.sdata : { *(.gptab.data) *(.gptab.sdata) }
-	.gptab.sbss : { *(.gptab.bss) *(.gptab.sbss) }
+	. = ALIGN(16);
+	_end = .;
 
 	/* Sections to be discarded */
-	/DISCARD/	: {
+	/DISCARD/ : {
 		*(.MIPS.options)
 		*(.options)
 		*(.pdr)
-- 
1.7.0.4

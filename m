Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Jul 2004 13:39:12 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:9209 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225534AbUGCMjI>; Sat, 3 Jul 2004 13:39:08 +0100
Received: from localhost (p7041-ipad204funabasi.chiba.ocn.ne.jp [222.146.94.41])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9DA866CA3; Sat,  3 Jul 2004 21:38:59 +0900 (JST)
Date: Sat, 03 Jul 2004 21:44:11 +0900 (JST)
Message-Id: <20040703.214411.74757075.anemo@mba.ocn.ne.jp>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Re: 2.4 pci_dma_sync_sg fix
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20040701135919.GA6906@linux-mips.org>
References: <20040701132240.GA6219@linux-mips.org>
	<20040701.224535.71082878.anemo@mba.ocn.ne.jp>
	<20040701135919.GA6906@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 1 Jul 2004 15:59:19 +0200, Ralf Baechle <ralf@linux-mips.org> said:

>> The loop contains paranoid out_of_line_bug, so it never be
>> optimized to empty.

ralf> Indeed and I think that's a bit of overkill.  I've never seen
ralf> these assertions catch any bugs - and 2.4 isn't exactly new
ralf> anymore.  Anyway, even if the loop was empty gcc would not
ralf> eleminate it.

Then how about this?

Index: pci.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/pci.h,v
retrieving revision 1.24.2.16
diff -u -r1.24.2.16 pci.h
--- pci.h	17 Nov 2003 01:07:45 -0000	1.24.2.16
+++ pci.h	3 Jul 2004 12:30:36 -0000
@@ -281,8 +281,16 @@
 
 	/* Make sure that gcc doesn't leave the empty loop body.  */
 #ifdef CONFIG_NONCOHERENT_IO
-	for (i = 0; i < nelems; i++, sg++)
-		dma_cache_wback_inv((unsigned long)sg->address, sg->length);
+	for (i = 0; i < nelems; i++, sg++) {
+		if (sg->address) {
+			dma_cache_wback_inv((unsigned long)sg->address,
+			                    sg->length);
+		} else {
+			dma_cache_wback_inv((unsigned long)
+				(page_address(sg->page) + sg->offset),
+				sg->length);
+		}
+	}
 #endif
 }
 

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2016 06:21:45 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49542 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009598AbcAVFVNp8Fzz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jan 2016 06:21:13 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 4313D82F13103;
        Fri, 22 Jan 2016 05:21:07 +0000 (GMT)
Received: from [10.100.200.15] (10.100.200.15) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.235.1; Fri, 22 Jan 2016
 05:21:07 +0000
Date:   Fri, 22 Jan 2016 05:21:34 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Aurelien Jarno <aurelien@aurel32.net>, <linux-mips@linux-mips.org>
Subject: [PATCH 6/7] MIPS: inst.h: Fix some instruction descriptions
In-Reply-To: <alpine.DEB.2.00.1601220227590.5958@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1601220254560.5958@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1601220227590.5958@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.15]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Fix the description of the microMIPS NOP16 encoding or MM_NOP16, which 
is not equivalent to the MIPS16 NOP instruction.  This is 0x0c00 and 
represents the microMIPS `MOVE16 $0, $0' operation, whereas MIPS16 NOP 
is encoded as 0x6500, representing `MOVE $0, $16'.

Also fix a typo in `mm_fp0_format' description.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
Ralf,

 I don't think these changes are worth two separate patches.  Please 
apply.

  Maciej

linux-mips-inst-comment-fix.diff
Index: linux-sfr-test/arch/mips/include/uapi/asm/inst.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/uapi/asm/inst.h	2016-01-20 21:52:36.000000000 +0000
+++ linux-sfr-test/arch/mips/include/uapi/asm/inst.h	2016-01-20 21:54:36.191277000 +0000
@@ -529,7 +529,7 @@ enum MIPS6e_i8_func {
 };
 
 /*
- * (microMIPS & MIPS16e) NOP instruction.
+ * (microMIPS) NOP instruction.
  */
 #define MM_NOP16	0x0c00
 
@@ -679,7 +679,7 @@ struct fp0_format {		/* FPU multiply and
 	;))))))
 };
 
-struct mm_fp0_format {		/* FPU multipy and add format (microMIPS) */
+struct mm_fp0_format {		/* FPU multiply and add format (microMIPS) */
 	__BITFIELD_FIELD(unsigned int opcode : 6,
 	__BITFIELD_FIELD(unsigned int ft : 5,
 	__BITFIELD_FIELD(unsigned int fs : 5,

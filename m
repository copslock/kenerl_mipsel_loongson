Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2006 00:45:16 +0100 (BST)
Received: from farad.aurel32.net ([82.232.2.251]:22983 "EHLO farad.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20039159AbWI1XpO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 Sep 2006 00:45:14 +0100
Received: from bode.aurel32.net ([2001:618:400:fc13:211:9ff:feed:c498])
	by farad.aurel32.net with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GT5Yy-0004YZ-Dn; Fri, 29 Sep 2006 01:45:08 +0200
Received: from aurel32 by bode.aurel32.net with local (Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1GT5Yy-0002H3-FV; Fri, 29 Sep 2006 01:45:08 +0200
Date:	Fri, 29 Sep 2006 01:45:08 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	qemu-devel@nongnu.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] MIPS: add support for cvt.s.d and cvt.d.s
Message-ID: <20060928234505.GA8305@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Hi,

The patch below implements the cvt.s.d and cvt.d.s instructions for the
mips target. They are need to be able to execute the cp and the find
programs.

Bye,
Aurelien


Index: target-mips/op.c
===================================================================
RCS file: /sources/qemu/qemu/target-mips/op.c,v
retrieving revision 1.9
diff -u -r1.9 op.c
--- target-mips/op.c	26 Jun 2006 20:29:47 -0000	1.9
+++ target-mips/op.c	28 Sep 2006 23:42:30 -0000
@@ -785,12 +785,24 @@
 
 #define FLOAT_OP(name, p) void OPPROTO op_float_##name##_##p(void)
 
+FLOAT_OP(cvtd, s)
+{
+    FDT2 = float32_to_float64(WT0, &env->fp_status);
+    DEBUG_FPU_STATE();
+    RETURN();
+}
 FLOAT_OP(cvtd, w)
 {
     FDT2 = int32_to_float64(WT0, &env->fp_status);
     DEBUG_FPU_STATE();
     RETURN();
 }
+FLOAT_OP(cvts, d)
+{
+    FST2 = float64_to_float32(WT0, &env->fp_status);
+    DEBUG_FPU_STATE();
+    RETURN();
+}
 FLOAT_OP(cvts, w)
 {
     FST2 = int32_to_float32(WT0, &env->fp_status);
Index: target-mips/translate.c
===================================================================
RCS file: /sources/qemu/qemu/target-mips/translate.c,v
retrieving revision 1.15
diff -u -r1.15 translate.c
--- target-mips/translate.c	26 Jun 2006 20:02:45 -0000	1.15
+++ target-mips/translate.c	28 Sep 2006 23:42:30 -0000
@@ -1675,6 +1675,13 @@
         GEN_STORE_FTN_FREG(fd, WT2);
         opn = "ceil.w.d";
         break;
+    case FOP(33, 16): /* cvt.d.s */
+        CHECK_FR(ctx, fs | fd);
+        GEN_LOAD_FREG_FTN(WT0, fs);
+        gen_op_float_cvtd_s();
+        GEN_STORE_FTN_FREG(fd, DT2);
+        opn = "cvt.d.s";
+        break;
     case FOP(33, 20): /* cvt.d.w */
         CHECK_FR(ctx, fs | fd);
         GEN_LOAD_FREG_FTN(WT0, fs);
@@ -1782,6 +1789,13 @@
         GEN_STORE_FTN_FREG(fd, WT2);
         opn = "trunc.w.s";
         break;
+    case FOP(32, 17): /* cvt.s.d */
+        CHECK_FR(ctx, fs | fd);
+        GEN_LOAD_FREG_FTN(WT0, fs);
+        gen_op_float_cvts_d();
+        GEN_STORE_FTN_FREG(fd, WT2);
+        opn = "cvt.s.d";
+        break;
     case FOP(32, 20): /* cvt.s.w */
         CHECK_FR(ctx, fs | fd);
         GEN_LOAD_FREG_FTN(WT0, fs);
-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net

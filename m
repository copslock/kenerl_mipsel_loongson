Return-Path: <SRS0=AiVX=QN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DFFC169C4
	for <linux-mips@archiver.kernel.org>; Wed,  6 Feb 2019 12:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196B82175B
	for <linux-mips@archiver.kernel.org>; Wed,  6 Feb 2019 12:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNT8E/8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbfBFMDO (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:03:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:47045 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729756AbfBFMDN (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 6 Feb 2019 07:03:13 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so2951442pfe.13
        for <linux-mips@vger.kernel.org>; Wed, 06 Feb 2019 04:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=YkjRNVvQVYSmxehtMEBfBmi0pU30hQNGqJlCmYY4gnk=;
        b=bNT8E/8teKY4AxUAE7xWhKbbW7yEv3tGYQkee7AyEEbI8RXfIC47Rg3KwmFcpgwU6k
         iPp93h3BNhxvzUUWoGvdy926EoA3z8Yx4bewwPIxokg6jcPkFOPC7fvBLw+2oiusJB8G
         pBh9mdYKNMMtJKBviRwoLm7OsMo3REmwCUB6TxLRSEI8pGaQiqvJz9I22KqEZ3JpX0T/
         zEHFr0sWJuv3VD9xxj1DAdhxHzwr+OxCa78qX6+f3/U7Yg4nJ0V8JlHHdB5pZfzTA3XI
         Rin9TGdW+2k2aVJd6DEzU5EPILChkpE1osCmwpOcofeFXyvtf44Pc2LbU4GmFnIvIemS
         +rnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=YkjRNVvQVYSmxehtMEBfBmi0pU30hQNGqJlCmYY4gnk=;
        b=cSC8J9exetpCPh21Q6coCemklq5I74uAteDlfE7AgIBtmYFbQqiAebZE/69UFE7CYc
         DbI8sCEW1W70n/Win9WxI+R8mCfWJMEZGCOd9QU3zCYWJNAn8C8/CpVXdnrEqWM3n+CI
         dQYNBx81Zj1PQsZaQcJz9FjzBURmyrnxCvDG1FWtpieSh2tO9YfSQx8RPiUoZ81qiek9
         cVeHMbipS2gaEp4rz+v7uDZxHkz0aNZ7U6Gtjzsl2DQJP4mAu466vmG80GITP/ca71Tb
         YS8NhYSFv0rnl7S4vAjUPaHDYPiYgbRmElT6cCg84L9Diu3UbZf7txJPxiLrt7eQRgH8
         D8nw==
X-Gm-Message-State: AHQUAua9CTxAa0g09GsVyrCIbkoMvGiK0IriTUXlz307gTuUJiShuWal
        hTLi7vSdfbBgd0SDImGS8TA=
X-Google-Smtp-Source: AHgI3IYQt2rsupVPdA11M+Lh7G058oiK9Z9j/oqiBgMHj9OCuf6Tt+ZuPDf9ynv9WNiAko4S9byksA==
X-Received: by 2002:a63:ee4c:: with SMTP id n12mr8986835pgk.21.1549454592235;
        Wed, 06 Feb 2019 04:03:12 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id w6sm9339023pga.72.2019.02.06.04.03.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Feb 2019 04:03:10 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-mips@linux-mips.org, linux-mips@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Pei Huang <huangpei@loongson.cn>
Subject: [PATCH] MIPS: math-emu: Add madd/msub/nmadd/nmsub emulation for Loongson-3
Date:   Wed,  6 Feb 2019 20:03:14 +0800
Message-Id: <1549454594-9056-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Add madd.s/madd.d/msub.s/msub.d/nmadd.s/nmadd.d/nmsub.s/nmsub.d
emulation for Loongson-3. MIPS R2 suggest these instructions be
unfused, but Loongson-3 suggest these instructions be fused, which
is similar to maddf/msubf in MIPS R6.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Pei Huang <huangpei@loongson.cn>
---
 arch/mips/math-emu/cp1emu.c     | 32 +++++++++++++++++++++++++
 arch/mips/math-emu/dp_maddf.c   | 53 +++++++++++++++++++++++++++--------------
 arch/mips/math-emu/ieee754.h    | 16 +++++++++++++
 arch/mips/math-emu/ieee754int.h |  1 +
 arch/mips/math-emu/sp_maddf.c   | 53 +++++++++++++++++++++++++++--------------
 5 files changed, 119 insertions(+), 36 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index e60e290..2f99ec2 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1463,6 +1463,7 @@ static union ieee754sp fpemu_sp_rsqrt(union ieee754sp s)
 	return ieee754sp_div(ieee754sp_one(0), ieee754sp_sqrt(s));
 }
 
+#ifndef CONFIG_CPU_LOONGSON3
 DEF3OP(madd, sp, ieee754sp_mul, ieee754sp_add, );
 DEF3OP(msub, sp, ieee754sp_mul, ieee754sp_sub, );
 DEF3OP(nmadd, sp, ieee754sp_mul, ieee754sp_add, ieee754sp_neg);
@@ -1471,6 +1472,7 @@ DEF3OP(madd, dp, ieee754dp_mul, ieee754dp_add, );
 DEF3OP(msub, dp, ieee754dp_mul, ieee754dp_sub, );
 DEF3OP(nmadd, dp, ieee754dp_mul, ieee754dp_add, ieee754dp_neg);
 DEF3OP(nmsub, dp, ieee754dp_mul, ieee754dp_sub, ieee754dp_neg);
+#endif
 
 static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 	mips_instruction ir, void __user **fault_addr)
@@ -1525,6 +1527,20 @@ static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			}
 			break;
 
+#ifdef CONFIG_CPU_LOONGSON3
+		case madd_s_op:
+			handler = ieee754sp_madd;
+			goto scoptop;
+		case msub_s_op:
+			handler = ieee754sp_msub;
+			goto scoptop;
+		case nmadd_s_op:
+			handler = ieee754sp_nmadd;
+			goto scoptop;
+		case nmsub_s_op:
+			handler = ieee754sp_nmsub;
+			goto scoptop;
+#else
 		case madd_s_op:
 			handler = fpemu_sp_madd;
 			goto scoptop;
@@ -1537,6 +1553,7 @@ static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 		case nmsub_s_op:
 			handler = fpemu_sp_nmsub;
 			goto scoptop;
+#endif
 
 		      scoptop:
 			SPFROMREG(fr, MIPSInst_FR(ir));
@@ -1621,6 +1638,20 @@ static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			}
 			break;
 
+#ifdef CONFIG_CPU_LOONGSON3
+		case madd_d_op:
+			handler = ieee754dp_madd;
+			goto dcoptop;
+		case msub_d_op:
+			handler = ieee754dp_msub;
+			goto dcoptop;
+		case nmadd_d_op:
+			handler = ieee754dp_nmadd;
+			goto dcoptop;
+		case nmsub_d_op:
+			handler = ieee754dp_nmsub;
+			goto dcoptop;
+#else
 		case madd_d_op:
 			handler = fpemu_dp_madd;
 			goto dcoptop;
@@ -1633,6 +1664,7 @@ static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 		case nmsub_d_op:
 			handler = fpemu_dp_nmsub;
 			goto dcoptop;
+#endif
 
 		      dcoptop:
 			DPFROMREG(fr, MIPSInst_FR(ir));
diff --git a/arch/mips/math-emu/dp_maddf.c b/arch/mips/math-emu/dp_maddf.c
index 7ea2f82..a9c2db4 100644
--- a/arch/mips/math-emu/dp_maddf.c
+++ b/arch/mips/math-emu/dp_maddf.c
@@ -71,6 +71,12 @@ static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
 
 	ieee754_clearcx();
 
+	rs = xs ^ ys;
+	if (flags & MADDF_NEGATE_PRODUCT)
+		rs ^= 1;
+	if (flags & MADDF_NEGATE_ADDITION)
+		zs ^= 1;
+
 	/*
 	 * Handle the cases when at least one of x, y or z is a NaN.
 	 * Order of precedence is sNaN, qNaN and z, x, y.
@@ -107,9 +113,7 @@ static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
-		if ((zc == IEEE754_CLASS_INF) &&
-		    ((!(flags & MADDF_NEGATE_PRODUCT) && (zs != (xs ^ ys))) ||
-		     ((flags & MADDF_NEGATE_PRODUCT) && (zs == (xs ^ ys))))) {
+		if ((zc == IEEE754_CLASS_INF) && (zs != rs)) {
 			/*
 			 * Cases of addition of infinities with opposite signs
 			 * or subtraction of infinities with same signs.
@@ -119,15 +123,10 @@ static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
 		}
 		/*
 		 * z is here either not an infinity, or an infinity having the
-		 * same sign as product (x*y) (in case of MADDF.D instruction)
-		 * or product -(x*y) (in MSUBF.D case). The result must be an
-		 * infinity, and its sign is determined only by the value of
-		 * (flags & MADDF_NEGATE_PRODUCT) and the signs of x and y.
+		 * same sign as product (x*y). The result must be an infinity,
+		 * and its sign is determined only by the sign of product (x*y).
 		 */
-		if (flags & MADDF_NEGATE_PRODUCT)
-			return ieee754dp_inf(1 ^ (xs ^ ys));
-		else
-			return ieee754dp_inf(xs ^ ys);
+		return ieee754dp_inf(rs);
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_NORM):
@@ -138,10 +137,7 @@ static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
 			return ieee754dp_inf(zs);
 		if (zc == IEEE754_CLASS_ZERO) {
 			/* Handle cases +0 + (-0) and similar ones. */
-			if ((!(flags & MADDF_NEGATE_PRODUCT)
-					&& (zs == (xs ^ ys))) ||
-			    ((flags & MADDF_NEGATE_PRODUCT)
-					&& (zs != (xs ^ ys))))
+			if (zs == rs)
 				/*
 				 * Cases of addition of zeros of equal signs
 				 * or subtraction of zeroes of opposite signs.
@@ -190,9 +186,6 @@ static union ieee754dp _dp_maddf(union ieee754dp z, union ieee754dp x,
 	assert(ym & DP_HIDDEN_BIT);
 
 	re = xe + ye;
-	rs = xs ^ ys;
-	if (flags & MADDF_NEGATE_PRODUCT)
-		rs ^= 1;
 
 	/* shunt to top of word */
 	xm <<= 64 - (DP_FBITS + 1);
@@ -343,3 +336,27 @@ union ieee754dp ieee754dp_msubf(union ieee754dp z, union ieee754dp x,
 {
 	return _dp_maddf(z, x, y, MADDF_NEGATE_PRODUCT);
 }
+
+union ieee754dp ieee754dp_madd(union ieee754dp z, union ieee754dp x,
+				union ieee754dp y)
+{
+	return _dp_maddf(z, x, y, 0);
+}
+
+union ieee754dp ieee754dp_msub(union ieee754dp z, union ieee754dp x,
+				union ieee754dp y)
+{
+	return _dp_maddf(z, x, y, MADDF_NEGATE_ADDITION);
+}
+
+union ieee754dp ieee754dp_nmadd(union ieee754dp z, union ieee754dp x,
+				union ieee754dp y)
+{
+	return _dp_maddf(z, x, y, MADDF_NEGATE_PRODUCT|MADDF_NEGATE_ADDITION);
+}
+
+union ieee754dp ieee754dp_nmsub(union ieee754dp z, union ieee754dp x,
+				union ieee754dp y)
+{
+	return _dp_maddf(z, x, y, MADDF_NEGATE_PRODUCT);
+}
diff --git a/arch/mips/math-emu/ieee754.h b/arch/mips/math-emu/ieee754.h
index e0eb7a9..e12bb9f 100644
--- a/arch/mips/math-emu/ieee754.h
+++ b/arch/mips/math-emu/ieee754.h
@@ -80,6 +80,14 @@ union ieee754sp ieee754sp_maddf(union ieee754sp z, union ieee754sp x,
 				union ieee754sp y);
 union ieee754sp ieee754sp_msubf(union ieee754sp z, union ieee754sp x,
 				union ieee754sp y);
+union ieee754sp ieee754sp_madd(union ieee754sp z, union ieee754sp x,
+				union ieee754sp y);
+union ieee754sp ieee754sp_msub(union ieee754sp z, union ieee754sp x,
+				union ieee754sp y);
+union ieee754sp ieee754sp_nmadd(union ieee754sp z, union ieee754sp x,
+				union ieee754sp y);
+union ieee754sp ieee754sp_nmsub(union ieee754sp z, union ieee754sp x,
+				union ieee754sp y);
 int ieee754sp_2008class(union ieee754sp x);
 union ieee754sp ieee754sp_fmin(union ieee754sp x, union ieee754sp y);
 union ieee754sp ieee754sp_fmina(union ieee754sp x, union ieee754sp y);
@@ -115,6 +123,14 @@ union ieee754dp ieee754dp_maddf(union ieee754dp z, union ieee754dp x,
 				union ieee754dp y);
 union ieee754dp ieee754dp_msubf(union ieee754dp z, union ieee754dp x,
 				union ieee754dp y);
+union ieee754dp ieee754dp_madd(union ieee754dp z, union ieee754dp x,
+				union ieee754dp y);
+union ieee754dp ieee754dp_msub(union ieee754dp z, union ieee754dp x,
+				union ieee754dp y);
+union ieee754dp ieee754dp_nmadd(union ieee754dp z, union ieee754dp x,
+				union ieee754dp y);
+union ieee754dp ieee754dp_nmsub(union ieee754dp z, union ieee754dp x,
+				union ieee754dp y);
 int ieee754dp_2008class(union ieee754dp x);
 union ieee754dp ieee754dp_fmin(union ieee754dp x, union ieee754dp y);
 union ieee754dp ieee754dp_fmina(union ieee754dp x, union ieee754dp y);
diff --git a/arch/mips/math-emu/ieee754int.h b/arch/mips/math-emu/ieee754int.h
index 06ac0e2..302815c 100644
--- a/arch/mips/math-emu/ieee754int.h
+++ b/arch/mips/math-emu/ieee754int.h
@@ -28,6 +28,7 @@
 
 enum maddf_flags {
 	MADDF_NEGATE_PRODUCT	= 1 << 0,
+	MADDF_NEGATE_ADDITION	= 1 << 1,
 };
 
 static inline void ieee754_clearcx(void)
diff --git a/arch/mips/math-emu/sp_maddf.c b/arch/mips/math-emu/sp_maddf.c
index 07ba675..d334181 100644
--- a/arch/mips/math-emu/sp_maddf.c
+++ b/arch/mips/math-emu/sp_maddf.c
@@ -39,6 +39,12 @@ static union ieee754sp _sp_maddf(union ieee754sp z, union ieee754sp x,
 
 	ieee754_clearcx();
 
+	rs = xs ^ ys;
+	if (flags & MADDF_NEGATE_PRODUCT)
+		rs ^= 1;
+	if (flags & MADDF_NEGATE_ADDITION)
+		zs ^= 1;
+
 	/*
 	 * Handle the cases when at least one of x, y or z is a NaN.
 	 * Order of precedence is sNaN, qNaN and z, x, y.
@@ -76,9 +82,7 @@ static union ieee754sp _sp_maddf(union ieee754sp z, union ieee754sp x,
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_NORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_DNORM):
 	case CLPAIR(IEEE754_CLASS_INF, IEEE754_CLASS_INF):
-		if ((zc == IEEE754_CLASS_INF) &&
-		    ((!(flags & MADDF_NEGATE_PRODUCT) && (zs != (xs ^ ys))) ||
-		     ((flags & MADDF_NEGATE_PRODUCT) && (zs == (xs ^ ys))))) {
+		if ((zc == IEEE754_CLASS_INF) && (zs != rs)) {
 			/*
 			 * Cases of addition of infinities with opposite signs
 			 * or subtraction of infinities with same signs.
@@ -88,15 +92,10 @@ static union ieee754sp _sp_maddf(union ieee754sp z, union ieee754sp x,
 		}
 		/*
 		 * z is here either not an infinity, or an infinity having the
-		 * same sign as product (x*y) (in case of MADDF.D instruction)
-		 * or product -(x*y) (in MSUBF.D case). The result must be an
-		 * infinity, and its sign is determined only by the value of
-		 * (flags & MADDF_NEGATE_PRODUCT) and the signs of x and y.
+		 * same sign as product (x*y). The result must be an infinity,
+		 * and its sign is determined only by the sign of product (x*y).
 		 */
-		if (flags & MADDF_NEGATE_PRODUCT)
-			return ieee754sp_inf(1 ^ (xs ^ ys));
-		else
-			return ieee754sp_inf(xs ^ ys);
+		return ieee754sp_inf(rs);
 
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_ZERO):
 	case CLPAIR(IEEE754_CLASS_ZERO, IEEE754_CLASS_NORM):
@@ -107,10 +106,7 @@ static union ieee754sp _sp_maddf(union ieee754sp z, union ieee754sp x,
 			return ieee754sp_inf(zs);
 		if (zc == IEEE754_CLASS_ZERO) {
 			/* Handle cases +0 + (-0) and similar ones. */
-			if ((!(flags & MADDF_NEGATE_PRODUCT)
-					&& (zs == (xs ^ ys))) ||
-			    ((flags & MADDF_NEGATE_PRODUCT)
-					&& (zs != (xs ^ ys))))
+			if (zs == rs)
 				/*
 				 * Cases of addition of zeros of equal signs
 				 * or subtraction of zeroes of opposite signs.
@@ -161,9 +157,6 @@ static union ieee754sp _sp_maddf(union ieee754sp z, union ieee754sp x,
 	assert(ym & SP_HIDDEN_BIT);
 
 	re = xe + ye;
-	rs = xs ^ ys;
-	if (flags & MADDF_NEGATE_PRODUCT)
-		rs ^= 1;
 
 	/* Multiple 24 bit xm and ym to give 48 bit results */
 	rm64 = (uint64_t)xm * ym;
@@ -263,3 +256,27 @@ union ieee754sp ieee754sp_msubf(union ieee754sp z, union ieee754sp x,
 {
 	return _sp_maddf(z, x, y, MADDF_NEGATE_PRODUCT);
 }
+
+union ieee754sp ieee754sp_madd(union ieee754sp z, union ieee754sp x,
+				union ieee754sp y)
+{
+	return _sp_maddf(z, x, y, 0);
+}
+
+union ieee754sp ieee754sp_msub(union ieee754sp z, union ieee754sp x,
+				union ieee754sp y)
+{
+	return _sp_maddf(z, x, y, MADDF_NEGATE_ADDITION);
+}
+
+union ieee754sp ieee754sp_nmadd(union ieee754sp z, union ieee754sp x,
+				union ieee754sp y)
+{
+	return _sp_maddf(z, x, y, MADDF_NEGATE_PRODUCT|MADDF_NEGATE_ADDITION);
+}
+
+union ieee754sp ieee754sp_nmsub(union ieee754sp z, union ieee754sp x,
+				union ieee754sp y)
+{
+	return _sp_maddf(z, x, y, MADDF_NEGATE_PRODUCT);
+}
-- 
2.7.0


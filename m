Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Nov 2007 21:22:29 +0000 (GMT)
Received: from gepetto.dc.ltu.se ([130.240.42.40]:37572 "EHLO
	gepetto.dc.ltu.se") by ftp.linux-mips.org with ESMTP
	id S20031813AbXKXVWV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 Nov 2007 21:22:21 +0000
Received: from thinktank.campus.ltu.se (thinktank.campus.luth.se [130.240.205.31])
	by gepetto.dc.ltu.se (8.12.5/8.12.5) with ESMTP id lAOLMJOq013855;
	Sat, 24 Nov 2007 22:22:20 +0100 (MET)
Date:	Sat, 24 Nov 2007 22:22:19 +0100 (MET)
From:	Richard Knutsson <ricknu-0@student.ltu.se>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	Richard Knutsson <ricknu-0@student.ltu.se>
Message-Id: <20071124211046.9931.46998.sendpatchset@thinktank.campus.ltu.se>
Subject: [PATCH] [MIPS]: Compliment va_start() with va_end().
Return-Path: <ricknu-0@student.ltu.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ricknu-0@student.ltu.se
Precedence: bulk
X-list: linux-mips

Compliment va_start() with va_end().

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
---

 ieee754.c   |    2 ++
 ieee754dp.c |    2 ++
 ieee754sp.c |    2 ++
 3 files changed, 6 insertions(+)


diff --git a/arch/mips/math-emu/ieee754.c b/arch/mips/math-emu/ieee754.c
index 946aee3..cb1b682 100644
--- a/arch/mips/math-emu/ieee754.c
+++ b/arch/mips/math-emu/ieee754.c
@@ -108,6 +108,7 @@ int ieee754si_xcpt(int r, const char *op, ...)
 	ax.rv.si = r;
 	va_start(ax.ap, op);
 	ieee754_xcpt(&ax);
+	va_end(ax.ap);
 	return ax.rv.si;
 }
 
@@ -122,5 +123,6 @@ s64 ieee754di_xcpt(s64 r, const char *op, ...)
 	ax.rv.di = r;
 	va_start(ax.ap, op);
 	ieee754_xcpt(&ax);
+	va_end(ax.ap);
 	return ax.rv.di;
 }
diff --git a/arch/mips/math-emu/ieee754dp.c b/arch/mips/math-emu/ieee754dp.c
index 3e214aa..6d2d89f 100644
--- a/arch/mips/math-emu/ieee754dp.c
+++ b/arch/mips/math-emu/ieee754dp.c
@@ -57,6 +57,7 @@ ieee754dp ieee754dp_xcpt(ieee754dp r, const char *op, ...)
 	ax.rv.dp = r;
 	va_start(ax.ap, op);
 	ieee754_xcpt(&ax);
+	va_end(ax.ap);
 	return ax.rv.dp;
 }
 
@@ -83,6 +84,7 @@ ieee754dp ieee754dp_nanxcpt(ieee754dp r, const char *op, ...)
 	ax.rv.dp = r;
 	va_start(ax.ap, op);
 	ieee754_xcpt(&ax);
+	va_end(ax.ap);
 	return ax.rv.dp;
 }
 
diff --git a/arch/mips/math-emu/ieee754sp.c b/arch/mips/math-emu/ieee754sp.c
index adda851..4635340 100644
--- a/arch/mips/math-emu/ieee754sp.c
+++ b/arch/mips/math-emu/ieee754sp.c
@@ -58,6 +58,7 @@ ieee754sp ieee754sp_xcpt(ieee754sp r, const char *op, ...)
 	ax.rv.sp = r;
 	va_start(ax.ap, op);
 	ieee754_xcpt(&ax);
+	va_end(ax.ap);
 	return ax.rv.sp;
 }
 
@@ -84,6 +85,7 @@ ieee754sp ieee754sp_nanxcpt(ieee754sp r, const char *op, ...)
 	ax.rv.sp = r;
 	va_start(ax.ap, op);
 	ieee754_xcpt(&ax);
+	va_end(ax.ap);
 	return ax.rv.sp;
 }
 

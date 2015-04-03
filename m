Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:32:03 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025292AbbDCWZ5Mmcsy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:25:57 +0200
Date:   Fri, 3 Apr 2015 23:25:57 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 29/48] MIPS: math-emu: Make NaN classifiers static
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504031614470.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46746
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

The `ieee754sp_isnan' and `ieee754dp_isnan' NaN classifiers are now no 
longer externally referred, remove their header prototypes and make them 
local to the two only respective places still making use of them.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-emu-isnan.diff
Index: linux/arch/mips/math-emu/ieee754dp.c
===================================================================
--- linux.orig/arch/mips/math-emu/ieee754dp.c	2015-04-02 20:27:55.587207000 +0100
+++ linux/arch/mips/math-emu/ieee754dp.c	2015-04-02 20:27:56.032207000 +0100
@@ -30,7 +30,7 @@ int ieee754dp_class(union ieee754dp x)
 	return xc;
 }
 
-int ieee754dp_isnan(union ieee754dp x)
+static inline int ieee754dp_isnan(union ieee754dp x)
 {
 	return ieee754_class_nan(ieee754dp_class(x));
 }
Index: linux/arch/mips/math-emu/ieee754dp.h
===================================================================
--- linux.orig/arch/mips/math-emu/ieee754dp.h	2015-04-02 20:18:50.309509000 +0100
+++ linux/arch/mips/math-emu/ieee754dp.h	2015-04-02 20:27:56.035204000 +0100
@@ -77,6 +77,5 @@ static inline union ieee754dp builddp(in
 	return r;
 }
 
-extern int ieee754dp_isnan(union ieee754dp);
 extern union ieee754dp __cold ieee754dp_nanxcpt(union ieee754dp);
 extern union ieee754dp ieee754dp_format(int, int, u64);
Index: linux/arch/mips/math-emu/ieee754sp.c
===================================================================
--- linux.orig/arch/mips/math-emu/ieee754sp.c	2015-04-02 20:27:55.601223000 +0100
+++ linux/arch/mips/math-emu/ieee754sp.c	2015-04-02 20:27:56.037202000 +0100
@@ -30,7 +30,7 @@ int ieee754sp_class(union ieee754sp x)
 	return xc;
 }
 
-int ieee754sp_isnan(union ieee754sp x)
+static inline int ieee754sp_isnan(union ieee754sp x)
 {
 	return ieee754_class_nan(ieee754sp_class(x));
 }
Index: linux/arch/mips/math-emu/ieee754sp.h
===================================================================
--- linux.orig/arch/mips/math-emu/ieee754sp.h	2015-04-02 20:18:50.314505000 +0100
+++ linux/arch/mips/math-emu/ieee754sp.h	2015-04-02 20:27:56.039206000 +0100
@@ -82,6 +82,5 @@ static inline union ieee754sp buildsp(in
 	return r;
 }
 
-extern int ieee754sp_isnan(union ieee754sp);
 extern union ieee754sp __cold ieee754sp_nanxcpt(union ieee754sp);
 extern union ieee754sp ieee754sp_format(int, int, unsigned);

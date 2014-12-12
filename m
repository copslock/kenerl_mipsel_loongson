Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 15:28:16 +0100 (CET)
Received: from mail-wg0-f47.google.com ([74.125.82.47]:57283 "EHLO
        mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007955AbaLLO2OTmIOj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Dec 2014 15:28:14 +0100
Received: by mail-wg0-f47.google.com with SMTP id n12so9155302wgh.6
        for <linux-mips@linux-mips.org>; Fri, 12 Dec 2014 06:28:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :mime-version:content-type:content-disposition:user-agent;
        bh=cMihjPzOoSD9UUseJIvyQhpLPJUDxVlubUirsWa+5f8=;
        b=lzNZhxFVJyHXpi7+qLHy8nyLARFktkjCwgkvO7LvmR5WWiPWzqeKyZrO1PvhqO0w1W
         mA3DPY0avjjBFnzUEyJpdCRWxpiFV4N6Gk9oiAhHgmQOVEyoAI3uFAyDiQaSIiOHXV6a
         xBPMy62jmVo0ECxvqG1edwggzfhno72FhSBT4KsYPsupD12qX8mZD7G8QP3bjDgyDxQB
         jTgvV80vrENgn/t9vmk1DHhJY8uoJoUfltX9v6NFnrtTwGBmoRXr+sMC1VvzQgnYydWQ
         8Vff/Ymumbr8tMvsuhkeGaPwt3oNqKunffHaXIVhaf8JH1rYpYlD3chQP91Z5iM4ZoZe
         wxbA==
X-Gm-Message-State: ALoCoQkT1U1YScsA2WClZEbcJliSTQpxqUjR6xRsJFQGlnIq4PAj0YHsgP4+mupMsWoIVICPJsiC
X-Received: by 10.194.250.68 with SMTP id za4mr28295801wjc.92.1418394489034;
        Fri, 12 Dec 2014 06:28:09 -0800 (PST)
Received: from bordel.klfree.net (bordel.klfree.cz. [81.201.48.42])
        by mx.google.com with ESMTPSA id p5sm2170136wix.7.2014.12.12.06.28.08
        for <linux-mips@linux-mips.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Dec 2014 06:28:08 -0800 (PST)
Date:   Fri, 12 Dec 2014 15:28:01 +0100
From:   Petr Malat <oss@malat.biz>
To:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Provide correct siginfo_t.si_stime
Message-ID: <20141212142800.GA4176@bordel.klfree.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <oss@malat.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oss@malat.biz
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

From: Petr Malat <oss@malat.biz>

Provide correct siginfo_t.si_stime on MIPS64

Bug description:
MIPS version of copy_siginfo() is not aware of alignment on platforms with
64-bit long integers, which leads to an incorrect si_stime passed to signal
handlers, because the last element (si_stime) of _sifields._sigchld is not
copied. If _MIPS_SZLONG is 64, then the _sifields starts at the offset of 
4 * sizeof(int).

Patch description:
Use the generic copy_siginfo, which doesn't have this problem.

Signed-off-by: Petr Malat <oss@malat.biz>
---
Please put me on CC, I'm not signed into the mailing list.

diff -Naurp linux-3.18/arch/mips/include/asm/siginfo.h linux-3.18-new/arch/mips/include/asm/siginfo.h
--- linux-3.18/arch/mips/include/asm/siginfo.h	2014-12-07 23:21:05.000000000 +0100
+++ linux-3.18-new/arch/mips/include/asm/siginfo.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,29 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1998, 1999, 2001, 2003 Ralf Baechle
- * Copyright (C) 2000, 2001 Silicon Graphics, Inc.
- */
-#ifndef _ASM_SIGINFO_H
-#define _ASM_SIGINFO_H
-
-#include <uapi/asm/siginfo.h>
-
-
-/*
- * Duplicated here because of <asm-generic/siginfo.h> braindamage ...
- */
-#include <linux/string.h>
-
-static inline void copy_siginfo(struct siginfo *to, struct siginfo *from)
-{
-	if (from->si_code < 0)
-		memcpy(to, from, sizeof(*to));
-	else
-		/* _sigchld is currently the largest know union member */
-		memcpy(to, from, 3*sizeof(int) + sizeof(from->_sifields._sigchld));
-}
-
-#endif /* _ASM_SIGINFO_H */
diff -Naurp linux-3.18/arch/mips/include/uapi/asm/siginfo.h linux-3.18-new/arch/mips/include/uapi/asm/siginfo.h
--- linux-3.18/arch/mips/include/uapi/asm/siginfo.h	2014-12-07 23:21:05.000000000 +0100
+++ linux-3.18-new/arch/mips/include/uapi/asm/siginfo.h	2014-12-11 17:11:36.698056810 +0100
@@ -16,13 +16,6 @@
 #define HAVE_ARCH_SIGINFO_T
 
 /*
- * We duplicate the generic versions - <asm-generic/siginfo.h> is just borked
- * by design ...
- */
-#define HAVE_ARCH_COPY_SIGINFO
-struct siginfo;
-
-/*
  * Careful to keep union _sifields from shifting ...
  */
 #if _MIPS_SZLONG == 32
@@ -35,8 +28,9 @@ struct siginfo;
 
 #define __ARCH_SIGSYS
 
-#include <asm-generic/siginfo.h>
+#include <uapi/asm-generic/siginfo.h>
 
+/* We can't use generic siginfo_t, because our si_code and si_errno are swapped */
 typedef struct siginfo {
 	int si_signo;
 	int si_code;
@@ -120,5 +114,6 @@ typedef struct siginfo {
 #define SI_TIMER __SI_CODE(__SI_TIMER, -3) /* sent by timer expiration */
 #define SI_MESGQ __SI_CODE(__SI_MESGQ, -4) /* sent by real time mesq state change */
 
+#include <asm-generic/siginfo.h>
 
 #endif /* _UAPI_ASM_SIGINFO_H */

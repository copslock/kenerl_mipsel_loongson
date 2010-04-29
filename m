Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Apr 2010 11:58:38 +0200 (CEST)
Received: from mx1.moondrake.net ([212.85.150.166]:41348 "EHLO
        mx1.mandriva.com" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S1492434Ab0D2J46 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Apr 2010 11:56:58 +0200
Received: by mx1.mandriva.com (Postfix, from userid 501)
        id 334C727401A; Thu, 29 Apr 2010 11:56:58 +0200 (CEST)
Received: from office-abk.mandriva.com (unknown [195.7.104.248])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.mandriva.com (Postfix) with ESMTP id 54EA2274012
        for <linux-mips@linux-mips.org>; Thu, 29 Apr 2010 11:56:57 +0200 (CEST)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
        by office-abk.mandriva.com (Postfix) with ESMTP id 7F5A984250
        for <linux-mips@linux-mips.org>; Thu, 29 Apr 2010 12:14:38 +0200 (CEST)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
        by anduin.mandriva.com (Postfix) with ESMTP id B3691FF855
        for <linux-mips@linux-mips.org>; Thu, 29 Apr 2010 11:58:51 +0200 (CEST)
From:   Arnaud Patard <apatard@mandriva.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH] loongson.h: Fix LOONGSON_ADDRWIN_CFG macro
Organization: Mandriva
Date:   Thu, 29 Apr 2010 11:58:51 +0200
Message-ID: <m3tyquwpes.fsf@anduin.mandriva.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

--=-=-=


There's a typo in the LOONGSON_ADDRWIN_CFG macro. The cpu window mmap
register address should contain the destination parameters not the
source one (this has not been noticed because the code is only using
source=destination)

Signed-off-by: Arnaud Patard <apatard@mandriva.com>
---

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=fix_addrwin_cfg_macro.patch

Index: linux-2.6/arch/mips/include/asm/mach-loongson/loongson.h
===================================================================
--- linux-2.6.orig/arch/mips/include/asm/mach-loongson/loongson.h
+++ linux-2.6/arch/mips/include/asm/mach-loongson/loongson.h
@@ -307,7 +307,7 @@ extern unsigned long _loongson_addrwincf
  */
 #define LOONGSON_ADDRWIN_CFG(s, d, w, src, dst, size) do {\
 	s##_WIN##w##_BASE = (src); \
-	s##_WIN##w##_MMAP = (src) | ADDRWIN_MAP_DST_##d; \
+	s##_WIN##w##_MMAP = (dst) | ADDRWIN_MAP_DST_##d; \
 	s##_WIN##w##_MASK = ~(size-1); \
 } while (0)
 

--=-=-=--

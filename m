Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Feb 2010 13:38:55 +0100 (CET)
Received: from mail-gx0-f214.google.com ([209.85.217.214]:49933 "EHLO
        mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491089Ab0BLMhs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Feb 2010 13:37:48 +0100
Received: by gxk6 with SMTP id 6so1826651gxk.4
        for <multiple recipients>; Fri, 12 Feb 2010 04:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=loSLtQdHIcOqIe9vm12RozVzPsLRDHzKlV3orTOV+gw=;
        b=pFx7Kf0Jmo61cMJ8BhJFCBJtXRRgr0f1vl45heeUWRQMevdxLpZEsZ5jfBFHhTasdj
         8rdXGtN0Wy58PGxRR4Z3wlCUynMdKJxctRTgQ21n5nHkb4xpFtHSAwAbDdQYH50PeSfj
         0gVGOPfpyB243bHf4iPatefz6riw32ELG0gcM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        b=PrtxiM1NEHocYpWQAso/h0t5UhPVMi9KmI3HCwgOgRWQAr39KHIlnWstvJt4uQGQeR
         IgdJIpVT/8JwW/Ltpmvx4D43LgyuuK+PiXp8TcKXhh7BaZcEgEIc+EcMiBoqVEsf7QM8
         bm8IM7BF2aXRTeP+25xZJ1tSmmIhbC01pbq3g=
Received: by 10.101.7.29 with SMTP id k29mr1954461ani.12.1265978261739;
        Fri, 12 Feb 2010 04:37:41 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 16sm2413492gxk.15.2010.02.12.04.37.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Feb 2010 04:37:41 -0800 (PST)
Date:   Fri, 12 Feb 2010 21:33:56 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH -queue 3/4] MIPS: use generic serial.h
Message-Id: <20100212213356.198e723b.yuasa@linux-mips.org>
In-Reply-To: <20100212212914.f04a046b.yuasa@linux-mips.org>
References: <20100212212759.76f1b52a.yuasa@linux-mips.org>
        <20100212212914.f04a046b.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/include/asm/serial.h |   23 +----------------------
 1 files changed, 1 insertions(+), 22 deletions(-)

diff --git a/arch/mips/include/asm/serial.h b/arch/mips/include/asm/serial.h
index c07ebd8..a0cb0ca 100644
--- a/arch/mips/include/asm/serial.h
+++ b/arch/mips/include/asm/serial.h
@@ -1,22 +1 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1999 by Ralf Baechle
- * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
- */
-#ifndef _ASM_SERIAL_H
-#define _ASM_SERIAL_H
-
-
-/*
- * This assumes you have a 1.8432 MHz clock for your UART.
- *
- * It'd be nice if someone built a serial card with a 24.576 MHz
- * clock, since the 16550A is capable of handling a top speed of 1.5
- * megabits/second; but this requires the faster clock.
- */
-#define BASE_BAUD (1843200 / 16)
-
-#endif /* _ASM_SERIAL_H */
+#include <asm-generic/serial.h>
-- 
1.6.6.2

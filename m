Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Feb 2010 13:38:32 +0100 (CET)
Received: from mail-yw0-f188.google.com ([209.85.211.188]:56668 "EHLO
        mail-yw0-f188.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491087Ab0BLMhr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Feb 2010 13:37:47 +0100
Received: by mail-yw0-f188.google.com with SMTP id 26so2126051ywh.26
        for <multiple recipients>; Fri, 12 Feb 2010 04:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=5IIQkXEjvf8hvlfLIJZzTkDKvYcwK/FaENjrvLoAJhc=;
        b=Yw4JN467CkatHaQgcwhM13C1qUvosHTZ+dDsS3C7VNnht06g433hEcVaRf2YXnZNaR
         cgO0Iwf7JM9XDjfgCex32MTIFhe3xd0LScOZUTX10DbD2tHA3ozd2ywfAjVg/iTMgJ1O
         BWNMMjy1udakCl0/RjvX2rox0NOwfzVHmwSIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        b=fZPF7txkDh5iOO/gOArX1nit6eP/TwnOkDQVlYQYO4UppaDVLXNp5QVrutqepcw5K2
         TBD9iduZMYSYRwaO0Qzj9jjBim9/mDOuLBnr4+4HWew3OT9jbJjp2cTbsnH8K7Tr52Xf
         7NiKw3B0aQ5K8VU3qglcEKFQdeXqQwewrZAKU=
Received: by 10.101.7.23 with SMTP id k23mr1939057ani.36.1265978266957;
        Fri, 12 Feb 2010 04:37:46 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 14sm2418693gxk.14.2010.02.12.04.37.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Feb 2010 04:37:46 -0800 (PST)
Date:   Fri, 12 Feb 2010 21:35:04 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH -queue 4/4] MIPS: use generic ucontext.h
Message-Id: <20100212213504.366b7029.yuasa@linux-mips.org>
In-Reply-To: <20100212213356.198e723b.yuasa@linux-mips.org>
References: <20100212212759.76f1b52a.yuasa@linux-mips.org>
        <20100212212914.f04a046b.yuasa@linux-mips.org>
        <20100212213356.198e723b.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/include/asm/ucontext.h |   22 +---------------------
 1 files changed, 1 insertions(+), 21 deletions(-)

diff --git a/arch/mips/include/asm/ucontext.h b/arch/mips/include/asm/ucontext.h
index 8a4b20e..9bc07b9 100644
--- a/arch/mips/include/asm/ucontext.h
+++ b/arch/mips/include/asm/ucontext.h
@@ -1,21 +1 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Low level exception handling
- *
- * Copyright (C) 1998, 1999 by Ralf Baechle
- */
-#ifndef _ASM_UCONTEXT_H
-#define _ASM_UCONTEXT_H
-
-struct ucontext {
-	unsigned long	  uc_flags;
-	struct ucontext  *uc_link;
-	stack_t		  uc_stack;
-	struct sigcontext uc_mcontext;
-	sigset_t	  uc_sigmask;	/* mask last for extensibility */
-};
-
-#endif /* _ASM_UCONTEXT_H */
+#include <asm-generic/ucontext.h>
-- 
1.6.6.2

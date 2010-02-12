Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Feb 2010 13:37:43 +0100 (CET)
Received: from mail-yw0-f188.google.com ([209.85.211.188]:56668 "EHLO
        mail-yw0-f188.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491028Ab0BLMhj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Feb 2010 13:37:39 +0100
Received: by ywh26 with SMTP id 26so2126051ywh.26
        for <multiple recipients>; Fri, 12 Feb 2010 04:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=vVqQH+LfNmuiz1nIFKXMHoj83gtCVsSzg4xi6J/cBcA=;
        b=Jyp8gljxBPBshA4sY1Ijxs7pzx0v37/7inuh/lLYkNxYiw9imugIg15TzjSWdLi/YL
         tayFeEr4p9n8VbI0fPBJedQsoEkrJ8aHCKmVgwuIHiCERQeuj4vr1ru4fqI6ESC22Zoi
         8CHAbcsPv5zv1D2kTehiV8z+uAs99GIxA+cow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=PEBub0P4ef1QU23fGhGqaMiwy7w+/I2jC5/HPjyPfPMpZBLkLLQWI28laivJUaL/cG
         aUjZm9lsHXX99y6WJGoAIDGEvDU5TDTmbxXSU9BfafghzIXua67ZDxTRp7AnyZVfGoi6
         UQWLskXluL6uR4+PHvaRd9zcAii7V1w877tw8=
Received: by 10.101.10.2 with SMTP id n2mr1795161ani.189.1265978252473;
        Fri, 12 Feb 2010 04:37:32 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 14sm2431915gxk.2.2010.02.12.04.37.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Feb 2010 04:37:31 -0800 (PST)
Date:   Fri, 12 Feb 2010 21:27:59 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH -queue 1/4] MIPS: use generic current.h
Message-Id: <20100212212759.76f1b52a.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/include/asm/current.h |   24 +-----------------------
 1 files changed, 1 insertions(+), 23 deletions(-)

diff --git a/arch/mips/include/asm/current.h b/arch/mips/include/asm/current.h
index 559db66..4c51401 100644
--- a/arch/mips/include/asm/current.h
+++ b/arch/mips/include/asm/current.h
@@ -1,23 +1 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1998, 2002 Ralf Baechle
- * Copyright (C) 1999 Silicon Graphics, Inc.
- */
-#ifndef _ASM_CURRENT_H
-#define _ASM_CURRENT_H
-
-#include <linux/thread_info.h>
-
-struct task_struct;
-
-static inline struct task_struct * get_current(void)
-{
-	return current_thread_info()->task;
-}
-
-#define current		get_current()
-
-#endif /* _ASM_CURRENT_H */
+#include <asm-generic/current.h>
-- 
1.6.6.2

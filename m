Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Feb 2010 13:38:08 +0100 (CET)
Received: from mail-yx0-f194.google.com ([209.85.210.194]:37427 "EHLO
        mail-yx0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491085Ab0BLMhp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Feb 2010 13:37:45 +0100
Received: by yxe32 with SMTP id 32so2842420yxe.0
        for <multiple recipients>; Fri, 12 Feb 2010 04:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=+uwruMkFH3xK1AxqG9rhuCJc/azYBMpuGxV54/1Ycbc=;
        b=vvPSwx7lRCf7zesOGmP5StViiDQWCS7IeMPQHlWFOIj8+e73pvZFoU+pk/Tkjb7+7k
         p/ilvDSHWA/07XpKVFxa5Ut94lhjz+cSnRyR0WMtDDZk891TD463jnn1MrEkuKTYGga0
         XGFpIgppqbUNsG0DbnEXNybp5ZAXi/y/A0Kfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        b=eDLJVz37TXpr5RqpUNmZkdyxn0PyDGZN+iART5SmAUHMPjclxWH2LcNLc82iBZ/ZYX
         AmpzTtYnQPLIMC6WkZBlWj835MybyakMDgkQqwKg7uXMt12A2wncfuIOgCQVPy+rlvbN
         DY4cfGpO90J8payqwa60vjdCafBGkVYachsqw=
Received: by 10.100.25.14 with SMTP id 14mr1835067any.158.1265978257066;
        Fri, 12 Feb 2010 04:37:37 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 15sm2410195gxk.8.2010.02.12.04.37.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Feb 2010 04:37:36 -0800 (PST)
Date:   Fri, 12 Feb 2010 21:29:14 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH -queue 2/4] MIPS: use generic parport.h
Message-Id: <20100212212914.f04a046b.yuasa@linux-mips.org>
In-Reply-To: <20100212212759.76f1b52a.yuasa@linux-mips.org>
References: <20100212212759.76f1b52a.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/include/asm/parport.h |   16 +---------------
 1 files changed, 1 insertions(+), 15 deletions(-)

diff --git a/arch/mips/include/asm/parport.h b/arch/mips/include/asm/parport.h
index f526568..cf252af 100644
--- a/arch/mips/include/asm/parport.h
+++ b/arch/mips/include/asm/parport.h
@@ -1,15 +1 @@
-/*
- * Copyright (C) 1999, 2000  Tim Waugh <tim@cyberelk.demon.co.uk>
- *
- * This file should only be included by drivers/parport/parport_pc.c.
- */
-#ifndef _ASM_PARPORT_H
-#define _ASM_PARPORT_H
-
-static int __devinit parport_pc_find_isa_ports(int autoirq, int autodma);
-static int __devinit parport_pc_find_nonpci_ports(int autoirq, int autodma)
-{
-	return parport_pc_find_isa_ports(autoirq, autodma);
-}
-
-#endif /* _ASM_PARPORT_H */
+#include <asm-generic/parport.h>
-- 
1.6.6.2

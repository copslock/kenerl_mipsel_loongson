Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2005 02:47:47 +0100 (BST)
Received: from 63-207-7-10.ded.pacbell.net ([IPv6:::ffff:63.207.7.10]:30657
	"EHLO cassini.enmediainc.com") by linux-mips.org with ESMTP
	id <S8225948AbVC3Brc>; Wed, 30 Mar 2005 02:47:32 +0100
Received: from [127.0.0.1] (unknown [192.168.10.203])
	by cassini.enmediainc.com (Postfix) with ESMTP id 01B4825C95F
	for <linux-mips@linux-mips.org>; Tue, 29 Mar 2005 17:47:06 -0800 (PST)
Message-ID: <424A04A9.9060703@c2micro.com>
Date:	Tue, 29 Mar 2005 17:45:13 -0800
From:	Ed Martini <martini@c2micro.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: inconsistent asm macro
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <martini@c2micro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: martini@c2micro.com
Precedence: bulk
X-list: linux-mips

In include/asm-mips/interrupt.h, the definition for local_irq_restore is 
inconsistent in its use of .reorder/.noreorder assembler directives.  
Other asm macros in interrupt.h are wrapped with '.set push' and '.set pop'.

It doesn't seem to be a problem with the 2.96 mipsel-linux- assembler, 
but it caused me a problem with my 4.0-based toolchain.  (As it was the 
local_irq_restore left the assembler in 'reorder' mode and a stack 
pointer post-inc was reordered out of the return delay slot where it 
belonged.)  Luckily we have a sharp compiler guy who figured it out.  
Thanks.

As usual, there may be a reason for this, but it took me a whole day to 
find it, and I thought I'd point it out.

Ed Martini

$ diff -uN interrupt.h interrupt-new.h
--- interrupt.h 2005-03-29 17:35:02.922362384 -0800
+++ interrupt-new.h     2005-03-29 17:33:26.350770293 -0800
@@ -100,6 +100,7 @@

 __asm__ (
        ".macro\tlocal_irq_restore flags\n\t"
+       ".set\tpush\n\t"
        ".set\tnoreorder\n\t"
        ".set\tnoat\n\t"
        "mfc0\t$1, $12\n\t"
@@ -109,8 +110,7 @@
        "or\t\\flags, $1\n\t"
        "mtc0\t\\flags, $12\n\t"
        "irq_disable_hazard\n\t"
-       ".set\tat\n\t"
-       ".set\treorder\n\t"
+       ".set\tpop\n\t"
        ".endm");

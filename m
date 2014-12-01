Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Dec 2014 21:42:04 +0100 (CET)
Received: from mail-pd0-f172.google.com ([209.85.192.172]:53482 "EHLO
        mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007716AbaLAUmAAEmaI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Dec 2014 21:42:00 +0100
Received: by mail-pd0-f172.google.com with SMTP id y13so11706340pdi.3
        for <multiple recipients>; Mon, 01 Dec 2014 12:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=A7E75woH+ZUFWug5UW6V5RNoSJDbxFaryl+jr8Y/tOE=;
        b=CGWBeEhuLB58w9hlKeQQ5hhV/60UK+Y6CApKa0dwBrkXdb4fpo/yelgc1aDQg6d41/
         kDv+Tb9VYCuB66usDFV73gfJRp46Nz7hXH0t0bC1D43GpiqoY4m7jmnKFkErJhbWypdc
         pY8GDpurWzr9X14PGpM3azUsg6j5gilwkdaRxgiW1zWemsiImGDVv5BwpNDXOFfla8uQ
         92fKnFumLnQOMK+K4a+z7iRBxIDvwE0nmTNWcq1cFOuUw5U9UezNtChRJ0oDxFO424Fl
         wIgviiROkc5Cx0bjMiM9oennPNUUBruozcXtuDd/wf5sus3x+qJt3nQFQuirzHcLjciz
         cUaQ==
X-Received: by 10.66.231.200 with SMTP id ti8mr16671255pac.41.1417466514354;
        Mon, 01 Dec 2014 12:41:54 -0800 (PST)
Received: from [192.168.1.102] ([223.72.65.11])
        by mx.google.com with ESMTPSA id lg8sm18443187pab.41.2014.12.01.12.41.48
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 01 Dec 2014 12:41:53 -0800 (PST)
Message-ID: <547CD304.20407@gmail.com>
Date:   Tue, 02 Dec 2014 04:43:48 +0800
From:   Chen Gang <gang.chen.5i5j@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        minchan@kernel.org, "rth@twiddle.net" <rth@twiddle.net>,
        "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "jejb@parisc-linux.org" <jejb@parisc-linux.org>,
        "deller@gmx.de" <deller@gmx.de>,
        "chris@zankel.net" <chris@zankel.net>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>
CC:     "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] arch: uapi: asm: mman.h: Support MADV_FREE for madvise()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <gang.chen.5i5j@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gang.chen.5i5j@gmail.com
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

At present, kernel supports madvise(MADV_FREE), so can benefit to all
related architectures (can grep MADV_WILLNEED or MADV_REMOVE in "arch/"
to know about all related architectures).

The related git commit: "4fb10ba mm: support madvise(MADV_FREE)".

The related error (with allmodconfig under parisc):

    CC      mm/madvise.o
  mm/madvise.c: In function 'madvise_need_mmap_write':
  mm/madvise.c:42:7: error: 'MADV_FREE' undeclared (first use in this function)
    case MADV_FREE:
       ^
  mm/madvise.c:42:7: note: each undeclared identifier is reported only once for each function it appears in
  mm/madvise.c: In function 'madvise_vma':
  mm/madvise.c:534:7: error: 'MADV_FREE' undeclared (first use in this function)
    case MADV_FREE:
       ^
  mm/madvise.c: In function 'madvise_behavior_valid':
  mm/madvise.c:561:7: error: 'MADV_FREE' undeclared (first use in this function)
    case MADV_FREE:
       ^
  make[1]: *** [mm/madvise.o] Error 1
  make: *** [mm] Error 2

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 arch/alpha/include/uapi/asm/mman.h  | 1 +
 arch/mips/include/uapi/asm/mman.h   | 1 +
 arch/parisc/include/uapi/asm/mman.h | 1 +
 arch/xtensa/include/uapi/asm/mman.h | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
index 0086b47..836fbd4 100644
--- a/arch/alpha/include/uapi/asm/mman.h
+++ b/arch/alpha/include/uapi/asm/mman.h
@@ -44,6 +44,7 @@
 #define MADV_WILLNEED	3		/* will need these pages */
 #define	MADV_SPACEAVAIL	5		/* ensure resources are available */
 #define MADV_DONTNEED	6		/* don't need these pages */
+#define MADV_FREE	7		/* free pages only if memory pressure */
 
 /* common/generic parameters */
 #define MADV_REMOVE	9		/* remove these pages & resources */
diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
index cfcb876..106e741 100644
--- a/arch/mips/include/uapi/asm/mman.h
+++ b/arch/mips/include/uapi/asm/mman.h
@@ -67,6 +67,7 @@
 #define MADV_SEQUENTIAL 2		/* expect sequential page references */
 #define MADV_WILLNEED	3		/* will need these pages */
 #define MADV_DONTNEED	4		/* don't need these pages */
+#define MADV_FREE	5		/* free pages only if memory pressure */
 
 /* common parameters: try to keep these consistent across architectures */
 #define MADV_REMOVE	9		/* remove these pages & resources */
diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
index 294d251..6cb8db7 100644
--- a/arch/parisc/include/uapi/asm/mman.h
+++ b/arch/parisc/include/uapi/asm/mman.h
@@ -40,6 +40,7 @@
 #define MADV_SPACEAVAIL 5               /* insure that resources are reserved */
 #define MADV_VPS_PURGE  6               /* Purge pages from VM page cache */
 #define MADV_VPS_INHERIT 7              /* Inherit parents page size */
+#define MADV_FREE	8		/* free pages only if memory pressure */
 
 /* common/generic parameters */
 #define MADV_REMOVE	9		/* remove these pages & resources */
diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
index 201aec0..1b19f25 100644
--- a/arch/xtensa/include/uapi/asm/mman.h
+++ b/arch/xtensa/include/uapi/asm/mman.h
@@ -80,6 +80,7 @@
 #define MADV_SEQUENTIAL	2		/* expect sequential page references */
 #define MADV_WILLNEED	3		/* will need these pages */
 #define MADV_DONTNEED	4		/* don't need these pages */
+#define MADV_FREE	5		/* free pages only if memory pressure */
 
 /* common parameters: try to keep these consistent across architectures */
 #define MADV_REMOVE	9		/* remove these pages & resources */
-- 
1.9.3

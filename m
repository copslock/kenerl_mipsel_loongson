Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jan 2016 04:29:19 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:56098 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006506AbcARD3RNrBs3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jan 2016 04:29:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Message-Id:Date:Subject:Cc:To:From;
        bh=5+wE5qUMdOTGV5SCN/5paJkoCtJdHsZCRsYHXwLdxoQ=; b=aTE8IjmAeO4BGSRROaqIkzQxDO
        wQSQPj+p38nBtMAhTSHe0GzWlPvKgovsQpmHgtKri7diUxxVsqZNxXJotWmfCzaItnBQwCje2QAfg
        PjWm54axsADvQ+ZATPNh7TmdQbXkFfYKNd5Tn8TfYIUVoYwNDH9UXsHWUVUwKUVX8xhCQlEo1/Zud
        CFAUTEN6ORriaI9nunAhmPfgyE/L+26euRUkPPohg2w+rZrSdmUJbQNPLZRW/lHgNGBq1f3fIogKb
        fzpI0sZ0XKlYSQI93nzl9qCrkBQa0ziQ08JBoctihP6kYmcilC8ko2YnzEDvSFOzjVRrmoXBG1Kjc
        dtpoI4IQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:36222 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.86)
        (envelope-from <linux@roeck-us.net>)
        id 1aL0VY-0020Ef-CT; Mon, 18 Jan 2016 03:29:33 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, Guenter Roeck <linux@roeck-us.net>,
        Chen Gang <gang.chen.5i5j@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH] mm: Remove duplicate definitions of MADV_FREE
Date:   Sun, 17 Jan 2016 19:29:06 -0800
Message-Id: <1453087746-4658-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.1.4
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51186
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

Commits 21f55b018ba5 ("arch/*/include/uapi/asm/mman.h: : let MADV_FREE
have same value for all architectures") and ef58978f1eaa ("mm: define
MADV_FREE for some arches") both defined MADV_FREE, but did not use the
same values. This results in build errors such as

./arch/alpha/include/uapi/asm/mman.h:53:0: error: "MADV_FREE" redefined
./arch/alpha/include/uapi/asm/mman.h:50:0: note:
	this is the location of the previous definition

for the affected architectures.

Fixes: 21f55b018ba5 ("arch/*/include/uapi/asm/mman.h: : let MADV_FREE have same value for all architectures")
Fixes: ef58978f1eaa ("mm: define MADV_FREE for some arches")
Cc: Chen Gang <gang.chen.5i5j@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/alpha/include/uapi/asm/mman.h  | 1 -
 arch/mips/include/uapi/asm/mman.h   | 1 -
 arch/parisc/include/uapi/asm/mman.h | 1 -
 arch/xtensa/include/uapi/asm/mman.h | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
index ab336c06153e..fec1947b8dbc 100644
--- a/arch/alpha/include/uapi/asm/mman.h
+++ b/arch/alpha/include/uapi/asm/mman.h
@@ -47,7 +47,6 @@
 #define MADV_WILLNEED	3		/* will need these pages */
 #define	MADV_SPACEAVAIL	5		/* ensure resources are available */
 #define MADV_DONTNEED	6		/* don't need these pages */
-#define MADV_FREE	7		/* free pages only if memory pressure */
 
 /* common/generic parameters */
 #define MADV_FREE	8		/* free pages only if memory pressure */
diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
index b0ebe59f73fd..ccdcfcbb24aa 100644
--- a/arch/mips/include/uapi/asm/mman.h
+++ b/arch/mips/include/uapi/asm/mman.h
@@ -73,7 +73,6 @@
 #define MADV_SEQUENTIAL 2		/* expect sequential page references */
 #define MADV_WILLNEED	3		/* will need these pages */
 #define MADV_DONTNEED	4		/* don't need these pages */
-#define MADV_FREE	5		/* free pages only if memory pressure */
 
 /* common parameters: try to keep these consistent across architectures */
 #define MADV_FREE	8		/* free pages only if memory pressure */
diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
index cf830d465f75..f3db7d8eb0c2 100644
--- a/arch/parisc/include/uapi/asm/mman.h
+++ b/arch/parisc/include/uapi/asm/mman.h
@@ -43,7 +43,6 @@
 #define MADV_SPACEAVAIL 5               /* insure that resources are reserved */
 #define MADV_VPS_PURGE  6               /* Purge pages from VM page cache */
 #define MADV_VPS_INHERIT 7              /* Inherit parents page size */
-#define MADV_FREE	8		/* free pages only if memory pressure */
 
 /* common/generic parameters */
 #define MADV_FREE	8		/* free pages only if memory pressure */
diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
index d030594ed22b..9e079d49e7f2 100644
--- a/arch/xtensa/include/uapi/asm/mman.h
+++ b/arch/xtensa/include/uapi/asm/mman.h
@@ -86,7 +86,6 @@
 #define MADV_SEQUENTIAL	2		/* expect sequential page references */
 #define MADV_WILLNEED	3		/* will need these pages */
 #define MADV_DONTNEED	4		/* don't need these pages */
-#define MADV_FREE	5		/* free pages only if memory pressure */
 
 /* common parameters: try to keep these consistent across architectures */
 #define MADV_FREE	8		/* free pages only if memory pressure */
-- 
2.1.4

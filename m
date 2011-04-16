Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Apr 2011 18:52:37 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:41412 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491075Ab1DPQv1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 16 Apr 2011 18:51:27 +0200
Received: (qmail 24271 invoked from network); 16 Apr 2011 16:51:24 -0000
Received: from localhost (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by localhost with (DHE-RSA-AES128-SHA encrypted) SMTP; 16 Apr 2011 16:51:24 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Sat, 16 Apr 2011 09:51:24 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] MIPS: Remove unused PAGE_* definitions
Date:   Sat, 16 Apr 2011 09:44:32 -0700
Message-Id: <ac7d470d5c334dc7870fa13d71942d21@localhost>
In-Reply-To: <7aa38c32b7748a95e814e5bb0583f967@localhost>
References: <7aa38c32b7748a95e814e5bb0583f967@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

PAGE_{NONE,READONLY,COPY,SHARED} are no longer needed after refactoring
setup_protection_map() to explicitly list r/w/x permissions.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/include/asm/pgtable.h |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 0b3e7c6..718991c 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -21,13 +21,6 @@
 struct mm_struct;
 struct vm_area_struct;
 
-#define PAGE_NONE	__pgprot(_PAGE_PRESENT | _CACHE_CACHABLE_NONCOHERENT)
-#define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | \
-				 _page_cachable_default)
-#define PAGE_COPY	__pgprot(_PAGE_PRESENT | _PAGE_NO_EXEC | \
-				 _page_cachable_default)
-#define PAGE_READONLY	__pgprot(_PAGE_PRESENT | \
-				 _page_cachable_default)
 #define PAGE_KERNEL	__pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE | \
 				 _PAGE_GLOBAL | _page_cachable_default)
 #define PAGE_USERIO	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | \
-- 
1.7.4.3

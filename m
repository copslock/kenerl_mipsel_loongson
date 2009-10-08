Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Oct 2009 10:57:59 +0200 (CEST)
Received: from mail-px0-f187.google.com ([209.85.216.187]:59192 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492479AbZJHI5w (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Oct 2009 10:57:52 +0200
Received: by pxi17 with SMTP id 17so7204430pxi.21
        for <multiple recipients>; Thu, 08 Oct 2009 01:57:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=19uObl8u6Ic9ybGnHoNv5fxvphHKJoqXJsGsR50ATzU=;
        b=kAwTXKmKQZu1H3sSiqApeR7++5YYHIec4j/mJQ01ia6Jv1RQXsNPUF0Mf99MgfaA4Z
         ODkVW6QiH8A8mNLwHGjJt1mwXd2SLMLaLNmfQm907ZjNEsEZQYKbtKJceiKXodC1cWwt
         OcMjVKHqmKfCKShkVyNXC+BUStNA/dx9ciUkM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=JTPjIfpjpevbVVnOPiO5GfnAJh9s5ZF9hg1uaZ1xKt6HyyxCGaEqOV8qAfaVzsAVRg
         vi8hSRKSxQa730ZjBi7tPXeSCb6sKGMBx1pS0+LyCHqMGIDzfjSNMEuNgH38lwciks2Z
         ATvuWbUO5xdz1h4AChakAk5+xM5KBgYerANjg=
Received: by 10.115.102.18 with SMTP id e18mr1802178wam.174.1254992261728;
        Thu, 08 Oct 2009 01:57:41 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm764214pxi.3.2009.10.08.01.57.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Oct 2009 01:57:41 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] MIPS: fix pfn_valid() for FLAGMEM
Date:	Thu,  8 Oct 2009 16:57:32 +0800
Message-Id: <1254992252-15923-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

When CONFIG_FLAGMEM enabled, STD/Hiberation will fail on YeeLoong
laptop, This patch fix it:

if pfn is between min_low_pfn and max_mapnr, the old pfn_valid() will
return TRUE, but in reality, if the memory is not continuous, it should
be false. for example:

$ cat /proc/iomem | grep "System RAM"
00000000-0fffffff : System RAM
90000000-bfffffff : System RAM

as we can see, it is not continuous, so, some of the memory is not valid
but regarded as valid by pfn_valid(), and at last make STD/Hibernate
fail when shrinking a too large number of invalid memory.

Here, we fix it via checking pfn is in the "System RAM" or not, if yes,
return TRUE.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/page.h |   11 ++++-------
 arch/mips/mm/page.c          |   17 +++++++++++++++++
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index f266295..16903a6 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -168,13 +168,10 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 
 #ifdef CONFIG_FLATMEM
 
-#define pfn_valid(pfn)							\
-({									\
-	unsigned long __pfn = (pfn);					\
-	/* avoid <linux/bootmem.h> include hell */			\
-	extern unsigned long min_low_pfn;				\
-									\
-	__pfn >= min_low_pfn && __pfn < max_mapnr;			\
+#define pfn_valid(pfn)				\
+({						\
+	extern int is_pfn_valid(unsigned long); \
+	is_pfn_valid(pfn);			\
 })
 
 #elif defined(CONFIG_SPARSEMEM)
diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
index f5c7375..48a4d2a 100644
--- a/arch/mips/mm/page.c
+++ b/arch/mips/mm/page.c
@@ -689,3 +689,20 @@ void copy_page(void *to, void *from)
 }
 
 #endif /* CONFIG_SIBYTE_DMA_PAGEOPS */
+
+#ifdef CONFIG_FLATMEM
+int is_pfn_valid(unsigned long pfn)
+{
+	int i;
+
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		if (boot_mem_map.map[i].type == BOOT_MEM_RAM) {
+			if ((pfn >= PFN_DOWN(boot_mem_map.map[i].addr)) &&
+				((pfn) <= (PFN_UP(boot_mem_map.map[i].addr +
+					boot_mem_map.map[i].size))))
+				return 1;
+		}
+	}
+	return 0;
+}
+#endif
-- 
1.6.2.1

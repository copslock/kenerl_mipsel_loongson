Return-Path: <SRS0=Rn8T=QP=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0018C169C4
	for <linux-mips@archiver.kernel.org>; Fri,  8 Feb 2019 06:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD9F21908
	for <linux-mips@archiver.kernel.org>; Fri,  8 Feb 2019 06:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfBHGC7 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 8 Feb 2019 01:02:59 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34805 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfBHGC7 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 8 Feb 2019 01:02:59 -0500
Received: by mail-qk1-f195.google.com with SMTP id a15so1491179qkc.1
        for <linux-mips@vger.kernel.org>; Thu, 07 Feb 2019 22:02:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+nXOz6pJ3BlFpyk91TAV6qomYY/ubiCtP1T6z27AOU8=;
        b=qlB14O1Wsv5z/lbiTBJSaqfJTvd4/iWPQHDaekv+aGbxQ6hD06Z/4wB5q5/JTspOPk
         x+yEVl+pdga27yn0qW/r4xNbBl2mhXDs9hYQZyE18grB9D9DvIIpsTuHJbzNmQ9+aD0U
         VC8LcD9Z2Lwj3QsEnMmgvLHQRL5GoWmXTBWF4ukK6eVo/wUDK+poGATJz+WdtzwgZ6ji
         Aa0X40WuYNvBbAKurMlORgM+viA7PeJ58hxZ5iOoOF3PgbKWm2wllNcb9SbUfoFV7Hpf
         8IriYi7dKkxYEKsfR7LUmEwJ99o4kX39yfF++URenuT45mcgL48nHwAq2p9CjojP3Srr
         qsoA==
X-Gm-Message-State: AHQUAuaznFAE2FcyEFLwuwEYD7XCmHw+OkzRDZP++7efF0q1FIujpvb+
        7Z1wEU1Ek40P0PC5vyafmx6vKA==
X-Google-Smtp-Source: AHgI3IY8UkuNEaunDWPDIIGAubiipW3iirC76VOqANc+nOZM1N0XFgV17IacLCmhs/QrcslrJHU2NQ==
X-Received: by 2002:ae9:f110:: with SMTP id k16mr10172495qkg.93.1549605777884;
        Thu, 07 Feb 2019 22:02:57 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id y6sm1075699qki.10.2019.02.07.22.02.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 22:02:57 -0800 (PST)
Date:   Fri, 8 Feb 2019 01:02:55 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 2/2] arch: move common mmap flags to linux/mman.h
Message-ID: <20190124142448.23243-3-mst@redhat.com>
References: <20190124142448.23243-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124142448.23243-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Now that we have 3 mmap flags shared by all architectures,
let's move them into the common header.

This will help discourage future architectures from duplicating code.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/alpha/include/uapi/asm/mman.h     | 4 +---
 arch/mips/include/uapi/asm/mman.h      | 4 +---
 arch/parisc/include/uapi/asm/mman.h    | 4 +---
 arch/xtensa/include/uapi/asm/mman.h    | 4 +---
 include/uapi/asm-generic/mman-common.h | 4 +---
 include/uapi/linux/mman.h              | 4 ++++
 6 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
index f9d4e6b6d4bd..ac23379b7a87 100644
--- a/arch/alpha/include/uapi/asm/mman.h
+++ b/arch/alpha/include/uapi/asm/mman.h
@@ -10,9 +10,7 @@
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
 
-#define MAP_SHARED	0x01		/* Share changes */
-#define MAP_PRIVATE	0x02		/* Changes are private */
-#define MAP_SHARED_VALIDATE 0x03	/* share + validate extension flags */
+/* 0x01 - 0x03 are defined in linux/mman.h */
 #define MAP_TYPE	0x0f		/* Mask for type of mapping (OSF/1 is _wrong_) */
 #define MAP_FIXED	0x100		/* Interpret addr exactly */
 #define MAP_ANONYMOUS	0x10		/* don't use a file */
diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
index 3035ca499cd8..c2b40969eb1f 100644
--- a/arch/mips/include/uapi/asm/mman.h
+++ b/arch/mips/include/uapi/asm/mman.h
@@ -27,9 +27,7 @@
 /*
  * Flags for mmap
  */
-#define MAP_SHARED	0x001		/* Share changes */
-#define MAP_PRIVATE	0x002		/* Changes are private */
-#define MAP_SHARED_VALIDATE 0x003	/* share + validate extension flags */
+/* 0x01 - 0x03 are defined in linux/mman.h */
 #define MAP_TYPE	0x00f		/* Mask for type of mapping */
 #define MAP_FIXED	0x010		/* Interpret addr exactly */
 
diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
index 870fbf8c7088..c98162f494db 100644
--- a/arch/parisc/include/uapi/asm/mman.h
+++ b/arch/parisc/include/uapi/asm/mman.h
@@ -10,9 +10,7 @@
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
 
-#define MAP_SHARED	0x01		/* Share changes */
-#define MAP_PRIVATE	0x02		/* Changes are private */
-#define MAP_SHARED_VALIDATE 0x03	/* share + validate extension flags */
+/* 0x01 - 0x03 are defined in linux/mman.h */
 #define MAP_TYPE	0x2b		/* Mask for type of mapping, includes bits 0x08 and 0x20 */
 #define MAP_FIXED	0x04		/* Interpret addr exactly */
 #define MAP_ANONYMOUS	0x10		/* don't use a file */
diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
index 58f29a9d895d..be726062412b 100644
--- a/arch/xtensa/include/uapi/asm/mman.h
+++ b/arch/xtensa/include/uapi/asm/mman.h
@@ -34,9 +34,7 @@
 /*
  * Flags for mmap
  */
-#define MAP_SHARED	0x001		/* Share changes */
-#define MAP_PRIVATE	0x002		/* Changes are private */
-#define MAP_SHARED_VALIDATE 0x003	/* share + validate extension flags */
+/* 0x01 - 0x03 are defined in linux/mman.h */
 #define MAP_TYPE	0x00f		/* Mask for type of mapping */
 #define MAP_FIXED	0x010		/* Interpret addr exactly */
 
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index e7ee32861d51..abd238d0f7a4 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -15,9 +15,7 @@
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
 
-#define MAP_SHARED	0x01		/* Share changes */
-#define MAP_PRIVATE	0x02		/* Changes are private */
-#define MAP_SHARED_VALIDATE 0x03	/* share + validate extension flags */
+/* 0x01 - 0x03 are defined in linux/mman.h */
 #define MAP_TYPE	0x0f		/* Mask for type of mapping */
 #define MAP_FIXED	0x10		/* Interpret addr exactly */
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
index d0f515d53299..fc1a64c3447b 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -12,6 +12,10 @@
 #define OVERCOMMIT_ALWAYS		1
 #define OVERCOMMIT_NEVER		2
 
+#define MAP_SHARED	0x01		/* Share changes */
+#define MAP_PRIVATE	0x02		/* Changes are private */
+#define MAP_SHARED_VALIDATE 0x03	/* share + validate extension flags */
+
 /*
  * Huge page size encoding when MAP_HUGETLB is specified, and a huge page
  * size other than the default is desired.  See hugetlb_encode.h.
-- 
MST


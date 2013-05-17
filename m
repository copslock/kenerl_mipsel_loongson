Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 May 2013 21:01:36 +0200 (CEST)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:39370 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835012Ab3EQTAyaxiBd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 May 2013 21:00:54 +0200
Received: by mail-pa0-f45.google.com with SMTP id lj1so3848646pab.18
        for <multiple recipients>; Fri, 17 May 2013 12:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=1/lyrST9PdwQIgdxz5JMGlIl3stnzAVwMEuoz7QvloI=;
        b=q3a7rcR3anlLq/kNBURvHXgqKwKHM8CaXQX059pUYjW1kLVShQUTkPYSK+ivyVNCD9
         1L9dlfG3OoNnAltNDrVpT9SJm1V0vduCsopThjH1bpWgsLsn5+Jrz67fjHxGpmCZ3NQ4
         ZPwgVHiJWf9yH9BVyuYsuo24iTc8XQn3KfZ1n0kH1aj3zvQSLBKUdDm0Qv58XW2dCJ85
         IK5nZ5bcOW5Cp87QZX8+lUubSFIx7IO65iEBGpJdblaQ459xQe3c/MI2FduWLdpbzKFE
         nyaksYTQlLPDUo4L/WorbAoL01ZxhkNXdXLPluMMZEZ6e8r27wMPIS0O8gwjXjMNfMIi
         zxhQ==
X-Received: by 10.68.180.132 with SMTP id do4mr49877238pbc.96.1368817247975;
        Fri, 17 May 2013 12:00:47 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id q18sm13322110pao.4.2013.05.17.12.00.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 12:00:46 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4HJ0iTt011592;
        Fri, 17 May 2013 12:00:44 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4HJ0hZB011591;
        Fri, 17 May 2013 12:00:43 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 2/2] perf tools: Hook up MIPS unwind and dwarf-regs in the Makefile
Date:   Fri, 17 May 2013 12:00:38 -0700
Message-Id: <1368817238-11548-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1368817238-11548-1-git-send-email-ddaney.cavm@gmail.com>
References: <1368817238-11548-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Define a new symbol (ARCH_SUPPORTS_LIBUNWIND) in config/Makefile.
Use this from x86 and MIPS to gate testing of libunwind.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 tools/perf/config/Makefile | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/config/Makefile b/tools/perf/config/Makefile
index f139dcd..90a0e58 100644
--- a/tools/perf/config/Makefile
+++ b/tools/perf/config/Makefile
@@ -11,6 +11,7 @@ CFLAGS := $(EXTRA_CFLAGS) $(EXTRA_WARNINGS)
 # Additional ARCH settings for x86
 ifeq ($(ARCH),i386)
   override ARCH := x86
+  ARCH_SUPPORTS_LIBUNWIND := 1
   NO_PERF_REGS := 0
   LIBUNWIND_LIBS = -lunwind -lunwind-x86
 endif
@@ -26,10 +27,18 @@ ifeq ($(ARCH),x86_64)
     CFLAGS += -DARCH_X86_64
     ARCH_INCLUDE = ../../arch/x86/lib/memcpy_64.S ../../arch/x86/lib/memset_64.S
   endif
+  ARCH_SUPPORTS_LIBUNWIND := 1
   NO_PERF_REGS := 0
   LIBUNWIND_LIBS = -lunwind -lunwind-x86_64
 endif
 
+# Additional ARCH settings for MIPS
+ifeq ($(ARCH),mips)
+  ARCH_SUPPORTS_LIBUNWIND := 1
+  NO_PERF_REGS := 0
+  LIBUNWIND_LIBS = -lunwind -lunwind-mips
+endif
+
 ifeq ($(NO_PERF_REGS),0)
   CFLAGS += -DHAVE_PERF_REGS
 endif
@@ -204,8 +213,7 @@ ifeq ($(call try-cc,$(SOURCE_ELF_MMAP),$(FLAGS_LIBELF),-DLIBELF_MMAP),y)
 endif # try-cc
 endif # NO_LIBELF
 
-# There's only x86 (both 32 and 64) support for CFI unwind so far
-ifneq ($(ARCH),x86)
+ifndef ARCH_SUPPORTS_LIBUNWIND
   NO_LIBUNWIND := 1
 endif
 
-- 
1.7.11.7

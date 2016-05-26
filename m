Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 May 2016 13:56:04 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2127 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27034483AbcEZL4BvcMOG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 May 2016 13:56:01 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id E9FCB848B2FCA;
        Thu, 26 May 2016 12:55:51 +0100 (IST)
Received: from [10.20.78.62] (10.20.78.62) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Thu, 26 May 2016
 12:55:54 +0100
Date:   Thu, 26 May 2016 12:55:45 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Tejun Heo <tj@kernel.org>, <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: VDSO: Build with `-fno-strict-aliasing'
Message-ID: <alpine.DEB.2.00.1605261239340.9344@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.62]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

Avoid an aliasing issue causing a build error in VDSO:

In file included from include/linux/srcu.h:34:0,
                 from include/linux/notifier.h:15,
                 from ./arch/mips/include/asm/uprobes.h:9,
                 from include/linux/uprobes.h:61,
                 from include/linux/mm_types.h:13,
                 from ./arch/mips/include/asm/vdso.h:14,
                 from arch/mips/vdso/vdso.h:27,
                 from arch/mips/vdso/gettimeofday.c:11:
include/linux/workqueue.h: In function 'work_static':
include/linux/workqueue.h:186:2: error: dereferencing type-punned pointer will break strict-aliasing rules [-Werror=strict-aliasing]
  return *work_data_bits(work) & WORK_STRUCT_STATIC;
  ^
cc1: all warnings being treated as errors
make[2]: *** [arch/mips/vdso/gettimeofday.o] Error 1

with a CONFIG_DEBUG_OBJECTS_WORK configuration and GCC 5.2.0.  Include 
`-fno-strict-aliasing' along with compiler options used, as required for 
kernel code, fixing a problem present since the introduction of VDSO 
with commit ebb5e78cc634 ("MIPS: Initial implementation of a VDSO").

Thanks to Tejun for diagnosing this properly!

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: stable@vger.kernel.org # v4.3+
---
linux-vdso-strict-aliasing.diff
Index: linux-sfr-test/arch/mips/vdso/Makefile
===================================================================
--- linux-sfr-test.orig/arch/mips/vdso/Makefile	2016-01-29 14:11:03.000000000 +0000
+++ linux-sfr-test/arch/mips/vdso/Makefile	2016-05-26 12:37:55.327782000 +0100
@@ -8,7 +8,8 @@ ccflags-vdso := \
 	$(filter -march=%,$(KBUILD_CFLAGS))
 cflags-vdso := $(ccflags-vdso) \
 	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
-	-O2 -g -fPIC -fno-common -fno-builtin -G 0 -DDISABLE_BRANCH_PROFILING \
+	-O2 -g -fPIC -fno-strict-aliasing -fno-common -fno-builtin -G 0 \
+	-DDISABLE_BRANCH_PROFILING \
 	$(call cc-option, -fno-stack-protector)
 aflags-vdso := $(ccflags-vdso) \
 	$(filter -I%,$(KBUILD_CFLAGS)) \

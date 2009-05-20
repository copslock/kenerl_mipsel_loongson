Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 22:54:36 +0100 (BST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:55973 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025177AbZETVya (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 22:54:30 +0100
Received: by pzk40 with SMTP id 40so625613pzk.22
        for <multiple recipients>; Wed, 20 May 2009 14:54:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BEISxEl1y49tMiSfKp49K81IsrDqp3V6fZEOPby01ko=;
        b=xgFj4KD1JOs9+hswsm+1n+yv8CVKBYV2GgMKwi/3ASHu9zT4+uFwvtT687jFi0BOEh
         jCkpi6sdEGjt8nlaLk4g0dYFUk/dsfcsKiGpyqS55k1iZhlyE4QfZt+MuXFaCFSZRSu6
         j+dI0tdP4Tr+Sntv0OaBUxABD4/Xqu3uPp31A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PUF6OL4AlGHrkiRetY6PY8cX+2kL4x1XZiJY9ubrYsGM8cGr//pGokzV6naClmrYd9
         A1tZbnD5g+7HgsVqa1WO5i3gNDMZXurKxBsRkU9HE8fkd/E7X14m1RC4lQCE0Y7Q2Yfl
         HsVh2ljz29SYhfdEF9l3pqfhfYPmpOnF1JdCM=
Received: by 10.114.147.1 with SMTP id u1mr3558949wad.115.1242856463596;
        Wed, 20 May 2009 14:54:23 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id b39sm759665rvf.1.2009.05.20.14.54.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 14:54:23 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, Yan hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: [loongson-PATCH-v1 10/27] add loongson-specific cpu-feature-overrides.h
Date:	Thu, 21 May 2009 05:54:12 +0800
Message-Id: <13b257a1608147ad3089a054e888ab240e19a75d.1242855716.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1242855716.git.wuzhangjin@gmail.com>
References: <cover.1242855716.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This file will obviously reduce the size of kernel image file, reduce
tons of branches and enhance the performance.

$ wc -c vmlinux		// before
8054849 vmlinux
$ wc -c vmlinux		// after
7626936 vmlinux
$ echo $(((8054849-7626936)/1024))	// kb
417
$ echo "(8054849-7626936)/8054849" | bc -l
.05312489408553779220

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 .../asm/mach-loongson/cpu-feature-overrides.h      |   58 ++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h

diff --git a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
new file mode 100644
index 0000000..daa2ee9
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
@@ -0,0 +1,58 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2009 Wu Zhangjin <wuzj@lemote.com>
+ * Copyright (C) 2009 Philippe Vachon <philippe@cowpig.ca>
+ * Copyright (C) 2009 Zhang Le <r0bertz@gentoo.org>
+ *
+ * reference: /proc/cpuinfo,
+ * 	arch/mips/kernel/cpu-probe.c(cpu_probe_legacy),
+ * 	arch/mips/kernel/proc.c(show_cpuinfo),
+ *      loongson2f user manual.
+ */
+
+#ifndef __ASM_LOONGSON_CPU_FEATURE_OVERRIDES_H
+#define __ASM_LOONGSON_CPU_FEATURE_OVERRIDES_H
+
+#define cpu_dcache_line_size()	32
+#define cpu_icache_line_size()	32
+#define cpu_scache_line_size()	32
+
+#define cpu_has_32fpr		1
+#define cpu_has_3k_cache	0
+#define cpu_has_4k_cache	1
+#define cpu_has_4kex		1
+#define cpu_has_64bits		1
+#define cpu_has_cache_cdex_p	0
+#define cpu_has_cache_cdex_s	0
+#define cpu_has_counter		1
+#define cpu_has_dc_aliases	1
+#define cpu_has_divec		0
+#define cpu_has_dsp		0
+#define cpu_has_ejtag		0
+#define cpu_has_fpu		1
+#define cpu_has_ic_fills_f_dc	0
+#define cpu_has_inclusive_pcaches	1
+#define cpu_has_llsc 		1
+#define cpu_has_mcheck		0
+#define cpu_has_mdmx		0
+#define cpu_has_mips16		0
+#define cpu_has_mips32r1	0
+#define cpu_has_mips32r2	0
+#define cpu_has_mips3d		0
+#define cpu_has_mips64r1	0
+#define cpu_has_mips64r2	0
+#define cpu_has_mipsmt		0
+#define cpu_has_prefetch	0
+#define cpu_has_smartmips	0
+#define cpu_has_tlb		1
+#define cpu_has_tx39_cache	0
+#define cpu_has_userlocal	0
+#define cpu_has_vce		0
+#define cpu_has_vtag_icache	0
+#define cpu_has_watch		1
+#define cpu_icache_snoops_remote_store	1
+
+#endif				/* __ASM_LOONGSON_CPU_FEATURE_OVERRIDES_H */
-- 
1.6.2.1

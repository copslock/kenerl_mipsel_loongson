Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Apr 2014 12:14:14 +0200 (CEST)
Received: from mail-we0-f173.google.com ([74.125.82.173]:36419 "EHLO
        mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822276AbaDBKNd14Ow7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Apr 2014 12:13:33 +0200
Received: by mail-we0-f173.google.com with SMTP id w61so7465080wes.4
        for <multiple recipients>; Wed, 02 Apr 2014 03:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=kAtryO1T9zX1GfLEfNnVXv5FmSyXakd+7BHb/55O63o=;
        b=M5jF7g1vZ+b9vOunrtnmDQIcJZqdadt8CtaoL90npx/QQ7QnSwInxqMIV1rhPt7cz7
         RWMDhLCiZu0Gmj68Fhbr5UWwIX5OiMDBvXUPpxGzxneZ48i4E3SYkaud59i+cgXHm5fV
         plGal4t08hK+py88LQa/2WumngEhvIaIQbFJJZwosFZaiaE6yAypcGrbpwoWHK01etWn
         ArcNkp86o5sppVZ/m4pLLeEDtRGAf0ZsO7uBDRCVsIodkXWS1PaW5NhBYzLX6vQkS3Jm
         BI72iidvhc4jafM5YYFUPeGnRWNQmTG8BeZpMR02K29WShs9/PT9QVxb4o4onc0BCXWQ
         0suA==
X-Received: by 10.194.24.74 with SMTP id s10mr28608370wjf.43.1396433608030;
        Wed, 02 Apr 2014 03:13:28 -0700 (PDT)
Received: from localhost.localdomain (p57A34F13.dip0.t-ipconnect.de. [87.163.79.19])
        by mx.google.com with ESMTPSA id w1sm3463877eel.16.2014.04.02.03.13.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Apr 2014 03:13:27 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     linux-audit@redhat.com, Steve Grubb <sgrubb@redhat.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Eric Paris <eparis@redhat.com>
Subject: [RESEND PATCH 2/2] MIPS syscall auditing patches
Date:   Wed,  2 Apr 2014 12:13:16 +0200
Message-Id: <1396433596-612624-3-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396433596-612624-1-git-send-email-manuel.lauss@gmail.com>
References: <1396433596-612624-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

From: Ralf Baechle <ralf@linux-mips.org>

These are the userland patches to go along with the recently posted
kernel patches.  Many of the comments posted along with those also apply
here, in particular wrt. to the ABI situation.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
-- 
mlau: Rediffed the patch against current audit-trunk. Build-tested
      on little-endian MIPS32.

diff -Naurp trunk/lib/Makefile.am trunk-work/lib/Makefile.am
--- trunk/lib/Makefile.am	2014-03-28 14:38:29.831405944 +0100
+++ trunk-work/lib/Makefile.am	2014-03-28 15:52:02.891982735 +0100
@@ -39,8 +39,9 @@ nodist_libaudit_la_SOURCES = $(BUILT_SOU
 
 BUILT_SOURCES = actiontabs.h errtabs.h fieldtabs.h flagtabs.h \
 	ftypetabs.h i386_tables.h ia64_tables.h machinetabs.h \
-	msg_typetabs.h optabs.h ppc_tables.h s390_tables.h \
-	s390x_tables.h x86_64_tables.h
+	msg_typetabs.h optabs.h mips_o32_tables.h mips_n32_tables.h \
+	mips_n64_tables.h ppc_tables.h s390_tables.h s390x_tables.h \
+	x86_64_tables.h
 if USE_ALPHA
 BUILT_SOURCES += alpha_tables.h
 endif
@@ -53,7 +54,8 @@ endif
 noinst_PROGRAMS = gen_actiontabs_h gen_errtabs_h gen_fieldtabs_h \
 	gen_flagtabs_h gen_ftypetabs_h gen_i386_tables_h \
 	gen_ia64_tables_h gen_machinetabs_h gen_msg_typetabs_h \
-	gen_optabs_h gen_ppc_tables_h gen_s390_tables_h \
+	gen_optabs_h gen_mips_o32_tables_h gen_mips_n32_tables_h \
+	gen_mips_n64_tables_h gen_ppc_tables_h gen_s390_tables_h \
 	gen_s390x_tables_h gen_x86_64_tables_h
 if USE_ALPHA
 noinst_PROGRAMS += gen_alpha_tables_h
@@ -137,6 +139,21 @@ gen_optabs_h_CFLAGS = $(AM_CFLAGS) '-DTA
 optabs.h: gen_optabs_h Makefile
 	./gen_optabs_h --i2s op > $@
 
+gen_mips_o32_tables_h_SOURCES = gen_tables.c gen_tables.h mips_o32_table.h
+gen_mips_o32_tables_h_CFLAGS = $(AM_CFLAGS) '-DTABLE_H="mips_o32_table.h"'
+mips_o32_tables.h: gen_mips_o32_tables_h Makefile
+	./gen_mips_o32_tables_h --lowercase --i2s --s2i mips_o32_syscall > $@
+
+gen_mips_n32_tables_h_SOURCES = gen_tables.c gen_tables.h mips_n32_table.h
+gen_mips_n32_tables_h_CFLAGS = $(AM_CFLAGS) '-DTABLE_H="mips_n32_table.h"'
+mips_n32_tables.h: gen_mips_n32_tables_h Makefile
+	./gen_mips_n32_tables_h --lowercase --i2s --s2i mips_n32_syscall > $@
+
+gen_mips_n64_tables_h_SOURCES = gen_tables.c gen_tables.h mips_n64_table.h
+gen_mips_n64_tables_h_CFLAGS = $(AM_CFLAGS) '-DTABLE_H="mips_n64_table.h"'
+mips_n64_tables.h: gen_mips_n64_tables_h Makefile
+	./gen_mips_n64_tables_h --lowercase --i2s --s2i mips_n64_syscall > $@
+
 gen_ppc_tables_h_SOURCES = gen_tables.c gen_tables.h ppc_table.h
 gen_ppc_tables_h_CFLAGS = $(AM_CFLAGS) '-DTABLE_H="ppc_table.h"'
 ppc_tables.h: gen_ppc_tables_h Makefile
diff -Naurp trunk/lib/libaudit.c trunk-work/lib/libaudit.c
--- trunk/lib/libaudit.c	2014-03-28 14:38:29.699404905 +0100
+++ trunk-work/lib/libaudit.c	2014-03-28 16:22:15.141833267 +0100
@@ -1078,7 +1078,10 @@ int audit_determine_machine(const char *
 	} else if (strcasecmp("b32", arch) == 0) {
 		bits = ~__AUDIT_ARCH_64BIT;
 		machine = audit_detect_machine();
-	} 
+	} else if (strcasecmp("n32", arch) == 0) {
+		bits = __AUDIT_ARCH_64BIT;
+		machine = MACH_MIPS64_N32;
+	}
 	else 
 		machine = audit_name_to_machine(arch);
 
@@ -1095,6 +1098,8 @@ int audit_determine_machine(const char *
 		machine = MACH_S390;
 	else if (bits == ~__AUDIT_ARCH_64BIT && machine == MACH_AARCH64)
 		machine = MACH_ARM;
+	else if (bits == ~__AUDIT_ARCH_64BIT && machine == MACH_MIPS64)
+		machine = MACH_MIPS;
 
 	/* Check for errors - return -6 
 	 * We don't allow 32 bit machines to specify 64 bit. */
@@ -1128,9 +1133,15 @@ int audit_determine_machine(const char *
 				return -6;
 			break;
 #endif
-		case MACH_86_64: /* fallthrough */
-		case MACH_PPC64: /* fallthrough */
-		case MACH_S390X: /* fallthrough */
+		case MACH_MIPS:
+			if (bits == __AUDIT_ARCH_64BIT)
+				return -6;
+			break;
+		case MACH_86_64:	/* fallthrough */
+		case MACH_PPC64:	/* fallthrough */
+		case MACH_S390X:	/* fallthrough */
+		case MACH_MIPS64_N32:	/* fallthrough */
+		case MACH_MIPS64:	/* fallthrough */
 			break;
 		default:
 			return -6;
@@ -1479,10 +1490,18 @@ static int audit_name_to_gid(const char
 int audit_detect_machine(void)
 {
 	struct utsname uts;
-	if (uname(&uts) == 0)
-//		strcpy(uts.machine, "x86_64");
-		return audit_name_to_machine(uts.machine);
-	return -1;
+	int little_endian;
+
+	if (uname(&uts) == -1)
+		return -1;
+
+//	strcpy(uts.machine, "x86_64");
+	if (!strcmp(uts.machine, "mips64") && little_endian)
+		strcpy(uts.machine, "mips64el");
+	else if (!strcmp(uts.machine, "mips") && little_endian)
+		strcpy(uts.machine, "mipsel");
+
+	return audit_name_to_machine(uts.machine);
 }
 hidden_def(audit_detect_machine)
 
diff -Naurp trunk/lib/libaudit.h trunk-work/lib/libaudit.h
--- trunk/lib/libaudit.h	2014-03-28 14:38:29.827405913 +0100
+++ trunk-work/lib/libaudit.h	2014-03-31 21:45:42.648415862 +0200
@@ -36,6 +36,58 @@ extern "C" {
 #include <stdarg.h>
 #include <syslog.h>
 
+/*
+ * The following defines should be defined in the kernel headers.  Until
+ * the new defines get picked up by the toolchain, these defines will supply
+ * the values.
+ */
+#ifndef AUDIT_ARCH_MIPS64EL
+#define AUDIT_ARCH_MIPS64EL	(EM_MIPS|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
+#endif
+#ifndef __AUDIT_ARCH_ALT
+#define __AUDIT_ARCH_ALT	0x20000000	/* indicates alternative ABI  */
+#endif
+#ifndef AUDIT_ARCH_MIPS64_N32
+#define AUDIT_ARCH_MIPS64_N32	(EM_MIPS|__AUDIT_ARCH_ALT)
+#endif
+#ifndef AUDIT_ARCH_MIPS64EL_N32
+#define AUDIT_ARCH_MIPS64EL_N32	(EM_MIPS|__AUDIT_ARCH_ALT|__AUDIT_ARCH_LE)
+#endif
+
+#ifdef __mips__
+#undef AUDIT_BITMASK_SIZE
+#define AUDIT_BITMASK_SIZE 256
+
+struct audit_rule_data_mips {
+	__u32		flags;  /* AUDIT_PER_{TASK,CALL}, AUDIT_PREPEND */
+	__u32		action; /* AUDIT_NEVER, AUDIT_POSSIBLE, AUDIT_ALWAYS */
+	__u32		field_count;
+	__u32		mask[AUDIT_BITMASK_SIZE]; /* syscall(s) affected */
+	__u32		fields[AUDIT_MAX_FIELDS];
+	__u32		values[AUDIT_MAX_FIELDS];
+	__u32		fieldflags[AUDIT_MAX_FIELDS];
+	__u32		buflen; /* total length of string fields */
+	char		buf[0]; /* string fields buffer */
+};
+
+#define audit_rule_data audit_rule_data_mips
+
+/* audit_rule is supported to maintain backward compatibility with
+ * userspace.  It supports integer fields only and corresponds to
+ * AUDIT_ADD, AUDIT_DEL and AUDIT_LIST requests.
+ */
+struct audit_rule_mips {	/* for AUDIT_LIST, AUDIT_ADD, and AUDIT_DEL */
+	__u32		flags;  /* AUDIT_PER_{TASK,CALL}, AUDIT_PREPEND */
+	__u32		action; /* AUDIT_NEVER, AUDIT_POSSIBLE, AUDIT_ALWAYS */
+	__u32		field_count;
+	__u32		mask[AUDIT_BITMASK_SIZE];
+	__u32		fields[AUDIT_MAX_FIELDS];
+	__u32		values[AUDIT_MAX_FIELDS];
+};
+
+#define audit_rule audit_rule_mips
+
+#endif /* defined(__mips__) */
 
 /* Audit message types as of 2.6.29 kernel:
  * 1000 - 1099 are for commanding the audit system
@@ -419,6 +471,12 @@ typedef enum {
 	MACH_ALPHA,
 	MACH_ARM,
 	MACH_AARCH64
+	MACH_MIPS,
+	MACH_MIPSEL,
+	MACH_MIPS64,
+	MACH_MIPS64EL,
+	MACH_MIPS64_N32,
+	MACH_MIPS64EL_N32,
 } machine_t;
 
 /* These are the valid audit failure tunable enum values */
diff -Naurp trunk/lib/lookup_table.c trunk-work/lib/lookup_table.c
--- trunk/lib/lookup_table.c	2014-03-28 14:38:29.696404881 +0100
+++ trunk-work/lib/lookup_table.c	2014-03-31 21:49:48.532972389 +0200
@@ -46,6 +46,9 @@
 #endif
 #include "i386_tables.h"
 #include "ia64_tables.h"
+#include "mips_o32_tables.h"
+#include "mips_n32_tables.h"
+#include "mips_n64_tables.h"
 #include "ppc_tables.h"
 #include "s390_tables.h"
 #include "s390x_tables.h"
@@ -82,6 +85,12 @@ static const struct int_transtab elftab[
 #ifdef WITH_AARCH64
     { MACH_AARCH64, AUDIT_ARCH_AARCH64},
 #endif
+    { MACH_MIPS,	 AUDIT_ARCH_MIPS	 },
+    { MACH_MIPSEL,	 AUDIT_ARCH_MIPSEL	 },
+    { MACH_MIPS64,	 AUDIT_ARCH_MIPS64	 },
+    { MACH_MIPS64EL,	 AUDIT_ARCH_MIPS64EL	 },
+    { MACH_MIPS64_N32,	 AUDIT_ARCH_MIPS64_N32	 },
+    { MACH_MIPS64EL_N32, AUDIT_ARCH_MIPS64EL_N32 },
 };
 #define AUDIT_ELF_NAMES (sizeof(elftab)/sizeof(elftab[0]))
 
@@ -122,6 +131,15 @@ int audit_name_to_syscall(const char *sc
 		case MACH_IA64:
 			found = ia64_syscall_s2i(sc, &res);
 			break;
+		case MACH_MIPS:
+			found = mips_o32_syscall_s2i(sc, &res);
+			break;
+		case MACH_MIPS64:
+			found = mips_n64_syscall_s2i(sc, &res);
+			break;
+		case MACH_MIPS64_N32:
+			found = mips_n32_syscall_s2i(sc, &res);
+			break;
 		case MACH_PPC64:
 		case MACH_PPC:
 			found = ppc_syscall_s2i(sc, &res);
@@ -187,8 +205,15 @@ const char *audit_syscall_to_name(int sc
 	        case MACH_AARCH64:
 			return aarch64_syscall_i2s(sc);
 #endif
+		case MACH_MIPS:
+			return mips_o32_syscall_i2s(sc);
+		case MACH_MIPS64:
+			return mips_n64_syscall_i2s(sc);
+		case MACH_MIPS64_N32:
+			return mips_n32_syscall_i2s(sc);
 	}
 #endif
+
 	return NULL;
 }
 
diff -Naurp trunk/lib/machinetab.h trunk-work/lib/machinetab.h
--- trunk/lib/machinetab.h	2014-03-28 14:38:29.689404826 +0100
+++ trunk-work/lib/machinetab.h	2014-03-31 21:47:52.044287472 +0200
@@ -44,3 +44,5 @@ _S(MACH_ARM,   "armv7l")
 #ifdef WITH_AARCH64
 _S(MACH_AARCH64,   "aarch64"  )
 #endif
+_S(MACH_MIPS64,  "mips64" )
+_S(MACH_MIPS,    "mips"   )
diff -Naurp trunk/lib/mips_n32_table.h trunk-work/lib/mips_n32_table.h
--- trunk/lib/mips_n32_table.h	1970-01-01 01:00:00.000000000 +0100
+++ trunk-work/lib/mips_n32_table.h	2014-03-28 16:16:51.063651431 +0100
@@ -0,0 +1,333 @@
+/*
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * Copyright 2010 Wind River Systems,
+ *   written by Ralf Baechle <ralf linux-mips org>
+ */
+
+_S(6000, "read")
+_S(6001, "write")
+_S(6002, "open")
+_S(6003, "close")
+_S(6004, "stat")
+_S(6005, "fstat")
+_S(6006, "lstat")
+_S(6007, "poll")
+_S(6008, "lseek")
+_S(6009, "mmap")
+_S(6010, "mprotect")
+_S(6011, "munmap")
+_S(6012, "brk")
+_S(6013, "rt_sigaction")
+_S(6014, "rt_sigprocmask")
+_S(6015, "ioctl")
+_S(6016, "pread64")
+_S(6017, "pwrite64")
+_S(6018, "readv")
+_S(6019, "writev")
+_S(6020, "access")
+_S(6021, "pipe")
+_S(6022, "_newselect")
+_S(6023, "sched_yield")
+_S(6024, "mremap")
+_S(6025, "msync")
+_S(6026, "mincore")
+_S(6027, "madvise")
+_S(6028, "shmget")
+_S(6029, "shmat")
+_S(6030, "shmctl")
+_S(6031, "dup")
+_S(6032, "dup2")
+_S(6033, "pause")
+_S(6034, "nanosleep")
+_S(6035, "getitimer")
+_S(6036, "setitimer")
+_S(6037, "alarm")
+_S(6038, "getpid")
+_S(6039, "sendfile")
+_S(6040, "socket")
+_S(6041, "connect")
+_S(6042, "accept")
+_S(6043, "sendto")
+_S(6044, "recvfrom")
+_S(6045, "sendmsg")
+_S(6046, "recvmsg")
+_S(6047, "shutdown")
+_S(6048, "bind")
+_S(6049, "listen")
+_S(6050, "getsockname")
+_S(6051, "getpeername")
+_S(6052, "socketpair")
+_S(6053, "setsockopt")
+_S(6054, "getsockopt")
+_S(6055, "clone")
+_S(6056, "fork")
+_S(6057, "execve")
+_S(6058, "exit")
+_S(6059, "wait4")
+_S(6060, "kill")
+_S(6061, "uname")
+_S(6062, "semget")
+_S(6063, "semop")
+_S(6064, "semctl")
+_S(6065, "shmdt")
+_S(6066, "msgget")
+_S(6067, "msgsnd")
+_S(6068, "msgrcv")
+_S(6069, "msgctl")
+_S(6070, "fcntl")
+_S(6071, "flock")
+_S(6072, "fsync")
+_S(6073, "fdatasync")
+_S(6074, "truncate")
+_S(6075, "ftruncate")
+_S(6076, "getdents")
+_S(6077, "getcwd")
+_S(6078, "chdir")
+_S(6079, "fchdir")
+_S(6080, "rename")
+_S(6081, "mkdir")
+_S(6082, "rmdir")
+_S(6083, "creat")
+_S(6084, "link")
+_S(6085, "unlink")
+_S(6086, "symlink")
+_S(6087, "readlink")
+_S(6088, "chmod")
+_S(6089, "fchmod")
+_S(6090, "chown")
+_S(6091, "fchown")
+_S(6092, "lchown")
+_S(6093, "umask")
+_S(6094, "gettimeofday")
+_S(6095, "getrlimit")
+_S(6096, "getrusage")
+_S(6097, "sysinfo")
+_S(6098, "times")
+_S(6099, "ptrace")
+_S(6100, "getuid")
+_S(6101, "syslog")
+_S(6102, "getgid")
+_S(6103, "setuid")
+_S(6104, "setgid")
+_S(6105, "geteuid")
+_S(6106, "getegid")
+_S(6107, "setpgid")
+_S(6108, "getppid")
+_S(6109, "getpgrp")
+_S(6110, "setsid")
+_S(6111, "setreuid")
+_S(6112, "setregid")
+_S(6113, "getgroups")
+_S(6114, "setgroups")
+_S(6115, "setresuid")
+_S(6116, "getresuid")
+_S(6117, "setresgid")
+_S(6118, "getresgid")
+_S(6119, "getpgid")
+_S(6120, "setfsuid")
+_S(6121, "setfsgid")
+_S(6122, "getsid")
+_S(6123, "capget")
+_S(6124, "capset")
+_S(6125, "rt_sigpending")
+_S(6126, "rt_sigtimedwait")
+_S(6127, "rt_sigqueueinfo")
+_S(6128, "rt_sigsuspend")
+_S(6129, "sigaltstack")
+_S(6130, "utime")
+_S(6131, "mknod")
+_S(6132, "personality")
+_S(6133, "ustat")
+_S(6134, "statfs")
+_S(6135, "fstatfs")
+_S(6136, "sysfs")
+_S(6137, "getpriority")
+_S(6138, "setpriority")
+_S(6139, "sched_setparam")
+_S(6140, "sched_getparam")
+_S(6141, "sched_setscheduler")
+_S(6142, "sched_getscheduler")
+_S(6143, "sched_get_priority_max")
+_S(6144, "sched_get_priority_min")
+_S(6145, "sched_rr_get_interval")
+_S(6146, "mlock")
+_S(6147, "munlock")
+_S(6148, "mlockall")
+_S(6149, "munlockall")
+_S(6150, "vhangup")
+_S(6151, "pivot_root")
+_S(6152, "_sysctl")
+_S(6153, "prctl")
+_S(6154, "adjtimex")
+_S(6155, "setrlimit")
+_S(6156, "chroot")
+_S(6157, "sync")
+_S(6158, "acct")
+_S(6159, "settimeofday")
+_S(6160, "mount")
+_S(6161, "umount2")
+_S(6162, "swapon")
+_S(6163, "swapoff")
+_S(6164, "reboot")
+_S(6165, "sethostname")
+_S(6166, "setdomainname")
+_S(6167, "create_module")
+_S(6168, "init_module")
+_S(6169, "delete_module")
+_S(6170, "get_kernel_syms")
+_S(6171, "query_module")
+_S(6172, "quotactl")
+_S(6173, "nfsservctl")
+_S(6174, "getpmsg")
+_S(6175, "putpmsg")
+_S(6176, "afs_syscall")
+_S(6177, "reserved177")
+_S(6178, "gettid")
+_S(6179, "readahead")
+_S(6180, "setxattr")
+_S(6181, "lsetxattr")
+_S(6182, "fsetxattr")
+_S(6183, "getxattr")
+_S(6184, "lgetxattr")
+_S(6185, "fgetxattr")
+_S(6186, "listxattr")
+_S(6187, "llistxattr")
+_S(6188, "flistxattr")
+_S(6189, "removexattr")
+_S(6190, "lremovexattr")
+_S(6191, "fremovexattr")
+_S(6192, "tkill")
+_S(6193, "reserved193")
+_S(6194, "futex")
+_S(6195, "sched_setaffinity")
+_S(6196, "sched_getaffinity")
+_S(6197, "cacheflush")
+_S(6198, "cachectl")
+_S(6199, "sysmips")
+_S(6200, "io_setup")
+_S(6201, "io_destroy")
+_S(6202, "io_getevents")
+_S(6203, "io_submit")
+_S(6204, "io_cancel")
+_S(6205, "exit_group")
+_S(6206, "lookup_dcookie")
+_S(6207, "epoll_create")
+_S(6208, "epoll_ctl")
+_S(6209, "epoll_wait")
+_S(6210, "remap_file_pages")
+_S(6211, "rt_sigreturn")
+_S(6212, "fcntl64")
+_S(6213, "set_tid_address")
+_S(6214, "restart_syscall")
+_S(6215, "semtimedop")
+_S(6216, "fadvise64")
+_S(6217, "statfs64")
+_S(6218, "fstatfs64")
+_S(6219, "sendfile64")
+_S(6220, "timer_create")
+_S(6221, "timer_settime")
+_S(6222, "timer_gettime")
+_S(6223, "timer_getoverrun")
+_S(6224, "timer_delete")
+_S(6225, "clock_settime")
+_S(6226, "clock_gettime")
+_S(6227, "clock_getres")
+_S(6228, "clock_nanosleep")
+_S(6229, "tgkill")
+_S(6230, "utimes")
+_S(6231, "mbind")
+_S(6232, "get_mempolicy")
+_S(6233, "set_mempolicy")
+_S(6234, "mq_open")
+_S(6235, "mq_unlink")
+_S(6236, "mq_timedsend")
+_S(6237, "mq_timedreceive")
+_S(6238, "mq_notify")
+_S(6239, "mq_getsetattr")
+_S(6240, "vserver")
+_S(6241, "waitid")
+_S(6243, "add_key")
+_S(6244, "request_key")
+_S(6245, "keyctl")
+_S(6246, "set_thread_area")
+_S(6247, "inotify_init")
+_S(6248, "inotify_add_watch")
+_S(6249, "inotify_rm_watch")
+_S(6250, "migrate_pages")
+_S(6251, "openat")
+_S(6252, "mkdirat")
+_S(6253, "mknodat")
+_S(6254, "fchownat")
+_S(6255, "futimesat")
+_S(6256, "newfstatat")
+_S(6257, "unlinkat")
+_S(6258, "renameat")
+_S(6259, "linkat")
+_S(6260, "symlinkat")
+_S(6261, "readlinkat")
+_S(6262, "fchmodat")
+_S(6263, "faccessat")
+_S(6264, "pselect6")
+_S(6265, "ppoll")
+_S(6266, "unshare")
+_S(6267, "splice")
+_S(6268, "sync_file_range")
+_S(6269, "tee")
+_S(6270, "vmsplice")
+_S(6271, "move_pages")
+_S(6272, "set_robust_list")
+_S(6273, "get_robust_list")
+_S(6274, "kexec_load")
+_S(6275, "getcpu")
+_S(6276, "epoll_pwait")
+_S(6277, "ioprio_set")
+_S(6278, "ioprio_get")
+_S(6279, "utimensat")
+_S(6280, "signalfd")
+_S(6281, "timerfd")
+_S(6282, "eventfd")
+_S(6283, "fallocate")
+_S(6284, "timerfd_create")
+_S(6285, "timerfd_gettime")
+_S(6286, "timerfd_settime")
+_S(6287, "signalfd4")
+_S(6288, "eventfd2")
+_S(6289, "epoll_create1")
+_S(6290, "dup3")
+_S(6291, "pipe2")
+_S(6292, "inotify_init1")
+_S(6293, "preadv")
+_S(6294, "pwritev")
+_S(6295, "rt_tgsigqueueinfo")
+_S(6296, "perf_event_open")
+_S(6297, "accept4")
+_S(6298, "recvmmsg")
+_S(6299, "getdents64")
+_S(6300, "fanotify_init")
+_S(6301, "fanotify_mark")
+_S(6302, "prlimit64")
+_S(6303, "name_to_handle_at")
+_S(6304, "open_by_handle_at")
+_S(6305, "clock_adjtime")
+_S(6306, "syncfs")
+_S(6307, "sendmmsg")
+_S(6308, "setns")
+_S(6309, "process_vm_readv")
+_S(6310, "process_vm_writev")
+_S(6311, "kcmp")
+_S(6312, "finit_module")
+_S(6313, "sched_setattr")
+_S(6314, "sched_getattr")
diff -Naurp trunk/lib/mips_n64_table.h trunk-work/lib/mips_n64_table.h
--- trunk/lib/mips_n64_table.h	1970-01-01 01:00:00.000000000 +0100
+++ trunk-work/lib/mips_n64_table.h	2014-03-28 16:14:50.059698794 +0100
@@ -0,0 +1,329 @@
+/*
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * Copyright 2010 Wind River Systems,
+ *   written by Ralf Baechle <ralf linux-mips org>
+ */
+
+_S(5000, "read")
+_S(5001, "write")
+_S(5002, "open")
+_S(5003, "close")
+_S(5004, "stat")
+_S(5005, "fstat")
+_S(5006, "lstat")
+_S(5007, "poll")
+_S(5008, "lseek")
+_S(5009, "mmap")
+_S(5010, "mprotect")
+_S(5011, "munmap")
+_S(5012, "brk")
+_S(5013, "rt_sigaction")
+_S(5014, "rt_sigprocmask")
+_S(5015, "ioctl")
+_S(5016, "pread64")
+_S(5017, "pwrite64")
+_S(5018, "readv")
+_S(5019, "writev")
+_S(5020, "access")
+_S(5021, "pipe")
+_S(5022, "_newselect")
+_S(5023, "sched_yield")
+_S(5024, "mremap")
+_S(5025, "msync")
+_S(5026, "mincore")
+_S(5027, "madvise")
+_S(5028, "shmget")
+_S(5029, "shmat")
+_S(5030, "shmctl")
+_S(5031, "dup")
+_S(5032, "dup2")
+_S(5033, "pause")
+_S(5034, "nanosleep")
+_S(5035, "getitimer")
+_S(5036, "setitimer")
+_S(5037, "alarm")
+_S(5038, "getpid")
+_S(5039, "sendfile")
+_S(5040, "socket")
+_S(5041, "connect")
+_S(5042, "accept")
+_S(5043, "sendto")
+_S(5044, "recvfrom")
+_S(5045, "sendmsg")
+_S(5046, "recvmsg")
+_S(5047, "shutdown")
+_S(5048, "bind")
+_S(5049, "listen")
+_S(5050, "getsockname")
+_S(5051, "getpeername")
+_S(5052, "socketpair")
+_S(5053, "setsockopt")
+_S(5054, "getsockopt")
+_S(5055, "clone")
+_S(5056, "fork")
+_S(5057, "execve")
+_S(5058, "exit")
+_S(5059, "wait4")
+_S(5060, "kill")
+_S(5061, "uname")
+_S(5062, "semget")
+_S(5063, "semop")
+_S(5064, "semctl")
+_S(5065, "shmdt")
+_S(5066, "msgget")
+_S(5067, "msgsnd")
+_S(5068, "msgrcv")
+_S(5069, "msgctl")
+_S(5070, "fcntl")
+_S(5071, "flock")
+_S(5072, "fsync")
+_S(5073, "fdatasync")
+_S(5074, "truncate")
+_S(5075, "ftruncate")
+_S(5076, "getdents")
+_S(5077, "getcwd")
+_S(5078, "chdir")
+_S(5079, "fchdir")
+_S(5080, "rename")
+_S(5081, "mkdir")
+_S(5082, "rmdir")
+_S(5083, "creat")
+_S(5084, "link")
+_S(5085, "unlink")
+_S(5086, "symlink")
+_S(5087, "readlink")
+_S(5088, "chmod")
+_S(5089, "fchmod")
+_S(5090, "chown")
+_S(5091, "fchown")
+_S(5092, "lchown")
+_S(5093, "umask")
+_S(5094, "gettimeofday")
+_S(5095, "getrlimit")
+_S(5096, "getrusage")
+_S(5097, "sysinfo")
+_S(5098, "times")
+_S(5099, "ptrace")
+_S(5100, "getuid")
+_S(5101, "syslog")
+_S(5102, "getgid")
+_S(5103, "setuid")
+_S(5104, "setgid")
+_S(5105, "geteuid")
+_S(5106, "getegid")
+_S(5107, "setpgid")
+_S(5108, "getppid")
+_S(5109, "getpgrp")
+_S(5110, "setsid")
+_S(5111, "setreuid")
+_S(5112, "setregid")
+_S(5113, "getgroups")
+_S(5114, "setgroups")
+_S(5115, "setresuid")
+_S(5116, "getresuid")
+_S(5117, "setresgid")
+_S(5118, "getresgid")
+_S(5119, "getpgid")
+_S(5120, "setfsuid")
+_S(5121, "setfsgid")
+_S(5122, "getsid")
+_S(5123, "capget")
+_S(5124, "capset")
+_S(5125, "rt_sigpending")
+_S(5126, "rt_sigtimedwait")
+_S(5127, "rt_sigqueueinfo")
+_S(5128, "rt_sigsuspend")
+_S(5129, "sigaltstack")
+_S(5130, "utime")
+_S(5131, "mknod")
+_S(5132, "personality")
+_S(5133, "ustat")
+_S(5134, "statfs")
+_S(5135, "fstatfs")
+_S(5136, "sysfs")
+_S(5137, "getpriority")
+_S(5138, "setpriority")
+_S(5139, "sched_setparam")
+_S(5140, "sched_getparam")
+_S(5141, "sched_setscheduler")
+_S(5142, "sched_getscheduler")
+_S(5143, "sched_get_priority_max")
+_S(5144, "sched_get_priority_min")
+_S(5145, "sched_rr_get_interval")
+_S(5146, "mlock")
+_S(5147, "munlock")
+_S(5148, "mlockall")
+_S(5149, "munlockall")
+_S(5150, "vhangup")
+_S(5151, "pivot_root")
+_S(5152, "_sysctl")
+_S(5153, "prctl")
+_S(5154, "adjtimex")
+_S(5155, "setrlimit")
+_S(5156, "chroot")
+_S(5157, "sync")
+_S(5158, "acct")
+_S(5159, "settimeofday")
+_S(5160, "mount")
+_S(5161, "umount2")
+_S(5162, "swapon")
+_S(5163, "swapoff")
+_S(5164, "reboot")
+_S(5165, "sethostname")
+_S(5166, "setdomainname")
+_S(5167, "create_module")
+_S(5168, "init_module")
+_S(5169, "delete_module")
+_S(5170, "get_kernel_syms")
+_S(5171, "query_module")
+_S(5172, "quotactl")
+_S(5173, "nfsservctl")
+_S(5174, "getpmsg")
+_S(5175, "putpmsg")
+_S(5176, "afs_syscall")
+_S(5177, "reserved177")
+_S(5178, "gettid")
+_S(5179, "readahead")
+_S(5180, "setxattr")
+_S(5181, "lsetxattr")
+_S(5182, "fsetxattr")
+_S(5183, "getxattr")
+_S(5184, "lgetxattr")
+_S(5185, "fgetxattr")
+_S(5186, "listxattr")
+_S(5187, "llistxattr")
+_S(5188, "flistxattr")
+_S(5189, "removexattr")
+_S(5190, "lremovexattr")
+_S(5191, "fremovexattr")
+_S(5192, "tkill")
+_S(5193, "reserved193")
+_S(5194, "futex")
+_S(5195, "sched_setaffinity")
+_S(5196, "sched_getaffinity")
+_S(5197, "cacheflush")
+_S(5198, "cachectl")
+_S(5199, "sysmips")
+_S(5200, "io_setup")
+_S(5201, "io_destroy")
+_S(5202, "io_getevents")
+_S(5203, "io_submit")
+_S(5204, "io_cancel")
+_S(5205, "exit_group")
+_S(5206, "lookup_dcookie")
+_S(5207, "epoll_create")
+_S(5208, "epoll_ctl")
+_S(5209, "epoll_wait")
+_S(5210, "remap_file_pages")
+_S(5211, "rt_sigreturn")
+_S(5212, "set_tid_address")
+_S(5213, "restart_syscall")
+_S(5214, "semtimedop")
+_S(5215, "fadvise64")
+_S(5216, "timer_create")
+_S(5217, "timer_settime")
+_S(5218, "timer_gettime")
+_S(5219, "timer_getoverrun")
+_S(5220, "timer_delete")
+_S(5221, "clock_settime")
+_S(5222, "clock_gettime")
+_S(5223, "clock_getres")
+_S(5224, "clock_nanosleep")
+_S(5225, "tgkill")
+_S(5226, "utimes")
+_S(5227, "mbind")
+_S(5228, "get_mempolicy")
+_S(5229, "set_mempolicy")
+_S(5230, "mq_open")
+_S(5231, "mq_unlink")
+_S(5232, "mq_timedsend")
+_S(5233, "mq_timedreceive")
+_S(5234, "mq_notify")
+_S(5235, "mq_getsetattr")
+_S(5236, "vserver")
+_S(5237, "waitid")
+_S(5239, "add_key")
+_S(5240, "request_key")
+_S(5241, "keyctl")
+_S(5242, "set_thread_area")
+_S(5243, "inotify_init")
+_S(5244, "inotify_add_watch")
+_S(5245, "inotify_rm_watch")
+_S(5246, "migrate_pages")
+_S(5247, "openat")
+_S(5248, "mkdirat")
+_S(5249, "mknodat")
+_S(5250, "fchownat")
+_S(5251, "futimesat")
+_S(5252, "newfstatat")
+_S(5253, "unlinkat")
+_S(5254, "renameat")
+_S(5255, "linkat")
+_S(5256, "symlinkat")
+_S(5257, "readlinkat")
+_S(5258, "fchmodat")
+_S(5259, "faccessat")
+_S(5260, "pselect6")
+_S(5261, "ppoll")
+_S(5262, "unshare")
+_S(5263, "splice")
+_S(5264, "sync_file_range")
+_S(5265, "tee")
+_S(5266, "vmsplice")
+_S(5267, "move_pages")
+_S(5268, "set_robust_list")
+_S(5269, "get_robust_list")
+_S(5270, "kexec_load")
+_S(5271, "getcpu")
+_S(5272, "epoll_pwait")
+_S(5273, "ioprio_set")
+_S(5274, "ioprio_get")
+_S(5275, "utimensat")
+_S(5276, "signalfd")
+_S(5277, "timerfd")
+_S(5278, "eventfd")
+_S(5279, "fallocate")
+_S(5280, "timerfd_create")
+_S(5281, "timerfd_gettime")
+_S(5282, "timerfd_settime")
+_S(5283, "signalfd4")
+_S(5284, "eventfd2")
+_S(5285, "epoll_create1")
+_S(5286, "dup3")
+_S(5287, "pipe2")
+_S(5288, "inotify_init1")
+_S(5289, "preadv")
+_S(5290, "pwritev")
+_S(5291, "rt_tgsigqueueinfo")
+_S(5292, "perf_event_open")
+_S(5293, "accept4")
+_S(5294, "recvmmsg")
+_S(5295, "fanotify_init")
+_S(5296, "fanotify_mark")
+_S(5297, "prlimit64")
+_S(5298, "name_to_handle_at")
+_S(5299, "open_by_handle_at")
+_S(5300, "clock_adjtime")
+_S(5301, "syncfs")
+_S(5302, "sendmmsg")
+_S(5303, "setns")
+_S(5304, "process_vm_readv")
+_S(5305, "process_vm_writev")
+_S(5306, "kcmp")
+_S(5307, "finit_module")
+_S(5308, "getdents64")
+_S(5309, "sched_setattr")
+_S(5310, "sched_getattr")
diff -Naurp trunk/lib/mips_o32_table.h trunk-work/lib/mips_o32_table.h
--- trunk/lib/mips_o32_table.h	1970-01-01 01:00:00.000000000 +0100
+++ trunk-work/lib/mips_o32_table.h	2014-03-28 16:12:56.817807268 +0100
@@ -0,0 +1,369 @@
+/*
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * Copyright 2010 Wind River Systems,
+ *   written by Ralf Baechle <ralf linux-mips org>
+ */
+
+_S(4000, "syscall")
+_S(4001, "exit")
+_S(4002, "fork")
+_S(4003, "read")
+_S(4004, "write")
+_S(4005, "open")
+_S(4006, "close")
+_S(4007, "waitpid")
+_S(4008, "creat")
+_S(4009, "link")
+_S(4010, "unlink")
+_S(4011, "execve")
+_S(4012, "chdir")
+_S(4013, "time")
+_S(4014, "mknod")
+_S(4015, "chmod")
+_S(4016, "lchown")
+_S(4017, "break")
+_S(4018, "unused18")
+_S(4019, "lseek")
+_S(4020, "getpid")
+_S(4021, "mount")
+_S(4022, "umount")
+_S(4023, "setuid")
+_S(4024, "getuid")
+_S(4025, "stime")
+_S(4026, "ptrace")
+_S(4027, "alarm")
+_S(4028, "unused28")
+_S(4029, "pause")
+_S(4030, "utime")
+_S(4031, "stty")
+_S(4032, "gtty")
+_S(4033, "access")
+_S(4034, "nice")
+_S(4035, "ftime")
+_S(4036, "sync")
+_S(4037, "kill")
+_S(4038, "rename")
+_S(4039, "mkdir")
+_S(4040, "rmdir")
+_S(4041, "dup")
+_S(4042, "pipe")
+_S(4043, "times")
+_S(4044, "prof")
+_S(4045, "brk")
+_S(4046, "setgid")
+_S(4047, "getgid")
+_S(4048, "signal")
+_S(4049, "geteuid")
+_S(4050, "getegid")
+_S(4051, "acct")
+_S(4052, "umount2")
+_S(4053, "lock")
+_S(4054, "ioctl")
+_S(4055, "fcntl")
+_S(4056, "mpx")
+_S(4057, "setpgid")
+_S(4058, "ulimit")
+_S(4059, "unused59")
+_S(4060, "umask")
+_S(4061, "chroot")
+_S(4062, "ustat")
+_S(4063, "dup2")
+_S(4064, "getppid")
+_S(4065, "getpgrp")
+_S(4066, "setsid")
+_S(4067, "sigaction")
+_S(4068, "sgetmask")
+_S(4069, "ssetmask")
+_S(4070, "setreuid")
+_S(4071, "setregid")
+_S(4072, "sigsuspend")
+_S(4073, "sigpending")
+_S(4074, "sethostname")
+_S(4075, "setrlimit")
+_S(4076, "getrlimit")
+_S(4077, "getrusage")
+_S(4078, "gettimeofday")
+_S(4079, "settimeofday")
+_S(4080, "getgroups")
+_S(4081, "setgroups")
+_S(4082, "reserved82")
+_S(4083, "symlink")
+_S(4084, "unused84")
+_S(4085, "readlink")
+_S(4086, "uselib")
+_S(4087, "swapon")
+_S(4088, "reboot")
+_S(4089, "readdir")
+_S(4090, "mmap")
+_S(4091, "munmap")
+_S(4092, "truncate")
+_S(4093, "ftruncate")
+_S(4094, "fchmod")
+_S(4095, "fchown")
+_S(4096, "getpriority")
+_S(4097, "setpriority")
+_S(4098, "profil")
+_S(4099, "statfs")
+_S(4100, "fstatfs")
+_S(4101, "ioperm")
+_S(4102, "socketcall")
+_S(4103, "syslog")
+_S(4104, "setitimer")
+_S(4105, "getitimer")
+_S(4106, "stat")
+_S(4107, "lstat")
+_S(4108, "fstat")
+_S(4109, "unused109")
+_S(4110, "iopl")
+_S(4111, "vhangup")
+_S(4112, "idle")
+_S(4113, "vm86")
+_S(4114, "wait4")
+_S(4115, "swapoff")
+_S(4116, "sysinfo")
+_S(4117, "ipc")
+_S(4118, "fsync")
+_S(4119, "sigreturn")
+_S(4120, "clone")
+_S(4121, "setdomainname")
+_S(4122, "uname")
+_S(4123, "modify_ldt")
+_S(4124, "adjtimex")
+_S(4125, "mprotect")
+_S(4126, "sigprocmask")
+_S(4127, "create_module")
+_S(4128, "init_module")
+_S(4129, "delete_module")
+_S(4130, "get_kernel_syms")
+_S(4131, "quotactl")
+_S(4132, "getpgid")
+_S(4133, "fchdir")
+_S(4134, "bdflush")
+_S(4135, "sysfs")
+_S(4136, "personality")
+_S(4137, "afs_syscall")
+_S(4138, "setfsuid")
+_S(4139, "setfsgid")
+_S(4140, "_llseek")
+_S(4141, "getdents")
+_S(4142, "_newselect")
+_S(4143, "flock")
+_S(4144, "msync")
+_S(4145, "readv")
+_S(4146, "writev")
+_S(4147, "cacheflush")
+_S(4148, "cachectl")
+_S(4149, "sysmips")
+_S(4150, "unused150")
+_S(4151, "getsid")
+_S(4152, "fdatasync")
+_S(4153, "_sysctl")
+_S(4154, "mlock")
+_S(4155, "munlock")
+_S(4156, "mlockall")
+_S(4157, "munlockall")
+_S(4158, "sched_setparam")
+_S(4159, "sched_getparam")
+_S(4160, "sched_setscheduler")
+_S(4161, "sched_getscheduler")
+_S(4162, "sched_yield")
+_S(4163, "sched_get_priority_max")
+_S(4164, "sched_get_priority_min")
+_S(4165, "sched_rr_get_interval")
+_S(4166, "nanosleep")
+_S(4167, "mremap")
+_S(4168, "accept")
+_S(4169, "bind")
+_S(4170, "connect")
+_S(4171, "getpeername")
+_S(4172, "getsockname")
+_S(4173, "getsockopt")
+_S(4174, "listen")
+_S(4175, "recv")
+_S(4176, "recvfrom")
+_S(4177, "recvmsg")
+_S(4178, "send")
+_S(4179, "sendmsg")
+_S(4180, "sendto")
+_S(4181, "setsockopt")
+_S(4182, "shutdown")
+_S(4183, "socket")
+_S(4184, "socketpair")
+_S(4185, "setresuid")
+_S(4186, "getresuid")
+_S(4187, "query_module")
+_S(4188, "poll")
+_S(4189, "nfsservctl")
+_S(4190, "setresgid")
+_S(4191, "getresgid")
+_S(4192, "prctl")
+_S(4193, "rt_sigreturn")
+_S(4194, "rt_sigaction")
+_S(4195, "rt_sigprocmask")
+_S(4196, "rt_sigpending")
+_S(4197, "rt_sigtimedwait")
+_S(4198, "rt_sigqueueinfo")
+_S(4199, "rt_sigsuspend")
+_S(4200, "pread64")
+_S(4201, "pwrite64")
+_S(4202, "chown")
+_S(4203, "getcwd")
+_S(4204, "capget")
+_S(4205, "capset")
+_S(4206, "sigaltstack")
+_S(4207, "sendfile")
+_S(4208, "getpmsg")
+_S(4209, "putpmsg")
+_S(4210, "mmap2")
+_S(4211, "truncate64")
+_S(4212, "ftruncate64")
+_S(4213, "stat64")
+_S(4214, "lstat64")
+_S(4215, "fstat64")
+_S(4216, "pivot_root")
+_S(4217, "mincore")
+_S(4218, "madvise")
+_S(4219, "getdents64")
+_S(4220, "fcntl64")
+_S(4221, "reserved221")
+_S(4222, "gettid")
+_S(4223, "readahead")
+_S(4224, "setxattr")
+_S(4225, "lsetxattr")
+_S(4226, "fsetxattr")
+_S(4227, "getxattr")
+_S(4228, "lgetxattr")
+_S(4229, "fgetxattr")
+_S(4230, "listxattr")
+_S(4231, "llistxattr")
+_S(4232, "flistxattr")
+_S(4233, "removexattr")
+_S(4234, "lremovexattr")
+_S(4235, "fremovexattr")
+_S(4236, "tkill")
+_S(4237, "sendfile64")
+_S(4238, "futex")
+_S(4239, "sched_setaffinity")
+_S(4240, "sched_getaffinity")
+_S(4241, "io_setup")
+_S(4242, "io_destroy")
+_S(4243, "io_getevents")
+_S(4244, "io_submit")
+_S(4245, "io_cancel")
+_S(4246, "exit_group")
+_S(4247, "lookup_dcookie")
+_S(4248, "epoll_create")
+_S(4249, "epoll_ctl")
+_S(4250, "epoll_wait")
+_S(4251, "remap_file_pages")
+_S(4252, "set_tid_address")
+_S(4253, "restart_syscall")
+_S(4254, "fadvise64")
+_S(4255, "statfs64")
+_S(4256, "fstatfs64")
+_S(4257, "timer_create")
+_S(4258, "timer_settime")
+_S(4259, "timer_gettime")
+_S(4260, "timer_getoverrun")
+_S(4261, "timer_delete")
+_S(4262, "clock_settime")
+_S(4263, "clock_gettime")
+_S(4264, "clock_getres")
+_S(4265, "clock_nanosleep")
+_S(4266, "tgkill")
+_S(4267, "utimes")
+_S(4268, "mbind")
+_S(4269, "get_mempolicy")
+_S(4270, "set_mempolicy")
+_S(4271, "mq_open")
+_S(4272, "mq_unlink")
+_S(4273, "mq_timedsend")
+_S(4274, "mq_timedreceive")
+_S(4275, "mq_notify")
+_S(4276, "mq_getsetattr")
+_S(4277, "vserver")
+_S(4278, "waitid")
+_S(4280, "add_key")
+_S(4281, "request_key")
+_S(4282, "keyctl")
+_S(4283, "set_thread_area")
+_S(4284, "inotify_init")
+_S(4285, "inotify_add_watch")
+_S(4286, "inotify_rm_watch")
+_S(4287, "migrate_pages")
+_S(4288, "openat")
+_S(4289, "mkdirat")
+_S(4290, "mknodat")
+_S(4291, "fchownat")
+_S(4292, "futimesat")
+_S(4293, "fstatat64")
+_S(4294, "unlinkat")
+_S(4295, "renameat")
+_S(4296, "linkat")
+_S(4297, "symlinkat")
+_S(4298, "readlinkat")
+_S(4299, "fchmodat")
+_S(4300, "faccessat")
+_S(4301, "pselect6")
+_S(4302, "ppoll")
+_S(4303, "unshare")
+_S(4304, "splice")
+_S(4305, "sync_file_range")
+_S(4306, "tee")
+_S(4307, "vmsplice")
+_S(4308, "move_pages")
+_S(4309, "set_robust_list")
+_S(4310, "get_robust_list")
+_S(4311, "kexec_load")
+_S(4312, "getcpu")
+_S(4313, "epoll_pwait")
+_S(4314, "ioprio_set")
+_S(4315, "ioprio_get")
+_S(4316, "utimensat")
+_S(4317, "signalfd")
+_S(4318, "timerfd")
+_S(4319, "eventfd")
+_S(4320, "fallocate")
+_S(4321, "timerfd_create")
+_S(4322, "timerfd_gettime")
+_S(4323, "timerfd_settime")
+_S(4324, "signalfd4")
+_S(4325, "eventfd2")
+_S(4326, "epoll_create1")
+_S(4327, "dup3")
+_S(4328, "pipe2")
+_S(4329, "inotify_init1")
+_S(4330, "preadv")
+_S(4331, "pwritev")
+_S(4332, "rt_tgsigqueueinfo")
+_S(4333, "perf_event_open")
+_S(4334, "accept4")
+_S(4335, "recvmmsg")
+_S(4336, "fanotify_init")
+_S(4337, "fanotify_mark")
+_S(4338, "prlimit64")
+_S(4339, "name_to_handle_at")
+_S(4340, "open_by_handle_at")
+_S(4341, "clock_adjtime")
+_S(4342, "syncfs")
+_S(4343, "sendmmsg")
+_S(4344, "setns")
+_S(4345, "process_vm_readv")
+_S(4346, "process_vm_writev")
+_S(4347, "kcmp")
+_S(4348, "finit_module")
+_S(4349, "sched_setattr")
+_S(4350, "sched_getattr")
diff -Naurp trunk/lib/syscall-update.txt trunk-work/lib/syscall-update.txt
--- trunk/lib/syscall-update.txt	2014-03-28 14:38:29.831405944 +0100
+++ trunk-work/lib/syscall-update.txt	2014-03-28 16:08:12.500568904 +0100
@@ -3,6 +3,7 @@ The place where syscall information is g
 arch/alpha/include/uapi/asm/unistd.h
 arch/arm/include/uapi/asm/unistd.h
 arch/ia64/include/uapi/asm/unistd.h
+arch/mips/include/uapi/asm/unistd.h
 arch/powerpc/include/uapi/asm/unistd.h
 arch/s390/include/uapi/asm/unistd.h
 arch/x86/syscalls/syscall_32.tbl
diff -Naurp trunk/lib/test/lookup_test.c trunk-work/lib/test/lookup_test.c
--- trunk/lib/test/lookup_test.c	2014-03-28 14:38:29.699404905 +0100
+++ trunk-work/lib/test/lookup_test.c	2014-03-28 15:52:02.893982751 +0100
@@ -205,6 +205,54 @@ test_ia64_table(void)
 }
 
 static void
+test_mips_o32_table(void)
+{
+	static const struct entry t[] = {
+#include "../mips_o32_table.h"
+	};
+
+	printf("Testing O32 mips_table...\n");
+#define I2S(I) audit_syscall_to_name((I), MACH_MIPS)
+#define S2I(S) audit_name_to_syscall((S), MACH_MIPS)
+	TEST_I2S(0);
+	TEST_S2I(-1);
+#undef I2S
+#undef S2I
+}
+
+static void
+test_mips_n32_table(void)
+{
+	static const struct entry t[] = {
+#include "../mips_n32_table.h"
+	};
+
+	printf("Testing mips_n32_table...\n");
+#define I2S(I) audit_syscall_to_name((I), MACH_MIPS)
+#define S2I(S) audit_name_to_syscall((S), MACH_MIPS)
+	TEST_I2S(0);
+	TEST_S2I(-1);
+#undef I2S
+#undef S2I
+}
+
+static void
+test_mips_n64_table(void)
+{
+	static const struct entry t[] = {
+#include "../mips_n64_table.h"
+	};
+
+	printf("Testing N64 mips_table...\n");
+#define I2S(I) audit_syscall_to_name((I), MACH_MIPS)
+#define S2I(S) audit_name_to_syscall((S), MACH_MIPS)
+	TEST_I2S(0);
+	TEST_S2I(-1);
+#undef I2S
+#undef S2I
+}
+
+static void
 test_ppc_table(void)
 {
 	static const struct entry t[] = {
@@ -413,6 +461,9 @@ main(void)
 #endif
 	test_i386_table();
 	test_ia64_table();
+	test_mips_o32_table();
+	test_mips_n32_table();
+	test_mips_n64_table();
 	test_ppc_table();
 	test_s390_table();
 	test_s390x_table();

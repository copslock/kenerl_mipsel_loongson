Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2018 20:54:07 +0100 (CET)
Received: from mail-pf1-x441.google.com ([IPv6:2607:f8b0:4864:20::441]:36724
        "EHLO mail-pf1-x441.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991034AbeJaTwarp2dx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Oct 2018 20:52:30 +0100
Received: by mail-pf1-x441.google.com with SMTP id j22-v6so4312763pfh.3;
        Wed, 31 Oct 2018 12:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=IEjr7pjOKiDHdXZG0NQrJu99vimFXUtb0MuO9FQ7m2I=;
        b=qgIXLFgS1mp5YfifpXqAHs6/G/o/2jFxx7Dra0Zm3PHib/mLyMecCErAekcSfjD9e5
         eoIQrs92AtXWJ0fnU7wUgT3aFMmmaucuzvxtQrjS5OyhHA4y4Uf0rI28syrxoZkSREGT
         +A1mrc3HOuH4Kt9fNsvHQyVItT9hLLQ0XM76ucaBUA1mlA205gdZx6rpfoDos5SQRYYC
         +Qh2XINJHasi5Dfvd57jXsyy1YCckw/365EF/EDHgG2KNeZm7ROBjQmwRWtm3pJLIzKp
         9ORz+XC68xDpXroxMwoIH052RzhwuYnQItWjeHSuNydtpUbxT7e/vAVOO3Jl0OafjRse
         6t1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=IEjr7pjOKiDHdXZG0NQrJu99vimFXUtb0MuO9FQ7m2I=;
        b=W4vP0hy54nv88OXELIY+1JjKKh1Ndn0/656M52CRLRRC4ywHLDuBb8FB8sXSQmysaE
         0yqCBtupqmqwmBK/LrpYBG1iOVGfDjaL/8VFXjIwkvIcF5BnSHvmtwJTSjTiqYM6ecDp
         1JJN/zqzygfmj1CNPCGIdKOvp+sXayxOzEmC/a/J1FMPN7ffZeMzMSTIrSNz0RqRttsq
         wPBAy+cP/IlI535fkfpU25tQSqA/N9ri6QtYdYLPBtkxK4/vZkHJLWUgKkR/+/SmAPvo
         XwAs9PD0KDdYWRlA7xtjbwCcnj1AztUUUQ2F4e8JR6nkt7m/dTw+bVUdLnAwAjQBRenI
         NtDw==
X-Gm-Message-State: AGRZ1gJd3Zks+/xHDbFaeEYhoMUOKLy3K0EH5zMredcXvEmmBnNWf9qd
        DUea1Mk92cLWwXKb5+TcxFwL2wn8
X-Google-Smtp-Source: AJdET5eN9SB27XJaYjLQBPklnmkS8jmJdZobIhxLvKlL4Mips5LN68ltLYVOn4rRiU/ANweeGx+d9g==
X-Received: by 2002:a62:fb04:: with SMTP id x4-v6mr4732905pfm.210.1541015549299;
        Wed, 31 Oct 2018 12:52:29 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r5-v6sm36834557pgi.64.2018.10.31.12.52.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 12:52:28 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [RFC PATCH] lib: Introduce generic __cmpxchg_u64() and use it where needed
Date:   Wed, 31 Oct 2018 12:52:18 -0700
Message-Id: <1541015538-11382-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67015
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

Some architectures do not or not always support cmpxchg64(). This results
in on/off problems when the function is used in common code. The latest
example is

net/sunrpc/auth_gss/gss_krb5_seal.c: In function 'gss_seq_send64_fetch_and_inc':
net/sunrpc/auth_gss/gss_krb5_seal.c:145:14: error:
	implicit declaration of function 'cmpxchg64'

which is seen with some powerpc and mips builds.

Introduce a generic version of __cmpxchg_u64() and use it for affected
architectures.

Fixes: 21924765862a
	("SUNRPC: use cmpxchg64() in gss_seq_send64_fetch_and_inc()")
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Couple of questions:
- Is this the right (or an acceptable) approach to fix the problem ?
- Should I split the patch into three, one to introduce __cmpxchg_u64()
  and one per architecture ?
- Who should take the patch (series) ?

 arch/mips/Kconfig                  |  1 +
 arch/mips/include/asm/cmpxchg.h    |  3 ++
 arch/powerpc/Kconfig               |  1 +
 arch/powerpc/include/asm/cmpxchg.h |  3 ++
 lib/Kconfig                        |  3 ++
 lib/Makefile                       |  2 ++
 lib/cmpxchg64.c                    | 60 ++++++++++++++++++++++++++++++++++++++
 7 files changed, 73 insertions(+)
 create mode 100644 lib/cmpxchg64.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 80778b40f8fa..7392a5f4e517 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -18,6 +18,7 @@ config MIPS
 	select CPU_PM if CPU_IDLE
 	select DMA_DIRECT_OPS
 	select GENERIC_ATOMIC64 if !64BIT
+	select GENERIC_CMPXCHG64 if !64BIT && SMP
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index 89e9fb7976fe..ca837b05bf3d 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -206,6 +206,9 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
 #ifndef CONFIG_SMP
 #define cmpxchg64(ptr, o, n) cmpxchg64_local((ptr), (o), (n))
+#else
+extern u64 __cmpxchg_u64(u64 *p, u64 old, u64 new);
+#define cmpxchg64(ptr, o, n) __cmpxchg_u64((ptr), (o), (n))
 #endif
 #endif
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e84943d24e5c..bd1d99c664c4 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -161,6 +161,7 @@ config PPC
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
 	select GENERIC_ATOMIC64			if PPC32
+	select GENERIC_CMPXCHG64		if PPC32
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CLOCKEVENTS_BROADCAST	if SMP
 	select GENERIC_CMOS_UPDATE
diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index 27183871eb3b..da8be4189731 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -534,8 +534,11 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 	cmpxchg_acquire((ptr), (o), (n));				\
 })
 #else
+extern u64 __cmpxchg_u64(u64 *p, u64 old, u64 new);
+
 #include <asm-generic/cmpxchg-local.h>
 #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+#define cmpxchg64(ptr, o, n) __cmpxchg_u64((ptr), (o), (n))
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/lib/Kconfig b/lib/Kconfig
index d1573a16aa92..2b581a70ded2 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -500,6 +500,9 @@ config NLATTR
 config GENERIC_ATOMIC64
        bool
 
+config GENERIC_CMPXCHG64
+	bool
+
 config LRU_CACHE
 	tristate
 
diff --git a/lib/Makefile b/lib/Makefile
index 988949c4fd3a..4646a06ed418 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -172,6 +172,8 @@ obj-$(CONFIG_GENERIC_CSUM) += checksum.o
 
 obj-$(CONFIG_GENERIC_ATOMIC64) += atomic64.o
 
+obj-$(CONFIG_GENERIC_CMPXCHG64) += cmpxchg64.o
+
 obj-$(CONFIG_ATOMIC64_SELFTEST) += atomic64_test.o
 
 obj-$(CONFIG_CPU_RMAP) += cpu_rmap.o
diff --git a/lib/cmpxchg64.c b/lib/cmpxchg64.c
new file mode 100644
index 000000000000..239c43d05d00
--- /dev/null
+++ b/lib/cmpxchg64.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic implementation of cmpxchg64().
+ * Derived from implementation in arch/sparc/lib/atomic32.c
+ * and from locking code implemented in lib/atomic32.c.
+ */
+
+#include <linux/cache.h>
+#include <linux/export.h>
+#include <linux/irqflags.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+/*
+ * We use a hashed array of spinlocks to provide exclusive access
+ * to each variable. Since this is expected to used on systems
+ * with small numbers of CPUs (<= 4 or so), we use a relatively
+ * small array of 16 spinlocks to avoid wasting too much memory
+ * on the spinlock array.
+ */
+#define NR_LOCKS	16
+
+/* Ensure that each lock is in a separate cacheline */
+static union {
+	raw_spinlock_t lock;
+	char pad[L1_CACHE_BYTES];
+} cmpxchg_lock[NR_LOCKS] __cacheline_aligned_in_smp = {
+	[0 ... (NR_LOCKS - 1)] = {
+		.lock =  __RAW_SPIN_LOCK_UNLOCKED(cmpxchg_lock.lock),
+	},
+};
+
+static inline raw_spinlock_t *lock_addr(const u64 *v)
+{
+	unsigned long addr = (unsigned long) v;
+
+	addr >>= L1_CACHE_SHIFT;
+	addr ^= (addr >> 8) ^ (addr >> 16);
+	return &cmpxchg_lock[addr & (NR_LOCKS - 1)].lock;
+}
+
+/*
+ * Generic version of __cmpxchg_u64, to be used for cmpxchg64().
+ * Takes u64 parameters.
+ */
+u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new)
+{
+	raw_spinlock_t *lock = lock_addr(ptr);
+	unsigned long flags;
+	u64 prev;
+
+	raw_spin_lock_irqsave(lock, flags);
+	prev = READ_ONCE(*ptr);
+	if (prev == old)
+		*ptr = new;
+	raw_spin_unlock_irqrestore(lock, flags);
+
+	return prev;
+}
+EXPORT_SYMBOL(__cmpxchg_u64);
-- 
2.7.4

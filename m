Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Nov 2018 09:46:25 +0100 (CET)
Received: from mail-pg1-x543.google.com ([IPv6:2607:f8b0:4864:20::543]:43391
        "EHLO mail-pg1-x543.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994560AbeK2Iog3lMNm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Nov 2018 09:44:36 +0100
Received: by mail-pg1-x543.google.com with SMTP id v28so601620pgk.10
        for <linux-mips@linux-mips.org>; Thu, 29 Nov 2018 00:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Iv3uvd/8GGpDFirXpjc3vER/MPei2h7zauZi6b90c1I=;
        b=jyZuAv09R6wijhBx9CK8mWoJ/ds5+UaXk0SmycM1FGvtME0bSWiyv9p42kQkxvkKdU
         b/7gCyXULIQGwXHa4VLiiDGJKA/2veIT3gCZMJAdqG/1n64cBAv0r5LeIa5u8nN3XWRh
         opXksls1QzpBh5GYymLTvsPg3OXeSEAU6Avy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Iv3uvd/8GGpDFirXpjc3vER/MPei2h7zauZi6b90c1I=;
        b=NfCI61f/gOL2V9QkUd85Iz9UYQiJyl7Geu/eHuZtHq/djaMnwD9FDRxpzpSTg+cfFH
         Qyv4Zbw+nXuroE1A0LpFwsLLipbb/4FxJ7JOkqtaKuhUZgONLbKDeE3HVkVml2c4y7Xi
         uBbndIlRkTTGCzDoYFIzuxlxFVeg0MJMSrJOqV1qA7nLsL5NGivPIviX4VFgT99D7qmY
         11HNV93JTq+pQkNZBWDDtHh07xDk8XHyY5L9n7nKt+fEoIsbAjmWf7TIDCunOjicC0tN
         iO8AjNrsVbgrdx0i1dFVbhdBaV+Ew7hWTeU6ONb1L+JnhZNdpZVx9lihZdXSiI7zHjD/
         +wUA==
X-Gm-Message-State: AA+aEWawLgWvRasC/nI1USPQPIqzhpoZkK/LpIO8BqBV/79MxCpOT8w8
        Jaa9pbZX4gozaQwWySxIOHXpUifpCOE=
X-Google-Smtp-Source: AFSGD/WecOi4KwCj1EosXDPIFemodkFYvt7KtNafsrO+6UFtfmQ0Dpcb0Lai1VX0TBHfqnE9pSrmuA==
X-Received: by 2002:a63:200e:: with SMTP id g14mr475762pgg.235.1543481075482;
        Thu, 29 Nov 2018 00:44:35 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 73-v6sm2322683pfl.142.2018.11.29.00.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Nov 2018 00:44:34 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org,
        firoz.khan@linaro.org
Subject: [PATCH v3 3/6] mips: add +1 to __NR_syscalls in uapi header
Date:   Thu, 29 Nov 2018 14:13:33 +0530
Message-Id: <1543481016-18500-4-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
Return-Path: <firoz.khan@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: firoz.khan@linaro.org
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

All other architectures are hold a value for __NR_syscalls will
be equal to the last system call number +1.

But in mips architecture, __NR_syscalls hold the value equal to
total number of system exits in the architecture. One of the
patch in this patch series will genarate uapi header files.

In order to make the implementation common across all architect-
ures, add +1 to __NR_syscalls, which will be equal to the last
system call number +1.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/mips/include/uapi/asm/unistd.h | 12 ++++++------
 arch/mips/kernel/ftrace.c           |  6 +++---
 arch/mips/kernel/scall32-o32.S      |  4 ++--
 arch/mips/kernel/scall64-64.S       |  2 +-
 arch/mips/kernel/scall64-n32.S      |  4 ++--
 arch/mips/kernel/scall64-o32.S      |  6 +++---
 6 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index 6914be5..dac1335 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -392,7 +392,7 @@
 #define __NR_io_pgetevents		(__NR_Linux + 368)
 
 #ifdef __KERNEL__
-#define __NR_syscalls			368
+#define __NR_syscalls			369
 #endif
 
 /*
@@ -403,7 +403,7 @@
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		368
+#define __NR_O32_Linux_syscalls		369
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -742,7 +742,7 @@
 #define __NR_io_pgetevents		(__NR_Linux + 328)
 
 #ifdef __KERNEL__
-#define __NR_syscalls			328
+#define __NR_syscalls			329
 #endif
 
 /*
@@ -753,7 +753,7 @@
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		328
+#define __NR_64_Linux_syscalls		329
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -1096,7 +1096,7 @@
 #define __NR_io_pgetevents		(__NR_Linux + 332)
 
 #ifdef __KERNEL__
-#define __NR_syscalls			332
+#define __NR_syscalls			333
 #endif
 
 /*
@@ -1107,6 +1107,6 @@
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		332
+#define __NR_N32_Linux_syscalls		333
 
 #endif /* _UAPI_ASM_UNISTD_H */
diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 7f3dfdb..f32caaf 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -410,13 +410,13 @@ unsigned long __init arch_syscall_addr(int nr)
 unsigned long __init arch_syscall_addr(int nr)
 {
 #ifdef CONFIG_MIPS32_N32
-	if (nr >= __NR_N32_Linux && nr <= __NR_N32_Linux + __NR_N32_Linux_syscalls)
+	if (nr >= __NR_N32_Linux && nr < __NR_N32_Linux + __NR_N32_Linux_syscalls)
 		return (unsigned long)sysn32_call_table[nr - __NR_N32_Linux];
 #endif
-	if (nr >= __NR_64_Linux  && nr <= __NR_64_Linux + __NR_64_Linux_syscalls)
+	if (nr >= __NR_64_Linux  && nr < __NR_64_Linux + __NR_64_Linux_syscalls)
 		return (unsigned long)sys_call_table[nr - __NR_64_Linux];
 #ifdef CONFIG_MIPS32_O32
-	if (nr >= __NR_O32_Linux && nr <= __NR_O32_Linux + __NR_O32_Linux_syscalls)
+	if (nr >= __NR_O32_Linux && nr < __NR_O32_Linux + __NR_O32_Linux_syscalls)
 		return (unsigned long)sys32_call_table[nr - __NR_O32_Linux];
 #endif
 
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index fea6edb..10f6367 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -86,7 +86,7 @@ loads_done:
 	bnez	t0, syscall_trace_entry # -> yes
 syscall_common:
 	subu	v0, v0, __NR_O32_Linux	# check syscall number
-	sltiu	t0, v0, __NR_O32_Linux_syscalls + 1
+	sltiu	t0, v0, __NR_O32_Linux_syscalls
 	beqz	t0, illegal_syscall
 
 	sll	t0, v0, 2
@@ -182,7 +182,7 @@ illegal_syscall:
 
 	LEAF(sys_syscall)
 	subu	t0, a0, __NR_O32_Linux	# check syscall number
-	sltiu	v0, t0, __NR_O32_Linux_syscalls + 1
+	sltiu	v0, t0, __NR_O32_Linux_syscalls
 	beqz	t0, einval		# do not recurse
 	sll	t1, t0, 2
 	beqz	v0, einval
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index 358d959..0b67fed 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -54,7 +54,7 @@ NESTED(handle_sys64, PT_SIZE, sp)
 
 syscall_common:
 	dsubu	t2, v0, __NR_64_Linux
-	sltiu   t0, t2, __NR_64_Linux_syscalls + 1
+	sltiu   t0, t2, __NR_64_Linux_syscalls
 	beqz	t0, illegal_syscall
 
 	dsll	t0, t2, 3		# offset into table
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index c65eaac..6468546 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -33,7 +33,7 @@ NESTED(handle_sysn32, PT_SIZE, sp)
 #endif
 
 	dsubu	t0, v0, __NR_N32_Linux	# check syscall number
-	sltiu	t0, t0, __NR_N32_Linux_syscalls + 1
+	sltiu	t0, t0, __NR_N32_Linux_syscalls
 
 #ifndef CONFIG_MIPS32_O32
 	ld	t1, PT_EPC(sp)		# skip syscall on return
@@ -87,7 +87,7 @@ n32_syscall_trace_entry:
 	ld	a5, PT_R9(sp)
 
 	dsubu	t2, v0, __NR_N32_Linux	# check (new) syscall number
-	sltiu   t0, t2, __NR_N32_Linux_syscalls + 1
+	sltiu   t0, t2, __NR_N32_Linux_syscalls
 	beqz	t0, not_n32_scall
 
 	j	syscall_common
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 73913f0..eb53d8ea 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -34,7 +34,7 @@ NESTED(handle_sys, PT_SIZE, sp)
 	ld	t1, PT_EPC(sp)		# skip syscall on return
 
 	dsubu	t0, v0, __NR_O32_Linux	# check syscall number
-	sltiu	t0, t0, __NR_O32_Linux_syscalls + 1
+	sltiu	t0, t0, __NR_O32_Linux_syscalls
 	daddiu	t1, 4			# skip to next instruction
 	sd	t1, PT_EPC(sp)
 	beqz	t0, not_o32_scall
@@ -144,7 +144,7 @@ trace_a_syscall:
 	ld	a7, PT_R11(sp)		# For indirect syscalls
 
 	dsubu	t0, v0, __NR_O32_Linux	# check (new) syscall number
-	sltiu	t0, t0, __NR_O32_Linux_syscalls + 1
+	sltiu	t0, t0, __NR_O32_Linux_syscalls
 	beqz	t0, not_o32_scall
 
 	j	syscall_common
@@ -193,7 +193,7 @@ not_o32_scall:
 
 LEAF(sys32_syscall)
 	subu	t0, a0, __NR_O32_Linux	# check syscall number
-	sltiu	v0, t0, __NR_O32_Linux_syscalls + 1
+	sltiu	v0, t0, __NR_O32_Linux_syscalls
 	beqz	t0, einval		# do not recurse
 	dsll	t1, t0, 3
 	beqz	v0, einval
-- 
1.9.1

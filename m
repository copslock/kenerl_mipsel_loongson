Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Dec 2017 09:52:19 +0100 (CET)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:37813
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990656AbdL0IvKAKSFM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Dec 2017 09:51:10 +0100
Received: by mail-wm0-x243.google.com with SMTP id f140so38110368wmd.2
        for <linux-mips@linux-mips.org>; Wed, 27 Dec 2017 00:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lwLLrS7mueZ/zWj6YdhKL1lPIayLUTMzei7H77VCkQk=;
        b=QtJm4zXVhuLpsXWoyJuUQkhle/5dXy0JI2WcpXmhBquEjre0C3BUPD5ch/f18mczrf
         DiLO3OML2FGRfJ8GotRLc7hdIbjGDa2Qbkl4gX/eiHwmkj4/1YkM4Ig4gS7IqJTnbFTL
         WjUFiGZM9AzmnZmYJOL1Yzn18Jf3xY0BnuVrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lwLLrS7mueZ/zWj6YdhKL1lPIayLUTMzei7H77VCkQk=;
        b=LLxWK1bkddaspdYubrNaNFmQ+84vnR9y3ae4UsmtqClr3HStpmBxfN55IXrHQg4zuJ
         4RefoCi9FIBBmOUiI2R2snVWLINyzviKZWt2IPS/FVDbKjv2Q988ErVqE48RpviJitCS
         G/eJy65RSwZkSlPiMBxOJnwhJRhuR4GRyfXDeNybY1PJbpyyTn1UgkiULNU9GcKL+ZKp
         5gT1BxIpbps3ZornsQtkgc+uGtzhFES9vRN9LnBTHtR86thQOmV8ZNBxYOcn6A7+LeWO
         LqMMF5xA3satRVXkpy8HmZSPNCOsgcBk7mTkPmeZQ9pkiBWucbcS1Tc9KpNbG5Ffi0D+
         sA2g==
X-Gm-Message-State: AKGB3mIkO2x8xDiduAS/FQphCOWwOvlLPPdPFmAN5Lnyv00ZSF0Bcmy9
        jW4OtJ5Q2j5LVMERgw/UEvJcWg==
X-Google-Smtp-Source: ACJfBot0inkAlmr5FQIjJNTM1vazAQDEswgp3dZpbx+Oj3HOtYfLH/QszPwIXDUOH92Dd/WcC2BeBg==
X-Received: by 10.28.160.23 with SMTP id j23mr21304907wme.54.1514364664371;
        Wed, 27 Dec 2017 00:51:04 -0800 (PST)
Received: from localhost.localdomain ([105.137.110.132])
        by smtp.gmail.com with ESMTPSA id q74sm32677226wmg.22.2017.12.27.00.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2017 00:51:03 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell King <linux@armlinux.org.uk>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
        James Morris <james.l.morris@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nico@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org
Subject: [PATCH v6 3/8] init: allow initcall tables to be emitted using relative references
Date:   Wed, 27 Dec 2017 08:50:28 +0000
Message-Id: <20171227085033.22389-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ard.biesheuvel@linaro.org
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

Allow the initcall tables to be emitted using relative references that
are only half the size on 64-bit architectures and don't require fixups
at runtime on relocatable kernels.

Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: James Morris <james.l.morris@oracle.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/linux/init.h   | 44 +++++++++++++++-----
 init/main.c            | 32 +++++++-------
 kernel/printk/printk.c |  4 +-
 security/security.c    |  4 +-
 4 files changed, 53 insertions(+), 31 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index ea1b31101d9e..125bbea99c6b 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -109,8 +109,24 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
-extern initcall_t __con_initcall_start[], __con_initcall_end[];
-extern initcall_t __security_initcall_start[], __security_initcall_end[];
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+typedef signed int initcall_entry_t;
+
+static inline initcall_t initcall_from_entry(initcall_entry_t *entry)
+{
+	return (initcall_t)((unsigned long)entry + *entry);
+}
+#else
+typedef initcall_t initcall_entry_t;
+
+static inline initcall_t initcall_from_entry(initcall_entry_t *entry)
+{
+	return *entry;
+}
+#endif
+
+extern initcall_entry_t __con_initcall_start[], __con_initcall_end[];
+extern initcall_entry_t __security_initcall_start[], __security_initcall_end[];
 
 /* Used for contructor calls. */
 typedef void (*ctor_fn_t)(void);
@@ -160,9 +176,20 @@ extern bool initcall_debug;
  * as KEEP() in the linker script.
  */
 
-#define __define_initcall(fn, id) \
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+#define ___define_initcall(fn, id, __sec)			\
+	__ADDRESSABLE(fn)					\
+	asm(".section	\"" #__sec ".init\", \"a\"	\n"	\
+	"__initcall_" #fn #id ":			\n"	\
+	    ".long "	VMLINUX_SYMBOL_STR(fn) " - .	\n"	\
+	    ".previous					\n");
+#else
+#define ___define_initcall(fn, id, __sec) \
 	static initcall_t __initcall_##fn##id __used \
-	__attribute__((__section__(".initcall" #id ".init"))) = fn;
+		__attribute__((__section__(#__sec ".init"))) = fn;
+#endif
+
+#define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
 
 /*
  * Early initcalls run before initializing SMP.
@@ -201,13 +228,8 @@ extern bool initcall_debug;
 #define __exitcall(fn)						\
 	static exitcall_t __exitcall_##fn __exit_call = fn
 
-#define console_initcall(fn)					\
-	static initcall_t __initcall_##fn			\
-	__used __section(.con_initcall.init) = fn
-
-#define security_initcall(fn)					\
-	static initcall_t __initcall_##fn			\
-	__used __section(.security_initcall.init) = fn
+#define console_initcall(fn)	___define_initcall(fn,, .con_initcall)
+#define security_initcall(fn)	___define_initcall(fn,, .security_initcall)
 
 struct obs_kernel_param {
 	const char *str;
diff --git a/init/main.c b/init/main.c
index 7b606fc48482..2cbe3c2804ab 100644
--- a/init/main.c
+++ b/init/main.c
@@ -845,18 +845,18 @@ int __init_or_module do_one_initcall(initcall_t fn)
 }
 
 
-extern initcall_t __initcall_start[];
-extern initcall_t __initcall0_start[];
-extern initcall_t __initcall1_start[];
-extern initcall_t __initcall2_start[];
-extern initcall_t __initcall3_start[];
-extern initcall_t __initcall4_start[];
-extern initcall_t __initcall5_start[];
-extern initcall_t __initcall6_start[];
-extern initcall_t __initcall7_start[];
-extern initcall_t __initcall_end[];
-
-static initcall_t *initcall_levels[] __initdata = {
+extern initcall_entry_t __initcall_start[];
+extern initcall_entry_t __initcall0_start[];
+extern initcall_entry_t __initcall1_start[];
+extern initcall_entry_t __initcall2_start[];
+extern initcall_entry_t __initcall3_start[];
+extern initcall_entry_t __initcall4_start[];
+extern initcall_entry_t __initcall5_start[];
+extern initcall_entry_t __initcall6_start[];
+extern initcall_entry_t __initcall7_start[];
+extern initcall_entry_t __initcall_end[];
+
+static initcall_entry_t *initcall_levels[] __initdata = {
 	__initcall0_start,
 	__initcall1_start,
 	__initcall2_start,
@@ -882,7 +882,7 @@ static char *initcall_level_names[] __initdata = {
 
 static void __init do_initcall_level(int level)
 {
-	initcall_t *fn;
+	initcall_entry_t *fn;
 
 	strcpy(initcall_command_line, saved_command_line);
 	parse_args(initcall_level_names[level],
@@ -892,7 +892,7 @@ static void __init do_initcall_level(int level)
 		   NULL, &repair_env_string);
 
 	for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
-		do_one_initcall(*fn);
+		do_one_initcall(initcall_from_entry(fn));
 }
 
 static void __init do_initcalls(void)
@@ -923,10 +923,10 @@ static void __init do_basic_setup(void)
 
 static void __init do_pre_smp_initcalls(void)
 {
-	initcall_t *fn;
+	initcall_entry_t *fn;
 
 	for (fn = __initcall_start; fn < __initcall0_start; fn++)
-		do_one_initcall(*fn);
+		do_one_initcall(initcall_from_entry(fn));
 }
 
 /*
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b9006617710f..0516005261c7 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2611,7 +2611,7 @@ EXPORT_SYMBOL(unregister_console);
  */
 void __init console_init(void)
 {
-	initcall_t *call;
+	initcall_entry_t *call;
 
 	/* Setup the default TTY line discipline. */
 	n_tty_init();
@@ -2622,7 +2622,7 @@ void __init console_init(void)
 	 */
 	call = __con_initcall_start;
 	while (call < __con_initcall_end) {
-		(*call)();
+		initcall_from_entry(call)();
 		call++;
 	}
 }
diff --git a/security/security.c b/security/security.c
index 1cd8526cb0b7..f648eeff06de 100644
--- a/security/security.c
+++ b/security/security.c
@@ -45,10 +45,10 @@ static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 
 static void __init do_security_initcalls(void)
 {
-	initcall_t *call;
+	initcall_entry_t *call;
 	call = __security_initcall_start;
 	while (call < __security_initcall_end) {
-		(*call) ();
+		initcall_from_entry(call)();
 		call++;
 	}
 }
-- 
2.11.0

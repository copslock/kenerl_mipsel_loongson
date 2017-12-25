Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Dec 2017 21:57:33 +0100 (CET)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:39708
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990493AbdLYUzpfeq8N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Dec 2017 21:55:45 +0100
Received: by mail-wr0-x244.google.com with SMTP id o101so4775783wrb.6
        for <linux-mips@linux-mips.org>; Mon, 25 Dec 2017 12:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FeRUkMrB+h9OzAG6tsXZHgHhFJKOYm9CVFNsKuS7D+M=;
        b=Q1HREJftT2aZs/JqWZHOsaU2Z+TagXl6eJx5d8qWSHZLETi/xqSxljw9g7z/0zATGE
         duUGBNR37ud1cZgQ+9l7EbvqnYeqHzsK4SsA2kf1hhrWK+rl77iGjFYfxJozrsjDhnwN
         bXow+s9jmxFGkTsydCr38z9kopa8/WalpD6Z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FeRUkMrB+h9OzAG6tsXZHgHhFJKOYm9CVFNsKuS7D+M=;
        b=FxFD7Nw7F6TbZicKFgwZBO4gYFoX8oLzJjFXHCaCbKXZ2lqz8MpNYcbTr2PnIywFk8
         wt22WpkXSECux7k+aaz+yQGG9IjtCrC8CuNrWebVrroMDzkkWKejV7D9BsbVwS2wwpwz
         3GFpfTu/GJQdHfLSkOeWDXSSts5yr1jQqnUh/o0wO093kb1i/i9sTreD2GpuT+goEIlv
         QZT/kHtRfjTVxwI4uau/NKBTyq18tgB1PG3KVxoYphhRNeYSaXR5j7haSl8LBQEQfznq
         MVcGzaPH/92cn9Pt7IwPldZylvWjjOVUWUMokawIWnBMpZB1J89wIDCgyNSC4lYsT225
         SOkA==
X-Gm-Message-State: AKGB3mLeEBxvqfR+dvT0CJ4j0ytXTIVMJvEWXzjat9khv658j4naMLht
        VKtuF2VTBWSaJts4SKSdQB6BzA==
X-Google-Smtp-Source: ACJfBoteICRvaVw9H9mJJrSL01+aQZvdzUzxu8wJD6cpdtXwoYC93Xxnvuqng/n5TPl+pbzXvxrMJg==
X-Received: by 10.223.145.230 with SMTP id 93mr21913104wri.190.1514235340172;
        Mon, 25 Dec 2017 12:55:40 -0800 (PST)
Received: from localhost.localdomain ([160.171.216.245])
        by smtp.gmail.com with ESMTPSA id y42sm39552441wrc.96.2017.12.25.12.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Dec 2017 12:55:39 -0800 (PST)
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
Subject: [PATCH v5 5/8] kernel: tracepoints: add support for relative references
Date:   Mon, 25 Dec 2017 20:54:37 +0000
Message-Id: <20171225205440.14575-6-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171225205440.14575-1-ard.biesheuvel@linaro.org>
References: <20171225205440.14575-1-ard.biesheuvel@linaro.org>
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61576
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

To avoid the need for relocating absolute references to tracepoint
structures at boot time when running relocatable kernels (which may
take a disproportionate amount of space), add the option to emit
these tables as relative references instead.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/linux/tracepoint.h | 19 ++++++--
 kernel/tracepoint.c        | 50 +++++++++++---------
 2 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index a26ffbe09e71..d02bf1a695e8 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -228,6 +228,19 @@ extern void syscall_unregfunc(void);
 		return static_key_false(&__tracepoint_##name.key);	\
 	}
 
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+#define __TRACEPOINT_ENTRY(name)					 \
+	asm("	.section \"__tracepoints_ptrs\", \"a\"		     \n" \
+	    "	.balign 4					     \n" \
+	    "	.long " VMLINUX_SYMBOL_STR(__tracepoint_##name) " - .\n" \
+	    "	.previous					     \n")
+#else
+#define __TRACEPOINT_ENTRY(name)					 \
+	static struct tracepoint * const __tracepoint_ptr_##name __used	 \
+	__attribute__((section("__tracepoints_ptrs"))) =		 \
+		&__tracepoint_##name
+#endif
+
 /*
  * We have no guarantee that gcc and the linker won't up-align the tracepoint
  * structures, so we create an array of pointers that will be used for iteration
@@ -237,11 +250,9 @@ extern void syscall_unregfunc(void);
 	static const char __tpstrtab_##name[]				 \
 	__attribute__((section("__tracepoints_strings"))) = #name;	 \
 	struct tracepoint __tracepoint_##name				 \
-	__attribute__((section("__tracepoints"))) =			 \
+	__attribute__((section("__tracepoints"), used)) =		 \
 		{ __tpstrtab_##name, STATIC_KEY_INIT_FALSE, reg, unreg, NULL };\
-	static struct tracepoint * const __tracepoint_ptr_##name __used	 \
-	__attribute__((section("__tracepoints_ptrs"))) =		 \
-		&__tracepoint_##name;
+	__TRACEPOINT_ENTRY(name);
 
 #define DEFINE_TRACE(name)						\
 	DEFINE_TRACE_FN(name, NULL, NULL);
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 685c50ae6300..05649fef106c 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -327,6 +327,28 @@ int tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *data)
 }
 EXPORT_SYMBOL_GPL(tracepoint_probe_unregister);
 
+static void for_each_tracepoint_range(struct tracepoint * const *begin,
+		struct tracepoint * const *end,
+		void (*fct)(struct tracepoint *tp, void *priv),
+		void *priv)
+{
+	if (!begin)
+		return;
+
+	if (IS_ENABLED(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)) {
+		const int *iter;
+
+		for (iter = (const int *)begin; iter < (const int *)end; iter++)
+			fct((struct tracepoint *)((unsigned long)iter + *iter),
+			    priv);
+	} else {
+		struct tracepoint * const *iter;
+
+		for (iter = begin; iter < end; iter++)
+			fct(*iter, priv);
+	}
+}
+
 #ifdef CONFIG_MODULES
 bool trace_module_has_bad_taint(struct module *mod)
 {
@@ -391,15 +413,9 @@ EXPORT_SYMBOL_GPL(unregister_tracepoint_module_notifier);
  * Ensure the tracer unregistered the module's probes before the module
  * teardown is performed. Prevents leaks of probe and data pointers.
  */
-static void tp_module_going_check_quiescent(struct tracepoint * const *begin,
-		struct tracepoint * const *end)
+static void tp_module_going_check_quiescent(struct tracepoint *tp, void *priv)
 {
-	struct tracepoint * const *iter;
-
-	if (!begin)
-		return;
-	for (iter = begin; iter < end; iter++)
-		WARN_ON_ONCE((*iter)->funcs);
+	WARN_ON_ONCE(tp->funcs);
 }
 
 static int tracepoint_module_coming(struct module *mod)
@@ -450,8 +466,9 @@ static void tracepoint_module_going(struct module *mod)
 			 * Called the going notifier before checking for
 			 * quiescence.
 			 */
-			tp_module_going_check_quiescent(mod->tracepoints_ptrs,
-				mod->tracepoints_ptrs + mod->num_tracepoints);
+			for_each_tracepoint_range(mod->tracepoints_ptrs,
+				mod->tracepoints_ptrs + mod->num_tracepoints,
+				tp_module_going_check_quiescent, NULL);
 			break;
 		}
 	}
@@ -503,19 +520,6 @@ static __init int init_tracepoints(void)
 __initcall(init_tracepoints);
 #endif /* CONFIG_MODULES */
 
-static void for_each_tracepoint_range(struct tracepoint * const *begin,
-		struct tracepoint * const *end,
-		void (*fct)(struct tracepoint *tp, void *priv),
-		void *priv)
-{
-	struct tracepoint * const *iter;
-
-	if (!begin)
-		return;
-	for (iter = begin; iter < end; iter++)
-		fct(*iter, priv);
-}
-
 /**
  * for_each_kernel_tracepoint - iteration on all kernel tracepoints
  * @fct: callback
-- 
2.11.0

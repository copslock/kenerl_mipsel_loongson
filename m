Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Dec 2017 09:53:06 +0100 (CET)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:46978
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990793AbdL0IvV6NvDM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Dec 2017 09:51:21 +0100
Received: by mail-wr0-x244.google.com with SMTP id g17so26988228wrd.13
        for <linux-mips@linux-mips.org>; Wed, 27 Dec 2017 00:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FeRUkMrB+h9OzAG6tsXZHgHhFJKOYm9CVFNsKuS7D+M=;
        b=C0bXnKbkb3eJ2wpcGYBYzKmS7OKKVzqXvhGL+TE/Uy7dsuLNclfxKdtFgpHGQgKloY
         Zs4iWMSBuMsqiYFGCw7m1R4DbRiqKG1NW7f82TFyG7d1QwH3ewhZOSt0KdSM89TLjK2S
         iuQ8d9gZaTRU5K3xKVmzRGBFzahnqD72bpvu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FeRUkMrB+h9OzAG6tsXZHgHhFJKOYm9CVFNsKuS7D+M=;
        b=g2ECi7Ao1EkaeK4BQ/TMK3+94KEDHntMeStnweZnf/UD3jmEIAL5N8Mb+l31aCjidZ
         75zQNe6MeWx1LVhUDfJp8ONFZIJ+SobhS6nLUr1PE7F8VUAb85clpl0BLgpJu7qjAHmz
         Qs2GLD8wfS8lYnA84Gql8mxcB0ul5R/ySwUqnMRoSnR6eaWtjsTgWRD4HCDTNDSWDdF/
         PA8vG+v3ArS/nL2fkXBZIsLSVd9lOWKDiJ/Cu0X0ultPjhUSdOLStHIia0DJgE5a3a8J
         dPTGq76ENQndo3vrqWDwyX29QLTKrZ+QbBZuvKiVyyF8HlyAUCskh3FP7+NULWfbYK2c
         HgwQ==
X-Gm-Message-State: AKGB3mIOQPFXkA1Hbid8P5RpMyFM6IjHfT/S2B4puQq3MEwz2neWtU+m
        Ms3MdTC7X+6b58RcHynMcY1TLQ==
X-Google-Smtp-Source: ACJfBotPYcUkpp9QgM+n2CesL6D42KsifP3LrOWmLEm8zOiNYsD4JqsoiqQpi0iCnTqCqnH483uEHw==
X-Received: by 10.223.136.118 with SMTP id e51mr28244488wre.21.1514364676546;
        Wed, 27 Dec 2017 00:51:16 -0800 (PST)
Received: from localhost.localdomain ([105.137.110.132])
        by smtp.gmail.com with ESMTPSA id q74sm32677226wmg.22.2017.12.27.00.51.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2017 00:51:15 -0800 (PST)
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
Subject: [PATCH v6 5/8] kernel: tracepoints: add support for relative references
Date:   Wed, 27 Dec 2017 08:50:30 +0000
Message-Id: <20171227085033.22389-6-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61622
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

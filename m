Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 21:07:19 +0100 (CET)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:45090
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992645AbeABUG3xBW8J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 21:06:29 +0100
Received: by mail-wm0-x244.google.com with SMTP id 9so62960360wme.4
        for <linux-mips@linux-mips.org>; Tue, 02 Jan 2018 12:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9pf2nmv48uHqsDbsl+hfOY5WaUyvrm1nnNGc9/9m6Qg=;
        b=JvakjjXXh2ftac/uQdStpmRnyog8dVy1B1dV3/FBRYhclGcwN1Nf1ULl77WmER9ry4
         qNvpqUIkOxaXMPtj6B3oJYPN87PgdaiNOi0rNpCB5XAS3BaMGwa31IA7QPoscn3u7sb0
         uOQNLx6iterfuYqWKriCvDY/4G6QygREzc7s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9pf2nmv48uHqsDbsl+hfOY5WaUyvrm1nnNGc9/9m6Qg=;
        b=ULuXmJv8vVkCPvC3IO1pQuNJrLL3Cz3rUoBmiaJqGyT3okYyVA3KSZQ3zm2jfvVlNx
         XzxL5RC92t3OFDRgJmgo11ZsFeLwlxDXmOxv8LkYabg39734Mj8ZZ0t+0iFC6s6ELaNn
         Y4HL9JISdKi9WRQR7Kp7iWkYkcf2QL62PyxQ0smFaCFwQx4GomYvZX98RPcSNf9UbBfQ
         vStF+TtAghqqOElTrdHvUzGUiZaa83dt9Yrzs95dyDvsvIKcp5q9gk/oowpdSq+2I0oQ
         Z64jQyglgH3HcL/Q4RKW2abHmQszJvvIZRHDFDlK1K8Xx1n2RShBg7W/5WJ0m2CmeU+w
         nk6A==
X-Gm-Message-State: AKGB3mIz0AIu9CeRPRQOU5GUwdtGK2dfblnCiEit2RnBgyUhWDrqBYHA
        0mtgAYDMZOZ+QtVVSOP5rfCbcQ==
X-Google-Smtp-Source: ACJfBosJ1YaW1H55WuPG4HZVNPR5sIYnqVBwvoCMpxmVYCKJYkCCK0WTpzNAV4SV0UZHkdO9ReayGQ==
X-Received: by 10.28.97.194 with SMTP id v185mr11849434wmb.21.1514923584444;
        Tue, 02 Jan 2018 12:06:24 -0800 (PST)
Received: from localhost.localdomain ([160.89.138.198])
        by smtp.gmail.com with ESMTPSA id m70sm19128526wma.36.2018.01.02.12.06.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jan 2018 12:06:23 -0800 (PST)
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
        sparclinux@vger.kernel.org, x86@kernel.org,
        matt@codeblueprint.co.uk
Subject: [PATCH v7 02/10] module: allow symbol exports to be disabled
Date:   Tue,  2 Jan 2018 20:05:41 +0000
Message-Id: <20180102200549.22984-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
References: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61869
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

To allow existing C code to be incorporated into the decompressor or
the UEFI stub, introduce a CPP macro that turns all EXPORT_SYMBOL_xxx
declarations into nops, and #define it in places where such exports
are undesirable. Note that this gets rid of a rather dodgy redefine
of linux/export.h's header guard.

Cc: matt@codeblueprint.co.uk
Cc: keescook@chromium.org
Cc: jeyu@kernel.org
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/boot/compressed/kaslr.c      | 5 +----
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 include/linux/export.h                | 9 +++++++++
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 8199a6187251..3a2a6d7049e4 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -23,11 +23,8 @@
  * _ctype[] in lib/ctype.c is needed by isspace() of linux/ctype.h.
  * While both lib/ctype.c and lib/cmdline.c will bring EXPORT_SYMBOL
  * which is meaningless and will cause compiling error in some cases.
- * So do not include linux/export.h and define EXPORT_SYMBOL(sym)
- * as empty.
  */
-#define _LINUX_EXPORT_H
-#define EXPORT_SYMBOL(sym)
+#define __DISABLE_EXPORTS
 
 #include "misc.h"
 #include "error.h"
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index adaa4a964f0c..312bd0b64a61 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -20,7 +20,8 @@ cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
 KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
 				   -D__NO_FORTIFY \
 				   $(call cc-option,-ffreestanding) \
-				   $(call cc-option,-fno-stack-protector)
+				   $(call cc-option,-fno-stack-protector) \
+				   -D__DISABLE_EXPORTS
 
 GCOV_PROFILE			:= n
 KASAN_SANITIZE			:= n
diff --git a/include/linux/export.h b/include/linux/export.h
index 1a1dfdb2a5c6..6dba2fb08f77 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -83,6 +83,15 @@ extern struct module __this_module;
  */
 #define __EXPORT_SYMBOL(sym, sec)	=== __KSYM_##sym ===
 
+#elif defined(__DISABLE_EXPORTS)
+
+/*
+ * Allow symbol exports to be disabled completely so that C code may
+ * be reused in other execution contexts such as the UEFI stub or the
+ * decompressor.
+ */
+#define __EXPORT_SYMBOL(sym, sec)
+
 #elif defined(CONFIG_TRIM_UNUSED_KSYMS)
 
 #include <generated/autoksyms.h>
-- 
2.11.0

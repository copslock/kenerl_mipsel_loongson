Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Dec 2017 21:58:56 +0100 (CET)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:38272
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992078AbdLYU4Erwf6N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Dec 2017 21:56:04 +0100
Received: by mail-wr0-x244.google.com with SMTP id o2so33422348wro.5
        for <linux-mips@linux-mips.org>; Mon, 25 Dec 2017 12:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zBo/6EncMhQE+u7uWHtusHrsjwb/Xhu+WleYCGKp7Zw=;
        b=AxFic8owS7Txq/CoSk0ELyr/8b7BGd7fSyXQ9DlBk9MPsWiEou3HkctdCK6fs9CWfj
         9xFtvULW+K1SeXe3CEYaIajB4EIvNe7qVXxxbAL0bv4kdtmVfqu9eUh7UIVpWwuyN+KF
         Tm2A7kVu731KOVGTPGaB49PbIzknFoAdFSDVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zBo/6EncMhQE+u7uWHtusHrsjwb/Xhu+WleYCGKp7Zw=;
        b=s/UN818QDu8OK+3h0obCb6V2DUEK8MChvabdbShTRzvRP5lDZWXd+HVbH8iTfoC/Sa
         P9nsvpIChTEf5m9jt8e5+fItsEKQF0lZvp3Erp0rCHfWjqkX5D4ct5uHQ2E+WtcSS22I
         hNSqtp2KBxLMyKuA9qCKylnuAKTa2piWDIS6SinI7qtHXzidEqJ8W0tiRsvtlrIIg2jS
         LGjolDrjnIWcn6alK7xD6iDeFRGOHDZ+4Q0qr4NDK1P+wscTegGsMDiDAhH6S6xadHgx
         g9DSuvKZuxfN+U7bsXkCzCHwLg+80SQijlTZetsa+J2xah6SjPqn+e4mUZYxM2wPLDAz
         vAQA==
X-Gm-Message-State: AKGB3mJ+t54Mj8ElCOGRZM9WezMptfbuByALjF4hCURUAmvui7HBDOWQ
        FOow0koWD4wHs6nlGr14Ma/HMw==
X-Google-Smtp-Source: ACJfBouL4MQr8U5PLojeTS0bEpACIZSfeb7CxzY5qMGdbr1Ki/cx572SMOacrjHY1mHs6O+ESTkogg==
X-Received: by 10.223.200.133 with SMTP id k5mr12885530wrh.215.1514235359354;
        Mon, 25 Dec 2017 12:55:59 -0800 (PST)
Received: from localhost.localdomain ([160.171.216.245])
        by smtp.gmail.com with ESMTPSA id y42sm39552441wrc.96.2017.12.25.12.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Dec 2017 12:55:58 -0800 (PST)
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
Subject: [PATCH v5 8/8] x86/kernel: jump_table: use relative references
Date:   Mon, 25 Dec 2017 20:54:40 +0000
Message-Id: <20171225205440.14575-9-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171225205440.14575-1-ard.biesheuvel@linaro.org>
References: <20171225205440.14575-1-ard.biesheuvel@linaro.org>
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61579
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

Similar to the arm64 case, 64-bit x86 can benefit from using 32-bit
relative references rather than 64-bit absolute ones when emitting
struct jump_entry instances. Not only does this reduce the memory
footprint of the entries themselves by 50%, it also removes the need
for carrying relocation metadata on relocatable builds (i.e., for KASLR)
which saves a fair chunk of .init space as well (although the savings
are not as dramatic as on arm64)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/include/asm/jump_label.h | 35 +++++++-----
 arch/x86/kernel/jump_label.c      | 59 ++++++++++++++------
 tools/objtool/special.c           |  4 +-
 3 files changed, 65 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 009ff2699d07..91c01af96907 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -36,8 +36,8 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 	asm_volatile_goto("1:"
 		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
 		".pushsection __jump_table,  \"aw\" \n\t"
-		_ASM_ALIGN "\n\t"
-		_ASM_PTR "1b, %l[l_yes], %c0 + %c1 \n\t"
+		".balign 4\n\t"
+		".long 1b - ., %l[l_yes] - ., %c0 + %c1 - .\n\t"
 		".popsection \n\t"
 		: :  "i" (key), "i" (branch) : : l_yes);
 
@@ -52,8 +52,8 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 		".byte 0xe9\n\t .long %l[l_yes] - 2f\n\t"
 		"2:\n\t"
 		".pushsection __jump_table,  \"aw\" \n\t"
-		_ASM_ALIGN "\n\t"
-		_ASM_PTR "1b, %l[l_yes], %c0 + %c1 \n\t"
+		".balign 4\n\t"
+		".long 1b - ., %l[l_yes] - ., %c0 + %c1 - .\n\t"
 		".popsection \n\t"
 		: :  "i" (key), "i" (branch) : : l_yes);
 
@@ -69,19 +69,26 @@ typedef u32 jump_label_t;
 #endif
 
 struct jump_entry {
-	jump_label_t code;
-	jump_label_t target;
-	jump_label_t key;
+	s32 code;
+	s32 target;
+	s32 key;
 };
 
 static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
 {
-	return entry->code;
+	return (jump_label_t)&entry->code + entry->code;
+}
+
+static inline jump_label_t jump_entry_target(const struct jump_entry *entry)
+{
+	return (jump_label_t)&entry->target + entry->target;
 }
 
 static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
 {
-	return (struct static_key *)((unsigned long)entry->key & ~1UL);
+	unsigned long key = (unsigned long)&entry->key + entry->key;
+
+	return (struct static_key *)(key & ~1UL);
 }
 
 static inline bool jump_entry_is_branch(const struct jump_entry *entry)
@@ -99,7 +106,7 @@ static inline void jump_entry_set_module_init(struct jump_entry *entry)
 	entry->code = 0;
 }
 
-#define jump_label_swap		NULL
+void jump_label_swap(void *a, void *b, int size);
 
 #else	/* __ASSEMBLY__ */
 
@@ -114,8 +121,8 @@ static inline void jump_entry_set_module_init(struct jump_entry *entry)
 	.byte		STATIC_KEY_INIT_NOP
 	.endif
 	.pushsection __jump_table, "aw"
-	_ASM_ALIGN
-	_ASM_PTR	.Lstatic_jump_\@, \target, \key
+	.balign		4
+	.long		.Lstatic_jump_\@ - ., \target - ., \key - .
 	.popsection
 .endm
 
@@ -130,8 +137,8 @@ static inline void jump_entry_set_module_init(struct jump_entry *entry)
 .Lstatic_jump_after_\@:
 	.endif
 	.pushsection __jump_table, "aw"
-	_ASM_ALIGN
-	_ASM_PTR	.Lstatic_jump_\@, \target, \key + 1
+	.balign		4
+	.long		.Lstatic_jump_\@ - ., \target - ., \key - . + 1
 	.popsection
 .endm
 
diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index e56c95be2808..cc5034b42335 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -52,22 +52,24 @@ static void __jump_label_transform(struct jump_entry *entry,
 			 * Jump label is enabled for the first time.
 			 * So we expect a default_nop...
 			 */
-			if (unlikely(memcmp((void *)entry->code, default_nop, 5)
-				     != 0))
-				bug_at((void *)entry->code, __LINE__);
+			if (unlikely(memcmp((void *)jump_entry_code(entry),
+					    default_nop, 5) != 0))
+				bug_at((void *)jump_entry_code(entry),
+				       __LINE__);
 		} else {
 			/*
 			 * ...otherwise expect an ideal_nop. Otherwise
 			 * something went horribly wrong.
 			 */
-			if (unlikely(memcmp((void *)entry->code, ideal_nop, 5)
-				     != 0))
-				bug_at((void *)entry->code, __LINE__);
+			if (unlikely(memcmp((void *)jump_entry_code(entry),
+					    ideal_nop, 5) != 0))
+				bug_at((void *)jump_entry_code(entry),
+				       __LINE__);
 		}
 
 		code.jump = 0xe9;
-		code.offset = entry->target -
-				(entry->code + JUMP_LABEL_NOP_SIZE);
+		code.offset = jump_entry_target(entry) -
+			      (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
 	} else {
 		/*
 		 * We are disabling this jump label. If it is not what
@@ -76,14 +78,18 @@ static void __jump_label_transform(struct jump_entry *entry,
 		 * are converting the default nop to the ideal nop.
 		 */
 		if (init) {
-			if (unlikely(memcmp((void *)entry->code, default_nop, 5) != 0))
-				bug_at((void *)entry->code, __LINE__);
+			if (unlikely(memcmp((void *)jump_entry_code(entry),
+					    default_nop, 5) != 0))
+				bug_at((void *)jump_entry_code(entry),
+				       __LINE__);
 		} else {
 			code.jump = 0xe9;
-			code.offset = entry->target -
-				(entry->code + JUMP_LABEL_NOP_SIZE);
-			if (unlikely(memcmp((void *)entry->code, &code, 5) != 0))
-				bug_at((void *)entry->code, __LINE__);
+			code.offset = jump_entry_target(entry) -
+				(jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
+			if (unlikely(memcmp((void *)jump_entry_code(entry),
+				     &code, 5) != 0))
+				bug_at((void *)jump_entry_code(entry),
+				       __LINE__);
 		}
 		memcpy(&code, ideal_nops[NOP_ATOMIC5], JUMP_LABEL_NOP_SIZE);
 	}
@@ -97,10 +103,13 @@ static void __jump_label_transform(struct jump_entry *entry,
 	 *
 	 */
 	if (poker)
-		(*poker)((void *)entry->code, &code, JUMP_LABEL_NOP_SIZE);
+		(*poker)((void *)jump_entry_code(entry), &code,
+			 JUMP_LABEL_NOP_SIZE);
 	else
-		text_poke_bp((void *)entry->code, &code, JUMP_LABEL_NOP_SIZE,
-			     (void *)entry->code + JUMP_LABEL_NOP_SIZE);
+		text_poke_bp((void *)jump_entry_code(entry), &code,
+			     JUMP_LABEL_NOP_SIZE,
+			     (void *)jump_entry_code(entry) +
+			     JUMP_LABEL_NOP_SIZE);
 }
 
 void arch_jump_label_transform(struct jump_entry *entry,
@@ -140,4 +149,20 @@ __init_or_module void arch_jump_label_transform_static(struct jump_entry *entry,
 		__jump_label_transform(entry, type, text_poke_early, 1);
 }
 
+void jump_label_swap(void *a, void *b, int size)
+{
+	long delta = (unsigned long)a - (unsigned long)b;
+	struct jump_entry *jea = a;
+	struct jump_entry *jeb = b;
+	struct jump_entry tmp = *jea;
+
+	jea->code	= jeb->code - delta;
+	jea->target	= jeb->target - delta;
+	jea->key	= jeb->key - delta;
+
+	jeb->code	= tmp.code + delta;
+	jeb->target	= tmp.target + delta;
+	jeb->key	= tmp.key + delta;
+}
+
 #endif
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 84f001d52322..98ae55b39037 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -30,9 +30,9 @@
 #define EX_ORIG_OFFSET		0
 #define EX_NEW_OFFSET		4
 
-#define JUMP_ENTRY_SIZE		24
+#define JUMP_ENTRY_SIZE		12
 #define JUMP_ORIG_OFFSET	0
-#define JUMP_NEW_OFFSET		8
+#define JUMP_NEW_OFFSET		4
 
 #define ALT_ENTRY_SIZE		13
 #define ALT_ORIG_OFFSET		0
-- 
2.11.0

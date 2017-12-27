Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Dec 2017 09:53:29 +0100 (CET)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:32849
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990510AbdL0Iv1HIieM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Dec 2017 09:51:27 +0100
Received: by mail-wm0-x244.google.com with SMTP id g130so38648391wme.0
        for <linux-mips@linux-mips.org>; Wed, 27 Dec 2017 00:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AUOuipd04iXjbyQ7tRijtnVIvzezHl+DybY8/NUX2wA=;
        b=Su8E/6dM4Vy7DKySqRJ3l4jpuAH4x7hmWnhUdVPEHgsUx1cAjV/QWCVdf3KmuWxfXJ
         if75rf7tsEcy9R3gldRubinvQYj/oP7SCk7bThryphMiYE9Vjb6cnNRsNzfE2a+YSFKM
         iq/frQeSsGa0mkmKE0McBrZfcqMxwzJ9WY4Do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AUOuipd04iXjbyQ7tRijtnVIvzezHl+DybY8/NUX2wA=;
        b=NYhCBmUY15rCy/cCts3OWgUtTgCmMag/vzLUR7L0TpiSJ/h7L+ZZk0HnL1Ln5bq2/m
         Ie9A/zNf/OAzjhEKY3DSycPsgdzvUD0eBD7Lcvce6dmcac5fjgkFCIhn3mjjUsT/l+lE
         qmlakvt7tWsQNFl3iLHWr5jwN5rS371oVwrxIF0BT7Ld1cWl/Oh4pagI0bxOnK5mpRpb
         9QkcOqNAXIDYWRh/j7YSnEkttygm9W/8QPYp4tt1ziTJqUv7YDwD4kh6VLFwcyTf+xnQ
         ktmTBYJTW2gzhrLPn+CC2Xprrm0erGfFLA7T7mhGa6jUmUKJwPSdBxob+NwQUR15V8zs
         LtfQ==
X-Gm-Message-State: AKGB3mLQxuHSIBQA0IBqqZ1sefSPQOaZbhHYGSXDzfISulJcJc8c/r6o
        WraZcCwgAONDhraCuhpqibmAXg==
X-Google-Smtp-Source: ACJfBovaIZgZBGoD0rMRMUd919x6YVta1CHNjSsFePXVm+immhMObrubgSpqR4zPxzzBuYCFjmCnMQ==
X-Received: by 10.28.220.215 with SMTP id t206mr22256701wmg.75.1514364681622;
        Wed, 27 Dec 2017 00:51:21 -0800 (PST)
Received: from localhost.localdomain ([105.137.110.132])
        by smtp.gmail.com with ESMTPSA id q74sm32677226wmg.22.2017.12.27.00.51.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2017 00:51:20 -0800 (PST)
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
Subject: [PATCH v6 6/8] kernel/jump_label: abstract jump_entry member accessors
Date:   Wed, 27 Dec 2017 08:50:31 +0000
Message-Id: <20171227085033.22389-7-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61623
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

In preparation of allowing architectures to use relative references
in jump_label entries [which can dramatically reduce the memory
footprint], introduce abstractions for references to the 'code' and
'key' members of struct jump_entry.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/include/asm/jump_label.h     | 27 ++++++++++++++
 arch/arm64/include/asm/jump_label.h   | 27 ++++++++++++++
 arch/mips/include/asm/jump_label.h    | 27 ++++++++++++++
 arch/powerpc/include/asm/jump_label.h | 27 ++++++++++++++
 arch/s390/include/asm/jump_label.h    | 20 +++++++++++
 arch/sparc/include/asm/jump_label.h   | 27 ++++++++++++++
 arch/tile/include/asm/jump_label.h    | 27 ++++++++++++++
 arch/x86/include/asm/jump_label.h     | 27 ++++++++++++++
 kernel/jump_label.c                   | 38 +++++++++-----------
 9 files changed, 225 insertions(+), 22 deletions(-)

diff --git a/arch/arm/include/asm/jump_label.h b/arch/arm/include/asm/jump_label.h
index e12d7d096fc0..7b05b404063a 100644
--- a/arch/arm/include/asm/jump_label.h
+++ b/arch/arm/include/asm/jump_label.h
@@ -45,5 +45,32 @@ struct jump_entry {
 	jump_label_t key;
 };
 
+static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
+{
+	return entry->code;
+}
+
+static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
+{
+	return (struct static_key *)((unsigned long)entry->key & ~1UL);
+}
+
+static inline bool jump_entry_is_branch(const struct jump_entry *entry)
+{
+	return (unsigned long)entry->key & 1UL;
+}
+
+static inline bool jump_entry_is_module_init(const struct jump_entry *entry)
+{
+	return entry->code == 0;
+}
+
+static inline void jump_entry_set_module_init(struct jump_entry *entry)
+{
+	entry->code = 0;
+}
+
+#define jump_label_swap		NULL
+
 #endif  /* __ASSEMBLY__ */
 #endif
diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
index 1b5e0e843c3a..9d6e46355c89 100644
--- a/arch/arm64/include/asm/jump_label.h
+++ b/arch/arm64/include/asm/jump_label.h
@@ -62,5 +62,32 @@ struct jump_entry {
 	jump_label_t key;
 };
 
+static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
+{
+	return entry->code;
+}
+
+static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
+{
+	return (struct static_key *)((unsigned long)entry->key & ~1UL);
+}
+
+static inline bool jump_entry_is_branch(const struct jump_entry *entry)
+{
+	return (unsigned long)entry->key & 1UL;
+}
+
+static inline bool jump_entry_is_module_init(const struct jump_entry *entry)
+{
+	return entry->code == 0;
+}
+
+static inline void jump_entry_set_module_init(struct jump_entry *entry)
+{
+	entry->code = 0;
+}
+
+#define jump_label_swap		NULL
+
 #endif  /* __ASSEMBLY__ */
 #endif	/* __ASM_JUMP_LABEL_H */
diff --git a/arch/mips/include/asm/jump_label.h b/arch/mips/include/asm/jump_label.h
index e77672539e8e..70df9293dc49 100644
--- a/arch/mips/include/asm/jump_label.h
+++ b/arch/mips/include/asm/jump_label.h
@@ -66,5 +66,32 @@ struct jump_entry {
 	jump_label_t key;
 };
 
+static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
+{
+	return entry->code;
+}
+
+static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
+{
+	return (struct static_key *)((unsigned long)entry->key & ~1UL);
+}
+
+static inline bool jump_entry_is_branch(const struct jump_entry *entry)
+{
+	return (unsigned long)entry->key & 1UL;
+}
+
+static inline bool jump_entry_is_module_init(const struct jump_entry *entry)
+{
+	return entry->code == 0;
+}
+
+static inline void jump_entry_set_module_init(struct jump_entry *entry)
+{
+	entry->code = 0;
+}
+
+#define jump_label_swap		NULL
+
 #endif  /* __ASSEMBLY__ */
 #endif /* _ASM_MIPS_JUMP_LABEL_H */
diff --git a/arch/powerpc/include/asm/jump_label.h b/arch/powerpc/include/asm/jump_label.h
index 9a287e0ac8b1..412b2699c9f6 100644
--- a/arch/powerpc/include/asm/jump_label.h
+++ b/arch/powerpc/include/asm/jump_label.h
@@ -59,6 +59,33 @@ struct jump_entry {
 	jump_label_t key;
 };
 
+static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
+{
+	return entry->code;
+}
+
+static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
+{
+	return (struct static_key *)((unsigned long)entry->key & ~1UL);
+}
+
+static inline bool jump_entry_is_branch(const struct jump_entry *entry)
+{
+	return (unsigned long)entry->key & 1UL;
+}
+
+static inline bool jump_entry_is_module_init(const struct jump_entry *entry)
+{
+	return entry->code == 0;
+}
+
+static inline void jump_entry_set_module_init(struct jump_entry *entry)
+{
+	entry->code = 0;
+}
+
+#define jump_label_swap		NULL
+
 #else
 #define ARCH_STATIC_BRANCH(LABEL, KEY)		\
 1098:	nop;					\
diff --git a/arch/s390/include/asm/jump_label.h b/arch/s390/include/asm/jump_label.h
index 40f651292aa7..3d4a08e9514b 100644
--- a/arch/s390/include/asm/jump_label.h
+++ b/arch/s390/include/asm/jump_label.h
@@ -50,5 +50,25 @@ struct jump_entry {
 	jump_label_t key;
 };
 
+static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
+{
+	return entry->code;
+}
+
+static inline jump_label_t jump_entry_key(const struct jump_entry *entry)
+{
+	return entry->key;
+}
+
+static inline bool jump_entry_is_module_init(const struct jump_entry *entry)
+{
+	return entry->code == 0;
+}
+
+static inline void jump_entry_set_module_init(struct jump_entry *entry)
+{
+	entry->code = 0;
+}
+
 #endif  /* __ASSEMBLY__ */
 #endif
diff --git a/arch/sparc/include/asm/jump_label.h b/arch/sparc/include/asm/jump_label.h
index 94eb529dcb77..18e893687f7c 100644
--- a/arch/sparc/include/asm/jump_label.h
+++ b/arch/sparc/include/asm/jump_label.h
@@ -48,5 +48,32 @@ struct jump_entry {
 	jump_label_t key;
 };
 
+static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
+{
+	return entry->code;
+}
+
+static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
+{
+	return (struct static_key *)((unsigned long)entry->key & ~1UL);
+}
+
+static inline bool jump_entry_is_branch(const struct jump_entry *entry)
+{
+	return (unsigned long)entry->key & 1UL;
+}
+
+static inline bool jump_entry_is_module_init(const struct jump_entry *entry)
+{
+	return entry->code == 0;
+}
+
+static inline void jump_entry_set_module_init(struct jump_entry *entry)
+{
+	entry->code = 0;
+}
+
+#define jump_label_swap		NULL
+
 #endif  /* __ASSEMBLY__ */
 #endif
diff --git a/arch/tile/include/asm/jump_label.h b/arch/tile/include/asm/jump_label.h
index cde7573f397b..86acaa6ff33d 100644
--- a/arch/tile/include/asm/jump_label.h
+++ b/arch/tile/include/asm/jump_label.h
@@ -55,4 +55,31 @@ struct jump_entry {
 	jump_label_t key;
 };
 
+static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
+{
+	return entry->code;
+}
+
+static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
+{
+	return (struct static_key *)((unsigned long)entry->key & ~1UL);
+}
+
+static inline bool jump_entry_is_branch(const struct jump_entry *entry)
+{
+	return (unsigned long)entry->key & 1UL;
+}
+
+static inline bool jump_entry_is_module_init(const struct jump_entry *entry)
+{
+	return entry->code == 0;
+}
+
+static inline void jump_entry_set_module_init(struct jump_entry *entry)
+{
+	entry->code = 0;
+}
+
+#define jump_label_swap		NULL
+
 #endif /* _ASM_TILE_JUMP_LABEL_H */
diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 8c0de4282659..009ff2699d07 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -74,6 +74,33 @@ struct jump_entry {
 	jump_label_t key;
 };
 
+static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
+{
+	return entry->code;
+}
+
+static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
+{
+	return (struct static_key *)((unsigned long)entry->key & ~1UL);
+}
+
+static inline bool jump_entry_is_branch(const struct jump_entry *entry)
+{
+	return (unsigned long)entry->key & 1UL;
+}
+
+static inline bool jump_entry_is_module_init(const struct jump_entry *entry)
+{
+	return entry->code == 0;
+}
+
+static inline void jump_entry_set_module_init(struct jump_entry *entry)
+{
+	entry->code = 0;
+}
+
+#define jump_label_swap		NULL
+
 #else	/* __ASSEMBLY__ */
 
 .macro STATIC_JUMP_IF_TRUE target, key, def
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 8594d24e4adc..4f44db58d981 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -37,10 +37,12 @@ static int jump_label_cmp(const void *a, const void *b)
 	const struct jump_entry *jea = a;
 	const struct jump_entry *jeb = b;
 
-	if (jea->key < jeb->key)
+	if ((unsigned long)jump_entry_key(jea) <
+	    (unsigned long)jump_entry_key(jeb))
 		return -1;
 
-	if (jea->key > jeb->key)
+	if ((unsigned long)jump_entry_key(jea) >
+	    (unsigned long)jump_entry_key(jeb))
 		return 1;
 
 	return 0;
@@ -53,7 +55,8 @@ jump_label_sort_entries(struct jump_entry *start, struct jump_entry *stop)
 
 	size = (((unsigned long)stop - (unsigned long)start)
 					/ sizeof(struct jump_entry));
-	sort(start, size, sizeof(struct jump_entry), jump_label_cmp, NULL);
+	sort(start, size, sizeof(struct jump_entry), jump_label_cmp,
+	     jump_label_swap);
 }
 
 static void jump_label_update(struct static_key *key);
@@ -254,8 +257,8 @@ EXPORT_SYMBOL_GPL(jump_label_rate_limit);
 
 static int addr_conflict(struct jump_entry *entry, void *start, void *end)
 {
-	if (entry->code <= (unsigned long)end &&
-		entry->code + JUMP_LABEL_NOP_SIZE > (unsigned long)start)
+	if (jump_entry_code(entry) <= (unsigned long)end &&
+	    jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE > (unsigned long)start)
 		return 1;
 
 	return 0;
@@ -314,16 +317,6 @@ static inline void static_key_set_linked(struct static_key *key)
 	key->type |= JUMP_TYPE_LINKED;
 }
 
-static inline struct static_key *jump_entry_key(struct jump_entry *entry)
-{
-	return (struct static_key *)((unsigned long)entry->key & ~1UL);
-}
-
-static bool jump_entry_branch(struct jump_entry *entry)
-{
-	return (unsigned long)entry->key & 1UL;
-}
-
 /***
  * A 'struct static_key' uses a union such that it either points directly
  * to a table of 'struct jump_entry' or to a linked list of modules which in
@@ -348,7 +341,7 @@ static enum jump_label_type jump_label_type(struct jump_entry *entry)
 {
 	struct static_key *key = jump_entry_key(entry);
 	bool enabled = static_key_enabled(key);
-	bool branch = jump_entry_branch(entry);
+	bool branch = jump_entry_is_branch(entry);
 
 	/* See the comment in linux/jump_label.h */
 	return enabled ^ branch;
@@ -364,7 +357,8 @@ static void __jump_label_update(struct static_key *key,
 		 * kernel_text_address() verifies we are not in core kernel
 		 * init code, see jump_label_invalidate_module_init().
 		 */
-		if (entry->code && kernel_text_address(entry->code))
+		if (!jump_entry_is_module_init(entry) &&
+		    kernel_text_address(jump_entry_code(entry)))
 			arch_jump_label_transform(entry, jump_label_type(entry));
 	}
 }
@@ -417,7 +411,7 @@ static enum jump_label_type jump_label_init_type(struct jump_entry *entry)
 {
 	struct static_key *key = jump_entry_key(entry);
 	bool type = static_key_type(key);
-	bool branch = jump_entry_branch(entry);
+	bool branch = jump_entry_is_branch(entry);
 
 	/* See the comment in linux/jump_label.h */
 	return type ^ branch;
@@ -541,7 +535,7 @@ static int jump_label_add_module(struct module *mod)
 			continue;
 
 		key = iterk;
-		if (within_module(iter->key, mod)) {
+		if (within_module((unsigned long)key, mod)) {
 			static_key_set_entries(key, iter);
 			continue;
 		}
@@ -591,7 +585,7 @@ static void jump_label_del_module(struct module *mod)
 
 		key = jump_entry_key(iter);
 
-		if (within_module(iter->key, mod))
+		if (within_module((unsigned long)key, mod))
 			continue;
 
 		/* No memory during module load */
@@ -634,8 +628,8 @@ static void jump_label_invalidate_module_init(struct module *mod)
 	struct jump_entry *iter;
 
 	for (iter = iter_start; iter < iter_stop; iter++) {
-		if (within_module_init(iter->code, mod))
-			iter->code = 0;
+		if (within_module_init(jump_entry_code(iter), mod))
+			jump_entry_set_module_init(iter);
 	}
 }
 
-- 
2.11.0

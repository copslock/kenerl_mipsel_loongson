Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 21:09:59 +0100 (CET)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:33850
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993153AbeABUHHe5oMJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 21:07:07 +0100
Received: by mail-wr0-x244.google.com with SMTP id 36so16290690wrh.1
        for <linux-mips@linux-mips.org>; Tue, 02 Jan 2018 12:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RtgdmqqE7QnNDS0Od8ctH/UMcFkuxkhGpZ1L+nRoK9Y=;
        b=ZXOsFAJioLobdvr9YpnYOCxgnNq32bEakvz+d8oHqbR+rWFbkbaVPtVyawqeeowoT1
         Dzbj11m2Bi/29hzMeufYCDd4u72LhfE0tCsxWkG9HEh2S9NwOvXB6vLZxGTzpuOUsPI5
         3M8pDezCKUo4tMXGIDfUWJ0EZBHr/1jyyzjGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RtgdmqqE7QnNDS0Od8ctH/UMcFkuxkhGpZ1L+nRoK9Y=;
        b=AS9mLufQWZ1bLshfsQXi8DeNDmYFJ3rbxQcI98HqrwBDUFbpQBqnSlIGXCNBJvRZTW
         E6zR5UUO5KsL1N06G5dHAR0roRqWZTxCcFciXotsmZ9AXFln5EpyYBYdjcy23+aLGeig
         GhJuDkD+a6ZP95MCKSzkDwSQqiBxTvPwIJefwreHDZOAiajxbwLh2fh9rnquVUX/bfuv
         sy5Z4TjzxUzl/EZaO1S5Z0lwHc4FU9coxG5J3F2++jwZ6p+Zw1JpEYndgNZhxwoxyTf9
         rRo/NlW4CAaQ6EGPictnbs4CUHqobOK5o3UGY8Q/+8GB8qDzR0HJGPZ92wf6pc5INmoF
         Qh/g==
X-Gm-Message-State: AKGB3mJ7ByxQp2uq9vVwn7+Vw4wveM9HaHgor3oYD7CtxC3dZavX8VSJ
        JjQzs173i3xIL+jKLSeeslTJKQ==
X-Google-Smtp-Source: ACJfBotnEYN73SoeBAeXFa2dgkyQaTjIm+dvcolnJ1DYqLR79c3pB4kn56LVZv46+GU71sfeYtgiCw==
X-Received: by 10.223.186.13 with SMTP id o13mr15747922wrg.43.1514923622162;
        Tue, 02 Jan 2018 12:07:02 -0800 (PST)
Received: from localhost.localdomain ([160.89.138.198])
        by smtp.gmail.com with ESMTPSA id m70sm19128526wma.36.2018.01.02.12.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jan 2018 12:07:01 -0800 (PST)
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
Subject: [PATCH v7 08/10] arm64/kernel: jump_label: use relative references
Date:   Tue,  2 Jan 2018 20:05:47 +0000
Message-Id: <20180102200549.22984-9-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
References: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61875
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

On a randomly chosen distro kernel build for arm64, vmlinux.o shows the
following sections, containing jump label entries, and the associated
RELA relocation records, respectively:

  ...
  [38088] __jump_table      PROGBITS         0000000000000000  00e19f30
       000000000002ea10  0000000000000000  WA       0     0     8
  [38089] .rela__jump_table RELA             0000000000000000  01fd8bb0
       000000000008be30  0000000000000018   I      38178   38088     8
  ...

In other words, we have 190 KB worth of 'struct jump_entry' instances,
and 573 KB worth of RELA entries to relocate each entry's code, target
and key members. This means the RELA section occupies 10% of the .init
segment, and the two sections combined represent 5% of vmlinux's entire
memory footprint.

So let's switch from 64-bit absolute references to 32-bit relative
references: this reduces the size of the __jump_table by 50%, and gets
rid of the RELA section entirely.

Note that this requires some extra care in the sorting routine, given
that the offsets change when entries are moved around in the jump_entry
table.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/jump_label.h | 27 ++++++++++++--------
 arch/arm64/kernel/jump_label.c      | 22 +++++++++++++---
 2 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
index 9d6e46355c89..8f82adeb7b0b 100644
--- a/arch/arm64/include/asm/jump_label.h
+++ b/arch/arm64/include/asm/jump_label.h
@@ -30,8 +30,8 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 {
 	asm goto("1: nop\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
-		 ".align 3\n\t"
-		 ".quad 1b, %l[l_yes], %c0\n\t"
+		 ".align 2\n\t"
+		 ".long 1b - ., %l[l_yes] - ., %c0 - .\n\t"
 		 ".popsection\n\t"
 		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
 
@@ -44,8 +44,8 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 {
 	asm goto("1: b %l[l_yes]\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
-		 ".align 3\n\t"
-		 ".quad 1b, %l[l_yes], %c0\n\t"
+		 ".align 2\n\t"
+		 ".long 1b - ., %l[l_yes] - ., %c0 - .\n\t"
 		 ".popsection\n\t"
 		 :  :  "i"(&((char *)key)[branch]) :  : l_yes);
 
@@ -57,19 +57,26 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 typedef u64 jump_label_t;
 
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
+	return (unsigned long)&entry->code + entry->code;
+}
+
+static inline jump_label_t jump_entry_target(const struct jump_entry *entry)
+{
+	return (unsigned long)&entry->target + entry->target;
 }
 
 static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
 {
-	return (struct static_key *)((unsigned long)entry->key & ~1UL);
+	unsigned long key = (unsigned long)&entry->key + entry->key;
+
+	return (struct static_key *)(key & ~1UL);
 }
 
 static inline bool jump_entry_is_branch(const struct jump_entry *entry)
@@ -87,7 +94,7 @@ static inline void jump_entry_set_module_init(struct jump_entry *entry)
 	entry->code = 0;
 }
 
-#define jump_label_swap		NULL
+void jump_label_swap(void *a, void *b, int size);
 
 #endif  /* __ASSEMBLY__ */
 #endif	/* __ASM_JUMP_LABEL_H */
diff --git a/arch/arm64/kernel/jump_label.c b/arch/arm64/kernel/jump_label.c
index c2dd1ad3e648..2b8e459e91f7 100644
--- a/arch/arm64/kernel/jump_label.c
+++ b/arch/arm64/kernel/jump_label.c
@@ -25,12 +25,12 @@
 void arch_jump_label_transform(struct jump_entry *entry,
 			       enum jump_label_type type)
 {
-	void *addr = (void *)entry->code;
+	void *addr = (void *)jump_entry_code(entry);
 	u32 insn;
 
 	if (type == JUMP_LABEL_JMP) {
-		insn = aarch64_insn_gen_branch_imm(entry->code,
-						   entry->target,
+		insn = aarch64_insn_gen_branch_imm(jump_entry_code(entry),
+						   jump_entry_target(entry),
 						   AARCH64_INSN_BRANCH_NOLINK);
 	} else {
 		insn = aarch64_insn_gen_nop();
@@ -50,4 +50,20 @@ void arch_jump_label_transform_static(struct jump_entry *entry,
 	 */
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
 #endif	/* HAVE_JUMP_LABEL */
-- 
2.11.0

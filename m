Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 21:10:22 +0100 (CET)
Received: from mail-wr0-x243.google.com ([IPv6:2a00:1450:400c:c0c::243]:32977
        "EHLO mail-wr0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993497AbeABUHOxMvXJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 21:07:14 +0100
Received: by mail-wr0-x243.google.com with SMTP id v21so38857117wrc.0
        for <linux-mips@linux-mips.org>; Tue, 02 Jan 2018 12:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3xW6hB18H7nCj1B8KM19meDl2NukzrBIHv9vfi9d94c=;
        b=IlsjC4yqku/Bgvxd3dSYA80TsqwMeZzyABWwlbxe827nworF3Z2Xw2NJJ9GC5u1EVj
         TlmJPcYtP0p5eP2s5u9UB06rVtkb1x+/J7q2wqmbSLsSc3bgNNB1+bkZWxdCYlujbUoP
         GxFZ5Jka238l0BCJThgTwy43cQ6Jj89D4IPmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3xW6hB18H7nCj1B8KM19meDl2NukzrBIHv9vfi9d94c=;
        b=ZIWNpMUSq7O8acgZojnr7QHPrXPZGJWSoPa2ACAbtpuizcMZdzYFaEnAmHKuWF4YfL
         frIPmqCLrKpFT6VKbFyB8VYI21/RKobSkfYwN7JSTM3vWQYLMdhl2IRr05LeHyDybrNw
         YuooTKOoWlTFXR5Jltd6v0PvG25gv8j2JdpF3S22uLHhJLMHZZsy5dLtRi3GqwEGEHbd
         lBS6inK0Gp6Vqj2MN+kR71wG9A78YeVa8oaWx9tvi8TykjijCqyOluPd75L1iDABJd4Y
         LqBJqHAh8ZbY52AVYP1O2SxwhYwZJUtg8vLPRi9ptHy4SsHtXyRjqLWvj497I1N0vFV8
         +0ug==
X-Gm-Message-State: AKGB3mJFlKDoje4eZBc/0Vvox5Jc0qDWdxwd12UqN8yE+tRrHLVM+eQS
        YpRbkzsgVe5YQUKe6gl5vDwMNw==
X-Google-Smtp-Source: ACJfBoud3bqGO7fUQcY4b1dNTrZOfP3q0fUJPUXWN6CkcwSAMQ/Py8E4OagotjFR3BvalO1ZlBxCBg==
X-Received: by 10.223.177.143 with SMTP id q15mr14341520wra.42.1514923629540;
        Tue, 02 Jan 2018 12:07:09 -0800 (PST)
Received: from localhost.localdomain ([160.89.138.198])
        by smtp.gmail.com with ESMTPSA id m70sm19128526wma.36.2018.01.02.12.07.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jan 2018 12:07:08 -0800 (PST)
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
Subject: [PATCH v7 09/10] x86: jump_label: switch to jump_entry accessors
Date:   Tue,  2 Jan 2018 20:05:48 +0000
Message-Id: <20180102200549.22984-10-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
References: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61876
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

In preparation of switching x86 to use place-relative references for
the code, target and key members of struct jump_entry, replace direct
references to the struct member with invocations of the new accessors.
This will allow us to make the switch by modifying the accessors only.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/kernel/jump_label.c | 43 ++++++++++++--------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index e56c95be2808..d64296092ef5 100644
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
-- 
2.11.0

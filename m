Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Oct 2018 11:31:33 +0200 (CEST)
Received: from mail-wr1-x443.google.com ([IPv6:2a00:1450:4864:20::443]:45155
        "EHLO mail-wr1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992891AbeJTJbaXP2JT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Oct 2018 11:31:30 +0200
Received: by mail-wr1-x443.google.com with SMTP id f17-v6so8040040wrs.12;
        Sat, 20 Oct 2018 02:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GHc11vhMARtDZs1nuQq2CZe5+fQS2/S7WpD2lg9m7dE=;
        b=GlNi1uYmhDH01oha5VpoEDlXkS+9sXfS1QZ7YVBYl0/ChpbVAY6/KIfPmejQBHajdg
         4aRm+4+lsXylljQMxui3sco61IFhyz9zLaBuEkM4T1e0j9OxyRGjfZaUdzG2IFP3R127
         zM//2HZ7X0oKvfUb6bLxANh29aLwWfQ2Wen0oJ3hmbfrmb5cg3loxYO7N68DRlvYA/Fv
         Bej7oZkl97oI4DEb6tdmxqJ8PBFpOdV77gE6MQxTlbxOd9QKJV9nYcW8QFxNEFVUwl3R
         CDiAqHhHhXO5O/sWEg5mk7rNZmHjiTzDEONxVn8Lw8F5EgNa7uKg09yXH1stI+EAQ4J8
         FofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GHc11vhMARtDZs1nuQq2CZe5+fQS2/S7WpD2lg9m7dE=;
        b=CS9SO3lF9A5noyNCFhSVrLTxM4jsmlcGtIbF72+Lfg1NRmGF8jIlt9nyCr19LnpSUy
         lwQ2L85K8cQLb96Ux+uYXSwpCXO2bM3tGxEOM6kVV8Kl7NRRm9ARFl0eFSwmuWzavfz3
         13AJpOm3BdtvxYGNClGHseuoTeuloRFAVExbwljaPLsHspBZXDvaJyKgg8AUXL/wFOkY
         hG9RCd9Tmubg+hxAOok+aY+UxBO4tOMhzfeVafJQhmYWlLtMu2OYORDkV7b8wnk7L6qA
         CsFfnwA1XH46O8ZEHd9DD7wgV3XXpkCghaoEdFdwVM3XESYR4J95wnmAxaRqNkVUa1dD
         Ng8g==
X-Gm-Message-State: AGRZ1gIX6kmZtg5kqO45NQ2ufatmSpx3RALaQA3yaO0jzPsupsSH4FnJ
        r4FV9CqGU0cHFtWDm+VhOrzS82qnF9A=
X-Google-Smtp-Source: AJdET5dDu1I6n5YU0IueK92NfF6c2yp5cCIStkItK9Gy+rcWhLh9+m1/m4vm/9zXzOU8FP8YtyAkJw==
X-Received: by 2002:a5d:524f:: with SMTP id p15-v6mr6494426wrv.192.1540027884657;
        Sat, 20 Oct 2018 02:31:24 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id v76-v6sm7226030wmd.32.2018.10.20.02.31.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 02:31:24 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Ensure ELF appended dtb is relocated
Date:   Sat, 20 Oct 2018 12:31:00 +0300
Message-Id: <20181020093100.3810-1-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <yasha.che3@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yasha.che3@gmail.com
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

This fixes booting with the combination of CONFIG_RELOCATABLE=y
and CONFIG_MIPS_ELF_APPENDED_DTB=y.

Sections that appear after the relocation table are not relocated
on system boot (except .bss, which has special handling).

With CONFIG_MIPS_ELF_APPENDED_DTB, the dtb is part of the
vmlinux ELF, so it must be relocated together with everything else.

Fixes: 069fd766271d ("MIPS: Reserve space for relocation table")
Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/kernel/vmlinux.lds.S | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 971a504001c2..36f2e860ba3e 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -140,6 +140,13 @@ SECTIONS
 	PERCPU_SECTION(1 << CONFIG_MIPS_L1_CACHE_SHIFT)
 #endif
 
+#ifdef CONFIG_MIPS_ELF_APPENDED_DTB
+	.appended_dtb : AT(ADDR(.appended_dtb) - LOAD_OFFSET) {
+		*(.appended_dtb)
+		KEEP(*(.appended_dtb))
+	}
+#endif
+
 #ifdef CONFIG_RELOCATABLE
 	. = ALIGN(4);
 
@@ -164,11 +171,6 @@ SECTIONS
 	__appended_dtb = .;
 	/* leave space for appended DTB */
 	. += 0x100000;
-#elif defined(CONFIG_MIPS_ELF_APPENDED_DTB)
-	.appended_dtb : AT(ADDR(.appended_dtb) - LOAD_OFFSET) {
-		*(.appended_dtb)
-		KEEP(*(.appended_dtb))
-	}
 #endif
 	/*
 	 * Align to 64K in attempt to eliminate holes before the
-- 
2.19.1

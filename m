Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2018 20:09:14 +0200 (CEST)
Received: from mail-wm1-x342.google.com ([IPv6:2a00:1450:4864:20::342]:52842
        "EHLO mail-wm1-x342.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993946AbeIYSI5AifAH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Sep 2018 20:08:57 +0200
Received: by mail-wm1-x342.google.com with SMTP id l7-v6so9623709wme.2;
        Tue, 25 Sep 2018 11:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QcsiSHC0IriMHLUqwataqDFFhjE03MSei2N5kMdLovo=;
        b=ILilAhzmHg3sw6pL13xeTdJOGIsluDxAm3sABWjPa7BWKiLJU5oUSkgnRSzSF+yjtV
         THXQQ4a77+AWvPdjc07c0LI9BQhvumu64ew4clbmLy2nKg7KQHdfPJBWO5mfw4OtDV6l
         KcujJ3S1cBd/GGc8faJ3dZmWgJ91Xy+OLjahjqyJGB3FWjwuhzIRgvpzTHmfnnaZBbKc
         R69d/m2qrGS9RcmVFZOdcNiVHFDHw5BZyA5/EczB9FVGgHNYVIsCpLctBZTs/GkQNI+5
         ezcW8DCcBvdI9PJ3k+GNGyYtBoF1LL7ZIBmasxdaLFjLJjZKIeB+KXKEP0kob0Eu9v8o
         7v4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QcsiSHC0IriMHLUqwataqDFFhjE03MSei2N5kMdLovo=;
        b=refqUWvXeWnVFYRPGLI3R/ONfg0X5hWjWTRej6aUnBzpKyshoQGy9YYUH0WBYz2YyO
         D5ZViAXDvl+7IJFJgZ20Q38rl0FJIaYDpxeXiB4Iek9FsFnYtxppUKKa9xgowAYV8Jbm
         J9VGKqmYip5970l01AkiUiIBXB0qBTLRHoxWfnyUw7GWLN2/Oa2tOvEAnjWmOQPl+rGX
         cktW7fstC1HOFFr7kYpSTMJBhNiZpj3yv1lks2JE/BQkKtgteU7p3A1vc6d+BiqrLPzK
         QcnrOsvCdrsFJY3Ba5jNG1V+SgLTUNSnS3bFaLat47Y7CXhb9/LOhCMVUrJX297u7QLu
         vC5A==
X-Gm-Message-State: ABuFfoiBP3dVETnNQ+gY8uS8vcVZLwxTRvD6Wx9p33nrN1LseZd/Ej/+
        aNVZKY1V0CfGIM6IlG8emPq3a3nK/NQ=
X-Google-Smtp-Source: ACcGV60qL4SXJHtBZOWibWIdpZmktz3VnDAyONE3q0jTsn3JyrXZmO0MOvX0JI82I/o5KDaYx/007A==
X-Received: by 2002:a1c:7f93:: with SMTP id a141-v6mr1732086wmd.45.1537898931422;
        Tue, 25 Sep 2018 11:08:51 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id v6-v6sm2755827wro.66.2018.09.25.11.08.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 11:08:51 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] MIPS/head: Store ELF appended dtb in a global variable too
Date:   Tue, 25 Sep 2018 21:08:23 +0300
Message-Id: <20180925180825.24659-3-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180925180825.24659-1-yasha.che3@gmail.com>
References: <20180925180825.24659-1-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <yasha.che3@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66554
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

Since commit 15f37e158892 ("MIPS: store the appended
dtb address in a variable"),
in kernels with MIPS_RAW_APPENDED_DTB=y, the early boot code detects
the dtb and stores it in the 'fw_passed_dtb' variable.

However, the dtb is not stored in 'fw_passed_dtb' in kernels with
MIPS_ELF_APPENDED_DTB=y.

Under MIPS_ELF_APPENDED_DTB=y, the dtb is also located in the
__appended_dtb section, so we just need to update the #ifdef.

This will allow to access the dtb in a more uniform way.

Fixes: 15f37e158892 ("MIPS: store the appended dtb address in a variable")
Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/kernel/head.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index fef2f61c5394..351d40fe0859 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -94,7 +94,9 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
 0:
 
 #ifdef CONFIG_USE_OF
-#ifdef CONFIG_MIPS_RAW_APPENDED_DTB
+#if defined(CONFIG_MIPS_RAW_APPENDED_DTB) || \
+	defined(CONFIG_MIPS_ELF_APPENDED_DTB)
+
 	PTR_LA		t2, __appended_dtb
 
 #ifdef CONFIG_CPU_BIG_ENDIAN
@@ -104,7 +106,7 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
 #endif /* !CONFIG_CPU_BIG_ENDIAN */
 	lw		t0, (t2)
 	beq		t0, t1, dtb_found
-#endif /* CONFIG_MIPS_RAW_APPENDED_DTB */
+#endif /* CONFIG_MIPS_RAW_APPENDED_DTB || CONFIG_MIPS_ELF_APPENDED_DTB */
 	li		t1, -2
 	move		t2, a1
 	beq		a0, t1, dtb_found
-- 
2.19.0

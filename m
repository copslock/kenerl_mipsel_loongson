Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2018 20:09:02 +0200 (CEST)
Received: from mail-wm1-x342.google.com ([IPv6:2a00:1450:4864:20::342]:40678
        "EHLO mail-wm1-x342.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993941AbeIYSIygAaeH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Sep 2018 20:08:54 +0200
Received: by mail-wm1-x342.google.com with SMTP id o2-v6so8028234wmh.5;
        Tue, 25 Sep 2018 11:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BgszxiMh7UVkNVfekl9HVziiNCKJdcqkbKDqES3JS2E=;
        b=DtNHjdpn0/ZJiP0HFIxH3ajPaRp5xGtcpwUQP/J2HwZQ921pbrV4NErK+b+YWxXher
         Eo3d8DFNtXGM4L/hoaZFDJsHgHJr+W6wcz73yEHSVoCgQISWgI4EZ+wYgmKM5O0sQqlS
         mvntX8dRkekWByiuRrU//tK0G4dJP0PK2NRlIsM3ckOHGkCBsCTUPXm/BGtS6TmBkdYH
         e5CaDu0/mDL5tnPJJf96O2zq2LuLo1Sn3Ni7mTPX2X2O0E3TpUq19tCjKMN8bBF+tCO3
         Vn2CrKAYd48VCvqJuDzqv8nv+YDHvBAPKzl+qApjvq4esTgZg+AOYjDKKd5W7TLRUxWQ
         tPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BgszxiMh7UVkNVfekl9HVziiNCKJdcqkbKDqES3JS2E=;
        b=I1gTus2RvPO9AZ106Wyehn1a43SGmFD0YX6X7duJCkdibwjScXIQokGmw1jKilRj04
         tGrOdkTzP6a1pXP8fiuSGMrImdJGfyDxDoZpdbytQIEQ4GnH3vN21o3ojrJ4LFMHy3fi
         uu7FQ8VADFXuGZN1AEfuxi3sh/zOCj4jRLJHDNvfVm5zA+NIqkcnEbNMecJgRW89hv32
         ARx9ENpsYBJKP6/Lfzms7YpXvTJ4yZRTCpxhCWEgD2URtRo1cHSaRtoP/Qya/o8AUXJh
         nvaLH4da3ouKD9YOV7Xtqb74XVWcSltJ9qpbz053XRU1LN1fp+p4FJS5HNSMbBoGxAjv
         QBOA==
X-Gm-Message-State: ABuFfog3LgwmWMbY731VpPpR6mo3MHSXWWO4yzbEX+UfbSJsHOdnbtWG
        bqFJFFV26/3SM6UhBvjBgy87kt11GKI=
X-Google-Smtp-Source: ACcGV62vMgRK4yc9TMrankAW6e0MueWfOvXEsQhFo5i1xY7Fzx9REi1eHY1+vhX5oZQKhdQh1fv/rg==
X-Received: by 2002:a1c:7412:: with SMTP id p18-v6mr1788391wmc.49.1537898928946;
        Tue, 25 Sep 2018 11:08:48 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id v6-v6sm2755827wro.66.2018.09.25.11.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 11:08:48 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] MIPS/head: Add comments after #endif and #else
Date:   Tue, 25 Sep 2018 21:08:22 +0300
Message-Id: <20180925180825.24659-2-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180925180825.24659-1-yasha.che3@gmail.com>
References: <20180925180825.24659-1-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <yasha.che3@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66553
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

It makes the code more readable, especially in the nested ifdefs.

Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/kernel/head.S | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index d1bb506adc10..fef2f61c5394 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -77,7 +77,7 @@ EXPORT(_stext)
 	 */
 FEXPORT(__kernel_entry)
 	j	kernel_entry
-#endif
+#endif /* CONFIG_BOOT_RAW */
 
 	__REF
 
@@ -99,19 +99,19 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
 
 #ifdef CONFIG_CPU_BIG_ENDIAN
 	li		t1, 0xd00dfeed
-#else
+#else  /* !CONFIG_CPU_BIG_ENDIAN */
 	li		t1, 0xedfe0dd0
-#endif
+#endif /* !CONFIG_CPU_BIG_ENDIAN */
 	lw		t0, (t2)
 	beq		t0, t1, dtb_found
-#endif
+#endif /* CONFIG_MIPS_RAW_APPENDED_DTB */
 	li		t1, -2
 	move		t2, a1
 	beq		a0, t1, dtb_found
 
 	li		t2, 0
 dtb_found:
-#endif
+#endif /* CONFIG_USE_OF */
 	PTR_LA		t0, __bss_start		# clear .bss
 	LONG_S		zero, (t0)
 	PTR_LA		t1, __bss_stop - LONGSIZE
@@ -156,9 +156,9 @@ dtb_found:
 	 * newly sync'd icache.
 	 */
 	jr.hb		v0
-#else
+#else  /* !CONFIG_RELOCATABLE */
 	j		start_kernel
-#endif
+#endif /* !CONFIG_RELOCATABLE */
 	END(kernel_entry)
 
 #ifdef CONFIG_SMP
-- 
2.19.0

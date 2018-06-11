Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jun 2018 03:38:43 +0200 (CEST)
Received: from mail-pf0-x242.google.com ([IPv6:2607:f8b0:400e:c00::242]:33073
        "EHLO mail-pf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990395AbeFKBigoXoZV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jun 2018 03:38:36 +0200
Received: by mail-pf0-x242.google.com with SMTP id b17-v6so9373519pfi.0
        for <linux-mips@linux-mips.org>; Sun, 10 Jun 2018 18:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=bAgixViFfkx1IzT9AF73PimBt4nu0ow9e/V2V8gquh8=;
        b=marbznnIfFo8RDZOw7MWbh+mgOkEc7B4l9TZmOqA8tuYbBiQKq0+EsfsrTLVbJnpKJ
         hdZ+WDpV3zgafKvJdhFr+06DEtWW+eLVB0HOVQ1gY/T09KDV8nDY/D0SQ3LI1AdsKxnP
         0EjyQ0yV3QRodmetLLnbN6OiNm0Sy1wbTfntoqq933zAQPmU2bK+isd31Njrnep/gKFF
         Vf44mOKmgk7OuuckMkJOHQ4glCYEtd5tVms8yvofPAfcLSx1M4u/qrBdDq4Q5GOKRseR
         Y6oWM08z2x7g/lvWCJztyHtVD5W9WSce98YUbB1fZmw1kOfGlRyMzvIeRwjoD3HR/eAW
         LgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bAgixViFfkx1IzT9AF73PimBt4nu0ow9e/V2V8gquh8=;
        b=XPUOUE/myHP4nHMrFGsgEOninjQp/4KDnSItgPvsPBPOkyrTjoLsWcHujH8YA+7VU6
         tBarWDy3MKmWtIc1u2sMuJ11kvT4oMXIy2yAKg6gLLKBuiIK/mvYQVc3QSwsObyc2ioK
         DwM7P9RhFynbfL9/Zldwogk3mcYAS7PqMuk3S4mR/JEzzRAroukwvmCu2nr4ZJvRvyGr
         oK4nMVnzlYljRrPDWIs8WWQXm7z9YWEm1i/IG13R/8B80e12uJHy6cIiWoj/r55K4ixi
         sCnt0MCZ5dTNgCNz7Z1yZTw3tT/CFTPy86ymB6yFJx3MbrCcE2X9gNgoesktl1NILAhL
         9G1g==
X-Gm-Message-State: APt69E1utah4BXe+xlRIJd/IoMWgqlRsHmPqRHgBEtCavHeF0bSa1e9o
        qTa3BSFeg9qPgHCbJUyXgnod3FhHVAg=
X-Google-Smtp-Source: ADUXVKKu0Ujqpav/7V213nDSbdzE8yJ/L6fEdxuh9Oy2cxdEIL/0FxswSg+dUIvI3OINhC4SnGptig==
X-Received: by 2002:a62:c0cb:: with SMTP id g72-v6mr15365806pfk.226.1528681110042;
        Sun, 10 Jun 2018 18:38:30 -0700 (PDT)
Received: from localhost.localdomain ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id 4-v6sm43757344pfi.78.2018.06.10.18.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jun 2018 18:38:28 -0700 (PDT)
From:   r@hev.cc
To:     linux-mips@linux-mips.org, paul.burton@mips.com
Cc:     jhogan@kernel.org, ralf@linux-mips.org, Heiher <r@hev.cc>
Subject: [PATCH v4] MIPS: Fix ejtag handler on SMP
Date:   Mon, 11 Jun 2018 09:38:21 +0800
Message-Id: <20180611013821.21422-1-r@hev.cc>
X-Mailer: git-send-email 2.17.1
Return-Path: <r@hev.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r@hev.cc
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

From: Heiher <r@hev.cc>

On SMP systems, the shared ejtag debug buffer may be overwritten by
other cores, because every cores can generate ejtag exception at
same time.

Unfortunately, in that context, it's difficult to relax more registers
to access per cpu buffers. so use ll/sc to serialize the access.

Signed-off-by: Heiher <r@hev.cc>
---
 arch/mips/kernel/genex.S | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 37b9383eacd3..fec6256bac1e 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -354,16 +354,54 @@ NESTED(ejtag_debug_handler, PT_SIZE, sp)
 	sll	k0, k0, 30	# Check for SDBBP.
 	bgez	k0, ejtag_return
 
+#ifdef CONFIG_SMP
+1:	PTR_LA	k0, ejtag_debug_buffer_spinlock
+	ll	k0, 0(k0)
+	bnez	k0, 1b
+	PTR_LA	k0, ejtag_debug_buffer_spinlock
+	sc	k0, 0(k0)
+	beqz	k0, 1b
+# ifdef CONFIG_WEAK_REORDERING_BEYOND_LLSC
+	sync
+# endif
+
+	PTR_LA	k0, ejtag_debug_buffer
+	LONG_S	k1, 0(k0)
+
+	lw	k1, TI_CPU(gp)
+	PTR_SLL	k1, LONGLOG
+	PTR_LA	k0, ejtag_debug_buffer_per_cpu
+	PTR_ADDU k0, k1
+
+	PTR_LA	k1, ejtag_debug_buffer
+	LONG_L	k1, 0(k1)
+	LONG_S	k1, 0(k0)
+
+	PTR_LA	k0, ejtag_debug_buffer_spinlock
+	sw	zero, 0(k0)
+#else
 	PTR_LA	k0, ejtag_debug_buffer
 	LONG_S	k1, 0(k0)
+#endif
+
 	SAVE_ALL
 	move	a0, sp
 	jal	ejtag_exception_handler
 	RESTORE_ALL
+
+#ifdef CONFIG_SMP
+	lw	k1, TI_CPU(gp)
+	PTR_SLL	k1, LONGLOG
+	PTR_LA	k0, ejtag_debug_buffer_per_cpu
+	PTR_ADDU k0, k1
+	LONG_L	k1, 0(k0)
+#else
 	PTR_LA	k0, ejtag_debug_buffer
 	LONG_L	k1, 0(k0)
+#endif
 
 ejtag_return:
+	back_to_back_c0_hazard
 	MFC0	k0, CP0_DESAVE
 	.set	mips32
 	deret
@@ -377,6 +415,12 @@ ejtag_return:
 	.data
 EXPORT(ejtag_debug_buffer)
 	.fill	LONGSIZE
+#ifdef CONFIG_SMP
+EXPORT(ejtag_debug_buffer_spinlock)
+	.fill	LONGSIZE
+EXPORT(ejtag_debug_buffer_per_cpu)
+	.fill	LONGSIZE * NR_CPUS
+#endif
 	.previous
 
 	__INIT
-- 
2.17.1

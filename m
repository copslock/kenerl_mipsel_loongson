Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jun 2018 11:01:33 +0200 (CEST)
Received: from mail-pl0-x244.google.com ([IPv6:2607:f8b0:400e:c01::244]:42047
        "EHLO mail-pl0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990406AbeFKJB1DokGb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jun 2018 11:01:27 +0200
Received: by mail-pl0-x244.google.com with SMTP id w17-v6so11948555pll.9
        for <linux-mips@linux-mips.org>; Mon, 11 Jun 2018 02:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=p7YjCsxgshiZNq7SS5aMDgSDR35wat//+Agyd+bjIkE=;
        b=Vfu/G2IBzpt+1tHFSKLKijVP05pCjOZOBMjGUbOCnIGSm9cE1A1k6lgaGy1x1eCmy7
         cHh9K9ooB0hMGNAVfcUUr3oBu0WBciFyIXqxersPp4hCHVLJpPlxJqLZEDU6If6iKmlW
         TMy+wjM6jFCIRkVPzY8OvL+3fixsnFbMqCnnwWdrh38RtUX5NBICVq3c/GYimC5jpztT
         D2wjQJ6SaKnVVKwNKmu4Qg93GiyMw93ZffUIyEGJQPUAsAIlVhlwAnN8JfyXogF48yD2
         s/FWwRti4HXDerJKiSXBJbvEXWY9TGOE9dH6rFAfpTYCO85LXOEujS+8qIgwIKTQhz8O
         LCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p7YjCsxgshiZNq7SS5aMDgSDR35wat//+Agyd+bjIkE=;
        b=nWKN5jIaH0TzgR2BjYtcuioYfmbY917Qckcs57x0GJy+tjYJBltiDRZJP2sf05aows
         /+wa3AW9aK0zQxdc/E2bLPSQIfHgLbH0ktmTAhWTM/2FN4+AZ+ETzH4G9NW/fsnT4XOE
         vUbASaVwcqTo8P85cMtiSOAQM2AYnnd4GbBWUKEfSWuXf9AUau6E9h/NhPs5K/SrnOtc
         m2V5i5n6oIVxiMJFLt/PhQCXtk6JS3w+tXlNt42jmNlfMlfDyINj5zA9RYIKjDpUBWRJ
         8MQ/wq/Tv826du8zwqFsuN67v23T2yTQR4VSPrLtpO9zf1q0AHyvYe6Fpyf4p4a90vcr
         eoqA==
X-Gm-Message-State: APt69E2r9J98BnlDPz+HnEuWVDA+ZDZIVVX4cBfuXUkeR7a5rNdpQCxu
        95aj62mHiojUPGB5rtwddOeNSkTi3pI=
X-Google-Smtp-Source: ADUXVKI0maBBq4z5a0dAXE3EN2/arxx7erN5OTbJZoLdZKt1aoc/454ZMltmkl7EngUXqlIy9DUxXg==
X-Received: by 2002:a17:902:b110:: with SMTP id q16-v6mr17581882plr.286.1528707680516;
        Mon, 11 Jun 2018 02:01:20 -0700 (PDT)
Received: from localhost.localdomain ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id a23-v6sm51358347pgd.85.2018.06.11.02.01.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 02:01:18 -0700 (PDT)
From:   r@hev.cc
To:     linux-mips@linux-mips.org, paul.burton@mips.com
Cc:     jhogan@kernel.org, ralf@linux-mips.org, Heiher <r@hev.cc>
Subject: [PATCH v5] MIPS: Fix ejtag handler on SMP
Date:   Mon, 11 Jun 2018 17:01:10 +0800
Message-Id: <20180611090110.27978-1-r@hev.cc>
X-Mailer: git-send-email 2.17.1
Return-Path: <r@hev.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64223
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
 arch/mips/kernel/genex.S | 46 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 37b9383eacd3..6c257b52f57f 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -354,16 +354,56 @@ NESTED(ejtag_debug_handler, PT_SIZE, sp)
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
+	ASM_CPUID_MFC0 k1, ASM_SMP_CPUID_REG
+	PTR_SRL	k1, SMP_CPUID_PTRSHIFT
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
+	ASM_CPUID_MFC0 k1, ASM_SMP_CPUID_REG
+	PTR_SRL	k1, SMP_CPUID_PTRSHIFT
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
@@ -377,6 +417,12 @@ ejtag_return:
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

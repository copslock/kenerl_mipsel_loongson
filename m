Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Nov 2018 18:02:19 +0100 (CET)
Received: from mail-wm1-x343.google.com ([IPv6:2a00:1450:4864:20::343]:51649
        "EHLO mail-wm1-x343.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992922AbeKLRBIjOm6A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Nov 2018 18:01:08 +0100
Received: by mail-wm1-x343.google.com with SMTP id w7-v6so9217460wmc.1
        for <linux-mips@linux-mips.org>; Mon, 12 Nov 2018 09:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C2sX+hDQ3Df81Enc00bH7e6G7yh2CFtnAPDDDHGXYwQ=;
        b=B3VGkaJ08XpgpuGafm+ayVvlR4ORrKc6bhVJEN7pyOkfJT4TiriuxqVpWS98QQjQBU
         nAsADKcv8yun9D4Ozp3CHwpG6KFOO5s/EtJvwPMkc9SnG1lSjLP6Dr5V9tje0/A9sC0S
         c2FHoobH7NOy7yqWfHEhSifFgdGrAVVUwZUI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C2sX+hDQ3Df81Enc00bH7e6G7yh2CFtnAPDDDHGXYwQ=;
        b=VDBYG+UQJIeN+YpTVM7+gZP6SR/rltfWX/SOrVq5Qc2pDSMPEs1lAofE4sMaBg0H3F
         65nmFqDfhVBFTYwySZnHxIwHn9RXGU1Qx3F3MrKdFc1cevc7pq+2uzsjbTsMJLBwUsUL
         AgHo7gX8xNdKqz8urikaKKbNLfhlWVfuOOKa3/9OSVPqlH55pNa7hUZhcI4P81x7Ggql
         LHr2lZp2cJOsoWL5IEmYqAKaUZE5A67mH7ztjfFv8JmM9LSvEv7BRPG8YhfKCAfmhCNl
         JtNmDKytEo5fHHIRYFZwVRoo6rF9321sHnTDd5+up76j35i8BKejESm7DvlSYYGE1cCF
         sGxA==
X-Gm-Message-State: AGRZ1gKfnt6muBxUoqhcRqSd1xS6hlT7WU/MBn31UUyvosx88IDiEssq
        YoK18qc9S8aHmhJtjGq7mifygw==
X-Google-Smtp-Source: AJdET5dNNcKoWQCY84GuyCSuaEFRfCoBglFN9SKKZ22zgzRsLdk9GZjh9lBWNR4ReNL3akS+mcc9fw==
X-Received: by 2002:a1c:2104:: with SMTP id h4-v6mr372217wmh.130.1542042068219;
        Mon, 12 Nov 2018 09:01:08 -0800 (PST)
Received: from max-pc.synapse.com ([195.238.92.77])
        by smtp.gmail.com with ESMTPSA id u13-v6sm11835344wrn.11.2018.11.12.09.01.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 09:01:07 -0800 (PST)
From:   Maksym Kokhan <maksym.kokhan@globallogic.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Andrii Bordunov <andrew.bordunov@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Maksym Kokhan <maksym.kokhan@globallogic.com>
Subject: [PATCH v2 2/2] mips: sort list of configs for Malta
Date:   Mon, 12 Nov 2018 19:00:59 +0200
Message-Id: <20181112170059.7199-2-maksym.kokhan@globallogic.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181112170059.7199-1-maksym.kokhan@globallogic.com>
References: <20181112170059.7199-1-maksym.kokhan@globallogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <maksym.kokhan@globallogic.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67251
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maksym.kokhan@globallogic.com
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

Sort configs in menu "Machine selection" under MIPS_MALTA.

Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
Signed-off-by: Andrii Bordunov <andrew.bordunov@gmail.com>
---
 arch/mips/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index fe4c28275271..2ac32dac90b7 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -494,22 +494,23 @@ config MIPS_MALTA
 	select BOOT_RAW
 	select BUILTIN_DTB
 	select CEVT_R4K
-	select CSRC_R4K
 	select CLKSRC_MIPS_GIC
 	select COMMON_CLK
+	select CSRC_R4K
 	select DMA_MAYBE_COHERENT
 	select GENERIC_ISA_DMA
 	select HAVE_PCSPKR_PLATFORM
-	select IRQ_MIPS_CPU
-	select MIPS_GIC
 	select HW_HAS_PCI
 	select I8253
 	select I8259
+	select IRQ_MIPS_CPU
+	select LIBFDT
 	select MIPS_BONITO64
 	select MIPS_CPU_SCACHE
+	select MIPS_GIC
 	select MIPS_L1_CACHE_SHIFT_6
-	select PCI_GT64XXX_PCI0
 	select MIPS_MSC
+	select PCI_GT64XXX_PCI0
 	select SMP_UP if SMP
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_MIPS32_R1
@@ -528,16 +529,15 @@ config MIPS_MALTA
 	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_MICROMIPS
+	select SYS_SUPPORTS_MIPS16
 	select SYS_SUPPORTS_MIPS_CMP
 	select SYS_SUPPORTS_MIPS_CPS
-	select SYS_SUPPORTS_MIPS16
 	select SYS_SUPPORTS_MULTITHREADING
+	select SYS_SUPPORTS_RELOCATABLE
 	select SYS_SUPPORTS_SMARTMIPS
 	select SYS_SUPPORTS_VPE_LOADER
 	select SYS_SUPPORTS_ZBOOT
-	select SYS_SUPPORTS_RELOCATABLE
 	select USE_OF
-	select LIBFDT
 	select ZONE_DMA32 if 64BIT
 	help
 	  This enables support for the MIPS Technologies Malta evaluation
-- 
2.19.1

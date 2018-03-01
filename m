Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Mar 2018 03:36:35 +0100 (CET)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:34389
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992404AbeCACg2B2cb8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Mar 2018 03:36:28 +0100
Received: by mail-pg0-x242.google.com with SMTP id m19so1752305pgn.1;
        Wed, 28 Feb 2018 18:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=GK7mr2MxFGvUjY2IXdfBQmqqTQdMKQ8BUS2U7hPiY6I=;
        b=GpArE7OBW8J7zE2r+vF6iJleTPio63979NHmcjAz2kDcpZayH9+zxFU6MnmcANVntr
         tO3QvSh3f9Hur8RRCC31LepxIvR1atScxVEE6yItnuE1/c+gCM84sybGB49EJx4r2o1M
         fBAjl7loLUTHujsabyWIz0U3jlkVREbAE0vIZynnK6NVSWAznQxMTc7RLmcyHjWTKbOi
         SMk1s3LVTo/dqc13/R2jTliL6JaG9qObOdpy1XGQ9BMC4Dis4J2AoQHjBS6NJJgzuezz
         IuOW061Ev9mh9oBEAscczB+JBAbrUX6jeNBauvzRtI5R9h9ZJScrSNZowKZ34uuK5lMZ
         sLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=GK7mr2MxFGvUjY2IXdfBQmqqTQdMKQ8BUS2U7hPiY6I=;
        b=V+3laCKqmJrEq8X+u/5u3eOMx1oC96Ix474s4wtB0WayFe32/3Y3bO3/BozLYTHk4S
         X1FSlMJTpmyxm7XgxKYvoPNTNv12yu05az4qfI9ozhZSjyJLTWLoTwywH2r2EkO9H5FZ
         Cdj5VhUIyJstPhqgkC9ni6xcOtlGWR84IKV7Hydt4PzSeGEZPhLG76oLWRUKL9UTbgzf
         5gkWu6fcAfUZ5UMIKex2pq9fBikMGiIXPQbPx4H8OdLSMSf6hugjCOfjpxo0TFbDVwg7
         Ibj0aiJiF4HhLCjFW4wo+FU8cMPBL0Ge9jrlv2XgINmblEj6LUp04jpMj8R1/UKURsFJ
         tntg==
X-Gm-Message-State: APf1xPAPwN6CaZTu4bRMXo4qN3i1cZgymUhfM36NKGH4rnXHMsBxGSEL
        O4OKYRdciq/mpbZvn11eq2g8MA==
X-Google-Smtp-Source: AG47ELvTd0cULHuY5UROjgrQLuiz9RpyRRFfHtmMdlBT/U1O/atVnhbcwxPhYjrpttkRbVdyGb8K2g==
X-Received: by 10.99.4.197 with SMTP id 188mr223734pge.359.1519871780533;
        Wed, 28 Feb 2018 18:36:20 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id e83sm5987745pfk.148.2018.02.28.18.36.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Feb 2018 18:36:19 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 1/2] MIPS: Loongson64: Select ARCH_MIGHT_HAVE_PC_PARPORT
Date:   Thu,  1 Mar 2018 10:37:41 +0800
Message-Id: <1519871862-14624-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Commit a211a0820d3c8e7a ("MIPS: Push ARCH_MIGHT_HAVE_PC_PARPORT down to
platform level") moves the global MIPS ARCH_MIGHT_HAVE_PC_PARPORT
select down to various platforms, but doesn't add it to Loongson64
platforms which need it, so add the selects to these platforms too.

Fixes: a211a0820d3c8e7a ("MIPS: Push ARCH_MIGHT_HAVE_PC_PARPORT down to platform level")
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/loongson64/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
index bc2fdbf..12812a8b 100644
--- a/arch/mips/loongson64/Kconfig
+++ b/arch/mips/loongson64/Kconfig
@@ -7,6 +7,7 @@ choice
 config LEMOTE_FULOONG2E
 	bool "Lemote Fuloong(2e) mini-PC"
 	select ARCH_SPARSEMEM_ENABLE
+	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select CEVT_R4K
 	select CSRC_R4K
 	select SYS_HAS_CPU_LOONGSON2E
@@ -33,6 +34,7 @@ config LEMOTE_FULOONG2E
 config LEMOTE_MACH2F
 	bool "Lemote Loongson 2F family machines"
 	select ARCH_SPARSEMEM_ENABLE
+	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select BOARD_SCACHE
 	select BOOT_ELF32
 	select CEVT_R4K if ! MIPS_EXTERNAL_TIMER
@@ -62,6 +64,7 @@ config LEMOTE_MACH2F
 config LOONGSON_MACH3X
 	bool "Generic Loongson 3 family machines"
 	select ARCH_SPARSEMEM_ENABLE
+	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select GENERIC_ISA_DMA_SUPPORT_BROKEN
 	select BOOT_ELF32
 	select BOARD_SCACHE
-- 
2.7.0

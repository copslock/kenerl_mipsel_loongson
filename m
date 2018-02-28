Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2018 03:07:30 +0100 (CET)
Received: from mail-pl0-x241.google.com ([IPv6:2607:f8b0:400e:c01::241]:44610
        "EHLO mail-pl0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991855AbeB1CHOio0tM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Feb 2018 03:07:14 +0100
Received: by mail-pl0-x241.google.com with SMTP id w21-v6so589927plp.11;
        Tue, 27 Feb 2018 18:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=xUDAX+grc/AgP2PTrnzHtZ7pbfSnM1b58rzLe/IzoPU=;
        b=Yn99jk7+z+82JlVo/d8c+pjZNipRtbvpmZmzpy71fRi4e+skBDXTnOa8EhodUie6jN
         2380rxY/xoZBiHiF+le0kZUdcTFOU4keZ8/fycVy5YGO0ZoXrTk3kRuH1wBi0Ctk2n+A
         fboJQUE6vbU2TVRJhsNaSZzqpkbNePCkLKeDQG+iqWNjUqIEI+XRQEWErkWIUUlFYA4n
         Ipwxi7QnoITULVytFi5dXSDGFosg5mjk7KLN86K44APeaaup22Fduk0w1qaQHU6GUNQZ
         WzzlPeMJ1h/VjbpaMny8Et0LuRAM4cz5nr1HBYCODhj2y7HgdFeOOyQd7yW9scQra/O7
         pszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=xUDAX+grc/AgP2PTrnzHtZ7pbfSnM1b58rzLe/IzoPU=;
        b=ipligQ1Sv4rgEY4U1dGa7jA6kdzdohFjfrxdNpViMdIvRmWtkeMMxArfuUsrhsGn4G
         1qKW4mW+tMeNgQpCPjPY9yUuzh07+RPoDc4wVeHhcZ9hNksxJKUMBxW3u2snAuzbgDfZ
         QW7eMDblG/tTh6czhQMGeNd6xt7AzK3jW47Rp5x1u/LU3CirJ3aysjULRCt7oOQ7QZBI
         Q2S6XZVMB/rOmmLjW7iwR4EJVVdiK8KF302LHHZChwJcLQA5nKIPSTtUAneFY6ZqaTD9
         owZT5SnZFF3bkjheL2SfzTahFP4Y86GjRPxW1E7soRqa/d/IhkxNqQp2Y8tPJ0mCq51i
         ROYg==
X-Gm-Message-State: APf1xPCjUy3s0W8sSHLZYRHMDJHan6U/YFMdP5bHnXDEvcQ/VVpIg8l+
        YnSaBrdwx9HRXs1Axh2YxpfOhA==
X-Google-Smtp-Source: AG47ELsJiXQlQ+4E/dZ57ukhg4UBVfzoki+9n1zXAbamT2WHxAqNVOHH6CXa8cV8YGyKhFfm7sUO5g==
X-Received: by 2002:a17:902:4083:: with SMTP id c3-v6mr8019077pld.70.1519783627845;
        Tue, 27 Feb 2018 18:07:07 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id h186sm610804pfg.15.2018.02.27.18.07.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Feb 2018 18:07:07 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH] MIPS: Loongson64: Select ARCH_MIGHT_HAVE_PC_SERIO
Date:   Wed, 28 Feb 2018 10:08:34 +0800
Message-Id: <1519783714-23127-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62730
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

Commit 7a407aa5e0d3e587 ("MIPS: Push ARCH_MIGHT_HAVE_PC_SERIO down to
platform level") breaks Loongson64 platforms, so fix it.

Fixes: 7a407aa5e0d3e587 ("MIPS: Push ARCH_MIGHT_HAVE_PC_SERIO down to platform level")
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/loongson64/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
index bc2fdbf..5da4934 100644
--- a/arch/mips/loongson64/Kconfig
+++ b/arch/mips/loongson64/Kconfig
@@ -7,6 +7,7 @@ choice
 config LEMOTE_FULOONG2E
 	bool "Lemote Fuloong(2e) mini-PC"
 	select ARCH_SPARSEMEM_ENABLE
+	select ARCH_MIGHT_HAVE_PC_SERIO
 	select CEVT_R4K
 	select CSRC_R4K
 	select SYS_HAS_CPU_LOONGSON2E
@@ -33,6 +34,7 @@ config LEMOTE_FULOONG2E
 config LEMOTE_MACH2F
 	bool "Lemote Loongson 2F family machines"
 	select ARCH_SPARSEMEM_ENABLE
+	select ARCH_MIGHT_HAVE_PC_SERIO
 	select BOARD_SCACHE
 	select BOOT_ELF32
 	select CEVT_R4K if ! MIPS_EXTERNAL_TIMER
@@ -62,6 +64,7 @@ config LEMOTE_MACH2F
 config LOONGSON_MACH3X
 	bool "Generic Loongson 3 family machines"
 	select ARCH_SPARSEMEM_ENABLE
+	select ARCH_MIGHT_HAVE_PC_SERIO
 	select GENERIC_ISA_DMA_SUPPORT_BROKEN
 	select BOOT_ELF32
 	select BOARD_SCACHE
-- 
2.7.0

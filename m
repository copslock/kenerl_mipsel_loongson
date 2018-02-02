Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2018 05:01:51 +0100 (CET)
Received: from mail-lf0-x243.google.com ([IPv6:2a00:1450:4010:c07::243]:34211
        "EHLO mail-lf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994864AbeBBDz2uHXX0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Feb 2018 04:55:28 +0100
Received: by mail-lf0-x243.google.com with SMTP id k19so29491442lfj.1;
        Thu, 01 Feb 2018 19:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vzq0cfQudcToqxXeWpjUcK6wO+1IVaYcF40K5uNRIIg=;
        b=goyuMJyDduJrI0VSltOjQueBkMk5ffgI5F9kGDaCl0J5xVR8lGx9ppyabRAu1f1vkf
         MBdktNwmfLH5t1bAoOBel15qnPeDC1wDSsAGY402EDtCFZiwN5rx6rmnoVp+ikBCxAhG
         Kv/i8yT6Fhv9YRczseSItR3G9nKDu9DD3HyM5xhfy443H3Uf209HXsdwUBnr+Q8vSZjm
         9g79djFiZTBmOLyQFNyaTAO2MmdYVntpitxn+YKR1eoeNNZVpqItpvOcCEsFBGfLF+Ub
         jy6bYI0AZJizCj88aSG30Gyue+vXCTIM3TOja4r3m1/svOPbL4As5QkNMJ82IFfxNMDO
         eoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vzq0cfQudcToqxXeWpjUcK6wO+1IVaYcF40K5uNRIIg=;
        b=QcrUwZci54wZDEfNhE3h4ZkF0Gi8wJZ/qnF/qDbagNg3jWpZxYCmISZvPLW32X/Avo
         NMkj/mWXkTBm0fb58SNBOWUtqITN0geQuCauNEph0iP/1HsEYQOIncvLCK0OePR00dh5
         s2BgmB3oBZ889U93Z7MlwHTAA388YtCqLg3EXs9bmVsSrLxztDqlnDFG8estw0ayqpSf
         F4CWcVGAeqpN9w3Iqdu9z382QhjS/rGT12CwU9VJL8aDtMdd4jj4T5wTmDtykkKLcjNo
         WQ5iuMGzLdHKxXx9LLKWdBKP7b197DQ/HYK2n6vmUjLiCudaVYKng0/6KbxSb7Dg/Amu
         mY5w==
X-Gm-Message-State: AKwxytdBf3dbiZZim9GFhbkyL3W7Y1Z+EnHQRAuDlbheQzi1chbacXsU
        Nhp+OJWZtNok4Pa4wSdnbdkG8zgd
X-Google-Smtp-Source: AH8x227lJPeuEPfMvXmUkS/Ar8GBEWS9TbUqMgJFmg9JNPgrlpcpB2U8roCt15N/lXokzM4ADlrYVA==
X-Received: by 10.46.65.69 with SMTP id o66mr18968006lja.97.1517543723110;
        Thu, 01 Feb 2018 19:55:23 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id f14sm190934lje.84.2018.02.01.19.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 19:55:22 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, miodrag.dinic@mips.com, jhogan@kernel.org,
        goran.ferenc@mips.com, david.daney@cavium.com,
        paul.gortmaker@windriver.com, paul.burton@mips.com,
        alex.belits@cavium.com, Steven.Hill@cavium.com
Cc:     alexander.sverdlin@nokia.com, matt.redfearn@mips.com,
        kumba@gentoo.org, marcin.nowakowski@mips.com, James.hogan@mips.com,
        Peter.Wotton@mips.com, Sergey.Semin@t-platforms.ru,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v2 15/15] MIPS: memblock: Deactivate bootmem allocator
Date:   Fri,  2 Feb 2018 06:54:58 +0300
Message-Id: <20180202035458.30456-16-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180202035458.30456-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

Memblock allocator can be successfully used from now for early
memory management

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 350a990fc719..434f756e03e9 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -4,7 +4,6 @@ config MIPS
 	default y
 	select ARCH_BINFMT_ELF_STATE
 	select ARCH_CLOCKSOURCE_DATA
-	select ARCH_DISCARD_MEMBLOCK
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_MIGHT_HAVE_PC_PARPORT
@@ -57,6 +56,7 @@ config MIPS
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
+	select NO_BOOTMEM
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_MOD_ARCH_SPECIFIC
-- 
2.12.0

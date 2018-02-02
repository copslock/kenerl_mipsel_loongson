Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2018 04:56:39 +0100 (CET)
Received: from mail-lf0-x243.google.com ([IPv6:2a00:1450:4010:c07::243]:44174
        "EHLO mail-lf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991025AbeBBDzM4X6I0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Feb 2018 04:55:12 +0100
Received: by mail-lf0-x243.google.com with SMTP id v188so29426215lfa.11;
        Thu, 01 Feb 2018 19:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sjRAUl87kIegWEIMHZzr7JdOnoFmHax22DhSBJQMzT0=;
        b=hLRlSNZ51RxHwDULI62dwlLQw6SyOgDDIFCnC1ZXYOt2V888CGkcQGcecDiYwsXY1V
         6T8nTryBvxFQu0Rj75/7TCSwsprwz9PcbIpNmaEuME5Ie0cu+c7RieYMwwJxi8Qt50q7
         6EQCJnWDZULTh+473pTutOVZ2qeCDnPdyr2elkQEZhSlgOM7bXtNq15FzVt+AqKsd8PN
         roko/i7B6Ycpoj9gB5jgz7vMOrM6Hm8Fo5uHpu3MLzM52cT8ipLLmxu21dJ3YBKhlkj1
         Dmo3YY3BEHT8J0qLTD/h/gyfXD7KpAm0lJWYN2P5eFdAY150uVovEWDCDk+HWh1Syp8x
         Kriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sjRAUl87kIegWEIMHZzr7JdOnoFmHax22DhSBJQMzT0=;
        b=rM9ltyYh4fHLMtoh12LC7B3imELLJMSSqRomKqsqYaor/mQwie16CkV+GaXpDPOcrQ
         wOKNjrXeYu2MKdt1kQcK6rPbxVheWPI7kr85gdFFxHcGilzWgxw8KRdUoumNH8+v8eXN
         ADL65jaOQomZ1YC5mUee9ugmFC++Ly/ywCIM7Yc3oM91aeDsnIMfTJqToYE16IZHF/QA
         LHu5Zj1hmFDLR0TNd5cL4otR8gTfvtsBW/u0MhnGpQRqmL+cWBnz1uTkH3AvglxLQMGd
         wLPid1s6ODpp3SfwIlVohZjF8aP6bMSqKtz1c/MvGoqCcxaQk9FuXQe139TGSQcGTyUr
         PnjQ==
X-Gm-Message-State: AKwxytd8qKValToK1hHfKZuFX75bRHxtrSrXXFamWysjNlUqNvIXigzT
        8+oiCWbnJYd1Hj9vn2dOc0kbSvJi
X-Google-Smtp-Source: AH8x226LDzJkDQYWyySFH9nJk3CmjDqfcxan4eiUSlD9j0X4VwFGT+9q9D9zWDgJcbkt7BbP0NdexQ==
X-Received: by 10.46.41.12 with SMTP id u12mr11095980lje.52.1517543707172;
        Thu, 01 Feb 2018 19:55:07 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id f14sm190934lje.84.2018.02.01.19.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 19:55:06 -0800 (PST)
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
Subject: [PATCH v2 03/15] MIPS: memblock: Reserve initrd memory in memblock
Date:   Fri,  2 Feb 2018 06:54:46 +0300
Message-Id: <20180202035458.30456-4-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180202035458.30456-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62410
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

There is no reserve_bootmem() method in the nobootmem interface,
so we need to replace it with memblock-specific one.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index f502cd702fa7..a015cee353be 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -330,7 +330,7 @@ static void __init finalize_initrd(void)
 
 	maybe_bswap_initrd();
 
-	reserve_bootmem(__pa(initrd_start), size, BOOTMEM_DEFAULT);
+	memblock_reserve(__pa(initrd_start), size);
 	initrd_below_start_ok = 1;
 
 	pr_info("Initial ramdisk at: 0x%lx (%lu bytes)\n",
-- 
2.12.0

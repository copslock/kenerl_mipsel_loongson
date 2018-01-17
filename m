Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2018 23:27:55 +0100 (CET)
Received: from mail-lf0-x242.google.com ([IPv6:2a00:1450:4010:c07::242]:33952
        "EHLO mail-lf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994704AbeAQWXiVZtXP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Jan 2018 23:23:38 +0100
Received: by mail-lf0-x242.google.com with SMTP id k19so3754415lfj.1;
        Wed, 17 Jan 2018 14:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JFJQLVbQKdnw2gxDDATV58fcC+qGfo8oVCqOxuzgIp4=;
        b=cjkMjWPNf4xj9i5AuDWIVo5G3SbJxM/BssHonLmkkrHXIyNxA7/bsf8Wfwr3tgLNRw
         JQMSNYuy7cYtPUBX0Wahxu9xCO9oUQd9sggbdrDMUI3jB+OycPlE+fLZ2hpbWJdCxTmj
         pqXLuQQ6VHAPyP4d5RvQu9e1zvAVN3MiytNHR0GArM2yq49S3Tle+1eygguO6NUCDr2k
         /WgfpXrnBFe1MM/ZL2CieeB34zlZzC/kaHmuXOPIustJUbdcscbksmzML6YX+ciWtd9G
         ubLti/pvmgQk2h+VRJhcdRjrLtOD+RZN5V0C2k2Y4OkzQcyoM49cArDF0mWt6OcLZlxx
         lL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JFJQLVbQKdnw2gxDDATV58fcC+qGfo8oVCqOxuzgIp4=;
        b=N3fMN2s+fMqqJM8jx2OtwJbg8dciskWJBLq6PQ1X+KUKTDCbZAFEyJ/mVMk7QSLqq/
         OFOO/0SuM+gb1wXY2DiHgpyNB8wMDBNduBE029bNGLPxFxknMv1hFdiW4F3AJfm9NWnx
         5VIO6N+OOiC5TLoyhLPGhEhtNz0j1ykXCszJslkymRpyYBiepP6UCnk1SvVrsFaSh6gO
         SIw7zwc36epH+P2q+XRBeaOdiB6NGkPF0YUsEFi4d+l/QidRXECEuhriX64SKg+SVNeT
         oL34bmY/nTlC3/tXBljZ5OcVbhzvsBXae9eyrghGI2c5OkLGG5dsBtqEaRVVf5xjS46B
         Vo5Q==
X-Gm-Message-State: AKwxytc71KrtMuqaK3qzxk3ClOsRkAKYzwAOFTlcIlQsLGqtjckh/FG+
        kIXfsUhSb9glaes5Rrkq+CuSVgem
X-Google-Smtp-Source: ACJfBosC3Yk9oGcVU/5WReTziO2BXQ/ChcVCMhjUKYcHRw3JAEOLFlM9yr2bdqHUw5os3kMAcEorlg==
X-Received: by 10.46.15.2 with SMTP id 2mr1533911ljp.144.1516227812616;
        Wed, 17 Jan 2018 14:23:32 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id l203sm953867lfb.59.2018.01.17.14.23.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Jan 2018 14:23:32 -0800 (PST)
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
Subject: [PATCH 10/14] MIPS: memblock: Perform early low memory test
Date:   Thu, 18 Jan 2018 01:23:08 +0300
Message-Id: <20180117222312.14763-11-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180117222312.14763-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62221
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

Low memory can be tested at this point, since all the
reservations have just been finished without much of
additional allocations.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 82c6b77f6..b65047d85 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -873,6 +873,8 @@ static void __init arch_mem_init(char **cmdline_p)
 	memblock_allow_resize();
 
 	memblock_dump_all();
+
+	early_memtest(PFN_PHYS(min_low_pfn), PFN_PHYS(max_low_pfn));
 }
 
 static void __init resource_init(void)
-- 
2.12.0

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2018 23:27:27 +0100 (CET)
Received: from mail-lf0-x243.google.com ([IPv6:2a00:1450:4010:c07::243]:46051
        "EHLO mail-lf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994678AbeAQWXg7WdTa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Jan 2018 23:23:36 +0100
Received: by mail-lf0-x243.google.com with SMTP id x196so3985435lfd.12;
        Wed, 17 Jan 2018 14:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PjQmpoL4LcnxXx4VdXrwOEUjzy3XazCV4rZU/XP3kzA=;
        b=pMemN6FasuaBJAjlm8U1LxdBW8oFGCVdLjAdtsce/YF6liUsnY2VqaGDaWAh5KMF25
         N3VmuREELKpStd9aOrNV2LB1lz4TYwCH1n8ny3F/j2kp6Xd764RE/JCB4iqw0Nl+bRP6
         fDncGCqdcEg33RbsDkrMNCxMF4TrtQiGTvrPFM0BC2pryZmsVal/nN4BFhYolW9K6Ye6
         woxj2Vdw0RKPuIDFE9qOLasYj7EvvMOo2FBk+Foxj9KLEZ4FXiZf0YPcUa056g5pgCii
         CTLjgD4ostLIwV2DD5UfLQ5KUysG0Xhg7BbMFF/OhFVEQxjc2RLNQbxX3hCqSxLIUdXu
         AbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PjQmpoL4LcnxXx4VdXrwOEUjzy3XazCV4rZU/XP3kzA=;
        b=Lb3dyp/pCzvBQISW4ZIA0A0DzjsRiVucsRRD+HKY8nieTxULyeDpdDVqfJDicg8mL5
         t9EGRLUK8gGezhV+1G2hJWm0UxkuXj9adp6/mvy9tURkFdFuV9frwy3AwRFX6hkJ6k5b
         zkATAj5NY5vU8qDX7tF3v4fv6WuI5lD+01LD9iS5TQefIMfs3Rs4wB+uBxZBhP90VVqj
         kohgdEW99A0VZh/VKODfizSMS+sDkYVez8a+62vtji8lrvWu4LA16JAifSJS//uJQhja
         i0ySof1Wq3JqCGFtCL/cSYDdYHgnH/QKcW8XANL4LeKTJIBgn0LG41aQubxCO4/INNQd
         o5fA==
X-Gm-Message-State: AKGB3mLM04kUVk8Psxn2pQjQoA1FBlhhTBI5pby79Hg3FYGQs1WTskWa
        MYNSwB8HjAki2yeb1qGMk6n8IAdU
X-Google-Smtp-Source: ACJfBovJwupHoFbJU8oIXT6Yfa7nXadbl8ReptrAGOZ/3+ryAvA7Y17w3kOI+S8Oi05U/ymPeagTvg==
X-Received: by 10.46.69.84 with SMTP id s81mr28107331lja.96.1516227811256;
        Wed, 17 Jan 2018 14:23:31 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id l203sm953867lfb.59.2018.01.17.14.23.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Jan 2018 14:23:30 -0800 (PST)
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
Subject: [PATCH 09/14] MIPS: memblock: Allow memblock regions resize
Date:   Thu, 18 Jan 2018 01:23:07 +0300
Message-Id: <20180117222312.14763-10-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180117222312.14763-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62220
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

When all the main reservations are done the memblock regions
can be dynamically resized. Additionally it would be useful to have
memblock regions dumped on debug at this point.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index e0ca0d2bc..82c6b77f6 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -869,6 +869,10 @@ static void __init arch_mem_init(char **cmdline_p)
 	plat_swiotlb_setup();
 
 	dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
+
+	memblock_allow_resize();
+
+	memblock_dump_all();
 }
 
 static void __init resource_init(void)
-- 
2.12.0

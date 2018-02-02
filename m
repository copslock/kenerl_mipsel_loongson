Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2018 05:00:06 +0100 (CET)
Received: from mail-lf0-x243.google.com ([IPv6:2a00:1450:4010:c07::243]:38604
        "EHLO mail-lf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994858AbeBBDzXkdMq0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Feb 2018 04:55:23 +0100
Received: by mail-lf0-x243.google.com with SMTP id g72so29417967lfg.5;
        Thu, 01 Feb 2018 19:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OT3OKTxb6E0AUmlfLAacgJX+yna8Pz527Gm9MkRjrnE=;
        b=GCU7X3LcUhjO3tgHdVkL6YYRaYWf2FjXXRIDJMlDqItYa7AE8WobImkDB6lCRbtEL7
         MovpkTTkvM+zm07zEkwHY9UtzY8/Q9jPmoTN5Qx+Recj9kT3q87S86KqrKlm4iWdGJWj
         zSdFKfMOF91kiaIlO1kmDT33rskOFbDF9/vWTOcCWCgu1jNmk/RW4ApMZrSP7cs3486h
         hr8raH6OvcDeeeRwDV5MPi06AfL/pCFEgdvAStCeU21DKr3zNWzYSo3aVl4oDsdVGpFb
         +pTNpQdNgDNENJqdur77m2qKd+3civUvgN2gp9CEvqENr+7KAEkfFqGI5wMtB9xrooKm
         LcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OT3OKTxb6E0AUmlfLAacgJX+yna8Pz527Gm9MkRjrnE=;
        b=gpawZ/riuIVSnOi5U9D1o2/ZdiI1ynLgj5L3ASjL+stcjQQ2bcS26IyGpOp3p61gCp
         gs5GRLX7pTyhwoV3x1qqt+reuycMBXt3xHBXgG9LQVTsOhEqqBunMW03FI+ZNFuvF2l9
         OAw6giNSC0lvom2J9CjUWcJ4Y47pMnuFiTojIutoEHiVpi154TYJS42nP4akqCIEJntk
         GRjav6fgbFqLrb3OsWBHUwJBhFFDSPJID6K+nXnBAysW/RHslkiYNarfO5WhM1s8CPb9
         L2ETKKI+8xNYa4uoTgl1iobDIoS+JnvBsu9gwkZHwR4xqHx9lhcLM6ett1ReTXJDAGem
         zQ5Q==
X-Gm-Message-State: AKwxytfiVV2NoyLsfBAv9NrDJHvKfEKBvSMFT+JRtrATnSiTLGDMvizm
        8vS+ElQQQNWuysmzmrpuHesnvDKK
X-Google-Smtp-Source: AH8x227fKZvE6PQGWbdqwwwadhRdoifscUaI1NYnp7zVTFy/bGKye1oylFfXt01tOhNJ7HwCpYJmnA==
X-Received: by 10.46.54.20 with SMTP id d20mr2484772lja.51.1517543717944;
        Thu, 01 Feb 2018 19:55:17 -0800 (PST)
Received: from linux.local ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id f14sm190934lje.84.2018.02.01.19.55.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 19:55:17 -0800 (PST)
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
Subject: [PATCH v2 11/15] MIPS: memblock: Perform early low memory test
Date:   Fri,  2 Feb 2018 06:54:54 +0300
Message-Id: <20180202035458.30456-12-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180202035458.30456-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62418
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
index 531a1471a2a4..a0eac8160750 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -850,6 +850,8 @@ static void __init arch_mem_init(char **cmdline_p)
 	memblock_allow_resize();
 
 	memblock_dump_all();
+
+	early_memtest(PFN_PHYS(min_low_pfn), PFN_PHYS(max_low_pfn));
 }
 
 static void __init resource_init(void)
-- 
2.12.0

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 19:53:40 +0100 (CET)
Received: from mail-wr0-x244.google.com ([IPv6:2a00:1450:400c:c0c::244]:42260
        "EHLO mail-wr0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990397AbeABSx3r3NJ0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 19:53:29 +0100
Received: by mail-wr0-x244.google.com with SMTP id w107so23584790wrb.9;
        Tue, 02 Jan 2018 10:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xi/2NR0kDxqCZEyXlP9wwPIvA1C4oEhzDBcuag3xhhY=;
        b=uaWmfjFZ/kPGsIeacq66sl3viKOiedxNJblDc11depLggaxLWErVC9m8yYadKOvgsJ
         M6pvl3GgPfo4KFMwDoh+1ymiv0BMZIrHedF9X936se8/21KqtBco4bJHW1atDDYAE8bF
         DCyjWQ1V/IkrX2EjX8dqnp/CI0D8/bziFkX8vqLsbI4tpAwelEaSK2OCxnDjO2/XzDHw
         hXJkPQ/tPjvMnZVH1FM04grF95sU2PrW7KVNN8yNBXzRxABzEdaJ2QCuhnwza+MYQxnx
         2Qc644Z5gHADlDlIcTOhqRjYc+tYdXzF2DSNhl2VQVushfNxED8QUHa3nyX3a5/XGO+N
         RM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Xi/2NR0kDxqCZEyXlP9wwPIvA1C4oEhzDBcuag3xhhY=;
        b=iiGHVEmFBdj68aG7nvZYU2wlpgUZKFMosNOyFt00oahf5EX2lOsbIHErmeYm/4Yvl1
         gH+lfdIRGQMtnZ2S7dG8aGt3qGQJ+heTnN1uAF/pPzm5LaHQS6BV9tc4q8rvm/7Ia+NQ
         ME6uQJXbK7oqalGrGYysld/ScVPhhmpIcjDQ6jdEAluSLGilYpEfFBsOnFlX+6WSfKiM
         RiY1nr+2b66XqXwfkA+z0TgMiWgq3tgCG1S9IFYsnmDP/9zst7lSAh/izPQszStk35yP
         cd/tjfuAN4AvJAvSqL56+rxhsAwc3Sue7gAoH56S1M/2CRJgk2dPDqhuIywS+AIYWXPP
         GyFA==
X-Gm-Message-State: AKGB3mLlMEMkTlTc9txMlz4yyp1z6BURCbkaTsmqbGICBvPDbKLf/+Gr
        iroxSb1+sIB5rXGBRWLffqg=
X-Google-Smtp-Source: ACJfBotR+lWVXX0PcIxW6Vkt17e8IC6218vEq9HRqEVQ5pbysC/curYKSIsfdnqDSg+Zy1ooJ/s8/g==
X-Received: by 10.223.172.146 with SMTP id o18mr19460212wrc.127.1514919204220;
        Tue, 02 Jan 2018 10:53:24 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id 47sm89845926wru.27.2018.01.02.10.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jan 2018 10:53:23 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 9A3DA10C2747; Tue,  2 Jan 2018 19:53:22 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     James Hogan <james.hogan@mips.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] MIPS: Remove a warning when PHYS_OFFSET is 0x0
Date:   Tue,  2 Jan 2018 19:53:15 +0100
Message-Id: <20180102185316.9190-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171226113717.15074-2-malat@debian.org>
References: <20171226113717.15074-2-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61864
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

Rewrite the comparison in `else if` statement, case where `min_low_pfn >
ARCH_PFN_OFFSET` has already been checked in the first `if` statement:

  if (min_low_pfn > ARCH_PFN_OFFSET) {

Fix non-fatal warning during compilation using W=1:

arch/mips/kernel/setup.c: In function ‘bootmem_init’:
arch/mips/kernel/setup.c:461:25: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
  } else if (min_low_pfn < ARCH_PFN_OFFSET) {
                         ^

Reviewed-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: clarify W=1 in commit message
 arch/mips/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 68db4bdd3255..791dc78b132b 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -459,7 +459,7 @@ static void __init bootmem_init(void)
 		pr_info("Wasting %lu bytes for tracking %lu unused pages\n",
 			(min_low_pfn - ARCH_PFN_OFFSET) * sizeof(struct page),
 			min_low_pfn - ARCH_PFN_OFFSET);
-	} else if (min_low_pfn < ARCH_PFN_OFFSET) {
+	} else if (ARCH_PFN_OFFSET - min_low_pfn > 0UL) {
 		pr_info("%lu free pages won't be used\n",
 			ARCH_PFN_OFFSET - min_low_pfn);
 	}
-- 
2.11.0

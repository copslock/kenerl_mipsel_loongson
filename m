Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Mar 2018 21:27:38 +0100 (CET)
Received: from mx1.mailbox.org ([80.241.60.212]:63856 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994630AbeCPU1b2jOD1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Mar 2018 21:27:31 +0100
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id F3A7242A24;
        Fri, 16 Mar 2018 21:27:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id w2Ckv0PsMHy1; Fri, 16 Mar 2018 21:27:24 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, jhogan@kernel.org
Cc:     john@phrozen.org, dev@kresin.me, linux-mips@linux-mips.org,
        martin.blumenstingl@googlemail.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 0/3] MIPS: lantiq: fixes for clocks and Amazon SE
Date:   Fri, 16 Mar 2018 21:27:08 +0100
Message-Id: <20180316202711.488-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

This fixes multiple bugs which were introduced when changing the driver
for the reset controller unit. The mid term plan is to move these SoCs
to the common clock framework and replace most of the code in sysctrl.c.

Mathias Kresin (3):
  MIPS: lantiq: fix Danube USB clock
  MIPS: lantiq: enable AHB Bus for USB
  MIPS: lantiq: ase: Enable MFD_SYSCON

 arch/mips/lantiq/Kconfig        | 2 ++
 arch/mips/lantiq/xway/sysctrl.c | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.11.0

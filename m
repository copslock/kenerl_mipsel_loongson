Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Mar 2015 05:53:13 +0100 (CET)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35359 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006150AbbCZExLxDJSA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Mar 2015 05:53:11 +0100
Received: by pacwz10 with SMTP id wz10so491858pac.2;
        Wed, 25 Mar 2015 21:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=+BP5jkdKf/ddqj29b12uhgubV0jo6Xaam0H4hr1W7MU=;
        b=cwGcv+ZtIm908y+w2LJZxNGRRZdcIKDyTXkilu3v/tVtgIw1CT7GoiuDtG2A2FvKXs
         IPLXvepHNDtsG7BBYZBaXVGA721QmGQDGVz4t7ARABzvuUJ+qobP/FDDVUkwVSHNVbCk
         gMQHhtQ9NPSB4mi2EIA2RJeHXXyfd7jnALUX3Ba69Dg1igtyTy6vEgMhyBNF3hq1fKIk
         Nr6F5yy0yhB3naPIxO2j3JGmADbofZEKNRVmsd3iTXobSHXvP9mHaEaNg5yAK+SqnDtY
         5MnQq590gsoOWHCSVmwIb2OrYn8NXydVkxF2eViRsS2Vneb9HajrFRbf5jAMxUPtiY/B
         rm6w==
X-Received: by 10.66.221.194 with SMTP id qg2mr23549003pac.106.1427345585599;
        Wed, 25 Mar 2015 21:53:05 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id gl2sm4047456pbc.52.2015.03.25.21.53.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Mar 2015 21:53:04 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, cernekee@gmail.com, jaedon.shin@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 0/2] BMIPS: trivial fixes
Date:   Wed, 25 Mar 2015 21:51:35 -0700
Message-Id: <1427345497-15299-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Hi Ralf,

First patch is a respin of http://patchwork.linux-mips.org/patch/8848/ to fix
the build on MIPS64 platforms that you reported.

Second patch prevents a "choice" to be leaking to other MIPS platforms.

This is against upstream-sfr.git/mips-for-linux-next.

Thanks!

Florian Fainelli (1):
  MIPS: BMIPS: restrict DTB selection to BMIPS_GENERIC

Kevin Cernekee (1):
  MIPS: BMIPS: Flush the readahead cache after DMA

 arch/mips/bmips/Kconfig       |  4 ++++
 arch/mips/include/asm/bmips.h |  2 +-
 arch/mips/mm/dma-default.c    | 15 +++++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

-- 
2.1.0

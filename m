Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Apr 2015 04:41:19 +0200 (CEST)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35646 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007426AbbDCClRx6nk2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Apr 2015 04:41:17 +0200
Received: by patj18 with SMTP id j18so102407542pat.2;
        Thu, 02 Apr 2015 19:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=lWNoywWi8pWCoNf7IJly/CRyHSHbYWrkp0+r2jKXteI=;
        b=XTAt/5/IApUu07gBRuAs0GJj+u6dE88firddNSgesRXfkMYF5CLxGzggqLypLRbyJ+
         VnXXooSsI+qjbhtRaV8OQlZaRLuZRe+1/gLm3o1zma89FOUo4vFjjL9Pvsgx2BtAjUCu
         UeOvHwC/xFP+U/26N/RHI86DoutBIU44CHJOrJZiLV4pfbyulkNUsP97jXcd0S48upV1
         evJKJghZ2ivbTbraPFpIDGnEdR1zR4j+tDzEx5h48v0pL4VK6DgHQx8f5iFR8UU09sBU
         h5xWgbJTDsQp2w3AgLAOaaJAnjf2qDvAuLRvUAJmyyPRsnNwDxa+MHTraPRj1PVs8jC7
         f+Vw==
X-Received: by 10.68.109.197 with SMTP id hu5mr532681pbb.126.1428028872767;
        Thu, 02 Apr 2015 19:41:12 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id fk4sm6492867pbb.80.2015.04.02.19.41.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Apr 2015 19:41:11 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, cernekee@gmail.com, jogo@openwrt.org,
        mbizon@freebox.fr, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 0/2] Make BMIPS dma-coherence usable outside of mach-bmips
Date:   Thu,  2 Apr 2015 19:40:17 -0700
Message-Id: <1428028819-28236-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46711
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

This patch creates a bmips-dma-coherence.h file such that we can share it
between mach-bmips and mach-bcm63xx, since they are both using BMIPS
processors.

Patches against mips-for-linux-next.

Thanks!

Florian Fainelli (2):
  MIPS: BMIPS: Create bmips-dma-coherence.h
  MIPS: BCM63xx: Utilize bmips-dma-coherence.h

 arch/mips/include/asm/bmips-dma-coherence.h        | 68 ++++++++++++++++++++++
 arch/mips/include/asm/mach-bcm63xx/dma-coherence.h |  6 ++
 arch/mips/include/asm/mach-bmips/dma-coherence.h   | 64 +-------------------
 3 files changed, 75 insertions(+), 63 deletions(-)
 create mode 100644 arch/mips/include/asm/bmips-dma-coherence.h
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/dma-coherence.h

-- 
2.1.0

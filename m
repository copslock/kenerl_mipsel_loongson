Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jan 2014 07:08:39 +0100 (CET)
Received: from mail-oa0-f53.google.com ([209.85.219.53]:33926 "EHLO
        mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823056AbaANGIgfIxAH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jan 2014 07:08:36 +0100
Received: by mail-oa0-f53.google.com with SMTP id i7so271279oag.40
        for <multiple recipients>; Mon, 13 Jan 2014 22:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=SNi18cXZLg3ao83FO0kWmGakNv63ec/wSRFCQtR9mK0=;
        b=kYiSVuLRz9cvtFJh4kZyM2pOkXTT3EBzIeWvOiN5JYxmuJ+TU4qiOognoc8ssmMgrU
         n3wuc383aCapTcyemx1oozIZw6PtP8T1nFtbUnt/6djHR6yjdnYV1xLsJwPWu5feli0j
         pKkn0ZMOiD6kZzK68lXfRkk4M+xtJie6vZQSF5aq8YhTlvyD+SkpTBZ2Q0hL46EGS64S
         nsoaffG53ahfal/ozsYkBiszRobKE7ljL7b6SXBnepa7WKcB0Niob9JcBPe9ITAHm6CY
         35v39kw+b5Pi5ZuYcYlFLr7k1Oo/BCpF/DegqJBCiHl5fgseUEpUa3ZSp51qVl4CQQ/r
         qEdg==
X-Received: by 10.183.3.102 with SMTP id bv6mr23859230obd.18.1389679709620;
        Mon, 13 Jan 2014 22:08:29 -0800 (PST)
Received: from localhost.localdomain (ip68-5-18-231.oc.oc.cox.net. [68.5.18.231])
        by mx.google.com with ESMTPSA id nw5sm24074812obc.9.2014.01.13.22.08.28
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 13 Jan 2014 22:08:29 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, jogo@openwrt.org,
        mbizon@freebox.fr, cernekee@gmail.com, dgcbueu@gmail.com,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH v3 0/3] MIPS: L1_CACHE_SHIFT updates
Date:   Mon, 13 Jan 2014 22:07:29 -0800
Message-Id: <1389679652-14269-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.8.3.2
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38966
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

From: Florian Fainelli <florian@openwrt.org>

This patchset cleanups the MIPS_L1_CACHE_SHIFT values and also fixes it
for Broadcom BCM63xx DSL SOCs.

Thanks!

Rebased on top of John's mips-next-3.14.

Florian Fainelli (3):
  MIPS: introduce MIPS_L1_CACHE_SHIFT_<N>
  MIPS: update MIPS_L1_CACHE_SHIFT based on MIPS_L1_CACHE_SHIFT_<N>
  MIPS: BCM63XX: select correct MIPS_L1_CACHE_SHIFT value

 arch/mips/Kconfig              | 26 +++++++++++++++++++++++---
 arch/mips/pmcs-msp71xx/Kconfig |  1 +
 arch/mips/ralink/Kconfig       |  1 +
 3 files changed, 25 insertions(+), 3 deletions(-)

-- 
1.8.3.2

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Sep 2015 21:02:37 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:60057 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013620AbbIQTCP5nQ3U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Sep 2015 21:02:15 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B0F291415C5;
        Thu, 17 Sep 2015 19:02:13 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id A0A631415C2; Thu, 17 Sep 2015 19:02:13 +0000 (UTC)
Received: from sboyd-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 043B814159E;
        Thu, 17 Sep 2015 19:02:12 +0000 (UTC)
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Andy Gross <agross@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Walmsley <paul@pwsan.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: [PATCH v2 0/3] Add __ioread32_copy() and use it
Date:   Thu, 17 Sep 2015 12:02:08 -0700
Message-Id: <1442516531-16071-1-git-send-email-sboyd@codeaurora.org>
X-Mailer: git-send-email 2.6.0.rc2.11.g3da0120
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sboyd@codeaurora.org
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

The SMD driver is reading and writing chunks of data to iomem,
and there's an __iowrite32_copy() function for the writing part, but
no __ioread32_copy() function for the reading part. This series
adds __ioread32_copy() and uses it in two places. Andrew is on Cc in
case this should go through the -mm tree. Otherwise the target
of this patch series is SMD, so I've sent it to Andy.

Note this patch series relies on a previous patch on the list that
changes the readl() to __raw_readl() in the smd driver[1].

Changes since v1:
 * Dropped weak from __ioread32_copy()

Stephen Boyd (3):
  lib: iomap_copy: Add __ioread32_copy()
  soc: qcom: smd: Use __ioread32_copy() instead of open-coding it
  FIRMWARE: bcm47xx_nvram: Use __ioread32_copy() instead of open-coding

 drivers/firmware/broadcom/bcm47xx_nvram.c | 11 +++--------
 drivers/soc/qcom/smd.c                    | 13 ++++---------
 include/linux/io.h                        |  1 +
 lib/iomap_copy.c                          | 21 +++++++++++++++++++++
 4 files changed, 29 insertions(+), 17 deletions(-)

[1] http://lkml.kernel.org/g/1441234011-4259-7-git-send-email-sboyd@codeaurora.org

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

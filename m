Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 22:02:01 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:48755 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011384AbbJWUB5rKJMZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 22:01:57 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 4AEF513EE0C;
        Fri, 23 Oct 2015 20:01:55 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id 3509513EF60; Fri, 23 Oct 2015 20:01:55 +0000 (UTC)
Received: from sboyd-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C08A713EE0C;
        Fri, 23 Oct 2015 20:01:53 +0000 (UTC)
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Andy Gross <agross@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@sonymobile.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Paul Walmsley <paul@pwsan.com>, linux-mips@linux-mips.org,
        David Howells <dhowells@redhat.com>, linux-soc@vger.kernel.org
Subject: [PATCH v3 0/4] Add __ioread32_copy() and use it
Date:   Fri, 23 Oct 2015 13:01:48 -0700
Message-Id: <1445630512-10888-1-git-send-email-sboyd@codeaurora.org>
X-Mailer: git-send-email 2.6.2.281.g6766aa3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49663
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
adds __ioread32_copy() and uses it in two places.

This is a respin with some small fixes found with soaking in -next.

Andrew, the patches should apply cleanly to linux-next, so I hope
you can pick them up directly now, instead of the previous plan where
they would go through Andy's tree.

Changes from v2:
 * Make bcm patch actually compile
 * Add new patch for frv to avoid warnings

Cc: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Rafał Miłecki <zajec5@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: linux-mips@linux-mips.org
Cc: David Howells <dhowells@redhat.com>
Cc: linux-soc@vger.kernel.org

Stephen Boyd (4):
  frv: io: Accept const void pointers for read{b,w,l}()
  lib: iomap_copy: Add __ioread32_copy()
  soc: qcom: smd: Use __ioread32_copy() instead of open-coding it
  FIRMWARE: bcm47xx_nvram: Use __ioread32_copy() instead of open-coding

 arch/frv/include/asm/io.h                 | 17 ++++++++++++++---
 drivers/firmware/broadcom/bcm47xx_nvram.c | 11 +++--------
 drivers/soc/qcom/smd.c                    | 13 ++++---------
 include/linux/io.h                        |  1 +
 lib/iomap_copy.c                          | 21 +++++++++++++++++++++
 5 files changed, 43 insertions(+), 20 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

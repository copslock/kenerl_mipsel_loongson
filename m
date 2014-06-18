Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2014 14:35:44 +0200 (CEST)
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:56845 "EHLO
        mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859952AbaFRMfkwbMrW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jun 2014 14:35:40 +0200
X-IronPort-AV: E=Sophos;i="5.01,499,1400050800"; 
   d="scan'208";a="35032614"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw2-out.broadcom.com with ESMTP; 18 Jun 2014 05:39:59 -0700
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Wed, 18 Jun 2014 05:35:32 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.174.1; Wed, 18 Jun 2014 05:35:32 -0700
Received: from netl-oss-2.ban.broadcom.com (unknown [10.132.128.135])   by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 435BB9F9F7;  Wed, 18 Jun
 2014 05:35:30 -0700 (PDT)
From:   <ganesanr@broadcom.com>
To:     <kristina.martsenko@gmail.com>, <gregkh@linuxfoundation.org>
CC:     Ganesan Ramalingam <ganesanr@broadcom.com>,
        <jchandra@broadcom.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, <netdev@vger.kernel.org>
Subject: [PATCH 0/3] XLR/XLS network driver update and fixes
Date:   Wed, 18 Jun 2014 18:43:55 +0530
Message-ID: <cover.1403096668.git.ganesanr@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <ganesanr@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ganesanr@broadcom.com
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

From: Ganesan Ramalingam <ganesanr@broadcom.com>

Patches has following changes:

 * Fixed compilation failure caused by change in COP2 API
 * SGMII PHY address calculation was wrong, fixed
 * Updated the driver to have single parent device for a XLR/XLS
   network block with multiple network devices under it
 * Fixed comment format

Ganesan Ramalingam (3):
  Staging: Fix compilation error
  Staging: PHY address calculation fix
  Staging: Move all the netdev under single parent device per
    controller

 drivers/staging/netlogic/TODO           |    1 -
 drivers/staging/netlogic/platform_net.c |  213 ++++++++++++----------
 drivers/staging/netlogic/platform_net.h |    7 +-
 drivers/staging/netlogic/xlr_net.c      |  301 +++++++++++++++++--------------
 drivers/staging/netlogic/xlr_net.h      |    8 +-
 5 files changed, 292 insertions(+), 238 deletions(-)

-- 
1.7.9.5

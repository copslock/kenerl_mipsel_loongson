Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jan 2014 21:35:31 +0100 (CET)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:5250 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6870574AbaAJUf1spAyb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jan 2014 21:35:27 +0100
X-IronPort-AV: E=Sophos;i="4.95,640,1384329600"; 
   d="scan'208";a="8852232"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw1-out.broadcom.com with ESMTP; 10 Jan 2014 12:48:04 -0800
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.1.438.0; Fri, 10 Jan 2014 12:35:19 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP Server id
 14.1.438.0; Fri, 10 Jan 2014 12:35:19 -0800
Received: from fainelli-desktop.broadcom.com (unknown [10.12.164.252])  by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 3213B246A3;  Fri, 10 Jan
 2014 12:35:19 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>, <blogic@openwrt.org>, <jogo@openwrt.org>,
        <mbizon@freebox.fr>, <cernekee@gmail.com>, <dgcbueu@gmail.com>,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 0/3] MIPS: L1_CACHE_SHIFT updates
Date:   Fri, 10 Jan 2014 12:35:11 -0800
Message-ID: <1389386114-31834-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.8.3.2
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

Ralf, John,

This patchset cleanups the MIPS_L1_CACHE_SHIFT values and also fixes it
for Broadcom BCM63xx DSL SOCs.

Thanks!

Florian Fainelli (3):
  MIPS: introduce MIPS_L1_CACHE_SHIFT_<N>
  MIPS: update MIPS_L1_CACHE_SHIFT based on MIPS_L1_CACHE_SHIFT_<N>
  MIPS: BCM63XX: select correct MIPS_L1_CACHE_SHIFT value

 arch/mips/Kconfig              | 27 +++++++++++++++++++++++----
 arch/mips/pmcs-msp71xx/Kconfig |  1 +
 arch/mips/ralink/Kconfig       |  1 +
 3 files changed, 25 insertions(+), 4 deletions(-)

-- 
1.8.3.2

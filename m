Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 13:03:12 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6066 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012172AbcBCMDLDriCM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 13:03:11 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id CB9F63D72D05F;
        Wed,  3 Feb 2016 12:03:02 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 12:03:05 +0000
Received: from localhost (10.100.200.105) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 12:03:04 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/6] pch_gbe fixes for Imagination Technologies MIPS Boston
Date:   Wed, 3 Feb 2016 12:02:38 +0000
Message-ID: <1454500964-6256-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.105]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

This series has been extracted from an earlier larger series adding
support for the Imagination Technologies MIPS Boston development board.
The current version of that series without these patches included can be
found here:

    http://marc.info/?l=linux-mips&m=145449909110835&w=2

This series is somewhat standalone & should fix theoretical issues for
other users of the driver, but has only been tested by myself in
conjunction with the above series on a Boston board.

Paul Burton (6):
  net: pch_gbe: Allow build on MIPS platforms
  net: pch_gbe: Mark Minnow PHY reset GPIO active low
  net: pch_gbe: Pull PHY GPIO handling out of Minnow code
  net: pch_gbe: Always reset PHY along with MAC
  net: pch_gbe: Add device tree support
  net: pch_gbe: Allow longer for resets

 drivers/net/ethernet/oki-semi/pch_gbe/Kconfig      |  2 +-
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h    |  4 +-
 .../net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c   | 71 ++++++++++++++++++----
 3 files changed, 62 insertions(+), 15 deletions(-)

-- 
2.7.0

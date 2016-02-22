Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Feb 2016 23:39:51 +0100 (CET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:58533 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010147AbcBVWjtyEswQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Feb 2016 23:39:49 +0100
Received: from localhost.localdomain (85-76-167-245-nat.elisa-mobile.fi [85.76.167.245])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 091A9699E3;
        Tue, 23 Feb 2016 00:39:49 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 0/3] MIPS: OCTEON: fill mac addresses with appended DTB
Date:   Tue, 23 Feb 2016 00:39:45 +0200
Message-Id: <1456180788-6803-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.4.0
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

When using appended DTB, the MAC addresses should be filled in
from the bootinfo.

A.

Aaro Koskinen (3):
  MIPS: OCTEON: device_tree_init: use separate pass to fill mac
    addresses
  MIPS: OCTEON: device_tree_init: don't fill mac if already set
  MIPS: OCTEON: device_tree_init: fill mac addresses when using appended
    dtb

 arch/mips/cavium-octeon/octeon-platform.c | 95 +++++++++++++++++++++++++------
 arch/mips/cavium-octeon/setup.c           |  8 +++
 2 files changed, 87 insertions(+), 16 deletions(-)

-- 
2.4.0

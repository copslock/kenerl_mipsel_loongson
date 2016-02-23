Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Feb 2016 23:52:30 +0100 (CET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:33989 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012446AbcBWWwLdqTYR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Feb 2016 23:52:11 +0100
Received: from localhost.localdomain (85-76-167-245-nat.elisa-mobile.fi [85.76.167.245])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id A62E623401C;
        Wed, 24 Feb 2016 00:52:10 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 0/3] MIPS: OCTEON: fill mac addresses with appended DTB
Date:   Wed, 24 Feb 2016 00:52:04 +0200
Message-Id: <1456267927-2492-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.4.0
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52182
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

v2:	Use is_valid_ether_addr()
	Added Acked-bys.

A.

Aaro Koskinen (3):
  MIPS: OCTEON: device_tree_init: use separate pass to fill mac
    addresses
  MIPS: OCTEON: device_tree_init: don't fill mac if already set
  MIPS: OCTEON: device_tree_init: fill mac addresses when using appended
    dtb

 arch/mips/cavium-octeon/octeon-platform.c | 94 +++++++++++++++++++++++++------
 arch/mips/cavium-octeon/setup.c           |  8 +++
 2 files changed, 86 insertions(+), 16 deletions(-)

-- 
2.4.0

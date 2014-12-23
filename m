Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Dec 2014 13:29:36 +0100 (CET)
Received: from nivc-ms1.auriga.com ([80.240.102.146]:36335 "EHLO
        nivc-ms1.auriga.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008504AbaLWM3emj5Mv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Dec 2014 13:29:34 +0100
Received: from localhost (80.240.102.213) by NIVC-MS1.auriga.ru
 (80.240.102.146) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 23 Dec
 2014 15:29:26 +0300
From:   Aleksey Makarov <aleksey.makarov@auriga.com>
To:     <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>
Subject: [PATCH 0/3] MIPS: OCTEON: flash: syncronize bootbus access
Date:   Tue, 23 Dec 2014 15:26:58 +0300
Message-ID: <1419337623-16101-1-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.1.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [80.240.102.213]
Return-Path: <aleksey.makarov@auriga.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksey.makarov@auriga.com
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

- Use semaphore to protect access to bootbus.  
- Use device tree to probe for flash chips.

David Daney (3):
  MIPS: OCTEON: Add semaphore to serialize bootbus accesses.
  MIPS: OCTEON: Protect accesses to bootbus flash with
    octeon_bootbus_sem.
  MIPS: OCTEON: Use device tree to probe for flash chips.

 arch/mips/Kconfig                     |  1 +
 arch/mips/cavium-octeon/flash_setup.c | 84 ++++++++++++++++++++++++++++++++---
 arch/mips/cavium-octeon/setup.c       |  3 ++
 arch/mips/include/asm/octeon/octeon.h |  2 +
 4 files changed, 84 insertions(+), 6 deletions(-)

-- 
2.1.3

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2015 15:34:10 +0100 (CET)
Received: from nivc-ms1.auriga.com ([80.240.102.146]:61291 "EHLO
        nivc-ms1.auriga.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008192AbbCEOeHNtZf3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Mar 2015 15:34:07 +0100
Received: from localhost (80.240.102.213) by NIVC-MS1.auriga.ru
 (80.240.102.146) with Microsoft SMTP Server (TLS) id 14.3.224.2; Thu, 5 Mar
 2015 17:33:58 +0300
From:   Aleksey Makarov <aleksey.makarov@auriga.com>
To:     <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>
Subject: [PATCH v2 0/3] MIPS: OCTEON: flash: syncronize bootbus access
Date:   Thu, 5 Mar 2015 17:31:28 +0300
Message-ID: <1425565893-30614-1-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.3.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [80.240.102.213]
Return-Path: <aleksey.makarov@auriga.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46208
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

Changes in v2:

- Rebase to v4.0-rc2

Summary:

- Use semaphore to protect access to bootbus.  
- Use device tree to probe for flash chips.

Version 1:

https://lkml.kernel.org/g/<1419337623-16101-1-git-send-email-aleksey.makarov@auriga.com>

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
2.3.0

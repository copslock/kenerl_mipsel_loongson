Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Mar 2015 17:15:34 +0100 (CET)
Received: from nivc-ms1.auriga.com ([80.240.102.146]:54531 "EHLO
        nivc-ms1.auriga.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008821AbbCTQPdHsRWA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Mar 2015 17:15:33 +0100
Received: from localhost (80.240.102.213) by NIVC-MS1.auriga.ru
 (80.240.102.146) with Microsoft SMTP Server (TLS) id 14.3.224.2; Fri, 20 Mar
 2015 19:15:28 +0300
From:   Aleksey Makarov <aleksey.makarov@auriga.com>
To:     <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>
Subject: [PATCH 0/3] mips: OCTEON: Support for little-endian mode
Date:   Fri, 20 Mar 2015 19:11:55 +0300
Message-ID: <1426867920-7907-1-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.3.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [80.240.102.213]
Return-Path: <aleksey.makarov@auriga.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46478
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

These patches enable compiling and booting kernel on Octeon boards
in little-endian mode.

David Daney (3):
  MIPS: OCTEON: Handle bootloader structures in little-endian mode.
  MIPS: OCTEON: Add mach-cavium-octeon/mangle-port.h
  MIPS: OCTEON: Enable little endian kernel.

 arch/mips/Kconfig                                  |  3 +-
 arch/mips/cavium-octeon/octeon_boot.h              | 23 +++++++
 .../include/asm/mach-cavium-octeon/mangle-port.h   | 74 ++++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx-bootinfo.h       | 55 ++++++++++++++++
 4 files changed, 154 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/mangle-port.h

-- 
2.3.3

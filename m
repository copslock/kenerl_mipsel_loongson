Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Feb 2016 23:23:08 +0100 (CET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:52536 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010147AbcBVWXGzgmhK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Feb 2016 23:23:06 +0100
Received: from localhost.localdomain (85-76-167-245-nat.elisa-mobile.fi [85.76.167.245])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 1CAA93FD1;
        Tue, 23 Feb 2016 00:23:04 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 0/3] MIPS: OCTEON: Make DT "model" visible in /proc/cpuinfo
Date:   Tue, 23 Feb 2016 00:22:54 +0200
Message-Id: <1456179777-6247-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.4.0
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52163
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

This is a small cosmetic change to get rid of "Unsupported Board" in
/proc/cpuinfo with "pure DT" boards.

E.g. on EdgeRouter Pro this changes system type in /proc/cpuinfo from:

	system type             : Unsupported Board (CN6120p1.1-1000-NSP)

to:

	system type             : ubnt,e200 (CN6120p1.1-1000-NSP)

A.

Aaro Koskinen (3):
  MIPS: OCTEON: board_type_to_string: return NULL for unsupported board
  MIPS: OCTEON: initialize system type string after device tree init
  MIPS: OCTEON: use model string from DTB for unknown board type

 arch/mips/cavium-octeon/setup.c              | 23 +++++++++++++++++------
 arch/mips/include/asm/octeon/cvmx-bootinfo.h |  2 +-
 2 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.4.0

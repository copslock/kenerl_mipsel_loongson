Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jun 2014 00:00:06 +0200 (CEST)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:38849 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6859954AbaF0WAC3k6vY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Jun 2014 00:00:02 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 9D28156F84A;
        Sat, 28 Jun 2014 01:00:01 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id 2a95Dq+K4Xw3; Sat, 28 Jun 2014 00:59:55 +0300 (EEST)
Received: from cooljazz.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id EEAEE5BC01A;
        Sat, 28 Jun 2014 00:59:54 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 0/4] MIPS: OCTEON: run-time checks for HOTPLUG_CPU
Date:   Sat, 28 Jun 2014 00:59:48 +0300
Message-Id: <1403906392-10650-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.0.0
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40884
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

Here's a second attempt to be able to run an OCTEON kernel configured
with HOTPLUG_CPU on systems with legacy bootloaders that do not support it.

Aaro Koskinen (4):
  MIPS: OCTEON: SMP: delete redundant check
  MIPS: OCTEON: watchdog: don't jump to bootloader without entry address
  MIPS: OCTEON: support disabling HOTPLUG_CPU run-time
  MIPS: OCTEON: disable HOTPLUG_CPU if the bootloader version is
    incorrect

 arch/mips/cavium-octeon/smp.c      | 23 +++++++-------
 drivers/watchdog/octeon-wdt-main.c | 62 +++++++++++++++++++++-----------------
 2 files changed, 46 insertions(+), 39 deletions(-)

-- 
2.0.0

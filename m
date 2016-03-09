Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Mar 2016 21:09:17 +0100 (CET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:44277 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013477AbcCIUI4D5FUq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Mar 2016 21:08:56 +0100
Received: from localhost.localdomain (85-76-14-12-nat.elisa-mobile.fi [85.76.14.12])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 386A4188772;
        Wed,  9 Mar 2016 22:08:53 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 0/2] MIPS/PA-RISC: panic immediately when panic_on_oops
Date:   Wed,  9 Mar 2016 22:08:41 +0200
Message-Id: <1457554123-18491-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.4.0
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52565
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

MIPS and PA-RISC want to sleep 5 seconds before panicking when
panic_on_oops is set, with no apparent reason. We should remove
this feature, since some users may want their systems to fail as
quickly as possible.

Users who want to delay reboot after panic can use PANIC_TIMEOUT.

Also, this change will unify the behaviour with other architectures.

Aaro Koskinen (2):
  MIPS: panic immediately when panic_on_oops
  PA-RISC: panic immediately when panic_on_oops

 arch/mips/kernel/traps.c   | 5 +----
 arch/parisc/kernel/traps.c | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

-- 
2.4.0

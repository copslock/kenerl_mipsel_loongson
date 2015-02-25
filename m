Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2015 17:02:35 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:33442 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007272AbbBYQCe0VQNa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Feb 2015 17:02:34 +0100
Received: from p4fe256bb.dip0.t-ipconnect.de ([79.226.86.187]:42000 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1YQePc-0001vK-MG; Wed, 25 Feb 2015 17:02:13 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: [RFC V2 00/12] i2c: describe adapter quirks in a generic way
Date:   Wed, 25 Feb 2015 17:01:51 +0100
Message-Id: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
X-Mailer: git-send-email 2.1.4
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsa@the-dreams.de
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

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Here is the second version of the patch series to describe i2c adapter quirks
in a generic way. For the motivation, please read description of patch 1. This
is still RFC because I would like to do some more tests on my own, but I need
to write a tool for that. However, I'd really like to have the driver authors
to have a look already. Actual testing is very much appreciated. Thanks to the
Mediatek guys for rebasing their new driver to this framework. That helps, too!

The branch is also here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/quirks

Thanks,

   Wolfram

Major changes since V1:

* more fine-grained options to describe modes with combined messages.
  This should also cover the Mediatek HW now as well as all other
  permutations I can think of.

* the core code and at91 driver had to be refactored to reflect the
  above change

* added the bcm-iproc driver which came to mainline recently

Wolfram Sang (12):
  i2c: add quirk structure to describe adapter flaws
  i2c: add quirk checks to core
  i2c: at91: make use of the new infrastructure for quirks
  i2c: opal: make use of the new infrastructure for quirks
  i2c: qup: make use of the new infrastructure for quirks
  i2c: cpm: make use of the new infrastructure for quirks
  i2c: axxia: make use of the new infrastructure for quirks
  i2c: dln2: make use of the new infrastructure for quirks
  i2c: powermac: make use of the new infrastructure for quirks
  i2c: viperboard: make use of the new infrastructure for quirks
  i2c: pmcmsp: make use of the new infrastructure for quirks
  i2c: bcm-iproc: make use of the new infrastructure for quirks

 drivers/i2c/busses/i2c-at91.c       | 32 +++++++------------
 drivers/i2c/busses/i2c-axxia.c      | 11 ++++---
 drivers/i2c/busses/i2c-bcm-iproc.c  | 15 +++++----
 drivers/i2c/busses/i2c-cpm.c        | 20 ++++++------
 drivers/i2c/busses/i2c-dln2.c       | 12 +++----
 drivers/i2c/busses/i2c-opal.c       | 22 ++++++-------
 drivers/i2c/busses/i2c-pmcmsp.c     | 42 ++++++++++---------------
 drivers/i2c/busses/i2c-powermac.c   | 10 +++---
 drivers/i2c/busses/i2c-qup.c        | 21 ++++++-------
 drivers/i2c/busses/i2c-viperboard.c | 10 +++---
 drivers/i2c/i2c-core.c              | 62 +++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h                 | 43 +++++++++++++++++++++++++
 12 files changed, 191 insertions(+), 109 deletions(-)

-- 
2.1.4

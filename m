Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2015 18:22:28 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:53140 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010985AbbAIRW0vZ0V8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Jan 2015 18:22:26 +0100
Received: from p4fe257be.dip0.t-ipconnect.de ([79.226.87.190]:48230 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1Y9dGG-0000Lq-Bw; Fri, 09 Jan 2015 18:22:12 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
Subject: [RFC 00/11] i2c: add generic quirk infrastructure
Date:   Fri,  9 Jan 2015 18:21:30 +0100
Message-Id: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
X-Mailer: git-send-email 2.1.3
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45025
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

Recently, a number of submitted I2C master drivers could not fully handle all
I2C type transfers due to limited HW. So, they had to bail out with some errno
although the user supplied a valid I2C transfer. In order to centralize such
quirks, a central structure describing the quirks is introduced. The next patch
lets the core do the checks based on the information about the quirks. Then
existing drivers with quirks are converted.

This already has the advantage of avoiding code duplication and having
consistent error handling. Later, once the structure is tested and stable, we
can pass it over to the users, so they can actually check what the current HW
is capable of and react accordingly.

These patches are RFC and only build-tested so far. Yet, I wanted to show what
I am up to. I will do some testing on HW once I finished my task of fixing the
slave interface, hopefully after next week.

I'd really love to see this go into v3.20, but this will need assistance. I
really need testers, at least for the recent hardware. Other comments/reviews
are also appreciated.

Patches are based on v3.19-rc3 and the branch is here

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/quirks

Thanks,

   Wolfram


Wolfram Sang (11):
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

 drivers/i2c/busses/i2c-at91.c       | 32 ++++++++--------------
 drivers/i2c/busses/i2c-axxia.c      | 11 ++++----
 drivers/i2c/busses/i2c-cpm.c        | 20 +++++++-------
 drivers/i2c/busses/i2c-dln2.c       | 12 ++++-----
 drivers/i2c/busses/i2c-opal.c       | 22 +++++++--------
 drivers/i2c/busses/i2c-pmcmsp.c     | 42 +++++++++++------------------
 drivers/i2c/busses/i2c-powermac.c   | 10 +++----
 drivers/i2c/busses/i2c-qup.c        | 21 +++++++--------
 drivers/i2c/busses/i2c-viperboard.c | 10 ++++---
 drivers/i2c/i2c-core.c              | 53 +++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h                 | 35 ++++++++++++++++++++++++
 11 files changed, 167 insertions(+), 101 deletions(-)

-- 
2.1.3

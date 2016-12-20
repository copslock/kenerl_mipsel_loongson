Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Dec 2016 19:12:44 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:44274 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993301AbcLTSMhXQ802 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Dec 2016 19:12:37 +0100
From:   John Crispin <john@phrozen.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <john@phrozen.org>
Subject: [PATCH 0/7] arch: mips: ralink: new clocks, typos & co
Date:   Tue, 20 Dec 2016 19:12:39 +0100
Message-Id: <1482257566-61035-1-git-send-email-john@phrozen.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

This series contains a few patches that have accumulated inside the LEDE
tree over the last year.

John Crispin (7):
  arch: mips: ralink: MT7621 does not set its SoC type
  arch: mips: ralink: add missing I2C and I2S clocks
  arch: mips: ralink: add missing pinmux
  arch: mips: ralink: fix a typo in the pinmux setup
  arch: mips: ralink: add missing clk_round_rate()
  arch: mips: ralink: add missing symbol for highmem support
  arch: mips: ralink: cosmetic change to prom_init()

 arch/mips/include/asm/mach-ralink/mt7620.h |    7 ++++++-
 arch/mips/ralink/Kconfig                   |    1 +
 arch/mips/ralink/clk.c                     |    6 ++++++
 arch/mips/ralink/mt7620.c                  |   31 ++++++++++++++++++----------
 arch/mips/ralink/mt7621.c                  |    2 +-
 arch/mips/ralink/prom.c                    |    9 ++++----
 arch/mips/ralink/rt288x.c                  |    1 +
 arch/mips/ralink/rt305x.c                  |    2 ++
 arch/mips/ralink/rt3883.c                  |    2 ++
 9 files changed, 43 insertions(+), 18 deletions(-)

-- 
1.7.10.4

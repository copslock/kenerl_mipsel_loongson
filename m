Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jul 2014 21:29:47 +0200 (CEST)
Received: from seketeli.net ([94.23.218.202]:42186 "EHLO ms.seketeli.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6859936AbaGET3pJfCti (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 5 Jul 2014 21:29:45 +0200
Received: from amegan.ahome.fr (176-26-190-109.dsl.ovh.fr [109.190.26.176])
        by ms.seketeli.fr (Postfix) with ESMTPSA id 030282360035;
        Sat,  5 Jul 2014 21:29:45 +0200 (CEST)
Received: by amegan.ahome.fr (Postfix, from userid 1000)
        id 556D6A40601; Sat,  5 Jul 2014 21:30:15 +0200 (CEST)
From:   Apelete Seketeli <apelete@seketeli.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        John Crispin <blogic@openwrt.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Vinod Koul <vinod.koul@intel.com>, linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] Rename NOP transceiver in JZ4740 platform data
Date:   Sat,  5 Jul 2014 21:30:14 +0200
Message-Id: <1404588615-14722-1-git-send-email-apelete@seketeli.net>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <apelete@seketeli.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apelete@seketeli.net
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

Hello,

The name of the NOP transceiver driver was changed during v3.16
release cycle from usb_phy_gen_xceiv to usb_phy_generic.

The patch that comes as a follow up of this message renames
accordingly the NOP transceiver driver in JZ4740 platform data to fix
a subsequent kernel panic.

Changes since v1: 
  - specify commit 4525bee summary line in parens and give more
    details about the bug that was fixed in the commit message.

Please consider for merge in 3.16 if possible since it fixes an issue
that makes the Ben Nanonote unable to boot.

Changes were rebased on top of the linux-mips master branch, built and
tested successfully.

The following changes since commit bc0b9d9:

  Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux

are available in the git repository at:

  git://git.seketeli.net/~apelete/linux-mips.git rename-jz4740-xceiv

Apelete Seketeli (1):
  mips: jz4740: rename usb_nop_xceiv to usb_phy_generic

 arch/mips/jz4740/platform.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.7.10.4

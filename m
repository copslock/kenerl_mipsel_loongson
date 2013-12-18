Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2013 22:37:33 +0100 (CET)
Received: from seketeli.net ([91.121.166.71]:50295 "EHLO ms.seketeli.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867286Ab3LRVhUGmvkk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Dec 2013 22:37:20 +0100
Received: from localhost (176-26-190-109.dsl.ovh.fr [109.190.26.176])
        by ms.seketeli.net (Postfix) with ESMTP id 3C627EA074;
        Wed, 18 Dec 2013 23:12:17 +0100 (CET)
Received: by localhost (Postfix, from userid 1000)
        id 00CE8A401AB; Wed, 18 Dec 2013 22:36:59 +0100 (CET)
From:   Apelete Seketeli <apelete@seketeli.net>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] Add defconfig for Ben NanoNote
Date:   Wed, 18 Dec 2013 22:36:58 +0100
Message-Id: <1387402619-22921-1-git-send-email-apelete@seketeli.net>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <apelete@seketeli.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38753
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

Following a few patches sent to the linux-usb mailing list to add USB
support for the Ingenic JZ4740 MIPS SoC found in the Ben Nanonote,
here is patch that adds defconfig for the aforementioned device.

Ben NanoNote is a handheld computer built by the Qi-Hardware community
and is already supported in the kernel, albeit missing a defconfig
file until now.

Changes were rebased on top of Ralf Baechle's Linux MIPS master
branch, built and tested on device successfully.

The following changes since commit a9b766365f58654af3b7d0a8f4e3504ccde26c23:

  Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux

are available in the git repository at:

  git://seketeli.fr/~apelete/linux-mips.git ben-config

Apelete Seketeli (1):
  mips: qi_lb60: add defconfig for Ben NanoNote

 arch/mips/configs/qi_lb60_defconfig |  188 +++++++++++++++++++++++++++++++++++
 1 file changed, 188 insertions(+)
 create mode 100644 arch/mips/configs/qi_lb60_defconfig

-- 
1.7.10.4

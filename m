Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jan 2014 17:20:02 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:54828 "EHLO localhost"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6827281AbaAQQTWQAumL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Jan 2014 17:19:22 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1W4C8T-0005A3-Pb; Fri, 17 Jan 2014 10:19:09 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     blogic@openwrt.org
Subject: [PATCH 0/3] MIPS: CMP: Add CPU hotplug support for CMP platforms.
Date:   Fri, 17 Jan 2014 10:18:52 -0600
Message-Id: <1389975535-62279-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: "Steven J. Hill" <Steven.Hill@imgtec.com>

Add CPU hotplug support for cores with a CM.

Steven J. Hill (3):
  MIPS: CMP: Add support for CPU hotplugging.
  MIPS: CMP: Malta: Add support for CPU hotplugging.
  MIPS: CMP: Malta: Enable CPU hotplug.

 arch/mips/Kconfig                |    1 +
 arch/mips/include/asm/amon.h     |    1 +
 arch/mips/include/asm/gcmpregs.h |    2 +
 arch/mips/kernel/irq-gic.c       |    6 +-
 arch/mips/kernel/smp-cmp.c       |  167 +++++++++++++++++++++++++++-----------
 arch/mips/mti-malta/malta-amon.c |  107 ++++++++++++++++++++----
 arch/mips/mti-malta/malta-int.c  |    2 +-
 7 files changed, 216 insertions(+), 70 deletions(-)

-- 
1.7.10.4

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Sep 2015 05:34:35 +0200 (CEST)
Received: from mail.base45.de ([80.241.61.77]:51931 "EHLO mail.base45.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006948AbbICDedb44Tw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Sep 2015 05:34:33 +0200
Received: from port-92-195-113-129.dynamic.qsc.de ([92.195.113.129] helo=lazus.yip)
        by mail.base45.de with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
        (Exim 4.82)
        (envelope-from <lynxis@fe80.eu>)
        id 1ZXLIB-0002XO-Qh; Thu, 03 Sep 2015 05:34:28 +0200
From:   Alexander Couzens <lynxis@fe80.eu>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 0/2] ath79 misc irq controller
Date:   Thu,  3 Sep 2015 05:34:20 +0200
Message-Id: <1441251262-13335-1-git-send-email-lynxis@fe80.eu>
X-Mailer: git-send-email 2.5.1
Return-Path: <lynxis@fe80.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lynxis@fe80.eu
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

Hi Alban,

I've done the requested changes.

Best,
Alex

v2:
 move new IRQ_DECLARE just behind the new init for ar7100
 don't remove newline
 add log line when setup ar7100 misc irq controller
 improve commit message for missing irq ack handler

Alexander Couzens (2):
  MIPS: ath79: set missing irq ack handler for ar7100-misc-intc irq chip
  MIPS: ath79: add irq chip ar7240-misc-intc

 .../interrupt-controller/qca,ath79-misc-intc.txt   | 18 ++++++++++++++++-
 arch/mips/ath79/irq.c                              | 23 ++++++++++++++++++++--
 2 files changed, 38 insertions(+), 3 deletions(-)

-- 
2.4.0

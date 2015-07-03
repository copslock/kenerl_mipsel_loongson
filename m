Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jul 2015 11:12:20 +0200 (CEST)
Received: from smtp2-g21.free.fr ([212.27.42.2]:13726 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008981AbbGCJMT2AQ4n (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Jul 2015 11:12:19 +0200
Received: from localhost.localdomain (unknown [78.50.173.214])
        (Authenticated sender: albeu)
        by smtp2-g21.free.fr (Postfix) with ESMTPA id 1AEFE4B0258;
        Fri,  3 Jul 2015 11:12:10 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-gpio@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH 0/2] MIPS: ath79: Move the GPIO driver to drivers/gpio
Date:   Fri,  3 Jul 2015 11:11:47 +0200
Message-Id: <1435914709-15092-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

Hi all,

as requested when I posted the ATH79 OF support serie, here is the move of
the GPIO driver to the GPIO drivers directory. While at it I also removed
the custom pinmux API as it not used by any board.

Alban

Alban Bedel (2):
  MIPS: ath79: Remove the unused GPIO function API
  MIPS: ath79: Move the GPIO driver to drivers/gpio

 arch/mips/ath79/Makefile  |   2 +-
 arch/mips/ath79/common.h  |   3 -
 arch/mips/ath79/gpio.c    | 279 ----------------------------------------------
 drivers/gpio/Makefile     |   1 +
 drivers/gpio/gpio-ath79.c | 236 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 238 insertions(+), 283 deletions(-)
 delete mode 100644 arch/mips/ath79/gpio.c
 create mode 100644 drivers/gpio/gpio-ath79.c

-- 
2.0.0

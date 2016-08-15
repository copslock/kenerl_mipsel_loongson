Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Aug 2016 22:32:49 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:50125 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992509AbcHOUbwMCwOS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Aug 2016 22:31:52 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id u7FKVHYZ026395
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 15 Aug 2016 13:31:17 -0700 (PDT)
Received: from yow-lpgnfs-02.wrs.com (128.224.149.8) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.248.2; Mon, 15 Aug 2016 13:31:16 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        John Crispin <john@phrozen.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 0/4] mips: demodularize non-modular drivers.
Date:   Mon, 15 Aug 2016 16:30:51 -0400
Message-ID: <20160815203055.20541-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.8.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

This series of commits is a part of a larger project to ensure
people don't reference modular support functions in non-modular
code.  Overall there was roughly 5k lines of dead code in the
kernel due to this.  So far we've fixed several areas, like tty,
x86, net, ... and we continue to work on other areas.

There are several reasons to not use module support for code that
can never be built as a module, but the big ones are:

 (1) it is easy to accidentally write unused module_exit and remove code
 (2) it can be misleading when reading the source, thinking it can be
     modular when the Makefile and/or Kconfig prohibit it
 (3) it requires the include of the module.h header file which in turn
     includes nearly everything else, thus adding to CPP overhead.
 (4) it gets copied/replicated into other code and spreads like weeds.

This represents the drivers actually using modular functions; there are
also drivers/files that include module.h but don't use any of the macros
or functions within it.  Those MIPS instances will be handled separately.

Paul.

---

Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Cc: John Crispin <john@phrozen.org>
Cc: "Rafał Miłecki" <zajec5@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

Paul Gortmaker (4):
  mips: bcm47xx: make serial explicitly non-modular
  mips: ralink: make timer explicitly non-modular
  mips: lantiq: make vmmc explicitly non-modular
  mips: lantiq: make xrx200_phy_fw explicitly non-modular

 arch/mips/bcm47xx/serial.c            | 11 ++++-------
 arch/mips/lantiq/xway/vmmc.c          |  6 ++----
 arch/mips/lantiq/xway/xrx200_phy_fw.c | 12 ++++--------
 arch/mips/ralink/timer.c              | 28 +++++++---------------------
 4 files changed, 17 insertions(+), 40 deletions(-)

-- 
2.8.4

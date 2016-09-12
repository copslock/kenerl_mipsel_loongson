Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2016 00:17:05 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:37612 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992209AbcILWQ6opDna (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Sep 2016 00:16:58 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id u8CMGk7e026780
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 12 Sep 2016 15:16:47 -0700 (PDT)
Received: from yow-lpgnfs-02.wrs.com (128.224.149.8) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.294.0; Mon, 12 Sep 2016 15:16:46 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bin Gao <bin.gao@intel.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 0/8] gpio: wean gpio/driver.h off of module.h
Date:   Mon, 12 Sep 2016 18:16:23 -0400
Message-ID: <20160912221631.15812-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.8.4
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55119
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

Most shared headers in include/linux don't need to know what the
internals of a struct module are; all they care about is that it
is a struct and hence they may require a pointer to one.

The advantage in this is that module.h is including a lot of stuff
itself, and an otherwise empty C file that just contains module.h
will result in ~750kB from CPP (compared to say 12kB from init.h)

So we have approximately 50 instances of "struct module;" in the
various include/linux headers already that help us keep module.h
out of other headers; here we do the same for gpio.

But before we do, we fix up seven instances of code that were
implicitly relying on this module.h so that we don't introduce
build failures into the git history.

Some are tristate, so we just explicitly add module.h to them.
The others are non-modular, so we just prune them off of the module
based macros, so that module.h is no longer required to compile.

This series built on top of linux-next for arm, arm64, i386, x86_64
without any issues (allmodconfig).

---

Cc: Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bin Gao <bin.gao@intel.com>
Cc: Keguang Zhang <keguang.zhang@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Paul Gortmaker (8):
  gpio: palmas: fix implicit assumption module.h is present
  gpio: sx150x: fix implicit assumption module.h is present
  gpio: ts4800: fix implicit assumption module.h is present
  gpio: altera: fix implicit assumption module.h is present
  gpio: ath79: fix implicit assumption module.h is present
  gpio: loongson1: fix implicit assumption module.h is present
  gpio: wcove: fix implicit assumption module.h is present
  gpio: don't include module.h in shared driver header

 drivers/gpio/gpio-altera.c    | 1 +
 drivers/gpio/gpio-ath79.c     | 1 +
 drivers/gpio/gpio-loongson1.c | 1 +
 drivers/gpio/gpio-palmas.c    | 1 -
 drivers/gpio/gpio-sx150x.c    | 2 --
 drivers/gpio/gpio-ts4800.c    | 1 +
 drivers/gpio/gpio-wcove.c     | 1 +
 include/linux/gpio/driver.h   | 2 +-
 8 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.8.4

Return-Path: <SRS0=FRkd=RF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5368C43381
	for <linux-mips@archiver.kernel.org>; Sat,  2 Mar 2019 17:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97BAA20836
	for <linux-mips@archiver.kernel.org>; Sat,  2 Mar 2019 17:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="cOCwtQgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfCBRxv (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 2 Mar 2019 12:53:51 -0500
Received: from tomli.me ([153.92.126.73]:41934 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbfCBRxu (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sat, 2 Mar 2019 12:53:50 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 4f1a9d35;
        Sat, 2 Mar 2019 17:53:47 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:3d30:3659)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sat, 02 Mar 2019 17:53:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding; s=1490979754; bh=Iu77gxni0hLs6Vm42KIrRqfu7CGwYdDyYrNUfOrmUHk=; b=cOCwtQgtvaIY5Bo6NqfwqCSK5S0KC8LjFyVfGoJrhATmuJq5/yDtgFP4y4Nskqbu7lzGkQOkBdOuRXRVSNqrJVut+KgNOLFYAZ0BeTb2csdk597nsrFWfF3Exeqr6WP6EcLYJmRqcci254YIRgXwDybvluVxEZjFwcB0ZaTB6JPRf/kCCQXAaRWAJtWadiNXpWdy+A9dy6m99wmhgNnLwlsIt/d1JRehnvpynvLcp20CWKLXeFXPnk4mmuFEDtiAfXE506zerY/3in8mkytvgMfv2Pq5M+ULLsKeXUJaHILlqhiTnQP31O2N4awFv5Ue//lObuhraIO7uuw/IEfujA==
From:   Yifeng Li <tomli@tomli.me>
To:     Lee Jones <lee.jones@linaro.org>, linux-mips@vger.kernel.org
Cc:     Yifeng Li <tomli@tomli.me>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Preliminary Platform Driver Support for Lemote Yeeloong Laptops
Date:   Sun,  3 Mar 2019 01:53:27 +0800
Message-Id: <20190302175334.5103-1-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Lemote Yeeloong is a laptop powered by Loongson 2F MIPS processor,
primarily a demo platform for hobbyists and developers. It uses an
ENE KB3310B Embedded Controller with customized firmware to implement
hardware and power management.

Due to the lack of separation of responsibilities and functions between
different subsystems, the original platform driver submitted to the
mailing list was a piece of monolithic module that implements numerous
drivers, as a result, it was never accepted.

This patch series was carefully reorganized and partially reimplemented
to avoid those pitfalls in the original driver. This is the first part
of the submission, which modifies the core MIPS code to introduce
preliminary preparation for other subdrivers. Notably, it leverages a
notify chain and MFD cells to avoid introducing unnecessary code into
the core MIPS subsystem.

It features the following...

* Create a MFD driver for KB3310B controller, and move the original
KB3310B controller code from mips/loongson64 to our new MFD driver.

* Add yeeloong_sci driver support of System Control Interrupt to
arch/mips/loongson64/lemote-2f. This piece of code is crucial and
has to be included in loongson64/lemote-2f because it reprograms CS5536
southbridge GPIO to handle the underlying interrupts.

* Originally, the SCI code was mixed into the hotkey driver. The new
yeeloong_sci driver was written to avoid introducing unrelated subdriver
code that is unsuitable for Linux/MIPS. It only handle a minimum set of
core operations directly related to the hardware platform, and pass the
events to other subdrivers via a notifier chain. As a result, the SCI
logic and the specific hotkey handling logic have been decoupled.

* Subdrivers - hwmon, battery, backlight, lcd and hotkey are registered
as MFD cells in the MFD driver. It means onlf the MFD driver is resposible
to register the upcoming subdrivers, the core board files mips/loongson64/
will not contain unrelated code.

I've done everything I can think of to factor unrelated code out of the
MIPS subsystem. I hope the refactored code would be acceptable now. Please
review my changeset to see whether it's appropriate.

Thanks,

Yifeng Li (7):
  mfd: yeeloong_kb3310b: support KB3310B EC for Lemote Yeeloong laptops.
  mips: loongson64: select MFD_YEELOONG_KB3310B for LEMOTE_MACH2F.
  mips: loongson64: remove ec_kb3310b.c, use MFD driver.
  mips: loongson64: remove yeeloong_report_lid_status from pm.c
  mips: loongson64: register per-board platform drivers for lemote-2f
  mips: loongson64: Support System Control Interrupts for Lemote
    Yeeloong.
  MAINTAINERS: add myself as a maintainer of MIPS/Loongson2 platform
    code.

 MAINTAINERS                                   |  16 +
 .../include/asm/mach-loongson64/loongson.h    |   3 +
 arch/mips/loongson64/Kconfig                  |   1 +
 arch/mips/loongson64/common/platform.c        |  15 +
 arch/mips/loongson64/lemote-2f/Makefile       |   2 +-
 arch/mips/loongson64/lemote-2f/ec_kb3310b.c   | 129 ------
 arch/mips/loongson64/lemote-2f/ec_kb3310b.h   | 188 ---------
 arch/mips/loongson64/lemote-2f/platform.c     |  47 +++
 arch/mips/loongson64/lemote-2f/pm.c           |  38 +-
 arch/mips/loongson64/lemote-2f/reset.c        |   4 +-
 arch/mips/loongson64/lemote-2f/sci.c          | 392 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  10 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/yeeloong_kb3310b.c                | 206 +++++++++
 include/linux/mfd/yeeloong_kb3310b.h          | 211 ++++++++++
 15 files changed, 913 insertions(+), 350 deletions(-)
 delete mode 100644 arch/mips/loongson64/lemote-2f/ec_kb3310b.c
 delete mode 100644 arch/mips/loongson64/lemote-2f/ec_kb3310b.h
 create mode 100644 arch/mips/loongson64/lemote-2f/platform.c
 create mode 100644 arch/mips/loongson64/lemote-2f/sci.c
 create mode 100644 drivers/mfd/yeeloong_kb3310b.c
 create mode 100644 include/linux/mfd/yeeloong_kb3310b.h

-- 
2.20.1


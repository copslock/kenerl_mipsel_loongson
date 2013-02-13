Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Feb 2013 22:40:46 +0100 (CET)
Received: from mail-ea0-f180.google.com ([209.85.215.180]:51464 "EHLO
        mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827617Ab3BMVkpZapIu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Feb 2013 22:40:45 +0100
Received: by mail-ea0-f180.google.com with SMTP id c1so611536eaa.39
        for <linux-mips@linux-mips.org>; Wed, 13 Feb 2013 13:40:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer
         :x-gm-message-state;
        bh=NsdTmCFeDY2OsKfm1Ucnm3sB7JC/BeEi7XRPr3uNUK8=;
        b=nrJik+uni5sj38e7yjIjUil0WCPejGPl1+z5vXZPEBcVNACyUe/ORMPSNUKxclYZ8p
         fI/ew4p+sVKKylFr/mOOKqMF7+YAQwSU6DIhYvLDxo+5hMKyvYhOJhXKhBoIBGDt5A0V
         5Q89LCyV9f+kSv9Dc0/J2LeW9U0+ad9lrmIn13QpAizGUS4qBsRoFv60SZmdqEVA383p
         Sb3/71+rNteJgCMZPVBedkCsIg8III/CQXlL7ylRj2Ok1j9Raz/gUkUtuSfPrQ9l2xr/
         Y8e6sE05fVB5wSaSg0CA3kb941FZcZY6med0+kKI/Z+x2aM1PLJCMoyduEjQfUstzLyy
         NDdA==
X-Received: by 10.14.182.71 with SMTP id n47mr8752774eem.11.1360791639635;
        Wed, 13 Feb 2013 13:40:39 -0800 (PST)
Received: from localhost.localdomain ([77.70.100.51])
        by mx.google.com with ESMTPS id r4sm30921681eeo.12.2013.02.13.13.40.37
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 13:40:38 -0800 (PST)
From:   Svetoslav Neykov <svetoslav@neykov.name>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>
Cc:     linux-mips@linux-mips.org, linux-usb@vger.kernel.org,
        Svetoslav Neykov <svetoslav@neykov.name>
Subject: [PATCH 0/5] Chipidea driver support for the AR933x platform
Date:   Wed, 13 Feb 2013 23:38:53 +0200
Message-Id: <1360791538-6332-1-git-send-email-svetoslav@neykov.name>
X-Mailer: git-send-email 1.7.9.5
X-Gm-Message-State: ALoCoQlGbbaQ4KBAtr0UG70sqsVkbeNcXhNl/Gfo65R/VUp6+HyU5gxuU+O1Vn6EwBfWpoTE/rs0
X-archive-position: 35740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: svetoslav@neykov.name
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Add support for the usb controller in AR933x platform.
The processor is big-endian so all multi-byte values of the usb 
descriptors must be converted explicitly. Another difference is that
the controller supports both host and device modes but not OTG.
The patches are tested on WR703n router running OpenWRT trunk.

Svetoslav Neykov (5):
  usb: chipidea: big-endian support
  usb: chipidea: flags to force usb mode (host/device)
  usb: chipidea: Don't access OTG related registers
  usb: chipidea: AR933x platform support for the chipidea driver
  usb: chipidea: Fix incorrect check of function return value

 arch/mips/ath79/dev-usb.c                      |   19 ++++++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    3 +
 drivers/usb/chipidea/Makefile                  |    1 +
 drivers/usb/chipidea/ci13xxx_ar933x.c          |   73 +++++++++++++++++++++
 drivers/usb/chipidea/core.c                    |   26 ++++++--
 drivers/usb/chipidea/udc.c                     |   83 ++++++++++++++----------
 include/linux/usb/chipidea.h                   |    2 +
 7 files changed, 164 insertions(+), 43 deletions(-)
 create mode 100644 drivers/usb/chipidea/ci13xxx_ar933x.c

-- 
1.7.9.5

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Mar 2013 23:19:01 +0100 (CET)
Received: from mail-ee0-f51.google.com ([74.125.83.51]:40114 "EHLO
        mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827463Ab3CAWTAHIUej (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Mar 2013 23:19:00 +0100
Received: by mail-ee0-f51.google.com with SMTP id d17so2672214eek.38
        for <linux-mips@linux-mips.org>; Fri, 01 Mar 2013 14:18:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer
         :x-gm-message-state;
        bh=vT/3YtNPORJYwIC2383h9tOZkEGFBqU4bLEkLoNsS4M=;
        b=djq34popl1tsYqQ/049g5/Ighu/el0H2xrpaSOonx0UEt9acIud/G83dObdiMAvDjs
         ylxDayPEtKnDRKljAH9tKGgOxeBByDWt3LVynDhiPWAZsnhgWDV9IMUyNNKmcgT3mOZY
         1fGqy8vBGxz6fY9KwHTvLCBrZHse3mOrTs/fY+Vlr+Z/8y5Jnt4iZNazQmetN/ESYz/h
         JRHvypNcuhFrpFNpDBC0RZD2lyzweSoahCThlr4vDUUwFIU0I4/e2Smpe5tE0I4tI3qR
         eyvGVO3l+3i9dqnEffI61UdYCj67SfWg6/kUH8t4rWpCkuoFbN3cOfOjq/sjTb1ZjAAS
         cBbA==
X-Received: by 10.14.194.198 with SMTP id m46mr20139488een.8.1362176334247;
        Fri, 01 Mar 2013 14:18:54 -0800 (PST)
Received: from localhost.localdomain ([77.70.100.51])
        by mx.google.com with ESMTPS id m46sm19282356eeo.16.2013.03.01.14.18.52
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 01 Mar 2013 14:18:53 -0800 (PST)
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
Subject: [PATCH v2 0/2] Chipidea driver support for the AR933x platform
Date:   Sat,  2 Mar 2013 00:17:35 +0200
Message-Id: <1362176257-2328-1-git-send-email-svetoslav@neykov.name>
X-Mailer: git-send-email 1.7.9.5
X-Gm-Message-State: ALoCoQnAhudI9pO4Ct2IfEvZVRrk0X9QtuRnHz32IQK+z3sZWUajivZmi4u8zZrJVD9WeDiaTpmZ
X-archive-position: 35830
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
The patches are tested on WR703n router running OpenWRT trunk in device mode.

This version of the patch relies on the changes in "[PATCH 0/3] 
otg-for-v3.10-v2: separate phy code and add DT helper" and is generated from 
the tree at http://git.pengutronix.de/?p=mgr/linux.git;a=shortlog;h=refs/heads/chipidea-for-v3.10

The patch "[PATCH 3/5] usb: chipidea: Don't access OTG related registers" from
the last patchset is not attached because there have been significant
changes in the chipidea-for-v3.10 repository which make it obsolete. A patch
based on the latest changes will be provided in a separate patchset.

Changes since last version:
        * conditionally include ci13xxx_ar933x.c for compilation
        * removed __devinit/__devexit/__devexit_p()
        * use a dynamically allocated structure for ci13xxx_platform_data
        * move controller mode check to platform usb registration
        * pick a different name for the ar933x chipidea driver
        * use a correct MODE_ALIAS name
        * use the dr_mode changes in "[PATCH 0/3] otg-for-v3.10-v2:
          separate phy code and add DT helper"


Svetoslav Neykov (2):
  usb: chipidea: big-endian support
  usb: chipidea: AR933x platform support for the chipidea driver

 arch/mips/ath79/dev-usb.c                          |   50 +++++++++++++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h     |    3 +
 .../asm/mach-ath79/ar933x_chipidea_platform.h      |   18 +++++
 drivers/usb/chipidea/Makefile                      |    5 ++
 drivers/usb/chipidea/ci13xxx_ar933x.c              |   75 ++++++++++++++++++++
 drivers/usb/chipidea/core.c                        |    2 +-
 drivers/usb/chipidea/udc.c                         |   59 +++++++--------
 7 files changed, 183 insertions(+), 29 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-ath79/ar933x_chipidea_platform.h
 create mode 100644 drivers/usb/chipidea/ci13xxx_ar933x.c

-- 
1.7.9.5

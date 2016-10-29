Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Oct 2016 21:56:30 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:49278 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992022AbcJ2T4YNdfNh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 Oct 2016 21:56:24 +0200
X-IronPort-AV: E=Sophos;i="5.31,565,1473112800"; 
   d="scan'208";a="242872216"
Received: from palace.lip6.fr (HELO localhost.localdomain) ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256; 29 Oct 2016 21:56:18 +0200
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-omap@vger.kernel.org,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-mips@linux-mips.org, linux-pm@vger.kernel.org,
        patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fbdev@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net
Subject: [PATCH 00/15] use permission-specific DEVICE_ATTR variants
Date:   Sat, 29 Oct 2016 21:36:54 +0200
Message-Id: <1477769829-22230-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Return-Path: <Julia.Lawall@lip6.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Julia.Lawall@lip6.fr
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


Use DEVICE_ATTR_RO etc. for read only attributes etc.  This simplifies the
source code, improves readbility, and reduces the chance of
inconsistencies.

The complete semantic patch is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@ro@
declarer name DEVICE_ATTR;
identifier x,x_show;
@@

DEVICE_ATTR(x, \(0444\|S_IRUGO\), x_show, NULL);

@wo@
declarer name DEVICE_ATTR;
identifier x,x_store;
@@

DEVICE_ATTR(x, \(0200\|S_IWUSR\), NULL, x_store);

@rw@
declarer name DEVICE_ATTR;
identifier x,x_show,x_store;
@@

DEVICE_ATTR(x, \(0644\|S_IRUGO|S_IWUSR\), x_show, x_store);

@script:ocaml@
x << ro.x;
x_show << ro.x_show;
@@

if not (x^"_show" = x_show) then Coccilib.include_match false

@script:ocaml@
x << wo.x;
x_store << wo.x_store;
@@

if not (x^"_store" = x_store) then Coccilib.include_match false

@script:ocaml@
x << rw.x;
x_show << rw.x_show;
x_store << rw.x_store;
@@

if not (x^"_show" = x_show && x^"_store" = x_store)
then Coccilib.include_match false

@@
declarer name DEVICE_ATTR_RO;
identifier ro.x,ro.x_show;
@@

- DEVICE_ATTR(x, \(0444\|S_IRUGO\), x_show, NULL);
+ DEVICE_ATTR_RO(x);

@@
declarer name DEVICE_ATTR_WO;
identifier wo.x,wo.x_store;
@@

- DEVICE_ATTR(x, \(0200\|S_IWUSR\), NULL, x_store);
+ DEVICE_ATTR_WO(x);

@@
declarer name DEVICE_ATTR_RW;
identifier rw.x,rw.x_show,rw.x_store;
@@

- DEVICE_ATTR(x, \(0644\|S_IRUGO|S_IWUSR\), x_show, x_store);
+ DEVICE_ATTR_RW(x);
// </smpl>

---

 arch/mips/txx9/generic/7segled.c                  |    4 ++--
 arch/powerpc/kernel/iommu.c                       |    3 +--
 arch/tile/kernel/sysfs.c                          |   14 +++++++-------
 drivers/atm/solos-pci.c                           |    2 +-
 drivers/pci/pcie/aspm.c                           |    4 ++--
 drivers/power/supply/wm8350_power.c               |    2 +-
 drivers/ptp/ptp_sysfs.c                           |    2 +-
 drivers/thermal/int340x_thermal/int3400_thermal.c |    2 +-
 drivers/thermal/thermal_hwmon.c                   |    2 +-
 drivers/tty/nozomi.c                              |    4 ++--
 drivers/usb/wusbcore/dev-sysfs.c                  |    6 +++---
 drivers/usb/wusbcore/wusbhc.c                     |   13 +++++--------
 drivers/video/fbdev/wm8505fb.c                    |    2 +-
 sound/soc/omap/mcbsp.c                            |    4 ++--
 sound/soc/soc-dapm.c                              |    2 +-
 15 files changed, 31 insertions(+), 35 deletions(-)

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Sep 2015 15:35:05 +0200 (CEST)
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37215 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008401AbbIUNfDi7puj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Sep 2015 15:35:03 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NV1005TV4E5SJ60@mailout2.w1.samsung.com>; Mon,
 21 Sep 2015 14:34:54 +0100 (BST)
X-AuditID: cbfec7f5-f794b6d000001495-ba-5600077ddf16
Received: from eusync3.samsung.com ( [203.254.199.213])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id 42.17.05269.D7700065; Mon,
 21 Sep 2015 14:34:53 +0100 (BST)
Received: from AMDC1061.digital.local ([106.116.147.88])
 by eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0NV100LNT4DTKI10@eusync3.samsung.com>; Mon,
 21 Sep 2015 14:34:53 +0100 (BST)
From:   Andrzej Hajda <a.hajda@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexander Kuleshov <kuleshovmail@gmail.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Alison Wang <alison.wang@freescale.com>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Andreas Dilger <andreas.dilger@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arend van Spriel <arend@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Boris BREZILLON <boris.brezillon@free-electrons.com>,
        brcm80211-dev-list@broadcom.com,
        Brett Rudley <brudley@broadcom.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        devel@driverdev.osuosl.org, dev@openvswitch.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        dri-devel@lists.freedesktop.org, Eric Paris <eparis@redhat.com>,
        "Franky (Zhenhui) Lin" <frankyl@broadcom.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hal Rosenstock <hal.rosenstock@gmail.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Hante Meuleman <meuleman@broadcom.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        intel-gfx@lists.freedesktop.org, Ivan Mikhaylov <ivan@ru.ibm.com>,
        Jacek Anaszewski <j.anaszewski@samsung.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        Jianwei Wang <jianwei.wang.chn@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        John Stultz <john.stultz@linaro.org>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Kalle Valo <kvalo@codeaurora.org>,
        Karsten Keil <isdn@linux-pingi.de>, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-cachefs@redhat.com,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mm@kvack.org,
        linux-omap@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        lustre-devel@lists.lustre.org, Magnus Damm <magnus.damm@gmail.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Mackall <mpm@selenic.com>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        netdev@vger.kernel.org, Nick Dyer <nick.dyer@itdev.co.uk>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Oleg Drokin <oleg.drokin@intel.com>,
        Olof Johansson <olof@lixom.net>,
        Pawel Moll <pawel.moll@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pravin Shelar <pshelar@nicira.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Purdie <rpurdie@rpsys.net>, rtc-linux@googlegroups.com,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Simon Horman <horms@verge.net.au>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Steve Glendinning <steve.glendinning@shawell.net>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Tapasweni Pathak <tapaswenipathak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Luck <tony.luck@intel.com>,
        Wei Yang <weiyang@linux.vnet.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Woojung.Huh@microchip.com" <Woojung.Huh@microchip.com>,
        yalin wang <yalin.wang2010@gmail.com>
Subject: [PATCH 00/38] Fixes related to incorrect usage of unsigned types
Date:   Mon, 21 Sep 2015 15:33:32 +0200
Message-id: <1442842450-29769-1-git-send-email-a.hajda@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSb0wTdxjH/d397ndHtdml6ryJklnj4swQcS55nLpsM1nOZC/m3PbCZHEd
        XkClSFppJokJwlCilELt3FaZEShFWNdKW8AicdgqrlBRQKo1UIwaZUotTDvXImiB7N0n3z/P
        983D0YpeZim3J++ApMlT5SqJDPdMXx1MP8TO+2ZdJPQG3LH3MmDpG2RB3+unwNB6kYZqh43A
        yaELDJQF6yiwNjkwFAUfM1AyZqBhytjFQvMvDgY6R2sw2IvaCPzcP0ggMpJsNATsyQPXf8Rw
        paeDho5AgoWnxZMY/r4+zoCvdhTBzViUQFXbEQyeiSYaSuocBJpdVQgs8XYKjj9eBiUtMQSn
        Kl0UxJ1PCFw+PE1AP/gIQcOAA4HjfD2BwGQ6mM6NUxDoqUhKnmcs1DbWEHC9KCPgvB9kYMLS
        zcJEeZiBkXCcgr8qkvuhf/5lYKC9mkDLmB1B+bkWBip/MrIQtr1i4JTFgOGhV48hUKdnofql
        iYZaaykNY2eHWOj23cXwx+VhFu7+HiFQf6uP+jhLLO2fIqLttA2JkwkjEqO3S1nRPHKNiKbJ
        ZkYcqNBTorsxRInhiz4sPnD2IXHaZ6BEj3mYFVs7V4kdVX4i+mI1WCz3BNAXH+yUbd4t5e7R
        SZqMj76T5Ty5/5TkX8r44bDfhouQSXkMpXACv0FwH33IzPGbwo2wg8ywgq9HwtGznx5DsiQX
        U0J7wk3PGIR/V5hyhWZDi/i3BZd+pizjaP7FcsGaiOIZYyG/TWi4EZ0NYX6V4IyVzJbl/Fbh
        wW8vqbm1NMHfdYKpRPPPoHlNaLFUkJWv/T5bvX6tVqXWFuRlr83ar3aiuS+LnUf1XR96Ec8h
        5QL5J/yrrxWMSqc9qPYigaOVi+TvmZOSfLfqYKGk2b9LU5Arab0olcPKJfJf26NfKfhs1QFp
        nyTlS5r/XYpLWVqE9nrVC1J7t5/A93K2C3e6TIe6ncvTvswbqdqhaNuWuLLCmFi42r3pTN2f
        8Yysa/6bKW9FIsb0CuvG/szxzMZNRxQtuNpwunCjrpZb7U5btzKm22cPWrf89465dXiZeue3
        jwp3WZTPLWXmYs/7l1aEmj/vjOv4z2JXhaHiymf+0dSgEmtzVJlraI1W9RoVZkT3YQMAAA==
Return-Path: <a.hajda@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.hajda@samsung.com
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

Hi,

This is set of independent patches. The only connection between
them is that they try to address problems spotted by proposed
coccinelle semantic patch unsigned_lesser_than_zero.cocci[1].

Semantic patch finds comparisons of types:
    unsigned < 0
    unsigned >= 0
The former is always false, the latter is always true.
Such comparisons are useless, so theoretically they could be
safely removed, but their presence quite often indicates bugs.

This patchset contains mainly real bug fixes(patches 01-25),
usually type fixes.

Patches 26-37 removes unnecessary checks. Semantic patch found
much more such places (more than 80), but since every case needs
some analysis I have decided to leave them for antoher patchset.

The last patch should be probably replaced with something better,
I guess it should be treated rather as bug report.

The patches are based on linux-next (20150918).

Patches were only compile tested, so please look at them carefully.

I have sent all patches to linux-kernel mailing list. Individual
patches + cover letter went also to apropriate addresses,
according to get_maintainers.pl script.

One more thing. To fullfill different maintaner/subsystem requirements
I have decided to prefix patch subjects with prefixes present in
last 10 commits for affected files. I am not sure if this is the
best solution, if there are any better solutions please let me know :)

[1]: http://permalink.gmane.org/gmane.linux.kernel/2038576

Regards
Andrzej


Andrzej Hajda (38):
  arm-cci: fix handling cpumask_any_but return value
  bus: arm-ccn: fix handling cpumask_any_but return value
  drm/i915: fix handling gen8_emit_flush_coherentl3_wa result
  IB/ehca: fix handling idr_alloc result
  staging: lustre: fix handling lustre_posix_acl_xattr_filter result
  tty: serial: lpc32xx_hs: fix handling platform_get_irq result
  usb: host: ehci-msm: fix handling platform_get_irq result
  openvswitch: fix handling result of ipv6_skip_exthdr
  selftests/timers: fix write return value handlng
  hwrng: fix handling platform_get_irq
  HSI: omap_ssi: fix handling ida_simple_get result
  HSI: omap_ssi_port: fix handling of_get_named_gpio result
  ARM: shmobile: apmu: correct type of CPU id
  clk: vt8500: fix sign of possible PLL values
  drm/layerscape: fix handling fsl_dcu_drm_plane_index result
  gpu: ipu-v3: fix div_ratio type
  isdn: hisax: fix frame calculation
  net/ibm/emac: fix type of phy_mode
  net: stmmac: fix type of entry variable
  net: brcm80211: fix range check
  mwifiex: fix comparison expression
  orinoco: fix checking for default value
  rndis_wlan: fix checking for default value
  rtc: opal: fix type of token
  staging: media: davinci_vpfe: fix ipipe_mode type
  staging: lustre: remove invalid check
  usbnet: remove invalid check
  video/omap: remove invalid check
  Input: touchscreen: atmel: remove invalid check
  leds: flash: remove invalid check
  leds: tca6507: remove invalid check
  fs/cachefiles: remove invalid checks
  mm/memblock.c: remove invalid check
  perf: remove invalid check
  ptrace: remove invalid check
  MIPS: remove invalid check
  zlib_deflate/deftree: change always true condition to 1
  drm/radeon: simplify boot level calculation

 arch/arm/mach-shmobile/platsmp-apmu.c               |  2 +-
 arch/mips/mm/sc-mips.c                              |  4 ++--
 arch/sh/kernel/ptrace_32.c                          |  3 +--
 arch/sh/kernel/ptrace_64.c                          |  4 ++--
 drivers/bus/arm-cci.c                               |  2 +-
 drivers/bus/arm-ccn.c                               |  2 +-
 drivers/char/hw_random/xgene-rng.c                  |  7 ++++---
 drivers/clk/clk-vt8500.c                            |  6 +++---
 drivers/gpu/drm/amd/amdgpu/kv_dpm.c                 | 11 +----------
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c         |  3 ++-
 drivers/gpu/drm/i915/intel_lrc.c                    |  7 ++++---
 drivers/gpu/drm/radeon/kv_dpm.c                     | 11 +----------
 drivers/gpu/ipu-v3/ipu-csi.c                        |  2 +-
 drivers/hsi/controllers/omap_ssi.c                  |  7 +++----
 drivers/hsi/controllers/omap_ssi_port.c             |  8 ++++----
 drivers/input/touchscreen/atmel_mxt_ts.c            |  2 +-
 drivers/isdn/hisax/hfc4s8s_l1.c                     | 10 +++++-----
 drivers/leds/led-class-flash.c                      |  2 +-
 drivers/leds/leds-tca6507.c                         |  2 +-
 drivers/net/ethernet/ibm/emac/core.h                |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   |  2 +-
 drivers/net/usb/lan78xx.c                           |  5 -----
 drivers/net/usb/smsc75xx.c                          |  5 -----
 drivers/net/usb/smsc95xx.c                          |  5 -----
 drivers/net/wireless/brcm80211/brcmsmac/main.c      |  2 +-
 drivers/net/wireless/mwifiex/11n_rxreorder.c        |  4 ++--
 drivers/net/wireless/orinoco/cfg.c                  |  6 +++---
 drivers/net/wireless/rndis_wlan.c                   |  2 +-
 drivers/rtc/rtc-opal.c                              |  4 ++--
 drivers/staging/lustre/lustre/llite/xattr.c         |  7 ++++---
 drivers/staging/lustre/lustre/osc/lproc_osc.c       |  3 ---
 drivers/staging/media/davinci_vpfe/dm365_ipipe_hw.c |  2 +-
 drivers/staging/rdma/ehca/ehca_cq.c                 | 13 +++++++------
 drivers/tty/serial/lpc32xx_hs.c                     |  7 ++++---
 drivers/usb/host/ehci-msm.c                         |  6 +++---
 drivers/video/fbdev/omap/omapfb_main.c              |  5 -----
 fs/cachefiles/bind.c                                |  9 +++------
 fs/cachefiles/daemon.c                              |  6 +++---
 lib/zlib_deflate/deftree.c                          |  2 +-
 mm/memblock.c                                       |  2 +-
 net/openvswitch/conntrack.c                         |  2 +-
 tools/testing/selftests/timers/clocksource-switch.c |  2 +-
 42 files changed, 79 insertions(+), 119 deletions(-)

-- 
1.9.1

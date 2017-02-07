Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2017 00:04:04 +0100 (CET)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:34868
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992127AbdBGXD5cgBII (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Feb 2017 00:03:57 +0100
Received: by mail-wm0-x243.google.com with SMTP id u63so30968788wmu.2;
        Tue, 07 Feb 2017 15:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o2O0boRgAeCuwKI7aMln5RyRmF4c/Ig5lr4ErlnV3No=;
        b=fL2ruUEM4Tx59plnGvJMHFnfgL1Hj5mSznX1l5g5j9eFbdSAPZHs6WiLZqqTf9ZiTp
         ejj+udLslfG81iWmwmNWBT7mVgksM/jK/W1Mn4Ob5eh/vG5c07QGBrYycVfXZJb4dcOW
         l0FzIAgEOHpayAuJWDsOnmzUIGbul/0rwhjW9oU0ilWQZZFbi+uaoWNf54Jggpbj9OQi
         ft3F2VLe4yLSQtTRUdkPvchg2lDpR46OJrBrZXessQm0guG8jSYAu0xU/mas3y/5LZBQ
         H6/7ycgwwseRM5ifsGqVddyik2lUccYxJuxjAfcO414AKj/9Yg440wScm7Qw9qGV8q47
         PRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o2O0boRgAeCuwKI7aMln5RyRmF4c/Ig5lr4ErlnV3No=;
        b=enU1e9/yFeU/yRHlvoGet5MCNcdIzS2791oAb0B3qe/CT+sjF7gxy1I/Et7FpRQ4fl
         HrlmMhIaNJCE8hwN2mZCNq6of30GabF4akxmark5H7JydRsDSfmrtEjR2a8L5UyYxQmZ
         oLBfYhNPfWIOGCxFpIdAGrNs7jfv47mxPYSmzkf6DjusFgf33ga8r4eRIxQUto1/Ja07
         cPWo8hQnUtdblX6F/cmtlUh1PgTXSJ4xqvLY3pw8uWG09NxMeoQUS2q74AYDLyh3c6jS
         Ri+wDf2Yl4CjtxX2MLYj9LMzz7ZpZC0wBNvmbAUHUUDgb7vUxhXfl3nFYXZ5ZKGvQJj+
         za8A==
X-Gm-Message-State: AMke39nA840aazf7GsRlJPjziuMb6nkVHqokFZRjYFRQKr99UQlmh7Ujjq0V/pvyPQ2gcA==
X-Received: by 10.28.8.130 with SMTP id 124mr14309588wmi.65.1486508632117;
        Tue, 07 Feb 2017 15:03:52 -0800 (PST)
Received: from fainelli-desktop.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id b15sm9742283wra.4.2017.02.07.15.03.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 15:03:51 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org, linux-mips@linux-mips.org,
        linux-nfs@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jiri Slaby <jirislaby@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Timur Tabi <timur@codeaurora.org>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Woojung Huh <woojung.huh@microchip.com>
Subject: [PATCH net-next v2 00/12] net: dsa: remove unnecessary phy.h include
Date:   Tue,  7 Feb 2017 15:02:53 -0800
Message-Id: <20170207230305.18222-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Including phy.h and phy_fixed.h into net/dsa.h causes phy*.h to be an
unnecessary dependency for quite a large amount of the kernel.  There's
very little which actually requires definitions from phy.h in net/dsa.h
- the include itself only wants the declaration of a couple of
structures and IFNAMSIZ.

Add linux/if.h for IFNAMSIZ, declarations for the structures, phy.h to
mv88e6xxx.h as it needs it for phy_interface_t, and remove both phy.h
and phy_fixed.h from net/dsa.h.

This patch reduces from around 800 files rebuilt to around 40 - even
with ccache, the time difference is noticable.

In order to make this change, several drivers need to be updated to
include necessary headers that they were picking up through this
include.  This has resulted in a much larger patch series.

I'm assuming the 0-day builder has had 24 hours with this series, and
hasn't reported any further issues with it - the last issue was two
weeks ago (before I became ill) which I fixed over the last weekend.

I'm hoping this doesn't conflict with what's already in net-next...

David, this should probably go via your tree considering the diffstat.

Changes in v2:

- took Russell's patch series
- removed Qualcomm EMAC patch
- rebased against net-next/master

Russell King (12):
  net: sunrpc: fix build errors when linux/phy*.h is removed from
    net/dsa.h
  net: cgroups: fix build errors when linux/phy*.h is removed from
    net/dsa.h
  net: macb: fix build errors when linux/phy*.h is removed from
    net/dsa.h
  net: lan78xx: fix build errors when linux/phy*.h is removed from
    net/dsa.h
  net: bgmac: fix build errors when linux/phy*.h is removed from
    net/dsa.h
  net: fman: fix build errors when linux/phy*.h is removed from
    net/dsa.h
  net: mvneta: fix build errors when linux/phy*.h is removed from
    net/dsa.h
  iscsi: fix build errors when linux/phy*.h is removed from net/dsa.h
  MIPS: Octeon: Remove unnecessary MODULE_*()
  net: liquidio: fix build errors when linux/phy*.h is removed from
    net/dsa.h
  net: ath5k: fix build errors when linux/phy*.h is removed from
    net/dsa.h
  net: dsa: remove unnecessary phy*.h includes

 arch/mips/cavium-octeon/octeon-platform.c             | 4 ----
 drivers/net/dsa/mv88e6xxx/mv88e6xxx.h                 | 1 +
 drivers/net/ethernet/broadcom/bgmac.c                 | 2 ++
 drivers/net/ethernet/cadence/macb.h                   | 2 ++
 drivers/net/ethernet/cavium/liquidio/lio_main.c       | 1 +
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c    | 1 +
 drivers/net/ethernet/cavium/liquidio/octeon_console.c | 1 +
 drivers/net/ethernet/freescale/fman/fman_memac.c      | 1 +
 drivers/net/ethernet/marvell/mvneta.c                 | 1 +
 drivers/net/usb/lan78xx.c                             | 1 +
 drivers/net/wireless/ath/ath5k/ahb.c                  | 2 +-
 drivers/target/iscsi/iscsi_target_login.c             | 1 +
 include/net/dsa.h                                     | 5 +++--
 net/core/netprio_cgroup.c                             | 1 +
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c            | 1 +
 15 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.9.3

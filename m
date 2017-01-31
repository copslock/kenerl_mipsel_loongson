Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2017 20:17:37 +0100 (CET)
Received: from pandora.armlinux.org.uk ([IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6]:40266
        "EHLO pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993898AbdAaTRa7ZRya (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jan 2017 20:17:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=armlinux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=hHe7ki53/CRCyRvmlcg4Az5dgd1ybaRCh1tocg+n4GA=;
        b=MdeurFh8on3it1qZ1r53tN9l+aGHfKRyE3jUYm3YKFKQhfIi3TVr66xZ1CJ0dRc1C1fdYi1f7XzMy+tRjhMCjIOqzvxn0J/UjIGsTyrH2UEQLHFyj7MxyrFRAg9559vCtArSGN+mfFVBbGEg+gXzAMpleDTL1Tp70ZoSW1i5NTc=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:33626)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@armlinux.org.uk>)
        id 1cYdvV-0000hy-3l; Tue, 31 Jan 2017 19:17:13 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1cYdvO-0002GM-22; Tue, 31 Jan 2017 19:17:06 +0000
Date:   Tue, 31 Jan 2017 19:17:04 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     linux-mips@linux-mips.org, linux-nfs@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
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
Subject: [PATCH 4.10-rc3 00/13] net: dsa: remove unnecessary phy.h include
Message-ID: <20170131191704.GA8281@n2100.armlinux.org.uk>
References: <20170118001403.GJ27312@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170118001403.GJ27312@n2100.armlinux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@armlinux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@armlinux.org.uk
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

 arch/mips/cavium-octeon/octeon-platform.c             | 4 ----
 drivers/net/dsa/mv88e6xxx/mv88e6xxx.h                 | 1 +
 drivers/net/ethernet/broadcom/bgmac.c                 | 2 ++
 drivers/net/ethernet/cadence/macb.h                   | 2 ++
 drivers/net/ethernet/cavium/liquidio/lio_main.c       | 1 +
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c    | 1 +
 drivers/net/ethernet/cavium/liquidio/octeon_console.c | 1 +
 drivers/net/ethernet/freescale/fman/fman_memac.c      | 1 +
 drivers/net/ethernet/marvell/mvneta.c                 | 1 +
 drivers/net/ethernet/qualcomm/emac/emac-sgmii.c       | 1 +
 drivers/net/usb/lan78xx.c                             | 1 +
 drivers/net/wireless/ath/ath5k/ahb.c                  | 2 +-
 drivers/target/iscsi/iscsi_target_login.c             | 1 +
 include/net/dsa.h                                     | 6 ++++--
 net/core/netprio_cgroup.c                             | 1 +
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c            | 1 +
 16 files changed, 20 insertions(+), 7 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

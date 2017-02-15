Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Feb 2017 18:17:36 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31606 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993884AbdBORR3l8KVj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Feb 2017 18:17:29 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 1A900A3D09239;
        Wed, 15 Feb 2017 17:17:20 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 15 Feb 2017 17:17:23 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: OCTEON: Enable DEVTMPFS
Date:   Wed, 15 Feb 2017 17:17:14 +0000
Message-ID: <671051812ff6eee41f009753e22e79eed98f7502.1487178952.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Recent versions of udev and systemd require the kernel to be compiled
with CONFIG_DEVTMPFS in order to populate the /dev directory. Most MIPS
platforms have it enabled by default, so enable it for the Cavium Octeon
defconfig as well. This will assist with automated kernel boot testing.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/configs/cavium_octeon_defconfig | 1 +
 1 file changed, 1 insertion(+), 0 deletions(-)

diff --git a/arch/mips/configs/cavium_octeon_defconfig b/arch/mips/configs/cavium_octeon_defconfig
index d470d08362c0..31e3c4d9adb0 100644
--- a/arch/mips/configs/cavium_octeon_defconfig
+++ b/arch/mips/configs/cavium_octeon_defconfig
@@ -45,6 +45,7 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_LRO is not set
 CONFIG_IPV6=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
 # CONFIG_FW_LOADER is not set
 CONFIG_MTD=y
 # CONFIG_MTD_OF_PARTS is not set
-- 
git-series 0.8.10

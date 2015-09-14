Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Sep 2015 17:57:01 +0200 (CEST)
Received: from mailout4.samsung.com ([203.254.224.34]:49627 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013804AbbINPzObm20M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Sep 2015 17:55:14 +0200
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NUO01T3PC7JG520@mailout4.samsung.com>; Tue,
 15 Sep 2015 00:55:00 +0900 (KST)
X-AuditID: cbfee61a-f79a06d000005c6f-97-55f6edd4ff76
Received: from epmmp2 ( [203.254.227.17])       by epcpsbgm1new.samsung.com (EPCPMTA)
 with SMTP id ED.9E.23663.4DDE6F55; Tue, 15 Sep 2015 00:55:00 +0900 (KST)
Received: from AMDC1976.DIGITAL.local ([106.120.53.102])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5 2014)) with ESMTPA id <0NUO00D6QC2RXC60@mmp2.samsung.com>; Tue,
 15 Sep 2015 00:55:00 +0900 (KST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH] mips: sb1250_swarm_defconfig: disable IDE subsystem
Date:   Mon, 14 Sep 2015 17:51:57 +0200
Message-id: <1442245918-27631-16-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgluLIzCtJLcpLzFFi42I5/e+xoO6Vt99CDR7v0LbYOGM9q8WxHY+Y
        LC7vmsNmMWHqJHaLS3tUHFg9jq5cy+TRt2UVo8fnTXIBzFFcNimpOZllqUX6dglcGYtuBBcc
        YKs4cWQ+YwPjVdYuRk4OCQETiV0zHrNB2GISF+6tB7K5OIQEZjFKbH4znQUkISTwi1Hi3cVg
        EJtNwEpiYvsqRhBbRMBRYmLfSWYQm1kgXOLc1ytMILawgItEx4P9YDUsAqoS09fvA1vAK+Ap
        seDccRaIZXISJ49NBjuCEyj+6eVbVohdHhL3r51gmsDIu4CRYRWjRGpBckFxUnquYV5quV5x
        Ym5xaV66XnJ+7iZGcLg8k9rBeHCX+yFGAQ5GJR5ehftfQ4VYE8uKK3MPMUpwMCuJ8Faf/hYq
        xJuSWFmVWpQfX1Sak1p8iFGag0VJnFd25bNQIYH0xJLU7NTUgtQimCwTB6dUAyMrtxu/5GJm
        PgmVAukKB7u13pU/Ph9iPLpjs1mHEvdik+2bPZPWOjZWsQR5xld5Ntiu2ay+6ALHo6IbUiq3
        g/cdkrjxtbgrfeW/R3p9OYkJvyIZq6/Pepgjcutx+VyPdM+7//fyVz/vq117/usxC7POYD1W
        /feqWasFZ19MX/hZ892WiYdL9yixFGckGmoxFxUnAgCQzP0jEwIAAA==
Return-Path: <b.zolnierkie@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: b.zolnierkie@samsung.com
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

This patch disables deprecated IDE subsystem in sb1250_swarm_defconfig
(no IDE host drivers are selected in this config so there is no valid
reason to enable IDE subsystem itself).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/mips/configs/sb1250_swarm_defconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/configs/sb1250_swarm_defconfig b/arch/mips/configs/sb1250_swarm_defconfig
index 51bab13..09b1914 100644
--- a/arch/mips/configs/sb1250_swarm_defconfig
+++ b/arch/mips/configs/sb1250_swarm_defconfig
@@ -55,9 +55,6 @@ CONFIG_BLK_DEV_RAM_SIZE=9220
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_SGI_IOC4=m
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECD=y
-CONFIG_BLK_DEV_IDETAPE=y
 CONFIG_RAID_ATTRS=m
 CONFIG_NETDEVICES=y
 CONFIG_MACVLAN=m
-- 
1.9.1

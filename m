Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Oct 2015 15:03:07 +0100 (CET)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:32901 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011642AbbJ3OB55kZ50 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Oct 2015 15:01:57 +0100
Received: by padhy1 with SMTP id hy1so69590099pad.0;
        Fri, 30 Oct 2015 07:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L59nEmfBHpQDGQe2Q1G59J4f7ttkPCeZNBeBpd/gIUQ=;
        b=P9YQfDaFKccUpgxmtAIh6nlFly8ZD+Zby9jpxI8WwTqMbSydnghDT1yxVlssWl0xxm
         FZHk4rOIkALaQT5D1SuZP6id+yRHbDqpA+e7AR4wGnXt0IqUfWF/ulzbwRinlQ9pMv24
         MKr1OAYGu2BhlwmUdyyAEgD+IZpjTz4e5AWFWZ7IZe/5+uHi793MAAgt/bswULH7wbTe
         9eSvJhGz8usn/73clrVXOmmNORdyvy+8dZZ5fCoDWfYvZVwLln/YUmcElMIVZgQJcGXa
         Zyvzi7gM43PvgKa8oYCS6NqSWxbpbQxvo/+2iy5aihSolAa60n1TqjRoyIEBZazKrGz4
         P0hw==
X-Received: by 10.69.8.34 with SMTP id dh2mr9062822pbd.122.1446213712274;
        Fri, 30 Oct 2015 07:01:52 -0700 (PDT)
Received: from localhost.localdomain ([59.12.167.210])
        by smtp.gmail.com with ESMTPSA id zk3sm8473164pbb.41.2015.10.30.07.01.48
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Oct 2015 07:01:51 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v4 05/10] phy: phy_brcmstb_sata: remove duplicate definitions
Date:   Fri, 30 Oct 2015 23:01:19 +0900
Message-Id: <1446213684-2625-6-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
References: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

Remove duplicate definitions.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/phy/phy-brcmstb-sata.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/phy/phy-brcmstb-sata.c b/drivers/phy/phy-brcmstb-sata.c
index 8a2cb16a1937..0be55dafe9ea 100644
--- a/drivers/phy/phy-brcmstb-sata.c
+++ b/drivers/phy/phy-brcmstb-sata.c
@@ -26,8 +26,6 @@
 
 #define SATA_MDIO_BANK_OFFSET				0x23c
 #define SATA_MDIO_REG_OFFSET(ofs)			((ofs) * 4)
-#define SATA_MDIO_REG_SPACE_SIZE			0x1000
-#define SATA_MDIO_REG_LENGTH				0x1f00
 
 #define MAX_PORTS					2
 
-- 
2.6.2

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2016 10:33:01 +0100 (CET)
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33424 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992256AbcLIJccferVt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Dec 2016 10:32:32 +0100
Received: by mail-wm0-f66.google.com with SMTP id u144so2764034wmu.0
        for <linux-mips@linux-mips.org>; Fri, 09 Dec 2016 01:32:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o3WWAfiajefE3QLLXiFIZy21yZCWa+WGBTWpFuDni3E=;
        b=jNvY0Jg4no18Ag4V7Wb8tV0nSiPBS8TNMi/oPhmga+dfi3N8dPZgHkDJC2XCRDi6lb
         Ev7D/GUmS/95PGaIEvQ0N77hb9LMKgEZZ3Z0CCL4CaCx/fCNGCT8SOunfbxCMcWNAs4D
         QyCGtCig5aRT4eA6bWSeZ+x0q2t/su/uAnhzhTtVTLAfj+nyv1mMnkP6bdUjVvgozkfy
         n986ivLrloke5TjEM5nJwRH2qXxGdNC8sSmo6AMyEwBAyOkWkXY3AGzxeVIkGY4QfuMp
         l4PWNu2cCdgr2p8gtbv8pcwexU2SFcsIugF+3EaZmYO9T5SweemxE386ZHngFoKh1B4Z
         qtoA==
X-Gm-Message-State: AKaTC02pCEBohkfzV4L3Y1mFEWJgkzLbf8nSSDAyiOV/MhCoVcKvOALcpAul9UtAGzM4fw==
X-Received: by 10.28.94.76 with SMTP id s73mr2356125wmb.107.1481275947323;
        Fri, 09 Dec 2016 01:32:27 -0800 (PST)
Received: from localhost.localdomain (HSI-KBW-046-005-206-247.hsi8.kabel-badenwuerttemberg.de. [46.5.206.247])
        by smtp.gmail.com with ESMTPSA id k11sm19529619wmf.24.2016.12.09.01.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Dec 2016 01:32:26 -0800 (PST)
From:   Jan Glauber <jglauber@cavium.com>
To:     Wolfram Sang <wsa-dev@sang-engineering.com>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 1/4] i2c: octeon: thunderx: TWSI software reset in recovery
Date:   Fri,  9 Dec 2016 10:31:55 +0100
Message-Id: <20161209093158.3161-2-jglauber@cavium.com>
X-Mailer: git-send-email 2.9.0.rc0.21.g7777322
In-Reply-To: <20161209093158.3161-1-jglauber@cavium.com>
References: <20161209093158.3161-1-jglauber@cavium.com>
Return-Path: <jan.glauber@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jglauber@cavium.com
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

I've seen i2c recovery reporting long loops of:

[ 1035.887818] i2c i2c-4: SCL is stuck low, exit recovery
[ 1037.999748] i2c i2c-4: SCL is stuck low, exit recovery
[ 1040.111694] i2c i2c-4: SCL is stuck low, exit recovery
...

Add a TWSI software reset which clears the status and
STA,STP,IFLG in SW_TWSI_EOP_TWSI_CTL.

With this the recovery works fine and above message is not seen.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index 5e63b17..2b8a7bf 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -789,6 +789,9 @@ static void octeon_i2c_prepare_recovery(struct i2c_adapter *adap)
 	struct octeon_i2c *i2c = i2c_get_adapdata(adap);
 
 	octeon_i2c_hlc_disable(i2c);
+	octeon_i2c_reg_write(i2c, SW_TWSI_EOP_TWSI_RST, 0);
+	/* wait for software reset to settle */
+	udelay(5);
 
 	/*
 	 * Bring control register to a good state regardless
-- 
2.9.0.rc0.21.g7777322

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Nov 2016 19:52:44 +0100 (CET)
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36051 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993057AbcKNSvdNUW57 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Nov 2016 19:51:33 +0100
Received: by mail-wm0-f68.google.com with SMTP id m203so17848759wma.3
        for <linux-mips@linux-mips.org>; Mon, 14 Nov 2016 10:51:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EDQHUPbinSZ6A3nEC4Y96V1fOGVedweWkIj3gIW3nNU=;
        b=mTOpS9sHWeE3QGfJOjR6tB70ApZSas3C5X6I8EIxqu3p4cEtRwuC8Ngxf9jgqgCHdh
         qPxnpyoyvZkIbnKI6D1ZtQq4IxQ2jgA4fzxhANFSnsOvL0mfNODOwtTo3VUhDALxoSnc
         GgzwVMb0kSpqB0Ugp3x9X+Mk1N7zq9TcAD/A8yU69FzcYwnPYObDyRPA2RJg82F0erya
         9ZWTk3rRxTPNvmgXRcLIggo0xZ5wr3tUMkHRxBsbH3Dko5YAF2gjgH2MUiF0DA4KomXm
         rGUbMylIOzYvARDPdjLg1BxxkpPJLJT8nfU/lPjoe9YphysDbSVa5kVzoyN53ZNpY+pX
         TyqA==
X-Gm-Message-State: ABUngvenXpOF73wGd3sAhLk04eWgUCICI7AgzCI7RVWS77ZrOMf/QOxxQndiTiYRh8fNHA==
X-Received: by 10.28.87.84 with SMTP id l81mr13270323wmb.48.1479149487935;
        Mon, 14 Nov 2016 10:51:27 -0800 (PST)
Received: from wintermute.fritz.box (HSI-KBW-109-193-043-099.hsi7.kabel-badenwuerttemberg.de. [109.193.43.99])
        by smtp.gmail.com with ESMTPSA id k74sm30942198wmd.18.2016.11.14.10.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Nov 2016 10:51:27 -0800 (PST)
From:   Jan Glauber <jglauber@cavium.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v2 3/3] i2c: octeon: thunderx: TWSI software reset in recovery
Date:   Mon, 14 Nov 2016 19:50:45 +0100
Message-Id: <1479149445-4663-4-git-send-email-jglauber@cavium.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
References: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
Return-Path: <jan.glauber@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55821
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
index 54a9c14..c3b63c1 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -760,6 +760,9 @@ static void octeon_i2c_prepare_recovery(struct i2c_adapter *adap)
 	struct octeon_i2c *i2c = i2c_get_adapdata(adap);
 
 	octeon_i2c_hlc_disable(i2c);
+	octeon_i2c_reg_write(i2c, SW_TWSI_EOP_TWSI_RST, 0);
+	/* wait for software reset to settle */
+	udelay(5);
 
 	/*
 	 * Bring control register to a good state regardless
-- 
1.9.1

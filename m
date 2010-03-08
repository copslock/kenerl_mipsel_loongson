Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Mar 2010 20:04:43 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3130 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492476Ab0CHTEk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Mar 2010 20:04:40 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b954a4c0000>; Mon, 08 Mar 2010 11:04:44 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 8 Mar 2010 11:04:34 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 8 Mar 2010 11:04:34 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o28J4U4H031792;
        Mon, 8 Mar 2010 11:04:30 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o28J4Rqc031791;
        Mon, 8 Mar 2010 11:04:27 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-i2c@vger.kernel.org, ben-linux@fluff.org, khali@linux-fr.org
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        rade.bozic.ext@nsn.com, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] i2c: Fix section mismatch errors in i2c-octeon.c
Date:   Mon,  8 Mar 2010 11:04:21 -0800
Message-Id: <1268075061-31748-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
X-OriginalArrivalTime: 08 Mar 2010 19:04:34.0359 (UTC) FILETIME=[30CD1470:01CABEF2]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/i2c/busses/i2c-octeon.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index 6037550..be88d5b 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -446,7 +446,7 @@ static struct i2c_adapter octeon_i2c_ops = {
 /**
  * octeon_i2c_setclock - Calculate and set clock divisors.
  */
-static int __init octeon_i2c_setclock(struct octeon_i2c *i2c)
+static int __devinit octeon_i2c_setclock(struct octeon_i2c *i2c)
 {
 	int tclk, thp_base, inc, thp_idx, mdiv_idx, ndiv_idx, foscl, diff;
 	int thp = 0x18, mdiv = 2, ndiv = 0, delta_hz = 1000000;
@@ -489,7 +489,7 @@ static int __init octeon_i2c_setclock(struct octeon_i2c *i2c)
 	return 0;
 }
 
-static int __init octeon_i2c_initlowlevel(struct octeon_i2c *i2c)
+static int __devinit octeon_i2c_initlowlevel(struct octeon_i2c *i2c)
 {
 	u8 status;
 	int tries;
-- 
1.6.6.1

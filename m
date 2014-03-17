Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Mar 2014 07:07:15 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:64882 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822478AbaCQGHLO4SRp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Mar 2014 07:07:11 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s2H67112003138
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 16 Mar 2014 23:07:02 -0700 (PDT)
Received: from pek-wyang1-d1.wrs.com (128.224.162.170) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.169.1; Sun, 16 Mar 2014 23:07:00 -0700
From:   <Wei.Yang@windriver.com>
To:     <david.daney@cavium.com>, <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <wei.yang@windriver.com>
Subject: [PATCH] mips/octeon_3xxx: Fix a warning on octeon_3xxx
Date:   Mon, 17 Mar 2014 14:06:54 +0800
Message-ID: <1395036414-20581-1-git-send-email-Wei.Yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Wei.Yang@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Wei.Yang@windriver.com
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

From: Yang Wei <Wei.Yang@windriver.com>

Since the xlate of interrupts property of GPIO on octeon 3xxx
does not success, so the following warning would be triggerred
while invoking of_device_alloc to create platform device.
So we need to remove it to avoid the warning.

WARNING: CPU: 1 PID: 1 at drivers/of/platform.c:173 of_device_alloc+0x294/0x2a0()
Modules linked in:
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 3.14.0-rc6- #11
Stack : ffffffff81a20000 0000000000000001 0000000000000004 ffffffff81b50000
	  0000000000000001 0000000000000000 0000000000000000 ffffffff8119e878
	  ffffffff81a20000 ffffffff8119ee98 0000000000000000 0000000000000000
	  ffffffff81b30000 ffffffff81b20000 ffffffff81932900 ffffffff81a11077
	  ffffffff81b27a08 800000041f8704a8 0000000000000001 0000000000000001
	  0000000000000000 800000041fbf7438 0000000000000001 ffffffff81800d90
	  800000041f85fa68 ffffffff8114a60c 0000000000000000 ffffffff811a0838
	  800000041f870000 800000041f85f980 0000000000000001 ffffffff81805080
	  0000000000000000 0000000000000000 0000000000000000 0000000000000000
	  0000000000000000 ffffffff81122620 0000000000000000 0000000000000000
	  ...
Call Trace:
[<ffffffff81122620>] show_stack+0xc0/0xe0
[<ffffffff81805080>] dump_stack+0x8c/0xe0
[<ffffffff8114a7ac>] warn_slowpath_common+0x94/0xc8
[<ffffffff81693b1c>] of_device_alloc+0x294/0x2a0
[<ffffffff81693b74>] of_platform_device_create_pdata+0x4c/0xf0
[<ffffffff81693d58>] of_platform_bus_create+0x128/0x1a8
[<ffffffff81693da0>] of_platform_bus_create+0x170/0x1a8
[<ffffffff81693e8c>] of_platform_bus_probe+0xb4/0x110
[<ffffffff81100598>] do_one_initcall+0xe8/0x130
[<ffffffff81a92c5c>] kernel_init_freeable+0x1d4/0x2bc
[<ffffffff817fe140>] kernel_init+0x20/0x118
[<ffffffff8111d024>] ret_from_kernel_thread+0x14/0x1c

Signed-off-by: Yang Wei <Wei.Yang@windriver.com>
---
 arch/mips/cavium-octeon/octeon_3xxx.dts |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon_3xxx.dts b/arch/mips/cavium-octeon/octeon_3xxx.dts
index fa33115..9fe94d5 100644
--- a/arch/mips/cavium-octeon/octeon_3xxx.dts
+++ b/arch/mips/cavium-octeon/octeon_3xxx.dts
@@ -43,11 +43,6 @@
 			 */
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			/* The GPIO pin connect to 16 consecutive CUI bits */
-			interrupts = <0 16>, <0 17>, <0 18>, <0 19>,
-				     <0 20>, <0 21>, <0 22>, <0 23>,
-				     <0 24>, <0 25>, <0 26>, <0 27>,
-				     <0 28>, <0 29>, <0 30>, <0 31>;
 		};
 
 		smi0: mdio@1180000001800 {
-- 
1.7.9.5

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Feb 2015 11:02:11 +0100 (CET)
Received: from mail-wi0-f182.google.com ([209.85.212.182]:52230 "EHLO
        mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012930AbbBRKCJREaiT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Feb 2015 11:02:09 +0100
Received: by mail-wi0-f182.google.com with SMTP id l15so907486wiw.3;
        Wed, 18 Feb 2015 02:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=GFZg5Ycymgz14ccb2d3UMrArDg2CSEh3BJUn1CYytMU=;
        b=DoNgt/g4rkMRCsEdgwNUeXuhuA93G18xbD3chqbFH4oWwkzwabJuQbAJBj6GkEAE6f
         /61XUeoWbGsPD4k9UWmIlHnm/YKqf8gkByrQrZe2gZs5JhmkUXI5wDBgbo+0Hn/OhRa4
         u1Cj+AVYCPuNsSe1FSgJO6eew8Xxb6WWU4htpg8pHsN/vTDB3YGDAGBbikOr94mA2sSV
         Im6e6xuiy9EDF+XIRtvH7snY9O4Y6SPlW4pzfFMEo29Fz9uB+uWBwI80Sm0Mxnr5/JWk
         O5+2pYOxd8gsszUKbN0YH40S3u5hs5dOdAj6Ze7mXobQJHCV6/brzu4mvObY0oCzPemG
         mt6Q==
X-Received: by 10.194.8.2 with SMTP id n2mr2541333wja.46.1424253723288;
        Wed, 18 Feb 2015 02:02:03 -0800 (PST)
Received: from flagship.roarinelk.net (62-47-33-208.adsl.highway.telekom.at. [62.47.33.208])
        by mx.google.com with ESMTPSA id j9sm31754827wjy.18.2015.02.18.02.01.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Feb 2015 02:02:01 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Bruno Randolf <br1@einfach.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        stable@vger.kernel.org  [v3.17+]
Subject: [PATCH RESEND] MIPS: Alchemy: fix cpu clock calculation
Date:   Wed, 18 Feb 2015 11:01:56 +0100
Message-Id: <1424253716-588144-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.3.0
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

The current code uses bits 0-6 of the sys_cpupll register to calculate
core clock speed.  However this is only valid on Au1300, on all earlier
models the hardware only uses bits 0-5 to generate core clock.

This fixes clock calculation on the MTX1 (Au1500), where bit 6 of cpupll
is set as well, which ultimately lead the code to calculate a bogus cpu
core clock and also uart base clock down the line.

Reported-by: John Crispin <blogic@openwrt.org>
Tested-by: Bruno Randolf <br1@einfach.org>
Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
Cc: stable@vger.kernel.org	[v3.17+]
---
John originally noticed that the reported UART baud base differed between 3.14
and 3.18 on the MTX1,  Bruno tested and confirmed that the fix is correct.

Resend with linux mips ml address.

 arch/mips/alchemy/common/clock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/alchemy/common/clock.c b/arch/mips/alchemy/common/clock.c
index d8737a8..546914c 100644
--- a/arch/mips/alchemy/common/clock.c
+++ b/arch/mips/alchemy/common/clock.c
@@ -127,6 +127,8 @@ static unsigned long alchemy_clk_cpu_recalc(struct clk_hw *hw,
 		t = 396000000;
 	else {
 		t = alchemy_rdsys(AU1000_SYS_CPUPLL) & 0x7f;
+		if (alchemy_get_cputype() < ALCHEMY_CPU_AU1300)
+			t &= 0x3f;
 		t *= parent_rate;
 	}
 
-- 
2.3.0

Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 14:01:02 +0200 (CEST)
Received: from mail-lb0-f194.google.com ([209.85.217.194]:33336 "EHLO
        mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27032412AbcEUMANrM9dI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 14:00:13 +0200
Received: by mail-lb0-f194.google.com with SMTP id u2so692678lbo.0;
        Sat, 21 May 2016 05:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=MoOP3bRab9zPn8XUhLPTTx6+bUTHjeB/SpVPogkcj20=;
        b=nYm9yr2Bu9eil9ow6dR7jK2Zczn7EXKtw9mXFnc88a94QQU59Sk/++8kgIO7oclzFa
         R2uN2q7epZdkkBMvGWZOSB4q+eVCkV/X0bwPV/Zuyk9BY0I/DIunI0QLy/bjC1nwzELD
         L0aK17yT1zaV6hsCgUVNN4tVXiIti51ErtmijG2kdj1f7anMkeH3sscs+zmjSJKz9FVw
         d6p/8q+smoz7PVPJjx3Sv7KlrqiFTdKm+6VahGrqUxhN3tS++DSZVPSL2hwQXZor2YyY
         i8ZyiNrZuXf/fwVFjkzah0GFLu2hR/LSOdqgPQNWAlMBFMOXUI1FOl2ddxtczSfLMTSe
         7XFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=MoOP3bRab9zPn8XUhLPTTx6+bUTHjeB/SpVPogkcj20=;
        b=Kkg/+mMJLCt55PMdQBABSHerr/Cp+hJcmO3Ximj3MVnkDdVG3SLAgMXTxYRCdobMb8
         3lebpNeZq1EDvh5muBPq+YOzrJjD7RtJ4FLZRkuRaTxleDTERKEGpff66j4i5kfjg22w
         yZjM/9XOUm7tQyg4R9PnEFIa7DyieTskRI5QAFP7FQndqZ1qlNAaL68OhshDg3YfUiHv
         z1iGGo/wwMK/qtkOLAbHSIxDEzmWvF86Z2Nhm1OBX4vnaDMCOTyx17QwxdMClwfntXQ8
         KGObwXb89rbz2RiyGjhrkomYbWXiWgPOlzVD4/KmFVb5aI2W7ao05OFUD9ZdjNBo+L0d
         6Xcw==
X-Gm-Message-State: AOPr4FX3O+efH9glny+IGi23DuYsPtjhAdwlrx+kaPA30cr5qmDZ84KMV+PsYVNJ101l3A==
X-Received: by 10.112.141.135 with SMTP id ro7mr2727334lbb.0.1463832008489;
        Sat, 21 May 2016 05:00:08 -0700 (PDT)
Received: from glen.ipredator.se (anon-35-25.vpn.ipredator.se. [46.246.35.25])
        by smtp.gmail.com with ESMTPSA id h9sm4158544lfg.3.2016.05.21.05.00.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 May 2016 05:00:07 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     trivial@kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 0183/1529] Fix typo
Date:   Sat, 21 May 2016 14:00:04 +0200
Message-Id: <20160521120004.9396-1-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 2.8.2.534.g1f66975
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
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

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h
index 466fc85..c4e856f 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h
@@ -22,7 +22,7 @@ struct bcm63xx_enet_platform_data {
 	int has_phy_interrupt;
 	int phy_interrupt;
 
-	/* if has_phy, use autonegociated pause parameters or force
+	/* if has_phy, use autonegotiated pause parameters or force
 	 * them */
 	int pause_auto;
 	int pause_rx;
-- 
2.8.2.534.g1f66975

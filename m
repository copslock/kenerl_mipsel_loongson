Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2015 15:00:30 +0200 (CEST)
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36840 "EHLO
        mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026535AbbEHNA2ebTnN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 May 2015 15:00:28 +0200
Received: by pdea3 with SMTP id a3so82782869pde.3;
        Fri, 08 May 2015 06:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s8LYg2H7eawiZwJ0mUAH2pJ7tocElG6oDEEa6MTTaoA=;
        b=klIAQSAlThlyh1Cu1Pz9zYjxO9TEaGk1gIqauxPFuO65FxpnQIKGsQ3qSJqGLCFlRA
         6UJ9GWhbFLcLCmItfIuBtcAvyzHPQSCqwUJ5TNJzt6vaY/XKjuvo/TSTlPpmHFdOimNG
         GuYA/WZmZ3I+k2vMlkgVMgfZTNcHxayyWYHYXijMYnJPPkvuvWbJtF7eWPgWdDD3YyUe
         WOO9CdPZW1veOW97nIqEKwZsS0auYWjTdJf7EEK2ZOu0wIsFg7HfMXGYt5rppL/xvoOB
         4b1ymve889b8SYJflGaTjpxifLxtcqtXeEk3oCcb9qCBSxD9mVpGp06RT88uYGGihAeR
         PRDg==
X-Received: by 10.70.127.231 with SMTP id nj7mr6300798pdb.110.1431089967566;
        Fri, 08 May 2015 05:59:27 -0700 (PDT)
Received: from localhost.localdomain ([59.12.167.210])
        by mx.google.com with ESMTPSA id i16sm5182237pbq.79.2015.05.08.05.59.25
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 May 2015 05:59:26 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 1/2] MIPS: BMIPS: dts: remove unsupported entry for bcm7362
Date:   Fri,  8 May 2015 21:59:17 +0900
Message-Id: <1431089958-2626-2-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1431089958-2626-1-git-send-email-jaedon.shin@gmail.com>
References: <1431089958-2626-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47276
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

Remove unsupported memory entry for the bcm7362 platform. The BMIPS4380
processor only supports ZONE_NORMAL is not available for HIGHMEM.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm97362svmb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/brcm/bcm97362svmb.dts b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
index b7b88e5dc9e7..ab8b01fa7dcf 100644
--- a/arch/mips/boot/dts/brcm/bcm97362svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
@@ -8,7 +8,7 @@
 
 	memory@0 {
 		device_type = "memory";
-		reg = <0x00000000 0x10000000>, <0x20000000 0x30000000>;
+		reg = <0x00000000 0x10000000>;
 	};
 
 	chosen {
-- 
2.4.0

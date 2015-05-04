Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 May 2015 21:11:00 +0200 (CEST)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33373 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014629AbbEDTK0A5Nwh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 May 2015 21:10:26 +0200
Received: by pdbnk13 with SMTP id nk13so171167405pdb.0;
        Mon, 04 May 2015 12:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tQmbtsnWQb5McX7HpGhTG2hHx3brJAocSt9G7Uqb37g=;
        b=cl86jXqKP06/JdNCSYTKHg3M6NEcnCJ3VP18bswsjzAfq7LHHk8Iv5jroSI3mSAPeD
         qLXF0H7Z+XdBTU3jMw4yze82szZKxG15JzkU/yYlrwcG+SIc8FR+h6gLQHIsb2M/OFrm
         xEUP0BBYk8/9H9SeYvMBBgcKsXbm/aAWEsgp38BgYXQprbImRmLj5RjXNL0qlaWrPa1R
         /x5DyVMLh0e/N0IFqnVfKpokMyzFbrJuIyixHOKUePa4YkZx36zVS+uqtRLTvLkoLs20
         MbWMep2UwvT5xV5glRu1oyJClM3gA10v/U89MWHDT5RmauMveRqHJo0H2bp27Xmty15U
         uXMw==
X-Received: by 10.70.129.106 with SMTP id nv10mr45375409pdb.160.1430766622373;
        Mon, 04 May 2015 12:10:22 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id vi5sm13503820pbc.89.2015.05.04.12.10.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 May 2015 12:10:21 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@chromium.org,
        jogo@openwrt.org, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 2/2] MIPS: BCM63xx: Utilize asm/bmips-spaces.h
Date:   Mon,  4 May 2015 12:09:44 -0700
Message-Id: <1430766584-8429-3-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1430766584-8429-1-git-send-email-f.fainelli@gmail.com>
References: <1430766584-8429-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Since BCM63xx runs on BMIPS3300 which requires the use of a FIXADDR_TOP
to avoid collisions with the SBR, utilize asm/bmips-spaces.h which
defines FIXADDR_TOP for us now.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/include/asm/mach-bcm63xx/spaces.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/spaces.h b/arch/mips/include/asm/mach-bcm63xx/spaces.h
index 61e750fb4653..1410ed0da4df 100644
--- a/arch/mips/include/asm/mach-bcm63xx/spaces.h
+++ b/arch/mips/include/asm/mach-bcm63xx/spaces.h
@@ -10,7 +10,7 @@
 #ifndef _ASM_BCM63XX_SPACES_H
 #define _ASM_BCM63XX_SPACES_H
 
-#define FIXADDR_TOP		((unsigned long)(long)(int)0xff000000)
+#include <asm/bmips-spaces.h>
 
 #include <asm/mach-generic/spaces.h>
 
-- 
2.1.0

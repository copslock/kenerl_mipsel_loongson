Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 13:29:04 +0100 (CET)
Received: from mail-wi0-f176.google.com ([209.85.212.176]:55755 "EHLO
        mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009087AbaLRM3D1Tl02 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 13:29:03 +0100
Received: by mail-wi0-f176.google.com with SMTP id ex7so1597163wid.3;
        Thu, 18 Dec 2014 04:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=MuZXpwRF3JCKaeBe8Qcx6fq8kOQaooJ0EPKWVfm1pt8=;
        b=rOVMKeWk9OrwQzINmv2w5kz4Mhccd6WULTTkr/2bdbVK6viiZk2mkTFAtE1Ojn8Qau
         mfuGCCvNZnVDGVVBCdUNhOUaqHaWDz3CNGFUlWILixh607v013Zew+NL8BOadYrF4sOK
         bLdd5WxOOtJjIh8Z/Wb2wJDM5a3R2KmcQPpRmb255YeshvD759i+fjxxocwT5cy7CSnN
         Fv6RRSXPz4b6NwYBIPLNoQI3X55ueB847RFUXxxJqtCFsOUt86rxEH/yuMZ+G+0sx1ZA
         glY3y2C2bHCxg5dk9KD1SSJ8/iIicVqhJ8V1qV176lWVeoiFIkKgwpUml4INKluetdaV
         nZWg==
X-Received: by 10.180.76.211 with SMTP id m19mr4675392wiw.73.1418905737882;
        Thu, 18 Dec 2014 04:28:57 -0800 (PST)
Received: from hschaa-desktop.site (HSI-KBW-217-008-059-040.hsi.kabelbw.de. [217.8.59.40])
        by mx.google.com with ESMTPSA id pf4sm8761503wjb.36.2014.12.18.04.28.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Dec 2014 04:28:56 -0800 (PST)
From:   Helmut Schaa <helmut.schaa@googlemail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        Helmut Schaa <helmut.schaa@googlemail.com>
Subject: [PATCH] ath79: Increase max memory limit to 256MByte
Date:   Thu, 18 Dec 2014 13:05:40 +0100
Message-Id: <1418904340-13464-1-git-send-email-helmut.schaa@googlemail.com>
X-Mailer: git-send-email 1.8.4.5
Return-Path: <helmut.schaa@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: helmut.schaa@googlemail.com
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

At least QCA955x can handle up to 256MBytes.

Signed-off-by: Helmut Schaa <helmut.schaa@googlemail.com>
---

Only tested on QCA955x, not sure if this would affect older SoCs in some way.

Thanks,
Helmut

 arch/mips/ath79/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ath79/common.h b/arch/mips/ath79/common.h
index a312071..c39de61 100644
--- a/arch/mips/ath79/common.h
+++ b/arch/mips/ath79/common.h
@@ -17,7 +17,7 @@
 #include <linux/types.h>
 
 #define ATH79_MEM_SIZE_MIN	(2 * 1024 * 1024)
-#define ATH79_MEM_SIZE_MAX	(128 * 1024 * 1024)
+#define ATH79_MEM_SIZE_MAX	(256 * 1024 * 1024)
 
 void ath79_clocks_init(void);
 unsigned long ath79_get_sys_clk_rate(const char *id);
-- 
1.8.4.5

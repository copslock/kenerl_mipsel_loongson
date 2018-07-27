Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jul 2018 13:13:58 +0200 (CEST)
Received: from mail-lf1-x143.google.com ([IPv6:2a00:1450:4864:20::143]:33128
        "EHLO mail-lf1-x143.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990757AbeG0LNyXO4Rn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Jul 2018 13:13:54 +0200
Received: by mail-lf1-x143.google.com with SMTP id u14-v6so3277632lfu.0;
        Fri, 27 Jul 2018 04:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JjzmxAQjpb2J3gwXs5Pcpj6qK3CBWfDpwPfvEdMaxwQ=;
        b=R4bjflbn6jVS6aj7Fotd5DfxI3HeUUZYzEPmVc3dhO2/3lnq9jHDIUAXwyzKHoQcNi
         9qmjA8ajUaNxmHTdjh6HSq5upq3iLtPh8CIbX5WTMdQugSB/qFCFp1sr/xiAsKMy3A/9
         S4Sf4wOgKSi1JaOiD6W8IX4n0kQFdNHI8RdzOLWyor4/nMNozrz590WnJNHj9J9D/bDD
         BSdWQIvxvDnvxgiQWozZXjQ7kU5zBeISxQsjfP7OknmuARlHljPNT/kO21KE4qOF6DJn
         xUN2M/Fgu+AqvKgW0ES1Ly+xDvjS+H6s3fHHucqT+CJfh5UTSYldYcyhAsvzDc/N50v5
         bCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JjzmxAQjpb2J3gwXs5Pcpj6qK3CBWfDpwPfvEdMaxwQ=;
        b=f9iaOSiAOkug8j8QNQWPmfcQ9/+tNhxdDCqDnYoNSiOHDob/UNn5yqq6Ml2R69mZs3
         FFBSWmzTR9/sbJwQj+mdk89GZq2CW8AErn1+/BxhzhRca9Q0hMLjow3hWSePxpFN5wQL
         NgHWdSTfmK6j0D2ICwzSJGqrn6rv+5LjEAmXH3XLUwd/bIIN2MZ6DjBS2DdCgmIljayH
         Nn2QzWWYnYkrY9tfIsv/QKNnbK7XkaMfIjXMFI1pBhq1V3n7F0MEA0k2Yfe3UlFRWgEN
         92lZR0HQbB+vnATZv+liTe60FwIjjSDswdC1XwBMLg+ebt6JfrXCe4eY36jFgnzgE/5t
         2ENA==
X-Gm-Message-State: AOUpUlH1ykioNbLey5aFDdDt8vUME6RtLZECCHNBHV6/RyTWgV8507hF
        9U90j3Wj0nOIjvHr9T0Qe64=
X-Google-Smtp-Source: AAOMgpdRPDQ4owvZ/jXR2ZfSjOGMk3PQJrT4CHrGRoB0xm0vWV2ZM69Fxnym9CZD1kuQ5Euz6qoQng==
X-Received: by 2002:a19:a8d2:: with SMTP id r201-v6mr3894092lfe.147.1532690028679;
        Fri, 27 Jul 2018 04:13:48 -0700 (PDT)
Received: from linux-veee.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id g16-v6sm626054lje.1.2018.07.27.04.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jul 2018 04:13:47 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Michael Marley <michael@michaelmarley.com>,
        Tokunori Ikegami <ikegami@allied-telesis.co.jp>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Hauke Mehrtens <hauke@hauke-m.de>, linux-mips@linux-mips.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] Revert "MIPS: BCM47XX: Enable 74K Core ExternalSync for PCIe erratum"
Date:   Fri, 27 Jul 2018 13:13:39 +0200
Message-Id: <20180727111339.17895-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.13.7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

From: Rafał Miłecki <rafal@milecki.pl>

This reverts commit 2a027b47dba6b77ab8c8e47b589ae9bbc5ac6175.

Enabling ExternalSync caused a regression for BCM4718A1 (used e.g. in
Netgear E3000 and ASUS RT-N16): it simply hangs during PCIe
initialization. It's likely that BCM4717A1 is also affected.

I didn't notice that earlier as the only BCM47XX devices with PCIe I
own are:
1) BCM4706 with 2 x 14e4:4331
2) BCM4706 with 14e4:4360 and 14e4:4331
it appears that BCM4706 is unaffected.

While BCM5300X-ES300-RDS.pdf seems to document that erratum and its
workarounds (according to quotes provided by Tokunori) it seems not even
Broadcom follows them.

According to the provided info Broadcom should define CONF7_ES in their
SDK's mipsinc.h and implement workaround in the si_mips_init(). Checking
both didn't reveal such code. It *could* mean Broadcom also had some
problems with the given workaround.

Reported-by: Michael Marley <michael@michaelmarley.com>
Cc: Tokunori Ikegami <ikegami@allied-telesis.co.jp>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: stable@vger.kernel.org
Cc: James Hogan <jhogan@kernel.org>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
This has been reported by Michael as OpenWrt bug at:
https://bugs.openwrt.org/index.php?do=details&task_id=1688
---
 arch/mips/bcm47xx/setup.c        | 6 ------
 arch/mips/include/asm/mipsregs.h | 3 ---
 2 files changed, 9 deletions(-)

diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 8c9cbf13d32a..6054d49e608e 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -212,12 +212,6 @@ static int __init bcm47xx_cpu_fixes(void)
 		 */
 		if (bcm47xx_bus.bcma.bus.chipinfo.id == BCMA_CHIP_ID_BCM4706)
 			cpu_wait = NULL;
-
-		/*
-		 * BCM47XX Erratum "R10: PCIe Transactions Periodically Fail"
-		 * Enable ExternalSync for sync instruction to take effect
-		 */
-		set_c0_config7(MIPS_CONF7_ES);
 		break;
 #endif
 	}
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 0bc270806ec5..ae461d91cd1f 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -681,8 +681,6 @@
 #define MIPS_CONF7_WII		(_ULCAST_(1) << 31)
 
 #define MIPS_CONF7_RPS		(_ULCAST_(1) << 2)
-/* ExternalSync */
-#define MIPS_CONF7_ES		(_ULCAST_(1) << 8)
 
 #define MIPS_CONF7_IAR		(_ULCAST_(1) << 10)
 #define MIPS_CONF7_AR		(_ULCAST_(1) << 16)
@@ -2767,7 +2765,6 @@ __BUILD_SET_C0(status)
 __BUILD_SET_C0(cause)
 __BUILD_SET_C0(config)
 __BUILD_SET_C0(config5)
-__BUILD_SET_C0(config7)
 __BUILD_SET_C0(intcontrol)
 __BUILD_SET_C0(intctl)
 __BUILD_SET_C0(srsmap)
-- 
2.13.7

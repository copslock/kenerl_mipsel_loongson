Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 09:04:28 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:33716
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990514AbdCOIEVw2E6O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Mar 2017 09:04:21 +0100
Received: by mail-wm0-x241.google.com with SMTP id n11so3320464wma.0
        for <linux-mips@linux-mips.org>; Wed, 15 Mar 2017 01:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kresin-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=0nk75GQJSM75wt18IVUhUYxorsj+Tn69CURqQ0HRdto=;
        b=hkEgATP2pxLTo8dVpbSx9SR7r+7doXhMxf2+BLk+y27G8UgN4Uv0s8zHh2K0trlgxz
         g5Z5AQzdL+bO3fk7nP+bcsaVQQX9OVDWtJ0PaJ990mibQkbHH+T0X06ThKGJL+6hiOnD
         9JnugeLMo/8FFQdCqdegt+zkCAsg2CIEDq2G5RjOhFhaA4teWFl9i296iTiMnYB2IFoY
         hX1NxhkJdCgujaZAFyMh+YsNBR3cMdfu9D8JFF+vh/jyWPCm6jEOJ2XTCZzy8Fw+7DY5
         dJoDgBViif4NgCCyRmJiBcnD9IiGvPekflagHd7fCJq60aR7h7Gm6bjKtDelf3KeQRA+
         tOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0nk75GQJSM75wt18IVUhUYxorsj+Tn69CURqQ0HRdto=;
        b=sm1gvWwQ0Aex/V+cknfYuYw7+Y6jx+6Nkwdm9xrSh2RxY/7KXtnCBjWggf66rvMgbj
         7sKfeMnkd3VtjGHXP8ye1cxvr1fsMauDhjAjSziYzKSH1d3LPV7NvLuKdjnxR5kErR4N
         VnuGySS1Coj5RZrY+sBOGBurHKQV1CjTf+Vz/gtuZO9rhsShftvGmSlj4liAtYpD1Qix
         DJY6vFitvmncncQisCxBy2uDoamfVSdIdCd5h6W17gy94aUy4rQDgmJHA+WPOHXl+Q77
         eidQS29ZgJlwExXD2tV5zteblQsrmFppsGsBZ/aWZT0d2Mxha5X4XkbsM7bRpvQh3UOo
         nIZw==
X-Gm-Message-State: AFeK/H2qCZNPp5lbefN7uk3CD0MwKhgXVXxi3WyLZQTKW6IzZJixcHZe/KTu0jOHzYOLXg==
X-Received: by 10.28.35.151 with SMTP id j145mr17963629wmj.50.1489565056484;
        Wed, 15 Mar 2017 01:04:16 -0700 (PDT)
Received: from desktop.wvd.kresin.me (p2003008C2F134E007425DF58C90881F4.dip0.t-ipconnect.de. [2003:8c:2f13:4e00:7425:df58:c908:81f4])
        by smtp.gmail.com with ESMTPSA id r8sm1336082wrb.33.2017.03.15.01.04.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Mar 2017 01:04:16 -0700 (PDT)
From:   Mathias Kresin <dev@kresin.me>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: PCI: scan PCI controllers in reverse order
Date:   Wed, 15 Mar 2017 09:03:59 +0100
Message-Id: <1489565039-2621-1-git-send-email-dev@kresin.me>
X-Mailer: git-send-email 2.7.4
Return-Path: <dev@kresin.me>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dev@kresin.me
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

Commit 23dac14d05 "MIPS: PCI: Use struct list_head lists" changed the
controller list from reverse to straight order without taking care of
the changed order for the scan of the recorded PCI controllers.

Traverse the list in reverse order to restore the former behaviour.

This patches fixes the following PCI error on lantiq:

  pci 0000:01:00.0: BAR 0: error updating (0x1c000004 != 0x000000)

Fixes: 23dac14d05 ("MIPS: PCI: Use struct list_head lists")
Signed-off-by: Mathias Kresin <dev@kresin.me>
---
 arch/mips/pci/pci-legacy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
index 014649b..76a7ccc 100644
--- a/arch/mips/pci/pci-legacy.c
+++ b/arch/mips/pci/pci-legacy.c
@@ -222,7 +222,7 @@ static int __init pcibios_init(void)
 	struct pci_controller *hose;
 
 	/* Scan all of the recorded PCI controllers.  */
-	list_for_each_entry(hose, &controllers, list)
+	list_for_each_entry_reverse(hose, &controllers, list)
 		pcibios_scanbus(hose);
 
 	pci_fixup_irqs(pci_common_swizzle, pcibios_map_irq);
-- 
2.7.4

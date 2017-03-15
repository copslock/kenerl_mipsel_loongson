Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 21:09:19 +0100 (CET)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:36251
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992111AbdCOUJMaDmvL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Mar 2017 21:09:12 +0100
Received: by mail-wr0-x241.google.com with SMTP id l37so3362779wrc.3
        for <linux-mips@linux-mips.org>; Wed, 15 Mar 2017 13:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kresin-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=miAADLHqCKlc5RQc+546JUaWFbxre2kxor0RiyCtamY=;
        b=mX7JO2bWkKWi2IbCBftIUXJDmDEsUHfWYJ762CFd4ExByz3eErGxKQJWv458Urb1rK
         QlfIvxRFprNZkGGufACkntqLLF91OoT26Ri5mGyYh9yEaNnrOmRdSV3E/pd0mdwolvBC
         4u6kzBmC06zrS1b+0HhnLUBcK1gZV1nObQdhCdcH3lbUfzthSU/DbOXPWeFljdr31t7M
         Z1lA4PgO88rpgzmFgQYMD362FNKi4Cs0HpO7ts+N5BV7Bl59Pd3074Zpiki8/cuKABG1
         bN4gGKMIHtkGh4qmz2Z2fZIEHbLSBPQDWcTJLGWn5y/vSKkKIoJbhtv0IHI3y8CbOuDv
         iFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=miAADLHqCKlc5RQc+546JUaWFbxre2kxor0RiyCtamY=;
        b=lBBS2TMEnsSruyX2e4sKGi5CGHpTHSx6x8S70HCmkqwkbG/Lq9JYLLZfH4p4vnRNiZ
         TGUsQtaJ3RUmQ5ZL3p7w21C/8Ky1SV7wMBN8OOh9Qp0WHK5X7FmWTVHjN6zVaTdyGG/t
         7yK6t/3HjLLq1J1dRaazSB4BFE0OyI+/0Qi7nL9JAnB1jhm9gkQxttOAJ1+GEqfapJJb
         rxFT5rlQyhg5R5x7R/ntQUwi3ZfS33g7O+K5OZZSMYoJD3w1O8CO2kpe5NUjSnou1HiI
         HRbZ0/Dez05ACSunEXQUK6pUqlmPOub0fh3kqbljCRVFvlq+5wqt1E3CKgqU8zm88b+E
         w81w==
X-Gm-Message-State: AFeK/H2y5nPxgbcALG5e0vo/e43y9Sm4tMXg1xbbqx/Cb01KEIIwb2X7DVy+U07iGQwYvQ==
X-Received: by 10.223.136.182 with SMTP id f51mr4411692wrf.90.1489608546424;
        Wed, 15 Mar 2017 13:09:06 -0700 (PDT)
Received: from desktop.wvd.kresin.me (p2003008C2F134E009DA448A58F84DC9C.dip0.t-ipconnect.de. [2003:8c:2f13:4e00:9da4:48a5:8f84:dc9c])
        by smtp.gmail.com with ESMTPSA id v3sm3568993wrb.39.2017.03.15.13.09.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Mar 2017 13:09:06 -0700 (PDT)
From:   Mathias Kresin <dev@kresin.me>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org
Subject: [PATCH v2] MIPS: PCI: scan PCI controllers in reverse order
Date:   Wed, 15 Mar 2017 21:08:58 +0100
Message-Id: <1489608538-8035-1-git-send-email-dev@kresin.me>
X-Mailer: git-send-email 2.7.4
Return-Path: <dev@kresin.me>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57308
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

Commit 23dac14d058f ("MIPS: PCI: Use struct list_head lists") changed
the controller list from reverse to straight order without taking care
of the changed order for the scan of the recorded PCI controllers.

Traverse the list in reverse order to restore the former behaviour.

This patches fixes the following PCI error on lantiq:

  pci 0000:01:00.0: BAR 0: error updating (0x1c000004 != 0x000000)

Fixes: 23dac14d058f ("MIPS: PCI: Use struct list_head lists")
Signed-off-by: Mathias Kresin <dev@kresin.me>
---

Changes in v2:
- fix formal issues in commit message (Sergei Shtylyov)

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

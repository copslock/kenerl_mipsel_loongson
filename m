Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Mar 2017 19:05:57 +0200 (CEST)
Received: from mail-wr0-x243.google.com ([IPv6:2a00:1450:400c:c0c::243]:36087
        "EHLO mail-wr0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990509AbdCZRFrDPcqj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 26 Mar 2017 19:05:47 +0200
Received: by mail-wr0-x243.google.com with SMTP id u1so6321975wra.3
        for <linux-mips@linux-mips.org>; Sun, 26 Mar 2017 10:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kresin-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=SsB5eW5y/gM3F2/e/rgOL/Szj5d2e5KZHXbuLpyiDG8=;
        b=Ps29ErXw7CWbWtkTnjrtt5Ux8aVh3yKfk8IKQu7j1D1aLRB8pY5zabHweYzfyVxw70
         Eb+QcidQY2QaWkPzV1KhN+oACESSbIYEXqpi2RlwHAPZOUAhABbmoJngHTT7es1BW/qb
         ua/C3VbGxEgmYHHaFvO7QU8Je5EghhGhYf2ccM6ThiFR6Zbkf9GZuO/K/LU2xkoOBDdn
         a2msG/hDbNq9hD1sVATDxW3J29MjTxCCytGKWeP5oyL8tLatm785kho/PLkEmn4ZTJEO
         HtS9jajWCpeJDFD/JxlDjYKyppOsrUlmegZWHC8tGLvGrDBku7Zv/MWpjffiudmmp6IZ
         gKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SsB5eW5y/gM3F2/e/rgOL/Szj5d2e5KZHXbuLpyiDG8=;
        b=EFihBlJfZBvlaQkbwsF8WkjRfx5uHV35nw9IBapz5pLj0zK8/cm8ULDmthalNCXIgd
         JSMSAcm8APgkFUgcIxNq4OzTqp5vzx+vQ7t8N2MJWTQV+jZK0HfcNEdbXVuUGmDlkE+0
         5R1mt4ErdxYPV9ogwKoGAJN97WpxY4CWKkNj847u6W5FAr5hUrqaajtNoA4Tyi+MzLAN
         ljn8qb4DXjnfPmZ94PdUrybbsGDv7Iyke8KhzmjZ5WsoqiK4nxaJEg8wghdf6sL2NkEG
         +IwY/xvQ1ozM+glsc6OecwpX5xZEYrCmcbMOCxJk51r+hXq+iSBuFKPruJU0kwqX2zO+
         cJAw==
X-Gm-Message-State: AFeK/H1JYXNIrdXfmLC1H6+sP7dIafftSDpOqVyMeq1HeIytOzf0Q7G/OWRYKkRPzpezpQ==
X-Received: by 10.28.55.138 with SMTP id e132mr5984297wma.6.1490547941520;
        Sun, 26 Mar 2017 10:05:41 -0700 (PDT)
Received: from desktop.wvd.kresin.me (pD9F6A192.dip0.t-ipconnect.de. [217.246.161.146])
        by smtp.gmail.com with ESMTPSA id c17sm11422713wre.30.2017.03.26.10.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 Mar 2017 10:05:41 -0700 (PDT)
From:   Mathias Kresin <dev@kresin.me>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org
Subject: [PATCH v3] MIPS: PCI: add controllers before the specified head
Date:   Sun, 26 Mar 2017 19:05:36 +0200
Message-Id: <1490547936-21871-1-git-send-email-dev@kresin.me>
X-Mailer: git-send-email 2.7.4
Return-Path: <dev@kresin.me>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57447
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

With commit 23dac14d058f ("MIPS: PCI: Use struct list_head lists") new
controllers are added after the specified head where they where added
before the specified head previously.

Use list_add_tail to restore the former order.

This patches fixes the following PCI error on lantiq:

  pci 0000:01:00.0: BAR 0: error updating (0x1c000004 != 0x000000)

Fixes: 23dac14d058f ("MIPS: PCI: Use struct list_head lists")
Signed-off-by: Mathias Kresin <dev@kresin.me>

---

Changes in v3:
- fix the list order instead of adjusting the controller scan order
- update commit message accordingly

Changes in v2:
- fix formal issues in commit message (Sergei Shtylyov)

 arch/mips/pci/pci-legacy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
index 014649b..3a84f6c 100644
--- a/arch/mips/pci/pci-legacy.c
+++ b/arch/mips/pci/pci-legacy.c
@@ -190,7 +190,7 @@ void register_pci_controller(struct pci_controller *hose)
 	}
 
 	INIT_LIST_HEAD(&hose->list);
-	list_add(&hose->list, &controllers);
+	list_add_tail(&hose->list, &controllers);
 
 	/*
 	 * Do not panic here but later - this might happen before console init.
-- 
2.7.4

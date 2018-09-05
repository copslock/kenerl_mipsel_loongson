Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2018 08:51:43 +0200 (CEST)
Received: from mail-wr1-x444.google.com ([IPv6:2a00:1450:4864:20::444]:44113
        "EHLO mail-wr1-x444.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993094AbeIEGvjNPnp- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2018 08:51:39 +0200
Received: by mail-wr1-x444.google.com with SMTP id v16-v6so6314492wro.11
        for <linux-mips@linux-mips.org>; Tue, 04 Sep 2018 23:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kresin-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ri7EJN21pZemz2aQZfOHbQwdWYzT7gNlzYbBQlc8r5c=;
        b=hRMuV7vUG7c9qjmi4dfbs6ytnUOwLDK0VoJUq8g8woxXLRJqHF8oKS1hweMOqtbmXP
         iooIyVCjWhA+D20sBXVFLj3fe9AWkzhk/DlGjxy2JDKVyiHAtagg1qrkFNtMlpzrjL4A
         kYd10qkfhe2P9uFI5JmEvmDdFDtxS8BoTWwIeQaaIoOpnj8aREm+9n+JRwRr0QakrdYF
         2qItct9jZMF9FBdhdQgpGyZpPuivEl0aNn2l//+8I0ouOE0cX7bhxUeCIEh/Kx7BpxZZ
         zaXfDLQzF4guaFcMizrJPeAhKMFHfq4o8k4+gAOjzrpv1LxWzZ2h+qPhYh870uSaeG16
         rWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ri7EJN21pZemz2aQZfOHbQwdWYzT7gNlzYbBQlc8r5c=;
        b=VO/4ONun0Uh7yTQZGnkFucf28ZrR2f81QJNocj5wLYciBlZcrPahxVHnRXPpm5U6g6
         jHcJ26UjR8hTF3gg2jq6IZY0O7In8jznzx7n1Wc/pvPgOJdVQ1PDkReQbyQdv36e9h1M
         M1Pe61t1QkA5sY2Zbh9ypASIj6dd+b4tXNdPf/yaQ+xBgadihmHxEp9ePvk+q9peRqiL
         /uJTtjTd0BBAmJlDLW41M6NMrkU+AOZNy1URAdsTN6m9mk0Bq02/6xtjneTyNuo8ASHx
         h2/jYqRDNZPbSyieiatkv6KwHcJVquV06Ccxp1jzcDHesRtIUQZYYNzyBsuFSZGuEucG
         zw6Q==
X-Gm-Message-State: APzg51DEMNiwPbbxOSLXae14mBO98Cu8a4TlLHCst2h0dD12n+VIhs7M
        BdpPZJb8u9kKK3539I3mheL4UQ==
X-Google-Smtp-Source: ANB0VdbOtamYmccuSQE98uXRO0dEIaMO4OPoJOpHf9ssZRqeGf5yM0kXNwv9trcWJCdMMTS6qiV0FA==
X-Received: by 2002:adf:94c5:: with SMTP id 63-v6mr25937832wrr.247.1536130293775;
        Tue, 04 Sep 2018 23:51:33 -0700 (PDT)
Received: from desktop.wvd.kresin.me (p200300EC2BD12900A4378724D7036CAE.dip0.t-ipconnect.de. [2003:ec:2bd1:2900:a437:8724:d703:6cae])
        by smtp.gmail.com with ESMTPSA id s10-v6sm810818wrw.35.2018.09.04.23.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 23:51:33 -0700 (PDT)
From:   Mathias Kresin <dev@kresin.me>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, Tobias Wolf <dev-NTEO@vplace.de>
Subject: [PATCH] MIPS: pci-rt2880: set pci controller of_node
Date:   Wed,  5 Sep 2018 08:51:26 +0200
Message-Id: <1536130286-32088-1-git-send-email-dev@kresin.me>
X-Mailer: git-send-email 2.7.4
Return-Path: <dev@kresin.me>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65935
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

From: Tobias Wolf <dev-NTEO@vplace.de>

Set the PCI controller of_node such that PCI devices can be
instantiated via device tree.

Signed-off-by: Tobias Wolf <dev-NTEO@vplace.de>
Signed-off-by: Mathias Kresin <dev@kresin.me>
---
 arch/mips/pci/pci-rt2880.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/pci/pci-rt2880.c b/arch/mips/pci/pci-rt2880.c
index 711cdcc..f376a1d 100644
--- a/arch/mips/pci/pci-rt2880.c
+++ b/arch/mips/pci/pci-rt2880.c
@@ -246,6 +246,8 @@ static int rt288x_pci_probe(struct platform_device *pdev)
 	rt2880_pci_write_u32(PCI_BASE_ADDRESS_0, 0x08000000);
 	(void) rt2880_pci_read_u32(PCI_BASE_ADDRESS_0);
 
+	rt2880_pci_controller.of_node = pdev->dev.of_node;
+
 	register_pci_controller(&rt2880_pci_controller);
 	return 0;
 }
-- 
2.7.4

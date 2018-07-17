Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2018 13:42:05 +0200 (CEST)
Received: from mail-pf0-x241.google.com ([IPv6:2607:f8b0:400e:c00::241]:43797
        "EHLO mail-pf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990422AbeGQLmC2MvqT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jul 2018 13:42:02 +0200
Received: by mail-pf0-x241.google.com with SMTP id j26-v6so370424pfi.10;
        Tue, 17 Jul 2018 04:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zsxyWlJa5L1Gv7t8Xsms7pw8bNxF0HNNGy0CGtS1AO8=;
        b=av1CxqpND9tL7sjaBogagecvcJetC3oAWvnNxypjEI9WMLUHQvnzFPijEUNYszrv2Z
         fcgFtSx4HGUNSPkiwnabYDd/biIqVS3DHhJwsJum1NrX618ChCI1fmYhoUwYl04EPMII
         EF4VtyW2IqiAaqIuji999n3sxPfB7zMbCPulTCS/56gRndKKCYvviemHYK5kZqFiHods
         UWlYqIj3DbrTP1N5EUHDcvmoPnQCC5vhPek2CV5FoT/pFNVklwgtm/pkpasDbpyZqmIH
         z9OyI6SgZCiyav+dRXcAhn9NFVAoNy5R9K1lQuKN3q8NkemfOrvDFM1IAQdG0++/eoYz
         6FYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zsxyWlJa5L1Gv7t8Xsms7pw8bNxF0HNNGy0CGtS1AO8=;
        b=Jf9hP0CN8bEdgEFPmcuX0vlRP1j9fbJyKITglYXxtqf97zMd73DmW8PmTrrQVmgJaX
         eP3bZg44X/quslraXYanV64hoMIBBpsrZRbneRzsYsQWfQA3/luy0HVLrZrd+6hRryXQ
         Me52K8lwe4JSho1B9TwKf7+ysVSYcuJ5rTnecp0pnLjB1npv90UxNhG2Dw9XgPRzdTA1
         6cHHyvIBaVY0fGtun2dDObbcaA+0j44mCSboAvxtUz7uwvA+T+yEO8cnvAusszbUlpov
         7hm8YJsAd+XwaLNs0iO1HWUJGNlyS0mnkITkVr6nPKof9avAYERmlkYyFvIOjv28whjW
         NF+A==
X-Gm-Message-State: AOUpUlFBFLuuy+2v9UmHlphQ0XW5ynWYADGWZmV4gUR0VsvKKO6Ci6KH
        FcxTPA54LoT5f4K6VMTtPBJ2pJ7A
X-Google-Smtp-Source: AAOMgpdKSlpSxNSgGY0ksWmsXX+fvQbnKkweeoyQhZ6emF1MihY65ctxGtSX0uthlZTPNYhdhHCdIA==
X-Received: by 2002:a62:748:: with SMTP id b69-v6mr302636pfd.177.1531827715681;
        Tue, 17 Jul 2018 04:41:55 -0700 (PDT)
Received: from raghu-VirtualBox ([116.197.184.12])
        by smtp.gmail.com with ESMTPSA id y132-v6sm1608095pfb.91.2018.07.17.04.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 04:41:54 -0700 (PDT)
From:   RAGHU Halharvi <raghuhack78@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     RAGHU Halharvi <raghuhack78@gmail.com>, jhogan@kernel.org,
        ralf@linux-mips.org
Subject: [PATCH] mips:sgi-ip22:Check return value from kzalloc
Date:   Tue, 17 Jul 2018 17:11:45 +0530
Message-Id: <20180717114145.21856-1-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.17.1
Return-Path: <raghuhack78@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghuhack78@gmail.com
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

Signed-off-by: RAGHU Halharvi <raghuhack78@gmail.com>
---
 arch/mips/sgi-ip22/ip22-gio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/sgi-ip22/ip22-gio.c b/arch/mips/sgi-ip22/ip22-gio.c
index b225033aade6..5aaf40a1743b 100644
--- a/arch/mips/sgi-ip22/ip22-gio.c
+++ b/arch/mips/sgi-ip22/ip22-gio.c
@@ -363,6 +363,8 @@ static void ip22_check_gio(int slotno, unsigned long addr, int irq)
 		printk(KERN_INFO "GIO: slot %d : %s (id %x)\n",
 		       slotno, name, id);
 		gio_dev = kzalloc(sizeof *gio_dev, GFP_KERNEL);
+		if (!gio_dev)
+			return -ENOMEM;
 		gio_dev->name = name;
 		gio_dev->slotno = slotno;
 		gio_dev->id.id = id;
-- 
2.17.1

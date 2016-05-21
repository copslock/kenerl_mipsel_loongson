Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 14:07:38 +0200 (CEST)
Received: from mail-lb0-f196.google.com ([209.85.217.196]:34976 "EHLO
        mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27032498AbcEUMCh1lrZI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 14:02:37 +0200
Received: by mail-lb0-f196.google.com with SMTP id mx9so6877127lbb.2;
        Sat, 21 May 2016 05:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=QxnwcHoeXnoHa7GwtWpewxc9+v4QrmgcQtWZT031ANQ=;
        b=Wxe6YJYn8R6NKtvdLqLTm5RhhwrlI3a6JMz7lK6r3vkx0fnle/ilnPVrV118Ld7Gc+
         pU3PcAdpjXi/HvBw2hoyNjxmIZYfg1pbwzrpcbizsUtpPYvNatPtEA4K0XUAdhrGZV1u
         QsQnt58HiHibnIxf1hYYqwcXCXq48xsuNQJmLV8TLtYQWgMLv6JIwU7a8PF1epHgrrjY
         8eIn4Su08bYUXT5hykmBpULXjb85axEs22OngXCQV6mf1tLOaTiCCnylv6NNc7nS0am0
         3pYhce9VFbfkivrJju9hZduSNklGnV/Bw41ZMvcCVKTdJhJrCM3PAhVhMdTuYR8jsdc+
         zhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=QxnwcHoeXnoHa7GwtWpewxc9+v4QrmgcQtWZT031ANQ=;
        b=gKspPtnfqm/wrL3wcQpW9ruKIUFm9TjryY5AmT6hVyrF5M1xRTo51kOfo92SAAe/Y9
         PT7q9dtj60QLiCSqcNt8+bRtQRZuKGvaDi2V6Vp46GQqhHQsMVq4GWEbMinIQ+hBfXJc
         NWIHAdWCaN3qSOj4bEHctetLAgfNPhBjXRdhRRg9+LqlW5UvmXrd6skETa/Tr98Gz3vx
         bMUmC8K65lSBSU3NuD4840atnq9S/Q4B553Oy3z5/EXM0q92Qssdo6BXYJxU+gjafYiz
         yWRIBtVu5wwHbz39qorChfrK7KUVbMEwAv871KOZHl6ZtgLDF0oGBgXMmteH905T9z23
         zmaA==
X-Gm-Message-State: AOPr4FUEnXNG1U78AHPUsZpE+aUawLvwjxBLpwvVpZ+CQnllDhLGJGRd1vdGl6qyRLEpNw==
X-Received: by 10.112.181.72 with SMTP id du8mr2706252lbc.137.1463832152126;
        Sat, 21 May 2016 05:02:32 -0700 (PDT)
Received: from glen.ipredator.se (anon-35-25.vpn.ipredator.se. [46.246.35.25])
        by smtp.gmail.com with ESMTPSA id wt10sm4143864lbb.25.2016.05.21.05.02.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 May 2016 05:02:30 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     trivial@kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 0202/1529] Fix typo
Date:   Sat, 21 May 2016 14:02:26 +0200
Message-Id: <20160521120226.10458-1-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 2.8.2.534.g1f66975
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53600
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
 arch/mips/vr41xx/common/cmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/vr41xx/common/cmu.c b/arch/mips/vr41xx/common/cmu.c
index 05302bf..89bac98 100644
--- a/arch/mips/vr41xx/common/cmu.c
+++ b/arch/mips/vr41xx/common/cmu.c
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 2001-2002  MontaVista Software Inc.
  *    Author: Yoichi Yuasa <source@mvista.com>
- *  Copuright (C) 2003-2005  Yoichi Yuasa <yuasa@linux-mips.org>
+ *  Copyright (C) 2003-2005  Yoichi Yuasa <yuasa@linux-mips.org>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
-- 
2.8.2.534.g1f66975

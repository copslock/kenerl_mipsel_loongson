Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2017 20:27:56 +0200 (CEST)
Received: from mail-pg0-x241.google.com ([IPv6:2607:f8b0:400e:c05::241]:37536
        "EHLO mail-pg0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994895AbdHQS0fnjY37 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Aug 2017 20:26:35 +0200
Received: by mail-pg0-x241.google.com with SMTP id 83so11083865pgb.4;
        Thu, 17 Aug 2017 11:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UPSJYzi15MSSwrls8IbFRIF7C1utyrdLgFJmYxlokJM=;
        b=IzrdIWBkI2nvT9c3jOdJU+6rFm69cJxVmNDjrOiwzIpSIq3L6tBEDZ+o3YG9kBxN/4
         wQCEC6tBajFIGFHc2Gl13NNmgUuaZse+muwcjUrfJQhvaPKXlxOO3iVYzinsmIRSe/Pf
         RWIedw64MIbHgn7YP8xOBqdKIXa83XvJWYnDh/7wdlB8HYXIKEjWCxWtyrBMySroWeZm
         uAynP0ULCMajnCyJkgc8vYF44JBxkYFZ9PFiLsPC+e1OOaMxDueQkibfUOSsDtCJrfYg
         C5PVK0EzqJEh2qjs8GWwo6diWklQ6f4ryAMdLmobJNueViD8ZnsvOxlpOg8jNgHG2Pdy
         A4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UPSJYzi15MSSwrls8IbFRIF7C1utyrdLgFJmYxlokJM=;
        b=CC915yqCBbVZ6CRbNm3tHMH5JF0yOX7dR4hh9vyU0W6q/IGJHBzr8brXuEZ7DBif8z
         qWK71UWPv2Zy0e2e4gOXVR3MHie7vTMFqmQpOhcrJTXS6dPpUstddSAJ/eWkbc6sEyyz
         50m+fl3FV2kbI1ApGHEUYNXvBOsxFehqaY+LU9ZoNSfkNbZ6kaigsMi4qKbnT6pJc4si
         hb2fne8sQQH9GwZHXI+H8b35TXfUmOjy1K6PFgOjjNBICvhpBPou97z2BXZ/OvMS1HeM
         2ZZhSzqf2Rxf6Nzc9WzDeBQKniZe/D2eJk8kIxf133ZmlirVCrhwvgCqsDOrsjl2lrI2
         0dCg==
X-Gm-Message-State: AHYfb5gwRe04ivM+7BxPN4Esva8iFq7W0hB/SZ3Uk3rxz8uEPdZ5Bz+x
        j0noLsf5j9eGhA==
X-Received: by 10.99.4.9 with SMTP id 9mr2915210pge.70.1502994390049;
        Thu, 17 Aug 2017 11:26:30 -0700 (PDT)
Received: from linux.local ([42.109.133.212])
        by smtp.gmail.com with ESMTPSA id a86sm8882565pfe.181.2017.08.17.11.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Aug 2017 11:26:29 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To:     herbert@gondor.apana.org.au, robh+dt@kernel.org,
        mark.rutland@arm.com, ralf@linux-mips.org, mturquette@baylibre.com,
        sboyd@codeaurora.org, davem@davemloft.net, paul@crapouillou.net,
        linux-crypto@vger.kernel.org, linux-mips@linux-mips.org
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [PATCH 5/6] crypto: jz4780-rng: Add myself as mainatainer for JZ4780 PRNG driver
Date:   Thu, 17 Aug 2017 23:55:19 +0530
Message-Id: <20170817182520.20102-6-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20170817182520.20102-1-prasannatsmkumar@gmail.com>
References: <20170817182520.20102-1-prasannatsmkumar@gmail.com>
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

Add myself as the maintainer of JZ4780 SoC's PRNG drvier.

Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 45ec467..ee8c6f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6733,6 +6733,11 @@ L:	linux-mtd@lists.infradead.org
 S:	Maintained
 F:	drivers/mtd/nand/jz4780_*
 
+INGENIC JZ4780 PRNG DRIVER
+M:	PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
+S:	Maintained
+F:	drivers/crypto/jz4780-rng.c
+
 INOTIFY
 M:	John McCutchan <john@johnmccutchan.com>
 M:	Robert Love <rlove@rlove.org>
-- 
2.10.0

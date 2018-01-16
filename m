Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2018 04:27:12 +0100 (CET)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:38964
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991685AbeAPD1FuZJRw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Jan 2018 04:27:05 +0100
Received: by mail-qk0-x244.google.com with SMTP id c69so10137249qkg.6;
        Mon, 15 Jan 2018 19:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1MVXtJ6x4W1L+arjZeA1NqvWN3N6bhRdZLGsSQDtaAw=;
        b=vfydIRn2CNthqopfYXH5k7XikQz//NF9PjcfjgVzDks24cy+zqRkM47h4+QvYggHix
         bwmpssU6exNgRNk+vqZfKVPg8UzY6Rp7xNJ89KMcU2XFKNdhJpDzmcLzb8zfAaK5UYVw
         iYrZXkHIVPAhaV0m2E/Qz5CjQ+JXFKJ/d8/4WQdrPc0ESFNsE5MN1Qk9VvFOfJBjlu3r
         4IgLwcgM1pDELU9d9lm7OSKA6WQE7RMl6JFv1WXY0siw298jRcTubSbA0fHsB4NJO2yo
         mWsnv41GeRPAs9wKyM2udZkvBbsERb4nfW3wNH2Eig1Ov9/xpqCxg1IdMTCFwQZ13dwT
         UZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1MVXtJ6x4W1L+arjZeA1NqvWN3N6bhRdZLGsSQDtaAw=;
        b=td6sGPCVH9FfECtummJJcv6UXyQ+k9hKsst4OVU8NxdnMcXk5vTr7osZmMf2ONF/2w
         ygPAb4pl1pKhhXoY3NDRYu+tffq8VjX8mc0Kv9AevbvV6obgdZYp80O66LVxXmKCf4eH
         mwtqMy4FCwVbO4iRMWoPAm5cjHyuj++eBeNfAs/WP+2fHzM9UFddhblXblR5zaSA6o+i
         b6Yl4TLSUGASW6kfKGRN/A4eVfxrkJ6JS9Z6CHp0yZdhUuso7iAL2qNtJwzMNIWO3U8P
         HIdxKFfij+TwxmKSninfrFH0CyirEzGY/GTgVgsmjXOXcn1TBL9nUAi596y8RSfRkuXG
         jL3A==
X-Gm-Message-State: AKwxytftHx+9YTnlaTf23CXYeVH+aJYIP/n+t9Ya2LxfM9nVTNL+aI0G
        q9q1eGrA2NjLdDhZpLkGuDD4zA==
X-Google-Smtp-Source: ACJfBov/FIhtklYsLTv3KRkhVtevh5C4BqnS8bU18pvZYGptMzrVbe0onOiDtlyfnxjb5lpzYs0xBA==
X-Received: by 10.55.174.67 with SMTP id x64mr53299526qke.55.1516073219439;
        Mon, 15 Jan 2018 19:26:59 -0800 (PST)
Received: from localhost.localdomain (c-71-60-35-21.hsd1.pa.comcast.net. [71.60.35.21])
        by smtp.googlemail.com with ESMTPSA id q2sm768786qki.26.2018.01.15.19.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jan 2018 19:26:58 -0800 (PST)
From:   Daniel Sabogal <dsabogalcc@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] MIPS: Fix vmlinuz build when ZBOOT is selected
Date:   Mon, 15 Jan 2018 22:29:54 -0500
Message-Id: <20180116032954.13722-1-dsabogalcc@gmail.com>
X-Mailer: git-send-email 2.15.0
Return-Path: <dsabogalcc@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dsabogalcc@gmail.com
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

vmlinuz is not built by default for platforms using
COMPRESSION_FNAME (e.g. Malta) due to an erroneous
check on ZBOOT

Signed-off-by: Daniel Sabogal <dsabogalcc@gmail.com>
---
 arch/mips/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 9f6a26d72f9f..0f20f84de53b 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -228,7 +228,7 @@ libs-y				+= arch/mips/fw/lib/
 #
 # Kernel compression
 #
-ifdef SYS_SUPPORTS_ZBOOT
+ifdef CONFIG_SYS_SUPPORTS_ZBOOT
 COMPRESSION_FNAME		= vmlinuz
 else
 COMPRESSION_FNAME		= vmlinux
-- 
2.15.0

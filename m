Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Jan 2018 16:34:18 +0100 (CET)
Received: from mail-lf0-x242.google.com ([IPv6:2a00:1450:4010:c07::242]:41180
        "EHLO mail-lf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994794AbeAaPdsUsU1N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Jan 2018 16:33:48 +0100
Received: by mail-lf0-x242.google.com with SMTP id f136so21336463lff.8;
        Wed, 31 Jan 2018 07:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jjO8isB54+Zz1K4rKCzyl/mPhuuq7YMetmxdP1OzSd8=;
        b=O9O4W3lY9tjSrvbpbZuNAosbIt6zm4eSBAaQgk4LRu2CviMMFAX/D2lfhMDwvYJMQp
         A8O1TXYPRO18xlPqB5BBzZzyBpsPn/blyvSt10XA0M/QVH9MkAp9tTo4jwTQ2Gx7dPEt
         4FF7W0CDNjrpbNDXlSt8p8E4r+j/QkqxiMDCud0wvjii4T6q1wLhZpHRtRzxV7/nU5au
         xDL7gKeoAsaDmSCD55ftRFNKmwMF99V4KlhNHOOJliy5B7fdLarLI3ScxFHGOSg7aD1v
         wmUgOWRN92imo4uUkgUcTqQqGO6ZL3f1lUSiZHKMJJ1l8JzQfL5v733j1J5G1EP7khv9
         Q8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jjO8isB54+Zz1K4rKCzyl/mPhuuq7YMetmxdP1OzSd8=;
        b=Mz0VeEgIHzK9wH17e1JS6xsXxqbfCQAmgmo4iXYsE7bPz0yZ9gneB2I2is0tEBdlOv
         39djMrTXI66ib8nV7/rbIuLexCcrIMTb2UJCHpL1QPrkTegLsbHmWy/WIJaTC0Fz+eik
         j81q4GRp8NuYuJvmLxsBKJojKg42HdNhIvmetl56BiPW+0DbQvQ0V8AbFgk05JeNDoYh
         iNWcZM5f9oU6cjoGt999AzI1jkbSZ9HdOIixcqbRXOXOuOoINMgMTj5gbjTKfycf6gFv
         H25xV3o6k5KA5ewMEMoKKS+Dm1Qn08XVnhlBE1QwyeMkTEb89Jo+t3HqqvRm/+8Rm+WG
         xXYA==
X-Gm-Message-State: AKwxytd9lcyWajUHCYmPVHba5BwE0eN3f3VaFnWg3rZLbVG/VdadskY9
        HF362HityJZkWbczsWPEMYKErQ==
X-Google-Smtp-Source: AH8x226Ajompsu0OYQsuUOXgN2+H2pqIMojeeDnVpjvuqcxFYcKiCYzOtIN/a2TKSvQtfbt/GfomLg==
X-Received: by 10.25.59.136 with SMTP id d8mr19646644lfl.141.1517412822631;
        Wed, 31 Jan 2018 07:33:42 -0800 (PST)
Received: from localhost.localdomain (t109.niisi.ras.ru. [193.232.173.109])
        by smtp.gmail.com with ESMTPSA id u72sm3952454lfi.64.2018.01.31.07.33.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 07:33:41 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        Matt Redfearn <matt.redfearn@mips.com>
Subject: [PATCH v3 1/2] Add notrace to lib/ucmpdi2.c
Date:   Wed, 31 Jan 2018 18:33:36 +0300
Message-Id: <20180131153337.29021-2-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180131153337.29021-1-antonynpavlov@gmail.com>
References: <20180131153337.29021-1-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

From: Palmer Dabbelt <palmer@sifive.com>

As part of the MIPS conversion to use the generic GCC library routines,
Matt Redfearn discovered that I'd missed a notrace on __ucmpdi2().  This
patch rectifies the problem.

CC: Matt Redfearn <matt.redfearn@mips.com>
CC: Antony Pavlov <antonynpavlov@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Matt Redfearn <amtt.redfearn@mips.com>
---
 lib/ucmpdi2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ucmpdi2.c b/lib/ucmpdi2.c
index 25ca2d4c1e19..597998169a96 100644
--- a/lib/ucmpdi2.c
+++ b/lib/ucmpdi2.c
@@ -17,7 +17,7 @@
 #include <linux/module.h>
 #include <linux/libgcc.h>
 
-word_type __ucmpdi2(unsigned long long a, unsigned long long b)
+word_type notrace __ucmpdi2(unsigned long long a, unsigned long long b)
 {
 	const DWunion au = {.ll = a};
 	const DWunion bu = {.ll = b};
-- 
2.15.1

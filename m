Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Sep 2018 20:03:21 +0200 (CEST)
Received: from mail-lf1-x142.google.com ([IPv6:2a00:1450:4864:20::142]:38803
        "EHLO mail-lf1-x142.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994655AbeIGSDSVKCvZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Sep 2018 20:03:18 +0200
Received: by mail-lf1-x142.google.com with SMTP id i7-v6so12743548lfh.5;
        Fri, 07 Sep 2018 11:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WCP4JlpgixlAuxMIVAef6ZdT4lFJWxoSXx8pBBtb2rM=;
        b=Z4GflOKKNMs7VJxVvWIU6K6uJDOsOHnd9GcUaYG2XKUgy/xoeGfnh70mJx2JBxTgIu
         9pi/vouHMb/hjpIX05uyMWBSi9H/1iXNRyZ3AfOiTq3rKn86m4GgJ9TqJbNkFn6M3I9e
         1gX44vSm//ywLN2lnHdrll5kUGjzS7EWXTCYbTt4elB+BULUf3HdO2quQD+TSWIdcSrh
         IRAogt++pExEYnNzi2ZlJ1Y2nGsbHSg6Jqj3TQnmT+TrRjPQ4+O/x2h9sUegPGkErAcv
         LePWZKCVPZDQonUN1dEugXImd97kk6Ne/1DViOt0LyOUahpjdhrOTrWlV3pW7jJ0auCb
         FF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WCP4JlpgixlAuxMIVAef6ZdT4lFJWxoSXx8pBBtb2rM=;
        b=NjMh0EPMEhKAgL/xTiHSDQMOsfWF5CvKNZ/0qpw84z3CRKGWSNw94lrnnSGdMVxgfC
         m+z/QUuyvOm4FD97+MM2Lom8Gc/RbSZaYs38FHV6OdUNQ4RyMxJWKPg7xGM2pofMv2Qx
         AOHfmbTxx1b2WnRMmbuS6aXUB7SzWzX+US/QR5qIq//J87uMYYWcWZW6C6wEtiqBpfrt
         8SAC3wTsu/H5uJRY7eGo7EETSzCcAfSHEPMt/u/o2RZuwOfWrUZc37lt0/mk2FQX4zBi
         N2i5oXoMZHMtmBhu5JC/3XVO5VzJs+TRveXpGcvndF61t8yhXqVhiVgdyMJkU/+RaR1w
         CVzA==
X-Gm-Message-State: APzg51A9WaLQnCjlNrVMG0pHMN7AnYL4GZxiFUn1rcWuzBi7fIPyFBFC
        exo3rVc07fKwpma/vj2Yuwc=
X-Google-Smtp-Source: ANB0Vdb+2GsqHadK7Zx0YmNcgarp6mG8SesB+TRqeORhHBIMx6tROtpYzqpNNpxI+JTzNHYvneinEQ==
X-Received: by 2002:a19:ca09:: with SMTP id a9-v6mr5666369lfg.120.1536343392744;
        Fri, 07 Sep 2018 11:03:12 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-156-179-220.elisa-laajakaista.fi. [91.156.179.220])
        by smtp.gmail.com with ESMTPSA id r4-v6sm1362962ljd.70.2018.09.07.11.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 11:03:11 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mips: bug: add unlikely() to BUG_ON()
Date:   Fri,  7 Sep 2018 21:03:02 +0300
Message-Id: <20180907180302.656-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
Return-Path: <igor.stoppa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: igor.stoppa@gmail.com
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

Add a hint to the compiler that probably it won't be necessary to BUG()

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: David Daney <ddaney@caviumnetworks.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/include/asm/bug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/bug.h b/arch/mips/include/asm/bug.h
index 745dc160a069..02101b54aec2 100644
--- a/arch/mips/include/asm/bug.h
+++ b/arch/mips/include/asm/bug.h
@@ -31,7 +31,7 @@ static inline void  __BUG_ON(unsigned long condition)
 			     : : "r" (condition), "i" (BRK_BUG));
 }
 
-#define BUG_ON(C) __BUG_ON((unsigned long)(C))
+#define BUG_ON(C) __BUG_ON(unlikely((unsigned long)(C)))
 
 #define HAVE_ARCH_BUG_ON
 
-- 
2.17.1

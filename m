Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 14:05:04 +0200 (CEST)
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33007 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27032408AbcEUMBqIhCZI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 14:01:46 +0200
Received: by mail-lf0-f66.google.com with SMTP id z203so640252lfd.0;
        Sat, 21 May 2016 05:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=LBOIzYqFdiQgMhLmg/uSQnpehzWioPtE+HsG/LkJXpg=;
        b=L6VnzDOHvJnMJqR32W5OFpzkqGGqP1kMQqAB7i3JasG7uRpNXGIjhaxPlxb91HCBWQ
         sM7IWuSrcH4gXoRXl2kAEpExnqpODq1CiQaWy0NzUmsB4l6MbzkF6n2zyrgSgHJ1SJGy
         7nWtL5FVaPuMntEkZDjrx2WupTnoGmgAP+spHRruQspDpJpumjiuC8lR/epreSTxlsYZ
         NfByJcUZM+8s7ihpjSQs7xqGq9IJjIHuwCaY9bLHOZiM1m0edn0EOJHCfKPotVLu7ENc
         E6XXlU0pSoEUqj0gv6fVQT+nUbfahFA30kLMmhEYaCwMdH3aJLy30gzh/RZ/4ah6lOYn
         xqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=LBOIzYqFdiQgMhLmg/uSQnpehzWioPtE+HsG/LkJXpg=;
        b=BDHWsxWxvGLUsIsSfoJmSipF7dve0EW4fo1Sq3ahlqkEMcuhSpMlKjiQ7LihDKday3
         X1WKbl6ejg5FJEQfY8+HIrgSSA8KwEisj3uTSmcPnoFUErkCQ8KPFuRFv4rYIbrLR+mh
         O9ex5h60/zCcRod2ITy18VTqSM1Ygq05aFGGvZ7Gg6fceKOolzDhp4DxxZyyryZsZPdl
         j+ex1TDpdMJU7MkPQUp04G4WI2jAMrA6yzpOfQkQKzH22W10NFTHXlvzZVMzS5X6Nmmo
         EXUzoE16Tb3JrRJ2vBgcsJ+Hfdjtqtus1Xt2H9bLW3hGsfAxdgmpLKVJf6cQBYbaakdd
         heww==
X-Gm-Message-State: AOPr4FU5eGa3NIEAYRAIK/UnW3cjoL35PA48w4Sy4f23dpd15W1EgswOH6GEOuZiQUtf0Q==
X-Received: by 10.25.125.8 with SMTP id y8mr2763196lfc.81.1463832100802;
        Sat, 21 May 2016 05:01:40 -0700 (PDT)
Received: from glen.ipredator.se (anon-35-25.vpn.ipredator.se. [46.246.35.25])
        by smtp.gmail.com with ESMTPSA id b6sm4131768lbv.39.2016.05.21.05.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 May 2016 05:01:39 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     trivial@kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 0195/1529] Fix typo
Date:   Sat, 21 May 2016 14:01:36 +0200
Message-Id: <20160521120136.10090-1-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 2.8.2.534.g1f66975
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53593
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
 arch/mips/lib/memcpy.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index 9245e17..6c303a9 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -256,7 +256,7 @@
 
 	/*
 	 * Macro to build the __copy_user common code
-	 * Arguements:
+	 * Arguments:
 	 * mode : LEGACY_MODE or EVA_MODE
 	 * from : Source operand. USEROP or KERNELOP
 	 * to   : Destination operand. USEROP or KERNELOP
-- 
2.8.2.534.g1f66975

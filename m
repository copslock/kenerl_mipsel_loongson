Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 14:03:46 +0200 (CEST)
Received: from mail-lb0-f194.google.com ([209.85.217.194]:36274 "EHLO
        mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27032453AbcEUMBYW8YSI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 14:01:24 +0200
Received: by mail-lb0-f194.google.com with SMTP id r5so6876808lbj.3;
        Sat, 21 May 2016 05:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=WKxPm/g8NEoyQd+w6PGbP0rRTqf4XoPaQhW8CKn1ofk=;
        b=kawOTqXRy7mftpAV47W/iCOsi0O0E5fT94DL/1AaFqhVjKTzfYjzqg0Wt/vIUb0cnR
         oQRZqAzxykoqquZcDwzviX8UV2krtstraD/RsJNehsFVG9z8vTbUhZKL7pBQto3YJ1YQ
         neLuy+kwvZy2+mk8Txv59nB7ReS36Q4v8oHfjlvJpr6o/1kVPtMiywuSOvgbkjUyW2oc
         1Ie2QuUtc8mfyWcvEc/MxvgMqd9yX9FzhcIce1gZR9Ve4UxdUAHQ35eMcis0ZhGqE2yi
         9LwauuaTmkfzoiHb5+jcwl5k4boNQExtJ8f7hIZ+q72uBVbMKK4Ge84aLLhF0WqZWScY
         PqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=WKxPm/g8NEoyQd+w6PGbP0rRTqf4XoPaQhW8CKn1ofk=;
        b=cRkXaFx9zJQuwb3iPbCZLg/z6zHvhByHEIrRkJ+s/XQtvCZdXXG7gb3NiCVcOWwmcs
         +UDXOCyCgXvpdNGcjHaEatNqGea0a2HaTxpzNLxFRYlFDDl61aSXq1Icr0RiPR5QeX2t
         aoCEV45UeYr7h5LhJBK9jvLG9GAinT3x+NmyHpBTqiHBuhQcW5Ky7l/mJ83T0r6YNiaH
         zr1CTAOUkPn9dJTeeL86JCXrMVg2sdUXpFyDgdrtdkZViCLKjg4W5bgwLEIgmUcdfvAB
         +ZDfBqexkQa/nUAc6k9sfT9r7MPJR7knWH1wN4l+1e/k4ATTFsAs/7GyYLxdvKou/MIt
         IN2A==
X-Gm-Message-State: AOPr4FVWxt5RVsecfbZ/9uO3GBqCvHB/X7hejiFmDdA/GeQ41uKU04ChzAIsWlYFqaGiZQ==
X-Received: by 10.112.205.69 with SMTP id le5mr2791961lbc.138.1463832069435;
        Sat, 21 May 2016 05:01:09 -0700 (PDT)
Received: from glen.ipredator.se (anon-35-25.vpn.ipredator.se. [46.246.35.25])
        by smtp.gmail.com with ESMTPSA id u187sm4124512lfd.26.2016.05.21.05.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 May 2016 05:01:07 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     trivial@kernel.org, ralf@linux-mips.org, david.daney@cavium.com,
        janne.huttunen@nokia.com, aaro.koskinen@nokia.com,
        linux-mips@linux-mips.org
Subject: [PATCH 0191/1529] Fix typo
Date:   Sat, 21 May 2016 14:01:03 +0200
Message-Id: <20160521120103.9881-1-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 2.8.2.534.g1f66975
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53589
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
 arch/mips/include/asm/octeon/cvmx-pow.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/octeon/cvmx-pow.h b/arch/mips/include/asm/octeon/cvmx-pow.h
index 5153156..410bb70 100644
--- a/arch/mips/include/asm/octeon/cvmx-pow.h
+++ b/arch/mips/include/asm/octeon/cvmx-pow.h
@@ -2051,7 +2051,7 @@ static inline void cvmx_pow_tag_sw_desched(uint32_t tag,
 }
 
 /**
- * Descchedules the current work queue entry.
+ * Deschedules the current work queue entry.
  *
  * @no_sched: no schedule flag value to be set on the work queue
  *	      entry.  If this is set the entry will not be
-- 
2.8.2.534.g1f66975

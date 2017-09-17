Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Sep 2017 16:10:25 +0200 (CEST)
Received: from mail-wr0-x242.google.com ([IPv6:2a00:1450:400c:c0c::242]:34960
        "EHLO mail-wr0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992604AbdIQOKSpjRcI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Sep 2017 16:10:18 +0200
Received: by mail-wr0-x242.google.com with SMTP id n64so3698417wrb.2;
        Sun, 17 Sep 2017 07:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8wcwLTYJDt4hPUjEnb8t+8b5KmMxDY8qtb/ZN3nN+9I=;
        b=s414B8q8zSG3JwJ6tauKuNMAkX0+ICl3Td+ZnsqnopWKOOR60PUO0IcyV+E6VyUelj
         rFsw7XrOFey4ZcXQbg7VyhXbms0EkulXoYA+htMRu+LDwHr6387Ow6MzDUUYdVbOIfcd
         l9ajK3u0kN3xyoDtToq68bNS8KxlJu2zq4WDE8OWMPUC+NLDVnNJIz/haT2wti+PCtk5
         2A3kNm9xlvV3QSGphlmiZi+nP2CVUDibkAlqm/M1BugnsXrcyfVsaXfXabUE1tZXzTAE
         kouqghziu+Rv3silWLCtcrg0KoaSAPITwK2FF7GtmR8v8FRt8TrPNLyCv7F3TkJpxY3X
         UyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8wcwLTYJDt4hPUjEnb8t+8b5KmMxDY8qtb/ZN3nN+9I=;
        b=BqdpFrTO5UxHSRhk5FJYYzGoTDTrMolVel+XVmIdssJbsd3aOIIT374gr5/OVqYI+L
         YCQH1mo/IgfQqDFTFCki6iFKhlM1djyMMCE/SfEEZKPQE0Hxl9ghRKctMYmyg09aX41v
         ed57mCFIrJkBt8/8RkLY4nG6pAOUuoFwmqJ++IxTwYhHFURI3j6LPCoxaht76be615iA
         F+qimKK5ZSk5+XBGW3AIo7q4C18AEsgSb0DJqTyDIavsvSu5l7F8xj8FOF1Q3pJIe/YS
         0fZgyIvwiKdMSsSffGR0PK1RwXzqoP7XbWEBe5kQQg4uAgGZmxX4N+jx7U5wkZWFUdtQ
         HgPA==
X-Gm-Message-State: AHPjjUieql0kArPFAvzlbO4BkgdDvvnBmtqsC+pNsEJVwDXtveLuY2f9
        vdxFB6gQTx8haG1r
X-Google-Smtp-Source: ADKCNb6sp2LtkZ2vDBTN/Pu3zBOgImE5ZCU2REVx9KZJ7hYkIbk4yTPQKBhy1s3IsnyT3NztwURztw==
X-Received: by 10.223.146.4 with SMTP id 4mr26892321wrj.16.1505657413136;
        Sun, 17 Sep 2017 07:10:13 -0700 (PDT)
Received: from localhost.localdomain (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id i8sm4865478wra.56.2017.09.17.07.10.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Sep 2017 07:10:12 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] MIPS: MSP71xx: fix build failure
Date:   Sun, 17 Sep 2017 15:10:07 +0100
Message-Id: <1505657407-5696-1-git-send-email-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <sudipm.mukherjee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sudipm.mukherjee@gmail.com
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

The build of msp71xx_defconfig was failing with the error:
arch/mips/pmcs-msp71xx/msp_smp.c: In function 'msp_vsmp_int_init':
arch/mips/pmcs-msp71xx/msp_smp.c:72:2: error:
	implicit declaration of function 'set_vi_handler';
	did you mean 'irq_set_handler'? [-Werror=implicit-function-declaration]

The file 'msp_smp.c' was only missing a header file.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---

The build logs of next-20170915 is at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/275726387

 arch/mips/pmcs-msp71xx/msp_smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/pmcs-msp71xx/msp_smp.c b/arch/mips/pmcs-msp71xx/msp_smp.c
index ffa0f71..6441bd2 100644
--- a/arch/mips/pmcs-msp71xx/msp_smp.c
+++ b/arch/mips/pmcs-msp71xx/msp_smp.c
@@ -21,6 +21,7 @@
  */
 #include <linux/smp.h>
 #include <linux/interrupt.h>
+#include <asm/setup.h>
 
 #ifdef CONFIG_MIPS_MT_SMP
 #define MIPS_CPU_IPI_RESCHED_IRQ 0	/* SW int 0 for resched */
-- 
2.7.4

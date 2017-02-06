Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2017 17:27:09 +0100 (CET)
Received: from mail-pf0-x241.google.com ([IPv6:2607:f8b0:400e:c00::241]:33320
        "EHLO mail-pf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991955AbdBFQ1Bz9RxC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Feb 2017 17:27:01 +0100
Received: by mail-pf0-x241.google.com with SMTP id e4so7205193pfg.0;
        Mon, 06 Feb 2017 08:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PFue+niap5RP7gnuutK0MB7Du6m7s4kgzG+mHROsApY=;
        b=KZ5d3lnxlZuu57pMlgH9r6oG5Lkn1iCl0P6kFP/A88HZWfy8rG2MbNmKHJENbqFQxf
         xBmeLiy5Gm6vcHtPmMBHC1poGmgYhuBDPdP8ftaL7+vjdhr4eOrQ1gpp95euful8JN7W
         LuY26sw4Nq35N9tyuBeDevKzLVJ0MNz3eXYdM/iXFiYEIXAbXPVqXszxeyGrAMNuW5Hv
         K5jBpdG5RQnwKYxklQSRTgmP5LhC11+WC9qr3ZlU5Uwo/QFKw+8rlgMNIHsJEx29QjxK
         oxFDw7m36oZ6uqJ1cwfJ8jYCn4FuTslFMVKzaK2avGeZO/e58f9r/lkpNiTGkfRLLlui
         9MMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PFue+niap5RP7gnuutK0MB7Du6m7s4kgzG+mHROsApY=;
        b=Nog44Z7iDNa0m8qEz1UoxNGHLXv2dW7iPSzPPyxmLBHL7sS9auxPixJqik9hXjOwiF
         76xHLY6r+J4IHqLhSLTx9c7mpTc9+hraCURjcx04hLl5e1hFnApAqYHeQMwYB+tB0f+c
         mLs94FmSLjHx6vYhy7bHfV+iz5Mk+XuwlWiFXZLnhlYxKaXWIzLPo4mVhaKYlrcDAVI/
         xTppXrhS9LYWibINYE/2RX44YY3FXQeNs8dzqzUWlr+kH/Gkl8w/Hd8rpjvUUXiWWoXp
         WMjfGe7LL4LJRvT0NQGfqvBDFYBFaXaPpsOEUCuh9tp3sys1CKAnOauEB+C/yZA92pVP
         XB6Q==
X-Gm-Message-State: AIkVDXINzIp3v81J3wEOXRWqEqBIuBd+XtMwyLdrMSC68dSmd8aCjwHsU0ZUUwTCPyx0Nw==
X-Received: by 10.99.108.74 with SMTP id h71mr14039183pgc.99.1486398416112;
        Mon, 06 Feb 2017 08:26:56 -0800 (PST)
Received: from 192.168.0.37 (ec2-52-192-197-227.ap-northeast-1.compute.amazonaws.com. [52.192.197.227])
        by smtp.gmail.com with ESMTPSA id b10sm3951106pga.21.2017.02.06.08.26.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Feb 2017 08:26:55 -0800 (PST)
From:   Wei Yongjun <weiyj.lk@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Markus Elfring <elfring@users.sourceforge.net>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH -next] MIPS: sysmips: Remove duplicated include from syscall.c
Date:   Mon,  6 Feb 2017 16:26:50 +0000
Message-Id: <20170206162650.16320-1-weiyj.lk@gmail.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <weiyj.lk@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: weiyj.lk@gmail.com
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

From: Wei Yongjun <weiyongjun1@huawei.com>

Remove duplicated include.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 arch/mips/kernel/syscall.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 735733f..c86ddba 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -36,7 +36,6 @@
 #include <asm/sim.h>
 #include <asm/shmparam.h>
 #include <asm/sysmips.h>
-#include <linux/uaccess.h>
 #include <asm/switch_to.h>
 
 /*

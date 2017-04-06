Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 15:54:42 +0200 (CEST)
Received: from mail-pg0-x22d.google.com ([IPv6:2607:f8b0:400e:c05::22d]:35730
        "EHLO mail-pg0-x22d.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993911AbdDFNwqqmgcx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 15:52:46 +0200
Received: by mail-pg0-x22d.google.com with SMTP id 81so37122894pgh.2
        for <linux-mips@linux-mips.org>; Thu, 06 Apr 2017 06:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6iuvPjq2NXkmKqRP2BZ1DmT9HI2WCfJmxi+d3PpC3NE=;
        b=XEzY0JduJD9a5n9gvZQb4kMsqB6drzfIMu2lgFATUWrjwRoySAazAjSPgQFk8udPh6
         Bd0BxKv6KGNFkhI1ZCHoqNyORO2yYfIyLqajzBic5a3ECxbMmYpTVgFY5BRWUWFlaJRB
         uRUVJo3jpxeYp1+LssGoZFFLh46fDW/eqaq+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6iuvPjq2NXkmKqRP2BZ1DmT9HI2WCfJmxi+d3PpC3NE=;
        b=uSL9QthdRr/ufFp4MZOoEImP4/N3q8fePa4TaXypLJ6C5k1GEaNoy+DWT719c1cmjW
         2dqdV4AFOKe7FcbJ1W7jgz5AO/e0utGdquMKHWzovi2LkU3XwqIkBTVWdtci+0IVAXfx
         XTz7ZZzRDRqFNX7IWPsiHmcxf41OC9qFRdjuvTZePmaok66NWZnsZ34RNckELz3Sh2ub
         fQa4tEdHCjmhVDAC+77VaG1vIclSkzdNpY6ELJs5p0aeFWrBoGzNTpVL1J+PPf/EE89w
         ZnsNozDuCSH9MmLKjMyv7zikCS3vZTCyM6M3K7pWoxWJCaoR6hrFStopTwvKMWHbGoNC
         8BNQ==
X-Gm-Message-State: AFeK/H0Gj2Uqu6obtg72F+OyykspWY5Nag7kZ2Wtt3KkE7VQ+WU6OK9eFIGzDDt4q1eDiRQI
X-Received: by 10.99.217.17 with SMTP id r17mr37120850pgg.140.1491486760952;
        Thu, 06 Apr 2017 06:52:40 -0700 (PDT)
Received: from localhost.localdomain ([106.51.240.246])
        by smtp.gmail.com with ESMTPSA id v11sm4187210pfi.50.2017.04.06.06.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Apr 2017 06:52:40 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, james.hogan@imgtec.com,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Subject: [PATCH for-4.10 6/6] MIPS: IRQ Stack: Fix erroneous jal to plat_irq_dispatch
Date:   Thu,  6 Apr 2017 19:22:14 +0530
Message-Id: <1491486734-15668-7-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1491486734-15668-1-git-send-email-amit.pundir@linaro.org>
References: <1491486734-15668-1-git-send-email-amit.pundir@linaro.org>
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amit.pundir@linaro.org
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

From: Matt Redfearn <matt.redfearn@imgtec.com>

Commit dda45f701c9d ("MIPS: Switch to the irq_stack in interrupts")
changed both the normal and vectored interrupt handlers. Unfortunately
the vectored version, "except_vec_vi_handler", was incorrectly modified
to unconditionally jal to plat_irq_dispatch, rather than doing a jalr to
the vectored handler that has been set up. This is ok for many platforms
which set the vectored handler to plat_irq_dispatch anyway, but will
cause problems with platforms that use other handlers.

Fixes: dda45f701c9d ("MIPS: Switch to the irq_stack in interrupts")
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15110/
Signed-off-by: James Hogan <james.hogan@imgtec.com>
(cherry picked from commit c25f8064c1d5731a2ce5664def890140dcdd3e5c)
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 arch/mips/kernel/genex.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 0a7ba4b..7ec9612 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -329,7 +329,7 @@ NESTED(except_vec_vi_handler, 0, sp)
 	PTR_ADD sp, t0, t1
 
 2:
-	jal	plat_irq_dispatch
+	jalr	v0
 
 	/* Restore sp */
 	move	sp, s1
-- 
2.7.4

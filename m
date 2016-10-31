Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2016 22:17:57 +0100 (CET)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36650 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993009AbcJaVRC2zGC0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 Oct 2016 22:17:02 +0100
Received: by mail-pf0-f195.google.com with SMTP id n85so9648965pfi.3;
        Mon, 31 Oct 2016 14:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bsA+zIAlI4s3FQe0eNmU1RYYnE97ZN4KV1a6MEZflqM=;
        b=qpPR8agyOkixhVV2xd0WrOeil13nh03X18O1D+lLFdhpCV6OHnM3YpIjwwyXMzS4kC
         eT0VKaxneihwumjrzyNPpxNbSEn9Er3gwPGtkPHDMFRuiMJkEtWNVsjI9Gw24MHenPL2
         rbjvUlzpkl9UOjUhqNHsn/WWhhZMDG1zPLZmuwP6dLiFRJyGGoNdu8nup+G6tUH1pPDl
         5T41mC/ffVBJ9IUjgrk2neHnvD79GP+47qxczgTA0rv99xssYl0VJrYRT1aVeOt2AZKv
         9xnfGaw7Qi5CpaCJd8mEAx338Argh3sIQuCL//yWgIwjHh7uggQfMoxHFbJV/LUh5afS
         Kpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bsA+zIAlI4s3FQe0eNmU1RYYnE97ZN4KV1a6MEZflqM=;
        b=ebUJSxNoyycBTQhfzpfuVau8l0v3Xiwg6cxRVlYxOQ9XesqoZ+tg2rLK/itAuQdpR5
         t2/XX3WCEWjJPdYpTDo8RobkasJE7xAkfsQEPbgX8rV1ZuZNYZ+CBk/Qdjru73JGa0Sk
         0p1JEvvcjPLW1zjmLgmlXLp2bzz9h4uBnpKX/VKQb9RJKmPy3jlbu0INHp67PyOzB+/s
         IAm38q4RHR6WjPBfF9kekT/qmlCvfBON9I1Rvs8HSGMMcqCP1Iq+Xij5BUBo2ZfAKPfx
         jKtXiDtui799btfbXC0fmrzSh7eJUbiTieCoaaAqev7mb4zbGJa6CVppMTQ7OlIX8g4w
         Bf1g==
X-Gm-Message-State: ABUngvcVD7dsS5+0jKMc96ZKEUDkZSfFuUMtpkTYZn+QJNzvUbn0/zMyzReZxFA9Qfy+Mg==
X-Received: by 10.98.93.201 with SMTP id n70mr17541386pfj.161.1477948616572;
        Mon, 31 Oct 2016 14:16:56 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id a7sm37628013pan.34.2016.10.31.14.16.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Oct 2016 14:16:56 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, cernekee@gmail.com, jaedon.shin@gmail.com,
        justinpopo6@gmail.com, tglx@linuxtronix.de, marc.zyngier@arm.com,
        jason@lakedaemon.net, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 2/2] MIPS: BMIPS: Migrate interrupts during bmips_cpu_disable
Date:   Mon, 31 Oct 2016 14:16:47 -0700
Message-Id: <1477948607-12899-3-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1477948607-12899-1-git-send-email-f.fainelli@gmail.com>
References: <1477948607-12899-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55624
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

While we properly disabled the per-CPU timer interrupt, we also need to
make sure that all interrupts that can possibly have this CPU in their
smp_affinity mask also have a chance to see this interrupt migrated to a
CPU not being taken offline.

Fixes: 230b6ff57552 ("MIPS: BMIPS: Mask off timer IRQs when hot-unplugging a CPU")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/kernel/smp-bmips.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 6d0f1321e084..37dffda8f16b 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -365,6 +365,8 @@ static int bmips_cpu_disable(void)
 	set_cpu_online(cpu, false);
 	calculate_cpu_foreign_map();
 	cpumask_clear_cpu(cpu, &cpu_callin_map);
+
+	irq_cpu_offline();
 	clear_c0_status(IE_IRQ5);
 
 	local_flush_tlb_all();
-- 
2.7.4

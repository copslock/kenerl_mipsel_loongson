Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2016 22:19:31 +0100 (CET)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35577 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993022AbcJaVRufl0E0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 Oct 2016 22:17:50 +0100
Received: by mail-pf0-f195.google.com with SMTP id s8so9642102pfj.2;
        Mon, 31 Oct 2016 14:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bsA+zIAlI4s3FQe0eNmU1RYYnE97ZN4KV1a6MEZflqM=;
        b=c373pWDAbBYGt4kcd9f+Bfeoplb03wZCeaO8GpoLW64p7PA1odFWBkRBHfnnRpzwkI
         XsboIHLfdcfO7nM2Osnu47t0QcBw+Pvc5wvTgJeasaSsBfE2rWrpjwEvMOWPJCE1tHfG
         LlqD/75tyUrD/B65Q4SkASqf2kFtazoP26CE6yke+EqKORJZ9EBJZ1ehzwPMrQrweT5N
         79gV8pH/i8oBtFWpXrJySF2RcGh7BtKcb1zY8loyWfesSr60lqyTc49CtIWIdfsIyk3u
         N8pzrZlkb8ZJ1G/Wl2Pw2Bd0d6o7jKZf95vf39/yhN9aaCPLzPEvUQlFaITIAc8x5Nsh
         KvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bsA+zIAlI4s3FQe0eNmU1RYYnE97ZN4KV1a6MEZflqM=;
        b=fZPcvlOr1NLEvCYtaubeQf/lejU8sX6hibTUDTKudcNLYsmeoyEYkrY8UKEmDV1ZvB
         iRhGPuabuzjeUx7yFlznuHHo4TOUflzz7tCfoU4n+U+nr1jERhA6Ru9a0cYHT+O6Ayjq
         lav2rgbjJjXxszcYP1Yig5sJIfUWRAuRt2oqUxN5wrGQQCOqGKjDAKdKth9P7Rl8JZeS
         yAMqEpyj7G103TYNs7GnE6iSC4Siq7VmVMWR50NRZO/jPSzqrnMLgA+fobdHYZ3Mli/j
         3GGTdxGrJtjQTQBVAswelHYxpaFewuRtrubqINk3EGjbYna8hTgl02z/4mfRnMG/ROv3
         PVAQ==
X-Gm-Message-State: ABUngvfv1sxLzocdPkC5ScE2Rk02WTj1CfrF3KxYZD5BFEJBVEK+vwxpQ/D+R5vU5u3vjw==
X-Received: by 10.99.158.18 with SMTP id s18mr44321217pgd.114.1477948664794;
        Mon, 31 Oct 2016 14:17:44 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id w85sm25592601pfk.57.2016.10.31.14.17.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Oct 2016 14:17:44 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, cernekee@gmail.com, jaedon.shin@gmail.com,
        justinpopo6@gmail.com, tglx@linutronix.de, marc.zyngier@arm.com,
        jason@lakedaemon.net, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 2/2] MIPS: BMIPS: Migrate interrupts during bmips_cpu_disable
Date:   Mon, 31 Oct 2016 14:17:36 -0700
Message-Id: <1477948656-12966-3-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1477948656-12966-1-git-send-email-f.fainelli@gmail.com>
References: <1477948656-12966-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55628
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

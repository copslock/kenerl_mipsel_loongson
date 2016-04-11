Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2016 13:56:26 +0200 (CEST)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34241 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026350AbcDKL4ZGDFbf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Apr 2016 13:56:25 +0200
Received: by mail-pf0-f194.google.com with SMTP id d184so14726409pfc.1
        for <linux-mips@linux-mips.org>; Mon, 11 Apr 2016 04:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=vGVL+yt7Y1NwUA+YWtQq22z/i+nL1iArTMophV4aYuo=;
        b=Yx6mieM5NR2ng2FkGCqKJzJhAJ6mRZM/zN095Sp33eLlpphxTGjyTMIzOFrb8vgtjq
         1ba8lZHnlX9SokjMIZZwq+4L6u+hv4cDPMDk9z/+Hr466Y9EDfwnNynE7HHErRokYvpf
         0wI2MyEm9fiIVGgqzUDvvrD0b4TIqrUGav/xUxm5Eki+20LTgiECix1Yv7BuaD7sMBCt
         wKqSoXZvw5p5jm9ZdKQzz3noU0RA4FYXSIS0YSC7WhmsBK2zQQOjjenmEyZ5c7vek2Ow
         Zv81IXpyjh7YPZqDW60HCoa0thX3VsObiXS7OgGF8VcKtj/1N01uTMZ/XzES/wMbvKwE
         XaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vGVL+yt7Y1NwUA+YWtQq22z/i+nL1iArTMophV4aYuo=;
        b=THBOjGURNhoeBXty2N2y/aEh9A0cjDEvHlPU3WcjihRUj1U0AY2f5atUayYAGnB+RL
         cSIKkJJ6sHXDudbZ4jV7GYtHAqtOXK/pxOfjrPvILT9v1GTli9DEJGqSh3Z1EN+JApNG
         9e10D88Epyd8VU0r2qkWssE8YAtkUng/MOeRpSKWtV1GplPUkNwHhrNrCD+/A+ZRgAkP
         d6XnjNjoeNEM0VsSHxbzKAl4ac3I9YeaB9GAPjGXFIjZ8vBNHo/poQgP98ZRRlPh9phQ
         qkAfRZoklDfZJb3vHoAKYLs1zlyuJE/yYU/pXHDsBz6PZUpyx5iLzxVrmGBzlykb1CjB
         0QXg==
X-Gm-Message-State: AD7BkJL8aKwwrOmXFpME538y8PC6NSKLuJG5/ke6eJlwqMGO3S1iMXnZ3viU96DOZl5ZcA==
X-Received: by 10.98.32.218 with SMTP id m87mr32339374pfj.48.1460375778975;
        Mon, 11 Apr 2016 04:56:18 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id o71sm35814708pfj.68.2016.04.11.04.56.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Apr 2016 04:56:18 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-pm@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH 1/5] cpufreq: Loongson1: Rename the file to loongson1-cpufreq.c
Date:   Mon, 11 Apr 2016 19:55:55 +0800
Message-Id: <1460375759-20705-1-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

From: Kelvin Cheung <keguang.zhang@gmail.com>

This patch renames the file to loongson1-cpufreq.c

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 drivers/cpufreq/Makefile                                | 2 +-
 drivers/cpufreq/{ls1x-cpufreq.c => loongson1-cpufreq.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/cpufreq/{ls1x-cpufreq.c => loongson1-cpufreq.c} (100%)

diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 9e63fb1..bebe9c8 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -100,7 +100,7 @@ obj-$(CONFIG_CRIS_MACH_ARTPEC3)		+= cris-artpec3-cpufreq.o
 obj-$(CONFIG_ETRAXFS)			+= cris-etraxfs-cpufreq.o
 obj-$(CONFIG_IA64_ACPI_CPUFREQ)		+= ia64-acpi-cpufreq.o
 obj-$(CONFIG_LOONGSON2_CPUFREQ)		+= loongson2_cpufreq.o
-obj-$(CONFIG_LOONGSON1_CPUFREQ)		+= ls1x-cpufreq.o
+obj-$(CONFIG_LOONGSON1_CPUFREQ)		+= loongson1-cpufreq.o
 obj-$(CONFIG_SH_CPU_FREQ)		+= sh-cpufreq.o
 obj-$(CONFIG_SPARC_US2E_CPUFREQ)	+= sparc-us2e-cpufreq.o
 obj-$(CONFIG_SPARC_US3_CPUFREQ)		+= sparc-us3-cpufreq.o
diff --git a/drivers/cpufreq/ls1x-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
similarity index 100%
rename from drivers/cpufreq/ls1x-cpufreq.c
rename to drivers/cpufreq/loongson1-cpufreq.c
-- 
1.9.1

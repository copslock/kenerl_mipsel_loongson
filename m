Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Apr 2016 10:27:45 +0200 (CEST)
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35289 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027020AbcDSI1PqAQ-Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Apr 2016 10:27:15 +0200
Received: by mail-lf0-f51.google.com with SMTP id c126so10068596lfb.2
        for <linux-mips@linux-mips.org>; Tue, 19 Apr 2016 01:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=uHfNHs4OrHu6v+ElXf5jBQSqlG7TVH7zHCgcbPSQzes=;
        b=zJtFbQquekPZDdGTkybptATI0LxpEKgrwimkH6YDX1exXZlGpzWyVyvpPfqJQtlucV
         jCxVKX3BsJrt5VWfeMLvrxzWO981AV/cp61qjmcWQNlUEkYiYvVnY3HRXYsopjdGbe/S
         egl86yC0aH6LLIN6OE9vtwfVhDztc9286Em93KEmHBsY79UVTVBLpj2iIwi/ViyalRUu
         HLiXWG6KZbCerC/4xhe+vGLYh9XrGhAHVJYKPqgMyNJ3oPXJMUri6d6feaW2SUPj9FmZ
         Ld3Fx1Rx7IUZ4+dXpb4Is00DZqV0Jjy5KJ0ufJeMHj4r6mEDMi6s7KotHbeWUjr3twoI
         Njrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=uHfNHs4OrHu6v+ElXf5jBQSqlG7TVH7zHCgcbPSQzes=;
        b=Ps5HmlCA/13il0HKzzvKUwZALgckuDnCr8fXPYOjE5Yfc/pY+jumTpfZp6KA2n5eL+
         LKkIPXDyXZQe6S7Ql26JfvKFQd/dr0vLw5tP2x6Wo60aiDUBKVXIBstw2qVVkaOiMtbj
         BCfS2rXteBhOsXiTvAatsrUlfVA2A+uX4lgI7JdpZnqA0GbkVg5Myh+gRGzucPTCOkEZ
         gA3Rzspky39mZVscrVsX8GVB9v8437ANFttwOjeTYN2JU1Q35wCSqZ2hWTaj41zREm1b
         /11vRlZCsPa5Ij898Qt41QyWwuZ3ibbl9VvDQIdQny6yb1oIGD0LsNtI4iIc0cVX9oaO
         hV3Q==
X-Gm-Message-State: AOPr4FWXq3lUtbara4pkaLMyj1UUQasWyH+g8e8408F/EiPdaOmAbe7G3lGyjYMNnHI8rw==
X-Received: by 10.112.204.65 with SMTP id kw1mr782388lbc.21.1461054430472;
        Tue, 19 Apr 2016 01:27:10 -0700 (PDT)
Received: from localhost (ppp79-139-147-94.pppoe.spdop.ru. [79.139.147.94])
        by smtp.gmail.com with ESMTPSA id dm3sm9099665lbc.27.2016.04.19.01.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Apr 2016 01:27:09 -0700 (PDT)
Subject: [PATCH] arch/defconfig: remove CONFIG_RESOURCE_COUNTERS
From:   Konstantin Khlebnikov <koct9i@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-am33-list@redhat.com, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 19 Apr 2016 11:27:07 +0300
Message-ID: <146105442758.18940.2792564159961963110.stgit@zurg>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <koct9i@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: koct9i@gmail.com
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

This option replaced by PAGE_COUNTER which is selected by MEMCG.

Signed-off-by: Konstantin Khlebnikov <koct9i@gmail.com>
---
 arch/arm/configs/bcm_defconfig              |    1 -
 arch/arm/configs/zx_defconfig               |    1 -
 arch/mips/configs/db1xxx_defconfig          |    1 -
 arch/mips/configs/loongson3_defconfig       |    1 -
 arch/mn10300/configs/asb2364_defconfig      |    1 -
 arch/sh/configs/apsh4ad0a_defconfig         |    1 -
 arch/sh/configs/sdk7786_defconfig           |    1 -
 arch/sh/configs/se7206_defconfig            |    1 -
 arch/sh/configs/shx3_defconfig              |    1 -
 arch/sh/configs/urquell_defconfig           |    1 -
 arch/tile/configs/tilegx_defconfig          |    1 -
 arch/tile/configs/tilepro_defconfig         |    1 -
 arch/um/configs/i386_defconfig              |    1 -
 arch/um/configs/x86_64_defconfig            |    1 -
 arch/x86/configs/i386_defconfig             |    1 -
 arch/x86/configs/x86_64_defconfig           |    1 -
 arch/xtensa/configs/generic_kc705_defconfig |    1 -
 arch/xtensa/configs/smp_lx200_defconfig     |    1 -
 18 files changed, 18 deletions(-)

diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
index 7117662bab2e..909049a280ec 100644
--- a/arch/arm/configs/bcm_defconfig
+++ b/arch/arm/configs/bcm_defconfig
@@ -12,7 +12,6 @@ CONFIG_CGROUPS=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_RESOURCE_COUNTERS=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_BLK_CGROUP=y
 CONFIG_NAMESPACES=y
diff --git a/arch/arm/configs/zx_defconfig b/arch/arm/configs/zx_defconfig
index ab683fbbb954..d6253a48a9fa 100644
--- a/arch/arm/configs/zx_defconfig
+++ b/arch/arm/configs/zx_defconfig
@@ -7,7 +7,6 @@ CONFIG_CGROUPS=y
 CONFIG_CGROUP_DEBUG=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_RESOURCE_COUNTERS=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_RT_GROUP_SCHED=y
 CONFIG_NAMESPACES=y
diff --git a/arch/mips/configs/db1xxx_defconfig b/arch/mips/configs/db1xxx_defconfig
index 3bdb72a70364..f0c8971030c4 100644
--- a/arch/mips/configs/db1xxx_defconfig
+++ b/arch/mips/configs/db1xxx_defconfig
@@ -18,7 +18,6 @@ CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CPUSETS=y
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_RESOURCE_COUNTERS=y
 CONFIG_MEMCG=y
 CONFIG_MEMCG_SWAP=y
 CONFIG_MEMCG_KMEM=y
diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
index f8bf915c6d6b..7f95c4b3ab2c 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -25,7 +25,6 @@ CONFIG_TASK_XACCT=y
 CONFIG_TASK_IO_ACCOUNTING=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CPUSETS=y
-CONFIG_RESOURCE_COUNTERS=y
 CONFIG_MEMCG=y
 CONFIG_MEMCG_SWAP=y
 CONFIG_BLK_CGROUP=y
diff --git a/arch/mn10300/configs/asb2364_defconfig b/arch/mn10300/configs/asb2364_defconfig
index fbb96ae3122a..cd0a6cb17dee 100644
--- a/arch/mn10300/configs/asb2364_defconfig
+++ b/arch/mn10300/configs/asb2364_defconfig
@@ -11,7 +11,6 @@ CONFIG_CGROUPS=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_RESOURCE_COUNTERS=y
 CONFIG_RELAY=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
diff --git a/arch/sh/configs/apsh4ad0a_defconfig b/arch/sh/configs/apsh4ad0a_defconfig
index a8d975793b6d..fe45d2c9b151 100644
--- a/arch/sh/configs/apsh4ad0a_defconfig
+++ b/arch/sh/configs/apsh4ad0a_defconfig
@@ -10,7 +10,6 @@ CONFIG_CGROUPS=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_RESOURCE_COUNTERS=y
 CONFIG_CGROUP_MEMCG=y
 CONFIG_BLK_CGROUP=y
 CONFIG_NAMESPACES=y
diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
index e7e56a4131b4..36642ec2cb97 100644
--- a/arch/sh/configs/sdk7786_defconfig
+++ b/arch/sh/configs/sdk7786_defconfig
@@ -17,7 +17,6 @@ CONFIG_CGROUP_DEVICE=y
 CONFIG_CPUSETS=y
 # CONFIG_PROC_PID_CPUSET is not set
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_RESOURCE_COUNTERS=y
 CONFIG_CGROUP_MEMCG=y
 CONFIG_CGROUP_MEMCG_SWAP=y
 CONFIG_CGROUP_SCHED=y
diff --git a/arch/sh/configs/se7206_defconfig b/arch/sh/configs/se7206_defconfig
index 6bc30ab9fd18..91853a67ec34 100644
--- a/arch/sh/configs/se7206_defconfig
+++ b/arch/sh/configs/se7206_defconfig
@@ -10,7 +10,6 @@ CONFIG_CGROUPS=y
 CONFIG_CGROUP_DEBUG=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_RESOURCE_COUNTERS=y
 CONFIG_CGROUP_MEMCG=y
 CONFIG_RELAY=y
 CONFIG_NAMESPACES=y
diff --git a/arch/sh/configs/shx3_defconfig b/arch/sh/configs/shx3_defconfig
index cd6c519f8fad..4a4269ad5b04 100644
--- a/arch/sh/configs/shx3_defconfig
+++ b/arch/sh/configs/shx3_defconfig
@@ -12,7 +12,6 @@ CONFIG_CGROUPS=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_RESOURCE_COUNTERS=y
 CONFIG_CGROUP_MEMCG=y
 CONFIG_RELAY=y
 CONFIG_NAMESPACES=y
diff --git a/arch/sh/configs/urquell_defconfig b/arch/sh/configs/urquell_defconfig
index 1e843dbed5f0..01c9a91ee896 100644
--- a/arch/sh/configs/urquell_defconfig
+++ b/arch/sh/configs/urquell_defconfig
@@ -14,7 +14,6 @@ CONFIG_CGROUP_DEVICE=y
 CONFIG_CPUSETS=y
 # CONFIG_PROC_PID_CPUSET is not set
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_RESOURCE_COUNTERS=y
 CONFIG_CGROUP_MEMCG=y
 CONFIG_CGROUP_MEMCG_SWAP=y
 CONFIG_CGROUP_SCHED=y
diff --git a/arch/tile/configs/tilegx_defconfig b/arch/tile/configs/tilegx_defconfig
index 3f3dfb8b150a..2b91e47461c8 100644
--- a/arch/tile/configs/tilegx_defconfig
+++ b/arch/tile/configs/tilegx_defconfig
@@ -16,7 +16,6 @@ CONFIG_CGROUP_DEBUG=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CPUSETS=y
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_RESOURCE_COUNTERS=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_RT_GROUP_SCHED=y
 CONFIG_BLK_CGROUP=y
diff --git a/arch/tile/configs/tilepro_defconfig b/arch/tile/configs/tilepro_defconfig
index ef9e27eb2f50..2e2e33403b31 100644
--- a/arch/tile/configs/tilepro_defconfig
+++ b/arch/tile/configs/tilepro_defconfig
@@ -15,7 +15,6 @@ CONFIG_CGROUP_DEBUG=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CPUSETS=y
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_RESOURCE_COUNTERS=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_RT_GROUP_SCHED=y
 CONFIG_BLK_CGROUP=y
diff --git a/arch/um/configs/i386_defconfig b/arch/um/configs/i386_defconfig
index a12bf68c9f3a..5636221b8785 100644
--- a/arch/um/configs/i386_defconfig
+++ b/arch/um/configs/i386_defconfig
@@ -17,7 +17,6 @@ CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CPUSETS=y
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_RESOURCE_COUNTERS=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_BLK_CGROUP=y
 # CONFIG_PID_NS is not set
diff --git a/arch/um/configs/x86_64_defconfig b/arch/um/configs/x86_64_defconfig
index 3aab117bd553..7a67b7ac1a7e 100644
--- a/arch/um/configs/x86_64_defconfig
+++ b/arch/um/configs/x86_64_defconfig
@@ -15,7 +15,6 @@ CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CPUSETS=y
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_RESOURCE_COUNTERS=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_BLK_CGROUP=y
 # CONFIG_PID_NS is not set
diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 265901a84f3f..5fa6ee2c2dde 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -17,7 +17,6 @@ CONFIG_CGROUPS=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CPUSETS=y
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_RESOURCE_COUNTERS=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 0c8d7963483c..d28bdabcc87e 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -16,7 +16,6 @@ CONFIG_CGROUPS=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CPUSETS=y
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_RESOURCE_COUNTERS=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
diff --git a/arch/xtensa/configs/generic_kc705_defconfig b/arch/xtensa/configs/generic_kc705_defconfig
index f4b7b3888da8..d9444f01f4da 100644
--- a/arch/xtensa/configs/generic_kc705_defconfig
+++ b/arch/xtensa/configs/generic_kc705_defconfig
@@ -11,7 +11,6 @@ CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CPUSETS=y
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_RESOURCE_COUNTERS=y
 CONFIG_MEMCG=y
 CONFIG_NAMESPACES=y
 CONFIG_SCHED_AUTOGROUP=y
diff --git a/arch/xtensa/configs/smp_lx200_defconfig b/arch/xtensa/configs/smp_lx200_defconfig
index 22eeacba37cc..61f943c95619 100644
--- a/arch/xtensa/configs/smp_lx200_defconfig
+++ b/arch/xtensa/configs/smp_lx200_defconfig
@@ -11,7 +11,6 @@ CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CPUSETS=y
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_RESOURCE_COUNTERS=y
 CONFIG_MEMCG=y
 CONFIG_NAMESPACES=y
 CONFIG_SCHED_AUTOGROUP=y

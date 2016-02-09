Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 21:57:48 +0100 (CET)
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34912 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012425AbcBIU4Og8xFb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 21:56:14 +0100
Received: by mail-pf0-f178.google.com with SMTP id c10so66656217pfc.2;
        Tue, 09 Feb 2016 12:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AZUF2ZROkXVZZSNBBmj2A5KPOpTiN2YfCmxwPkQuwx0=;
        b=o7sK6bf4CjTWQZ9oZJNqQSrYbd7WvvPhnAiYiQCYJL17K8HZX0abpKw7V+s0V0fDeG
         239W7gIcr67yzgKUqcKQ3n9H4hq05e99rq1WGemwATqynPOfJ12iWKJUjL38sm3u60L7
         UD+GXXWgiZU7HKMvl0xCBLQfWDh6l9VxwX6TK3hn7vJvk/WWf4NPGRsiS+SXj89zJidV
         bVyXk4d7Cbye13uYchLIPAzzPZX7m6znjBvYIEXtDk4smUtfXmELbzQAXprD1gAxPv2E
         8a4ZAUpgBL+Zpqsd4g3tMI67MDlBzhMbeMV3usyvsWdJOKYUTMkcrqQcssAyv1AbEjFM
         Eovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AZUF2ZROkXVZZSNBBmj2A5KPOpTiN2YfCmxwPkQuwx0=;
        b=WzpdcaLCf4eLGDwmxzapLd5X/bu+WJ4UrAKz230N22x7H8dbCYfLqyLTGK8hiI1EFU
         PlC6FG2ZGKKi9LPH0+j6kQc3FVXCpjQ6QxrYZrDKF4vhvzhokVMcatNegNIH5oj6GugM
         s3KFGc6VyY6gd7kXRkyu1byfv2cS4xZjJ36qkhbQ5DU7vpgACMNeLQf/wvS8IqwIQLLX
         B6JgY+WnaAC0rArUZE1FaGASiHZdorPLEBE/oZQbkBDjfvB5rzFWatOqDyR/e92pjusi
         40b0//9xbNwTYxgRlpLCQ00898IHgJb5iQ5AHxsj5yblF8526wzT6FZeMyrwhjKslJpt
         0yZg==
X-Gm-Message-State: AG10YOT3/OSkHmhUe5H4RkZqWKKSQi1wV6pNX1EKg+9ODc3AutXdc+DQs3Zie2o2G9YeYw==
X-Received: by 10.98.10.65 with SMTP id s62mr53538914pfi.119.1455051368945;
        Tue, 09 Feb 2016 12:56:08 -0800 (PST)
Received: from stb-bld-03.irv.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id n4sm52684059pfi.3.2016.02.09.12.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2016 12:56:08 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jon.fraser@broadcom.com, pgynther@google.com,
        paul.burton@imgtec.com, ddaney.cavm@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 6/6] MIPS: Expose current_cpu_data.options through debugfs
Date:   Tue,  9 Feb 2016 12:55:54 -0800
Message-Id: <1455051354-6225-7-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1455051354-6225-1-git-send-email-f.fainelli@gmail.com>
References: <1455051354-6225-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51923
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

Debugging a missing features in cpu-features-override.h, or a runtime feature
set/clear in the vendor specific cpu_probe() function can be a little tedious,
ease that by providing a debugfs entry representing the
current_cpu_data.options bitmask.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/kernel/cpu-probe.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index cf9869d15c9f..4b569e13f727 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -17,6 +17,7 @@
 #include <linux/smp.h>
 #include <linux/stddef.h>
 #include <linux/export.h>
+#include <linux/debugfs.h>
 
 #include <asm/bugs.h>
 #include <asm/cpu.h>
@@ -1719,3 +1720,22 @@ void cpu_report(void)
 	if (cpu_has_msa)
 		pr_info("MSA revision is: %08x\n", c->msa_id);
 }
+
+#ifdef CONFIG_DEBUG_FS
+extern struct dentry *mips_debugfs_dir;
+static int __init debugfs_cpu_options(void)
+{
+	struct dentry *d;
+
+	if (!mips_debugfs_dir)
+		return -ENODEV;
+
+	d = debugfs_create_x64("cpu_options", S_IRUGO,
+			       mips_debugfs_dir, &current_cpu_data.options);
+	if (!d)
+		return -ENOMEM;
+
+	return 0;
+}
+__initcall(debugfs_cpu_options);
+#endif
-- 
2.1.0

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2014 10:12:58 +0200 (CEST)
Received: from mail-pd0-f178.google.com ([209.85.192.178]:41532 "EHLO
        mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822274AbaDDIMZEICn7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Apr 2014 10:12:25 +0200
Received: by mail-pd0-f178.google.com with SMTP id x10so2992827pdj.23
        for <multiple recipients>; Fri, 04 Apr 2014 01:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=deG+QTU4vnHNN8IqNn6qZ1V9lqg+m1fKfMYg54w4D/I=;
        b=hJBv3U8NPBd/gFKOYcvOEpo1+JnB4YBW98//jMxRr7YWi6g5BE6OKHVLh+BZ5KEVsN
         emvwOZrUuLv+sYgaLZKltWoiCaAKjCh+x85IAuZDxqM5gvWj1KGd8GJ52x38ryAQVAO5
         hZoDa4bNzIRt7oRciKNnjrPU7Q8HNLyPJfFuTO/v9iUw9ZDewRRwVWM40P3jaxYnH8Ri
         J9ZxkLfZd7OBJYC1wpnsDrTo2v2+PDJKhuRLj/ZhFZKhme1j5rsd0pZtSXzj4HHMwa2L
         sKNhU46htQpPKhz7WCRVar3iG/PkyRp3Ik5hTvRzpcCfdfBSraa6/1k9/NANZqIvX+dw
         CxSQ==
X-Received: by 10.68.181.165 with SMTP id dx5mr13523543pbc.38.1396599136043;
        Fri, 04 Apr 2014 01:12:16 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id pe3sm16066819pbc.23.2014.04.04.01.12.10
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 04 Apr 2014 01:12:15 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 1/9] MIPS: Support hard limit of cpu count (nr_cpu_ids)
Date:   Fri,  4 Apr 2014 16:11:36 +0800
Message-Id: <1396599104-24370-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1396599104-24370-1-git-send-email-chenhc@lemote.com>
References: <1396599104-24370-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

On MIPS currently, only the soft limit of cpu count (maxcpus) has its
effect, this patch enable the hard limit (nr_cpus) as well. Processor
cores which greater than maxcpus and less than nr_cpus can be taken up
via cpu hotplug. The code is borrowed from X86.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/kernel/setup.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index a842154..7ffda01 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -729,6 +729,23 @@ static void __init resource_init(void)
 	}
 }
 
+static void __init prefill_possible_map(void)
+{
+#ifdef CONFIG_SMP
+	int i, possible = num_possible_cpus();
+
+	if (possible > nr_cpu_ids)
+		possible = nr_cpu_ids;
+
+	for (i = 0; i < possible; i++)
+		set_cpu_possible(i, true);
+	for (; i < NR_CPUS; i++)
+		set_cpu_possible(i, false);
+
+	nr_cpu_ids = possible;
+#endif
+}
+
 void __init setup_arch(char **cmdline_p)
 {
 	cpu_probe();
@@ -752,6 +769,7 @@ void __init setup_arch(char **cmdline_p)
 
 	resource_init();
 	plat_smp_setup();
+	prefill_possible_map();
 
 	cpu_cache_init();
 }
-- 
1.7.7.3

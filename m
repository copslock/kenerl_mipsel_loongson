Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Apr 2014 02:25:27 +0200 (CEST)
Received: from mail-pd0-f179.google.com ([209.85.192.179]:57275 "EHLO
        mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822311AbaDMAYzG9u06 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Apr 2014 02:24:55 +0200
Received: by mail-pd0-f179.google.com with SMTP id w10so6655117pde.24
        for <multiple recipients>; Sat, 12 Apr 2014 17:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NWHXN3dyVwbHeoEIpOaBwMnSH7JqsgysHA3U5DIYnqM=;
        b=Sgcaku5Wde9NzxTJwLWbXKEuhmCSPaZ2qB3QnCKjE9O0IC2Z7SZw6QtxdN9nkhXGG7
         1rvWFwpTH5JKPY2h2f+hMx59hAzs7ZySEZ89mPuIjeZiu70B4AKybvDbWht+kjX2rCq3
         zERzqv0uNz5z8gYd2qeOXAZEyOH0OKt3Fmmttn2nA0Qqe3h21JIN24ww3hBi5qI/AkJR
         kgt0tiQBJm5Mp4/V4PG1RocvSRKRg6T7jvHJqZ8FHUCEIQliciEMhxdh850P1dtaFzmn
         w/TF62hg13Qm6wjAVChdGOXEtjZrf6E/BHMvfyoQb6j1s959zC0PvS2U0yK7tQE4bfWU
         6UnQ==
X-Received: by 10.66.171.206 with SMTP id aw14mr35931771pac.48.1397348688367;
        Sat, 12 Apr 2014 17:24:48 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id sh5sm24474879pbc.21.2014.04.12.17.24.42
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 12 Apr 2014 17:24:47 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 1/8] MIPS: Support hard limit of cpu count (nr_cpu_ids)
Date:   Sun, 13 Apr 2014 08:24:15 +0800
Message-Id: <1397348662-22502-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1397348662-22502-1-git-send-email-chenhc@lemote.com>
References: <1397348662-22502-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39784
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
 arch/mips/kernel/setup.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index a842154..2f01201 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -729,6 +729,25 @@ static void __init resource_init(void)
 	}
 }
 
+#ifdef CONFIG_SMP
+static void __init prefill_possible_map(void)
+{
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
+}
+#else
+static inline void prefill_possible_map(void) {}
+#endif
+
 void __init setup_arch(char **cmdline_p)
 {
 	cpu_probe();
@@ -752,6 +771,7 @@ void __init setup_arch(char **cmdline_p)
 
 	resource_init();
 	plat_smp_setup();
+	prefill_possible_map();
 
 	cpu_cache_init();
 }
-- 
1.7.7.3

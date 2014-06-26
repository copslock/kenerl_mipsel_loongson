Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jun 2014 05:42:49 +0200 (CEST)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:38967 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860003AbaFZDmLVdknX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Jun 2014 05:42:11 +0200
Received: by mail-pa0-f47.google.com with SMTP id kq14so2572905pab.34
        for <multiple recipients>; Wed, 25 Jun 2014 20:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9G5Kra3P8kiDOwpfEOGxFwD43+3am/iANWMx8mWHd2Y=;
        b=ocYjE0TaaYfE1asJrqkfZCb6meoiQLeAHzQGDqa8wf1WIVfztY3QK5LXEwofiIYYRK
         8+AFTxTvOZLMgucBNhppJrRobimgNukzfhA9LPnodPx6NAHmf+FB3ZYCrJiGGMsSSQWT
         wRlGNdoA8EGR+XQV4JXHdvHL2GxO+SF+YTK4qFalGdHBjX6L5jHK8x4sIaDSII3b707n
         FmtV9u9BvE72B4nob8NhVWBxLasRYSbYQGGwWAtW3OiVmwh/j75VmYBZ7R+hSt+bRTZz
         H8EZSShHniZsId4gbmYhswV4+IDx+oSYMTINHaQixu413p4Tgzj7V3V3QCN4FcdMa3Xy
         Pv3Q==
X-Received: by 10.69.31.235 with SMTP id kp11mr17313611pbd.59.1403754123543;
        Wed, 25 Jun 2014 20:42:03 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id aa3sm5115497pbd.17.2014.06.25.20.41.56
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 25 Jun 2014 20:42:03 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V3 1/8] MIPS: Support hard limit of cpu count (nr_cpu_ids)
Date:   Thu, 26 Jun 2014 11:41:25 +0800
Message-Id: <1403754092-26607-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1403754092-26607-1-git-send-email-chenhc@lemote.com>
References: <1403754092-26607-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40839
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
Reviewed-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
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

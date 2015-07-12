Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 01:12:25 +0200 (CEST)
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38322 "EHLO
        mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010505AbbGLXLiWjXCe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 01:11:38 +0200
Received: by iggf3 with SMTP id f3so9265297igg.1
        for <linux-mips@linux-mips.org>; Sun, 12 Jul 2015 16:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=/Yqjt3TCHXKRqthtJzFYfJLZrHOICNKmcmiFL+h4TNA=;
        b=PZKMdRkslrQnV1We1K3tH2RHQ1mc3YaJw80vl1Mw4SYVTgebvlN0BLQY32uqtL3XGR
         qPGgNda3niYHVpjuo9HBeiHRHEptVZnX0yTtiOGY30iSc9kQgUi9hhvlM9lnAVjDzD6v
         MPiYrk+ay57ttFYeoodWxIJEi41ucB4vM1Nqxop75TFbaLyjEqKWSYIDPqteV6jUYZ7T
         SJjk35G0Gif7XiKFl+mFBDPviR5sJ1Czdk9ziXJSM4mOtkLzGtSTWkPrIg1rylPp5Rdm
         t9bgbRf3qrMquurmUE80QaRh5EDSMxjjcOIV1t80EcF+8Tbit5p8JLTQ35hd+DqweMrh
         1Nwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:from:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=/Yqjt3TCHXKRqthtJzFYfJLZrHOICNKmcmiFL+h4TNA=;
        b=FLCOOF307ICg0AgjYxeVKVb+2pJNEqFBQLgKk8PoxCNT0ypUqaLPYdSoR5MMXRfO5w
         KNgc7OYYx7vXs9VC+cEvYzH88/UsxniTtBuHV6riTsh29VJlkrArIV9DOHN4kAzBisH7
         dkqyXO9YXWZCFnlLDD3wvUtprZB2TZsZmmYvkMM4cII2nkZ7E3kV8bFkI0yz2bPMwL40
         VQQGQKV0PTq8yaCpunGV8s/SIvN040XPjk08A3uuMbfqgbKCYfMteAZPe5a1Bnxwlofg
         ZxL0u/1In/6wFR32sj8M6KJ9FqpHjNYW+wkcV4OHdbb03A5tGWg0yzeKXWr5IRpA/xpE
         uBrQ==
X-Gm-Message-State: ALoCoQm4djcTL4ih9zDYF51WOp43lbtegQ1kxfEd9/LAofGNS0BvywGzKGBHbOIFc+is2mf40oNe
X-Received: by 10.107.16.169 with SMTP id 41mr14044817ioq.117.1436742692773;
        Sun, 12 Jul 2015 16:11:32 -0700 (PDT)
Received: from localhost ([69.71.1.1])
        by smtp.gmail.com with ESMTPSA id 140sm11383667ion.16.2015.07.12.16.11.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 12 Jul 2015 16:11:31 -0700 (PDT)
Subject: [PATCH 5/9] MIPS: Remove "weak" from get_c0_perfcount_int()
 declaration
To:     Ralf Baechle <ralf@linux-mips.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org
Date:   Sun, 12 Jul 2015 18:11:29 -0500
Message-ID: <20150712231129.11177.40742.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150712230402.11177.11848.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150712230402.11177.11848.stgit@bhelgaas-glaptop2.roam.corp.google.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

Weak header file declarations are error-prone because they make every
definition weak, and the linker chooses one based on link order (see
10629d711ed7 ("PCI: Remove __weak annotation from pcibios_get_phb_of_node
decl")).

get_c0_perfcount_int() is defined in several files.  Every definition is
weak, so I assume Kconfig prevents two or more from being included.  The
callers contain identical default code used when get_c0_perfcount_int()
isn't defined at all.

Add a weak get_c0_perfcount_int() definition with the default code and
remove the weak annotation from the declaration.

Then the platform implementations will be strong and will override the weak
default.  If multiple platforms are ever configured in, we'll get a link
error instead of calling a random platform's implementation.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/include/asm/time.h         |    2 +-
 arch/mips/kernel/perf_event_mipsxx.c |    7 +------
 arch/mips/kernel/time.c              |   10 +++++++++-
 arch/mips/oprofile/op_model_mipsxx.c |    8 +-------
 4 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index 8ab2874..ce6a7d5 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -46,7 +46,7 @@ extern unsigned int mips_hpt_frequency;
  * so it lives here.
  */
 extern int (*perf_irq)(void);
-extern int __weak get_c0_perfcount_int(void);
+extern int get_c0_perfcount_int(void);
 
 /*
  * Initialize the calling CPU's compare interrupt as clockevent device
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index cc1b6fa..c126b1c 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -1682,12 +1682,7 @@ init_hw_perf_events(void)
 		counters = counters_total_to_per_cpu(counters);
 #endif
 
-	if (get_c0_perfcount_int)
-		irq = get_c0_perfcount_int();
-	else if (cp0_perfcount_irq >= 0)
-		irq = MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
-	else
-		irq = -1;
+	irq = get_c0_perfcount_int();
 
 	mipspmu.map_raw_event = mipsxx_pmu_map_raw_event;
 
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index 8d01709..ec7082d 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -55,9 +55,17 @@ static int null_perf_irq(void)
 }
 
 int (*perf_irq)(void) = null_perf_irq;
-
 EXPORT_SYMBOL(perf_irq);
 
+#ifdef MIPS_CPU_IRQ_BASE
+int __weak get_c0_perfcount_int(void)
+{
+	if (cp0_perfcount_irq >= 0)
+		return MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
+	return -1;
+}
+#endif
+
 /*
  * time_init() - it does the following things.
  *
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 6a6e2cc..c0cffa9 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -438,13 +438,7 @@ static int __init mipsxx_init(void)
 	save_perf_irq = perf_irq;
 	perf_irq = mipsxx_perfcount_handler;
 
-	if (get_c0_perfcount_int)
-		perfcount_irq = get_c0_perfcount_int();
-	else if (cp0_perfcount_irq >= 0)
-		perfcount_irq = MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
-	else
-		perfcount_irq = -1;
-
+	perfcount_irq = get_c0_perfcount_int();
 	if (perfcount_irq >= 0)
 		return request_irq(perfcount_irq, mipsxx_perfcount_int,
 				   IRQF_PERCPU | IRQF_NOBALANCING |

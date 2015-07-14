Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 18:47:35 +0200 (CEST)
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35706 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010458AbbGNQqzIh6Pn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jul 2015 18:46:55 +0200
Received: by oihq81 with SMTP id q81so10504192oih.2
        for <linux-mips@linux-mips.org>; Tue, 14 Jul 2015 09:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=aIS9flF4QbS+BFARct9CSQZ4PlPXT7VTuMO3W/lCGxY=;
        b=bo9HA1wQbDGnbtlyaL4yyZjE7yudUi91/oWAKIIqvBjyb6prg/lLFiC17FSiqfEVSl
         3e8OPc/hRmw/dUzRnfx0icid/d3BVu6Cr6gTkWrUTqAgMkiyvbF4r2oR+8t6D6s0AmAH
         IiUefR5fWApIle36wdHCD82Wlrm5OVlU52c9QDymEqJro/HPMN5ocra7b7mjq8qYk3My
         tWS1rK2Fw0AqITjnxIZdKDy8GIVXPuDVC+5ZrwZr2FLdK2+nH7D/hFimDsYAKHJFkRUQ
         oxVEMgPHjmHiaDaTu+MpEd8A/6vrFi+w206mym53sRdmI77UZlk7C9595iYg5nPLGzkn
         xXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:from:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=aIS9flF4QbS+BFARct9CSQZ4PlPXT7VTuMO3W/lCGxY=;
        b=eGJTeLMkZlNdPlP03Cw6G/WkWV9pqUJBYmLtHDlJm2hzHDDyOOHzBe64EjXzPd8FY0
         lJn/bvd+5ZRqkn074J3M6ngbRVMzVjfATm+H5F+/y37RTanx1u93AVmnXosuUdwoy6lo
         UJiRYWFESn+jeEoMwWuIuOad7ZU6ao+myniRoOW21iGOnHRwIv6MHTQqpOaVFibuBJF2
         Ilz14nNOoXRmYR6g9VwxuF+W0U4jZZmtPIRmZYgtz3BnZd2DShjDVeewzroddYq5CNRh
         uzoCBLCZfqsLvTYnpUOg3K+m3DXbzDXFLdLv5RFgER1BTYkr4yskhI1oqRQ1WZuP87FR
         bLvQ==
X-Gm-Message-State: ALoCoQmPG3vJcqO8nCw5RawoaKZBAFKKRrKXWiJk9x4WvK9egk8t8ivtWSETf1cH4ezln4RtTlq0
X-Received: by 10.202.104.155 with SMTP id o27mr10313146oik.19.1436892409531;
        Tue, 14 Jul 2015 09:46:49 -0700 (PDT)
Received: from localhost ([69.71.1.1])
        by smtp.gmail.com with ESMTPSA id x82sm752546oie.19.2015.07.14.09.46.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Jul 2015 09:46:48 -0700 (PDT)
Subject: [PATCH v2 4/8] MIPS: Remove "weak" from get_c0_perfcount_int()
 declaration
To:     Ralf Baechle <ralf@linux-mips.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 14 Jul 2015 11:46:47 -0500
Message-ID: <20150714164647.1541.42503.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150714164142.1541.92710.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150714164142.1541.92710.stgit@bhelgaas-glaptop2.roam.corp.google.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48287
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
 arch/mips/kernel/time.c              |    9 ++++++++-
 arch/mips/oprofile/op_model_mipsxx.c |    8 +-------
 4 files changed, 11 insertions(+), 15 deletions(-)

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
index 8d01709..6fff600 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -27,6 +27,7 @@
 #include <asm/cpu-type.h>
 #include <asm/div64.h>
 #include <asm/time.h>
+#include <asm/irq.h>
 
 /*
  * forward reference
@@ -55,9 +56,15 @@ static int null_perf_irq(void)
 }
 
 int (*perf_irq)(void) = null_perf_irq;
-
 EXPORT_SYMBOL(perf_irq);
 
+int __weak get_c0_perfcount_int(void)
+{
+	if (cp0_perfcount_irq >= 0)
+		return MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
+	return -1;
+}
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

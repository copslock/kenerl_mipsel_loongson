Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Mar 2013 08:50:11 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:4772 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834974Ab3CYHuIorj6s (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Mar 2013 08:50:08 +0100
Received: from [10.9.208.53] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 25 Mar 2013 00:42:57 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 25 Mar 2013 00:49:54 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 25 Mar 2013 00:49:54 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 1E18D39289; Mon, 25
 Mar 2013 00:49:52 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        "John Crispin" <john@phrozen.org>
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 9/9 UPDATED] MIPS: Netlogic: Fix oprofile compile on XLR
 uniprocessor
Date:   Mon, 25 Mar 2013 13:21:52 +0530
Message-ID: <1364197912-1734-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <514EBDFA.4030903@phrozen.org>
References: <514EBDFA.4030903@phrozen.org>
MIME-Version: 1.0
X-WSS-ID: 7D4EDF8B3YC8538616-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

The commit c783390a0ecef08df5c804f8c5f647431a04f502 [MIPS: oprofile:
Support for XLR/XLS processors] causes a compilation failure when
oprofile is enabled and SMP is not configured.

arch/mips/oprofile/op_model_mipsxx.c: In function 'mipsxx_cpu_setup':
arch/mips/oprofile/op_model_mipsxx.c:181:2: error: implicit declaration of function 'cpu_logical_map'

To fix this, update oprofile_skip_cpu to not call cpu_logical_map when
CONFIG_SMP is not defined.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/oprofile/op_model_mipsxx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 1fd3614..e4b1140 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -41,7 +41,7 @@ static int (*save_perf_irq)(void);
  * first hardware thread in the core for setup and init.
  * Skip CPUs with non-zero hardware thread id (4 hwt per core)
  */
-#ifdef CONFIG_CPU_XLR
+#if defined(CONFIG_CPU_XLR) && defined(CONFIG_SMP)
 #define oprofile_skip_cpu(c)	((cpu_logical_map(c) & 0x3) != 0)
 #else
 #define oprofile_skip_cpu(c)	0
-- 
1.7.9.5

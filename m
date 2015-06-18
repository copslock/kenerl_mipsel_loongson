Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jun 2015 17:31:02 +0200 (CEST)
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34200 "EHLO
        mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008912AbbFRPbAefM1Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jun 2015 17:31:00 +0200
Received: by pdbki1 with SMTP id ki1so69033831pdb.1;
        Thu, 18 Jun 2015 08:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=3x3ongblDASFPH3JvZc9WTA1l0/EtSk5WLS5J7RURYI=;
        b=w3P5ibkb7ef7SnR33aJC20jjtSiRMs0yx0odi+jO9DHDSJBKuh3VvCRWFpGaMrcjM7
         soHQT6VQ/kO9umeOMWrsAANE+NCNgi6wCWrRTd4ckNuQpWQHraP78yOWGNxEaegjc4rS
         mNs7GBwhUXqch42m70lyc1guwY/4sNSC+yZQNTO9p7V4hpK9+N5bUl+cczCUKAi6wxxU
         jSnjyMrSCMyH0fx8V7QC1HlK+K4+Ymiezq74KcG3TfYWGk9rEba10qWuMZwu4Uy60dFE
         9KGQWfzK6H+Is/RpCeZtdEtIGcIEKwMDC9iEcVq02liYaCHWo/ygGTB/JM9jGLxEJKDm
         jgMA==
X-Received: by 10.68.69.37 with SMTP id b5mr22427094pbu.35.1434641454557;
        Thu, 18 Jun 2015 08:30:54 -0700 (PDT)
Received: from yggdrasil (114-25-189-158.dynamic.hinet.net. [114.25.189.158])
        by mx.google.com with ESMTPSA id dd3sm8504512pad.45.2015.06.18.08.30.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2015 08:30:53 -0700 (PDT)
Date:   Thu, 18 Jun 2015 23:30:49 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] MIPS: CPS: Guard mips_mt_set_cpuoptions call
Message-ID: <20150618232909-tung7970@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tung7970@gmail.com
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

Guard mips_mt_set_cpuoptions with MT specific options to
avoid undefined reference error on multicore platform
without multithreading support.

Signed-off-by: Tony Wu <tung7970@gmail.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/smp-cps.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 5570bc8..85633d6 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -102,7 +102,8 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 	bool cca_unsuitable;
 	u32 *entry_code;
 
-	mips_mt_set_cpuoptions();
+	if (config_enabled(CONFIG_MIPS_MT_SMP) && cpu_has_mipsmt)
+		mips_mt_set_cpuoptions();
 
 	/* Detect whether the CCA is unsuited to multi-core SMP */
 	cca = read_c0_config() & CONF_CM_CMASK;
-- 
1.7.5

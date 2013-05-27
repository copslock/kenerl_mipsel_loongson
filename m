Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 May 2013 13:01:16 +0200 (CEST)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:63592 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823668Ab3E0LBPU-nkF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 May 2013 13:01:15 +0200
Received: by mail-pa0-f46.google.com with SMTP id fa10so6706304pad.5
        for <multiple recipients>; Mon, 27 May 2013 04:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KAM+9qapHClnF1ABBH/wezvWrHFkh21XZJQs+evv3aE=;
        b=NKsg8kK8VgU4Aze+4waUc4llA6W4gfmn3tSkaxz+WbHplTsNx8vaGXyHicOOj73o3s
         7UqiMBDL7PZsYWlFeRx0dMV0KLKDTrVfAII/ElHkJGvDljQ2kfVSs1XneEM82bF23kFy
         lvfCBdpTTfPx8tBd0zZYEluNLoHR8Ug3DNqviffwPoOVJn7L7Tw1EmNh3lST0T1xWSH2
         voHf0WsDZiEcVxKgGdw9pEnyowo8BIrbiq77JpkCO4wEnZ+jTjQOocPehfTnGTvO9+GJ
         T90Bbqs5RNNBgL9RVZjc1by82WeXQAjvVCjG+GheUr0pEgaIXFJTPpCtdieO3tdWE1hg
         7+gw==
X-Received: by 10.66.119.103 with SMTP id kt7mr29147352pab.125.1369652468601;
        Mon, 27 May 2013 04:01:08 -0700 (PDT)
Received: from hades (111-243-158-188.dynamic.hinet.net. [111.243.158.188])
        by mx.google.com with ESMTPSA id qh4sm30215809pac.8.2013.05.27.04.01.05
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 27 May 2013 04:01:07 -0700 (PDT)
Date:   Mon, 27 May 2013 19:01:02 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org, Steven.Hill@imgtec.com, macro@linux-mips.org,
        david.daney@cavium.com, linux-mips@linux-mips.org
Subject: [PATCH v3 2/3] MIPS: microMIPS: Add kernel_uses_mmips in
 cpu-features.h
Message-ID: <20130527110102.GC31548@hades>
References: <20130527105810.GA31548@hades>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130527105810.GA31548@hades>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36609
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

Add kernel_uses_mmips to denote whether CONFIG_CPU_MICROMIPS
is set or not. This variable can help cut down #ifdef usage.

Signed-off-by: Tony Wu <tung7970@gmail.com>
Cc: David Daney <david.daney@cavium.com>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/cpu-features.h |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index e5ec8fc..dc7e94f 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -101,6 +101,13 @@
 #ifndef cpu_has_mmips
 #define cpu_has_mmips		(cpu_data[0].options & MIPS_CPU_MICROMIPS)
 #endif
+#ifndef kernel_uses_mmips
+# ifdef CONFIG_CPU_MICROMIPS
+#  define kernel_uses_mmips	1
+# else
+#  define kernel_uses_mmips	0
+# endif
+#endif
 #ifndef cpu_has_vtag_icache
 #define cpu_has_vtag_icache	(cpu_data[0].icache.flags & MIPS_CACHE_VTAG)
 #endif
-- 
1.7.10.2 (Apple Git-33)

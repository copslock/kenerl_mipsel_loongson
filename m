Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 May 2013 14:46:11 +0200 (CEST)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:62045 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823668Ab3E0MqKeDP5A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 May 2013 14:46:10 +0200
Received: by mail-pa0-f50.google.com with SMTP id fb11so5394707pad.23
        for <multiple recipients>; Mon, 27 May 2013 05:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KAM+9qapHClnF1ABBH/wezvWrHFkh21XZJQs+evv3aE=;
        b=LC4RvHFml01oE2BgrEv7o9n+/BbPr6jAh7mF1OA1xE3bDowBmlVNub1VU3AqWNfONT
         qWTdzvePAxYwYWQJ50LcKar2V47q8ywNvTKA7O3GfCWm4EmY8mNvw+9TVodhKD5a8rkx
         vxm3pVoNum9Y5odAbP8FTac1mjWMzVZhg6fzfWaclTfdLPzKGapoFq73JfBBClxN0Gko
         xpHnI49s2bOiP0f1bvUJDKVf4fEB7EWKGCgmZLNqQuB1llVtaWGcsNEd4vsTCDHEgKtJ
         BkSCiEhgepNdqQ7hQZgVji5Adg6ujiSFa8Rjnyk0E6NmX/T0HzzGB5B9GRoioTWa0ziX
         8qpQ==
X-Received: by 10.66.172.69 with SMTP id ba5mr6493984pac.198.1369658763838;
        Mon, 27 May 2013 05:46:03 -0700 (PDT)
Received: from hades (111-243-158-188.dynamic.hinet.net. [111.243.158.188])
        by mx.google.com with ESMTPSA id lq4sm30508267pab.19.2013.05.27.05.46.01
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 27 May 2013 05:46:03 -0700 (PDT)
Date:   Mon, 27 May 2013 20:45:57 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org, macro@linux-mips.org, Steven.Hill@imgtec.com,
        david.daney@cavium.com, linux-mips@linux-mips.org
Subject: [PATCH v4 2/3] MIPS: microMIPS: Add kernel_uses_mmips in
 cpu-features.h
Message-ID: <20130527124557.GB32322@hades>
References: <20130527124421.GA32322@hades>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130527124421.GA32322@hades>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36614
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

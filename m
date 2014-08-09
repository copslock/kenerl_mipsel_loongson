Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Aug 2014 19:54:27 +0200 (CEST)
Received: from mail-pd0-f181.google.com ([209.85.192.181]:57869 "EHLO
        mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819004AbaHIRyYdJSLE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Aug 2014 19:54:24 +0200
Received: by mail-pd0-f181.google.com with SMTP id g10so8493089pdj.26
        for <multiple recipients>; Sat, 09 Aug 2014 10:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Iy6HjWuXXBT49L22/0QSVwIgZIYqziIcBykvgReXDIQ=;
        b=H4pRZxwMkYf/dBKngyUCA023XPexWw8kRkkHWg1zzEqmGZNgT5yqlWYdC/nvgadKeA
         Bo+q7QteTDmO27XZtAvYsAjxwPdgvFsTARYK8lxZqLtALEJFTx9DjkTf4OSjOD+4dcbr
         OZz3kPwzvTtuDkb1xdW8CcDfz74WGrPA/m6GpiMtaMqLpLbAd8IWTGh9BeA8cnbD40aL
         uXh3fv0ASkhx8J88Pie2HCZAjLuU/83kF8ifsF8ZSAXcSimbMPJz/arf0/SnjgWqCVS4
         0oiqHIo1pzXdaowhM45JvBTuRYldsAjULFtdqucoSriKPLP4/NW5rDuUpJ6JFxXWpwUb
         uZNA==
X-Received: by 10.70.65.100 with SMTP id w4mr2515795pds.128.1407606857788;
        Sat, 09 Aug 2014 10:54:17 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id pu1sm6552381pbc.45.2014.08.09.10.54.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 09 Aug 2014 10:54:17 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Huacai Chen <chenhc@lemote.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Subject: [PATCH] mips: Fix nlm_xlp_defconfig build error
Date:   Sat,  9 Aug 2014 10:54:03 -0700
Message-Id: <1407606843-12984-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

The nlm_xlp_defconfig build fails with

./arch/mips/include/asm/mach-netlogic/topology.h:15:0:
			error: "topology_core_id" redefined [-Werror]
In file included from include/linux/smp.h:59:0,
	[ ...]
                 from arch/mips/mm/dma-default.c:12:
./arch/mips/include/asm/smp.h:41:0:
			note: this is the location of the previous definition

and similar errors.

This is caused by commit bda4584cd943d7 ("MIPS: Support CPU topology files
in sysfs") which adds the defines to arch/mips/include/asm/smp.h.

Remove the defines from arch/mips/include/asm/mach-netlogic/topology.h
as no longer necessary.

Cc: Huacai Chen <chenhc@lemote.com>
Cc: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/mips/include/asm/mach-netlogic/topology.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/mips/include/asm/mach-netlogic/topology.h b/arch/mips/include/asm/mach-netlogic/topology.h
index ceeb1f5..0eb43c8 100644
--- a/arch/mips/include/asm/mach-netlogic/topology.h
+++ b/arch/mips/include/asm/mach-netlogic/topology.h
@@ -10,13 +10,6 @@
 
 #include <asm/mach-netlogic/multi-node.h>
 
-#ifdef CONFIG_SMP
-#define topology_physical_package_id(cpu)	cpu_to_node(cpu)
-#define topology_core_id(cpu)	(cpu_logical_map(cpu) / NLM_THREADS_PER_CORE)
-#define topology_thread_cpumask(cpu)		(&cpu_sibling_map[cpu])
-#define topology_core_cpumask(cpu)	cpumask_of_node(cpu_to_node(cpu))
-#endif
-
 #include <asm-generic/topology.h>
 
 #endif /* _ASM_MACH_NETLOGIC_TOPOLOGY_H */
-- 
1.9.1

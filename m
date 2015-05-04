Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 May 2015 00:31:12 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:35037 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014682AbbEDWbLCid0x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 May 2015 00:31:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=bIn7vpt/BssA75bS5Lhqz/RQjGwgIiTx2UhD5zwdimk=;
        b=S1432JAbvhu8Qfg/C/JzR4YLgg72J6bUcEgC1ONJ3/vaLvGLnNdtzB2sUwYfh6H5Qck8blcyJoTpIbAIQB0V4ZqkhEeGAREO7244YuAdcuW2LFqZWI9W05ZTC8I5Kmnh/TT+kyoYRiSXQ78+8UymzEoG++ynyoGdmy/wWbkqvbU=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1YpOtG-000UA6-Ob
        for linux-mips@linux-mips.org; Mon, 04 May 2015 22:31:06 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:55214 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1YpOt7-000Tth-GX; Mon, 04 May 2015 22:30:58 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rusty Russell <rusty@rustcorp.com.au>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH resend 2/5] mips: Fix SMP builds
Date:   Mon,  4 May 2015 15:30:46 -0700
Message-Id: <1430778649-28126-3-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1430778649-28126-1-git-send-email-linux@roeck-us.net>
References: <1430778649-28126-1-git-send-email-linux@roeck-us.net>
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020201.5547F32A.01D4,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 15
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 0
X-CTCH-SenderID-TotalConfirmed: 0
X-CTCH-SenderID-TotalBulk: 0
X-CTCH-SenderID-TotalVirus: 0
X-CTCH-SenderID-TotalRecipients: 0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: mailgid no entry from get_relayhosts_entry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47233
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

Mips SMP builds fail with error messages similar to the following.

arch/mips/kernel/smp.c:211:2: error:
	passing argument 2 of 'cpumask_set_cpu' discards 'volatile'
	qualifier from pointer target type
arch/mips/kernel/process.c:52:2: error:
	passing argument 2 of 'cpumask_test_cpu' discards 'volatile'
	qualifier from pointer target type
arch/mips/cavium-octeon/smp.c:242:2: error:
	passing argument 2 of 'cpumask_clear_cpu' discards 'volatile'
	qualifier from pointer target type

cpu_callin_map is declared as volatile variable, but passed to various
functions with non-volatile arguments. Make it non-volatile and add a
memory barrier at the one location where volatile might be needed.

Fixes: 8dd928915a73 ("mips: fix up obsolete cpu function usage")
Cc: Rusty Russell <rusty@rustcorp.com.au>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Tested-by: Paul Martin <paul.martin@codethink.co.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Please consider pushing this patch into mainline, or provide feedback
on how to improve it to be acceptable.

 arch/mips/include/asm/smp.h | 2 +-
 arch/mips/kernel/smp.c      | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index bb02fac9b4fa..2b25d1ba1ea0 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -45,7 +45,7 @@ extern int __cpu_logical_map[NR_CPUS];
 #define SMP_DUMP		0x8
 #define SMP_ASK_C0COUNT		0x10
 
-extern volatile cpumask_t cpu_callin_map;
+extern cpumask_t cpu_callin_map;
 
 /* Mask of CPUs which are currently definitely operating coherently */
 extern cpumask_t cpu_coherent_mask;
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 193ace7955fb..158191394770 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -43,7 +43,7 @@
 #include <asm/time.h>
 #include <asm/setup.h>
 
-volatile cpumask_t cpu_callin_map;	/* Bitmask of started secondaries */
+cpumask_t cpu_callin_map;		/* Bitmask of started secondaries */
 
 int __cpu_number_map[NR_CPUS];		/* Map physical to logical */
 EXPORT_SYMBOL(__cpu_number_map);
@@ -218,8 +218,10 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 	/*
 	 * Trust is futile.  We should really have timeouts ...
 	 */
-	while (!cpumask_test_cpu(cpu, &cpu_callin_map))
+	while (!cpumask_test_cpu(cpu, &cpu_callin_map)) {
 		udelay(100);
+		mb();
+	}
 
 	synchronise_count_master(cpu);
 	return 0;
-- 
2.1.0

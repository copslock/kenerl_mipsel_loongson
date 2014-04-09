Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2014 10:48:38 +0200 (CEST)
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:59992 "EHLO
        cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821191AbaDIIsgKuEeV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Apr 2014 10:48:36 +0200
Received: from cpsps-ews15.kpnxchange.com ([10.94.84.182]) by cpsmtpb-ews09.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Wed, 9 Apr 2014 10:48:30 +0200
Received: from CPSMTPM-TLF101.kpnxchange.com ([195.121.3.4]) by cpsps-ews15.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Wed, 9 Apr 2014 10:48:30 +0200
Received: from [192.168.10.106] ([195.240.213.44]) by CPSMTPM-TLF101.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Wed, 9 Apr 2014 10:48:29 +0200
Message-ID: <1397033309.22767.8.camel@x220>
Subject: MIPS: Remove last traces of SMTC Support too?
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Date:   Wed, 09 Apr 2014 10:48:29 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-2.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Apr 2014 08:48:30.0009 (UTC) FILETIME=[7B11A290:01CF53D0]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
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

The patch "MIPS: Remove SMTC Support" landed in linux-next (see
next-20140409). A quick grep of the tree suggests a follow up is needed
(a sort-of-patch is pasted below).

Is a similar follow up queued somewhere? If not, should I submit a patch
or should I wait with doing that until "MIPS: Remove SMTC Support" hits
mainline?


Paul Bolle
---
 arch/mips/configs/maltasmtc_defconfig | 196 --------------------
 arch/mips/include/asm/cpu-info.h      |   2 +-
 arch/mips/include/asm/smtc.h          |  78 --------
 arch/mips/include/asm/smtc_ipi.h      | 129 --------------
 arch/mips/include/asm/smtc_proc.h     |  23 ---
 arch/mips/kernel/cevt-smtc.c          | 324 ----------------------------------
 arch/mips/kernel/smtc-asm.S           | 133 --------------
 arch/mips/kernel/smtc-proc.c          | 102 -----------
 arch/mips/pmcs-msp71xx/msp_smtc.c     | 104 -----------
 9 files changed, 1 insertion(+), 1090 deletions(-)
 delete mode 100644 arch/mips/configs/maltasmtc_defconfig
 delete mode 100644 arch/mips/include/asm/smtc.h
 delete mode 100644 arch/mips/include/asm/smtc_ipi.h
 delete mode 100644 arch/mips/include/asm/smtc_proc.h
 delete mode 100644 arch/mips/kernel/cevt-smtc.c
 delete mode 100644 arch/mips/kernel/smtc-asm.S
 delete mode 100644 arch/mips/kernel/smtc-proc.c
 delete mode 100644 arch/mips/pmcs-msp71xx/msp_smtc.c

diff --git a/arch/mips/configs/maltasmtc_defconfig b/arch/mips/configs/maltasmtc_defconfig
deleted file mode 100644
index eb316447588c..000000000000
diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index 2f6812b901b0..04088cf4e519 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -108,7 +108,7 @@ struct proc_cpuinfo_notifier_args {
 	unsigned long n;
 };
 
-#if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_MIPS_MT_SMTC)
+#if defined(CONFIG_MIPS_MT_SMP)
 # define cpu_vpe_id(cpuinfo)	((cpuinfo)->vpe_id)
 #else
 # define cpu_vpe_id(cpuinfo)	0
diff --git a/arch/mips/include/asm/smtc.h b/arch/mips/include/asm/smtc.h
deleted file mode 100644
index e56b439b7871..000000000000
diff --git a/arch/mips/include/asm/smtc_ipi.h b/arch/mips/include/asm/smtc_ipi.h
deleted file mode 100644
index 15278dbd7e79..000000000000
diff --git a/arch/mips/include/asm/smtc_proc.h b/arch/mips/include/asm/smtc_proc.h
deleted file mode 100644
index 25da651f1f5f..000000000000
diff --git a/arch/mips/kernel/cevt-smtc.c b/arch/mips/kernel/cevt-smtc.c
deleted file mode 100644
index b6cf0a60d896..000000000000
diff --git a/arch/mips/kernel/smtc-asm.S b/arch/mips/kernel/smtc-asm.S
deleted file mode 100644
index 2866863a39df..000000000000
diff --git a/arch/mips/kernel/smtc-proc.c b/arch/mips/kernel/smtc-proc.c
deleted file mode 100644
index 38635a996cbf..000000000000
diff --git a/arch/mips/pmcs-msp71xx/msp_smtc.c b/arch/mips/pmcs-msp71xx/msp_smtc.c
deleted file mode 100644
index 6b5607fce279..000000000000
-- 
1.9.0

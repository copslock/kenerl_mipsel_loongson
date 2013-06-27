Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jun 2013 12:45:36 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:1338 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818020Ab3F0KpfPQ237 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jun 2013 12:45:35 +0200
Received: from [10.9.208.53] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Thu, 27 Jun 2013 03:41:37 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Thu, 27 Jun 2013 03:45:20 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Thu, 27 Jun 2013 03:45:20 -0700
Received: from fainelli-desktop.broadcom.com (
 dhcp-lab-brsb-10.bri.broadcom.com [10.178.7.10]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id EC02DF2D72; Thu, 27
 Jun 2013 03:45:18 -0700 (PDT)
From:   "Florian Fainelli" <florian@openwrt.org>
To:     linux-mips@linux-mips.org
cc:     ralf@linux-mips.org, blogic@openwrt.org, jogo@openwrt.org,
        cernekee@gmail.com, "Florian Fainelli" <florian@openwrt.org>
Subject: [PATCH] MIPS: BMIPS: fix warnings for non BMIPS43xx builds
Date:   Thu, 27 Jun 2013 11:45:15 +0100
Message-ID: <1372329915-17944-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.8.1.2
MIME-Version: 1.0
X-WSS-ID: 7DD2C96B31W42651295-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

Commit dccfb4c4 ("MIPS: BMIPS: support booting from physical CPU other
than 0") introduces the following warning when building for non
BMIPS43xx builds:

arch/mips/kernel/smp-bmips.c:150:6: error: unused variable 'tpid'
[-Werror=unused-variable]

Fix this by getting rid of this variable and directly using
cpu_logical_map(cpu).

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Ralf,

You might want to fold this into the commit that actually introduced the
build warning.

Thanks!

 arch/mips/kernel/smp-bmips.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 62c5c7c..aea6c08 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -147,7 +147,6 @@ static void bmips_prepare_cpus(unsigned int max_cpus)
  */
 static void bmips_boot_secondary(int cpu, struct task_struct *idle)
 {
-	int tpid = cpu_logical_map(cpu);
 	bmips_smp_boot_sp = __KSTK_TOS(idle);
 	bmips_smp_boot_gp = (unsigned long)task_thread_info(idle);
 	mb();
@@ -174,7 +173,7 @@ static void bmips_boot_secondary(int cpu, struct task_struct *idle)
 	else {
 #if defined(CONFIG_CPU_BMIPS4350) || defined(CONFIG_CPU_BMIPS4380)
 		/* Reset slave TP1 if booting from TP0 */
-		if (tpid == 0)
+		if (cpu_logical_map(cpu) == 0)
 			set_c0_brcm_cmt_ctrl(0x01);
 #elif defined(CONFIG_CPU_BMIPS5000)
 		if (cpu & 0x01)
-- 
1.8.1.2

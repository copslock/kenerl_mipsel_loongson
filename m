Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Mar 2016 00:55:19 +0100 (CET)
Received: from mail177-1.suw61.mandrillapp.com ([198.2.177.1]:4716 "EHLO
        mail177-1.suw61.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27015057AbcCAXylY-8IJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Mar 2016 00:54:41 +0100
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=mandrill; d=linuxfoundation.org;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=gregkh@linuxfoundation.org;
 bh=A/W354sjzs4uZOe5GaeoVfh4Fn4=;
 b=iasVO6hx7qZ91A5eTmKPiayV8NzGtlCeQR0l/EiAnZz+lj5e7lEDKQer02/RD2ZE1MgN0jTM34Gx
   p1Xd3/PekmC0y99eULP4FRerVa2EFGttp0OVW6KDOflTBfVm9N4Ll3oF8VgLDYCqZmpgEsivvpPY
   XrR0LtH7TUlONITUpjc=
Received: from pmta06.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail177-1.suw61.mandrillapp.com id hqols222rtka for <linux-mips@linux-mips.org>; Tue, 1 Mar 2016 23:54:35 +0000 (envelope-from <bounce-md_30481620.56d62bbb.v1-c6cc38fe542e4e698c6183fb8d76ced3@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1456876475; h=From : 
 Subject : To : Cc : Message-Id : In-Reply-To : References : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=DppNXSsilPiAVRdA43BsXALiJlwE82x3pgVE986JYkw=; 
 b=dn4yYd2bTnxZIYgRiXys+3Q5ebmYlkcdkhhmjXqhE/ky/f+jZVwm15tUBm3z+eUwOBmZpi
 fvniQmIO4MdyN7M7ZctmnNbdMO1OvVdMZ8jWdUENwFUT1n7e5Q4UlzLO8nQdInulrAvMkStB
 oZRWidnzgbfpMOStNI9R1IRd3RO8g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.4 155/342] MIPS: Loongson-3: Fix SMP_ASK_C0COUNT IPI handler
Received: from [50.170.35.168] by mandrillapp.com id c6cc38fe542e4e698c6183fb8d76ced3; Tue, 01 Mar 2016 23:54:35 +0000
X-Mailer: git-send-email 2.7.2
To:     <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <stable@vger.kernel.org>, Huacai Chen <chenhc@lemote.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Message-Id: <20160301234532.982350186@linuxfoundation.org>
In-Reply-To: <20160301234527.990448862@linuxfoundation.org>
References: <20160301234527.990448862@linuxfoundation.org>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=30481620.c6cc38fe542e4e698c6183fb8d76ced3
X-Mandrill-User: md_30481620
Date:   Tue, 01 Mar 2016 23:54:35 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <bounce-md_30481620.56d62bbb.v1-c6cc38fe542e4e698c6183fb8d76ced3@mandrillapp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhc@lemote.com>

commit 5754843225f78ac7cbe142a6899890a9733a5a5d upstream.

When Core-0 handle SMP_ASK_C0COUNT IPI, we should make other cores to
see the result as soon as possible (especially when Store-Fill-Buffer
is enabled). Otherwise, C0_Count syncronization makes no sense.

BTW, array is more suitable than per-cpu variable for syncronization,
and there is a corner case should be avoid: C0_Count of Core-0 can be
really 0.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/12160/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/loongson64/loongson-3/smp.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -30,13 +30,13 @@
 #include "smp.h"
 
 DEFINE_PER_CPU(int, cpu_state);
-DEFINE_PER_CPU(uint32_t, core0_c0count);
 
 static void *ipi_set0_regs[16];
 static void *ipi_clear0_regs[16];
 static void *ipi_status0_regs[16];
 static void *ipi_en0_regs[16];
 static void *ipi_mailbox_buf[16];
+static uint32_t core0_c0count[NR_CPUS];
 
 /* read a 32bit value from ipi register */
 #define loongson3_ipi_read32(addr) readl(addr)
@@ -275,12 +275,14 @@ void loongson3_ipi_interrupt(struct pt_r
 	if (action & SMP_ASK_C0COUNT) {
 		BUG_ON(cpu != 0);
 		c0count = read_c0_count();
-		for (i = 1; i < num_possible_cpus(); i++)
-			per_cpu(core0_c0count, i) = c0count;
+		c0count = c0count ? c0count : 1;
+		for (i = 1; i < nr_cpu_ids; i++)
+			core0_c0count[i] = c0count;
+		__wbflush(); /* Let others see the result ASAP */
 	}
 }
 
-#define MAX_LOOPS 1111
+#define MAX_LOOPS 800
 /*
  * SMP init and finish on secondary CPUs
  */
@@ -305,16 +307,20 @@ static void loongson3_init_secondary(voi
 		cpu_logical_map(cpu) / loongson_sysconf.cores_per_package;
 
 	i = 0;
-	__this_cpu_write(core0_c0count, 0);
+	core0_c0count[cpu] = 0;
 	loongson3_send_ipi_single(0, SMP_ASK_C0COUNT);
-	while (!__this_cpu_read(core0_c0count)) {
+	while (!core0_c0count[cpu]) {
 		i++;
 		cpu_relax();
 	}
 
 	if (i > MAX_LOOPS)
 		i = MAX_LOOPS;
-	initcount = __this_cpu_read(core0_c0count) + i;
+	if (cpu_data[cpu].package)
+		initcount = core0_c0count[cpu] + i;
+	else /* Local access is faster for loops */
+		initcount = core0_c0count[cpu] + i/2;
+
 	write_c0_count(initcount);
 }

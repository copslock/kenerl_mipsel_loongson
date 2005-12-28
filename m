Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Dec 2005 22:22:07 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:44010 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133607AbVL1WVs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Dec 2005 22:21:48 +0000
Received: (qmail 5437 invoked from network); 28 Dec 2005 22:23:35 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 28 Dec 2005 22:23:35 -0000
Message-ID: <43B310F5.4090507@ru.mvista.com>
Date:	Thu, 29 Dec 2005 01:25:57 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux MIPS <linux-mips@linux-mips.org>
CC:	Manish Lachwani <mlachwani@mvista.com>,
	Jordan Crouse <jordan.crouse@amd.com>, ralf@linux-mips.org
Subject: Re: [PATCH] Retain the write-only OD from being clobbered
References: <20051122205938.GR18119@cosmic.amd.com> <43838957.2020106@ru.mvista.com>
In-Reply-To: <43838957.2020106@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------030905000906030802040701"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------030905000906030802040701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello

Sergei Shtylylov wrote:

> Jordan Crouse wrote:

>> First of several patches forwarded to me by Sergei Shtylyov.  Ralf,
>> these should be good to go for the tree.
>>
>> Retain the write-only OD bit from being clobbered by coherency_setup()
>>
>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>> Acked-by: Jordan Crouse <jordan.crouse@amd.com>

>    A long story of a long standing bug follows...
>    AMD Au1x00 board setup code in au1x00_setup() sets CONFIG.OD bit for 
> the early steppings of the Au1x00 SOCs, consulting the PRID table in 
> arch/mips/au1000/common/cputable.c. This bit disables the bus 
> transaction overlapping which causes a number of errata in those early 
> SOC steppings (including the one that I think we've run into with USB 
> host--at least setting the bit back to 1 fixed it, although disabling 
> USB host DMA coherency also seemd to help). The problem is that this bit 
> is write-only and reads
> as 0 on almost all SOCs that need it set. So, when the arch/mm/c-r4k.c code
> does RMW to the CONFIG reg. in coherency_setup(), its value is lost, and 
> the
> chip again becomes prone to all the nasty errata that it has just been 
> saved
> from... :-)
>       There's couple more places in the assembly code where the CP0 
> CONFIG reg. is written without care of OD bit:
>    1) In the cache parity error handler (arch/mips/mm/cex-gen.S) -- as 
> the panic() call follows shortly, probably CACHE.OD=0 doesn't matter 
> much at this point;
>    2) In arch/mips/au1000/common/sleeper.S, when the CPU regs are being
> restored on wakeup; Au1x00 PM code in 2.6 seem to have fallen out of
> maintenance, and the stack frame set up there seemed just erratic (2.4
> situation in this module is much better).
>    I didn't touch both those places. And of course, this CONFIG.OD bug is
> present in 2.4 kernels as well...

       Posting the reworked patch at last -- this variant doesn't include
machine-specific header into arch/mips/c-r4k.c...

WBR, Sergei

Signed-off-by: Konstantin Baidarov <kbaidarov@ru.mvista.com>
Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>




--------------030905000906030802040701
Content-Type: text/plain;
 name="Au1x00-retain-OD-bit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Au1x00-retain-OD-bit.patch"

diff --git a/arch/mips/au1000/common/setup.c b/arch/mips/au1000/common/setup.c
index 08c8c85..e36289b 100644
--- a/arch/mips/au1000/common/setup.c
+++ b/arch/mips/au1000/common/setup.c
@@ -143,6 +143,17 @@ void __init plat_setup(void)
 	au_writel(0, SYS_TOYTRIM);
 }
 
+/*
+ * Fix up write-only Config[OD] bit after a write to that register. Since the
+ * bit always reads as 0 on those SOC revs that require it to be set to fight
+ * the various errata, we need to set it back to 1...
+ */
+void au1x00_fixup_config_od(void)
+{
+	if (cur_cpu_spec[0]->cpu_od)
+		set_c0_config(1<<19);
+}
+
 #if defined(CONFIG_64BIT_PHYS_ADDR)
 /* This routine should be valid for all Au1x based boards */
 phys_t __fixup_bigphys_addr(phys_t phys_addr, phys_t size)
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 422b55f..8447699 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1201,8 +1201,20 @@ static void __init setup_scache(void)
 
 static inline void coherency_setup(void)
 {
+	extern void au1x00_fixup_config_od(void);
+
 	change_c0_config(CONF_CM_CMASK, CONF_CM_DEFAULT);
 
+#ifdef CONFIG_SOC_AU1X00
+	/*
+	 * c0_config.od (bit 19) is write only (and reads as 0) on many early
+	 * revs of AMD Au1x00 SOCs. It disables the bus transaction overlapping
+	 * and needs to be set to correct the various errata. So if it has been
+	 * set by the board setup code we must leave it set...
+	 */
+	au1x00_fixup_config_od();
+#endif
+
 	/*
 	 * c0_status.cu=0 specifies that updates by the sc instruction use
 	 * the coherency mode specified by the TLB; 1 means cachable


--------------030905000906030802040701--

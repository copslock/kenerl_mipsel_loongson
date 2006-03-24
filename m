Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2006 20:25:34 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:43451 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133896AbWCXUZZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Mar 2006 20:25:25 +0000
Received: (qmail 28040 invoked from network); 25 Mar 2006 01:35:58 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 25 Mar 2006 01:35:58 -0000
Message-ID: <442457A6.4080508@dev.rtsoft.ru>
Date:	Fri, 24 Mar 2006 23:33:42 +0300
From:	Sergei Shtylyov <sshtylyov@dev.rtsoft.ru>
Organization: RTSoft, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux MIPS <linux-mips@linux-mips.org>
CC:	Jordan Crouse <jordan.crouse@amd.com>, ralf@linux-mips.org
Subject: Re: [PATCH] Retain the write-only OD from being clobbered
References: <20051122205938.GR18119@cosmic.amd.com> <43838957.2020106@ru.mvista.com>
In-Reply-To: <43838957.2020106@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------080408020308070305040506"
Return-Path: <sshtylyov@dev.rtsoft.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@dev.rtsoft.ru
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------080408020308070305040506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

     Retain the write-only OD bit from being clobbered by coherency_setup().

WBR, Sergei

PS: Looks like this patch is stuck uncommitted since December, while it's a
serious issue causing the kernel lockups.

Signed-off-by: Konstantin Baidarov <kbaidarov@ru.mvista.com>
Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>



--------------080408020308070305040506
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




--------------080408020308070305040506--

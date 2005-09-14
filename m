Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2005 14:04:59 +0100 (BST)
Received: from [IPv6:::ffff:85.21.88.6] ([IPv6:::ffff:85.21.88.6]:3092 "EHLO
	buildserver.ru.mvista.com") by linux-mips.org with ESMTP
	id <S8225204AbVINNEk>; Wed, 14 Sep 2005 14:04:40 +0100
Received: from [192.168.12.17] ([10.149.0.1])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id j8ED4ct21813;
	Wed, 14 Sep 2005 18:04:38 +0500
Message-ID: <43281FE6.4070102@ru.mvista.com>
Date:	Wed, 14 Sep 2005 17:04:38 +0400
From:	"Vladimir A. Barinov" <vbarinov@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] Remove compile warnings for TX4927(37) platform
References: <20050913124544.GC3224@linux-mips.org>	<20050913133126.GO23161@lug-owl.de>	<20050913152038.GE3224@linux-mips.org> <17191.61757.80884.8289@mips.com> <43281DC3.8010602@ru.mvista.com> <43281F6E.3010807@ru.mvista.com>
In-Reply-To: <43281F6E.3010807@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------060407040209010203080500"
Return-Path: <vbarinov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vbarinov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------060407040209010203080500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello All!

This as a patch to aviod compile warnings for TX4927 platform.

Does it makes sence to push it in?

Regards,
Vladimir


--------------060407040209010203080500
Content-Type: text/plain;
 name="pro_mips_tx4927_warnings.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pro_mips_tx4927_warnings.patch"

 Signed-off-by: Vladimir Barinov <vbarinov@ru.mvista.com>
 Description:
 	Patch to aviod compile warnings from TX4927/37 platform.
                                                                                                                                                             
Index: linux-2.6.10/arch/mips/tx4927/common/tx4927_irq.c
===================================================================
--- linux-2.6.10/arch/mips/tx4927/common/tx4927_irq.c
+++ linux-2.6.10/arch/mips/tx4927/common/tx4927_irq.c
@@ -567,6 +567,8 @@ int tx4927_irq_nested(void)
 
 #ifdef CONFIG_TOSHIBA_RBTX4927
 			{
+				extern int toshiba_rbtx4927_irq_nested(int
+								       sw_irq);
 				sw_irq = toshiba_rbtx4927_irq_nested(sw_irq);
 			}
 #endif
Index: linux-2.6.10/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
===================================================================
--- linux-2.6.10/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
+++ linux-2.6.10/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
@@ -293,8 +293,10 @@ u32 bit2num(u32 num)
 int toshiba_rbtx4927_irq_nested(int sw_irq)
 {
 	u32 level3;
+#ifdef CONFIG_TOSHIBA_FPCIB0
 	u32 level4;
 	u32 level5;
+#endif
 
 	level3 = reg_rd08(TOSHIBA_RBTX4927_IOC_INTR_STAT) & 0x1f;
 	if (level3) {
Index: linux-2.6.10/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c
===================================================================
--- linux-2.6.10/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c
+++ linux-2.6.10/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c
@@ -74,7 +74,7 @@ void __init prom_init(void)
 	else
 		mips_machtype = MACH_TOSHIBA_RBTX4937;
 
-        toshiba_name = toshiba_name_list[mips_machtype];
+        toshiba_name = (char *)toshiba_name_list[mips_machtype];
 
 	msize = tx4927_get_mem_size();
 	add_memory_region(0, msize << 20, BOOT_MEM_RAM);
Index: linux-2.6.10/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
===================================================================
--- linux-2.6.10/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
+++ linux-2.6.10/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
@@ -134,6 +134,9 @@ int tx4927_using_backplane = 0;
 extern void gt64120_time_init(void);
 extern void toshiba_rbtx4927_irq_setup(void);
 
+extern char *prom_getcmdline(void);
+extern void rtc_ds1742_init(unsigned long);
+
 #ifdef CONFIG_PCI
 #define CONFIG_TX4927BUG_WORKAROUND
 #undef TX4927_SUPPORT_COMMAND_IO
@@ -268,7 +271,9 @@ static int __init tx4927_pcibios_init(vo
 			u8 v08_64;
 			u32 v32_b0;
 			u8 v08_e1;
+#ifdef TOSHIBA_RBTX4927_SETUP_DEBUG
 			char *s = " sb/isa --";
+#endif
 
 			TOSHIBA_RBTX4927_SETUP_DPRINTK
 			    (TOSHIBA_RBTX4927_SETUP_PCIBIOS, ":%s beg\n",
@@ -353,7 +358,9 @@ static int __init tx4927_pcibios_init(vo
 			u8 v08_41;
 			u8 v08_43;
 			u8 v08_5c;
+#ifdef TOSHIBA_RBTX4927_SETUP_DEBUG
 			char *s = " sb/ide --";
+#endif
 
 			TOSHIBA_RBTX4927_SETUP_DPRINTK
 			    (TOSHIBA_RBTX4927_SETUP_PCIBIOS, ":%s beg\n",
@@ -971,9 +978,6 @@ void __init toshiba_rbtx4927_setup(void)
 void __init
 toshiba_rbtx4927_time_init(void)
 {
-	u32 c1;
-	u32 c2;
-
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_TIME_INIT, "-\n");
 
 	rtc_ds1742_init(RBTX4927_RTC_BASE);

--------------060407040209010203080500--

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2TKd7911063
	for linux-mips-outgoing; Thu, 29 Mar 2001 12:39:07 -0800
Received: from tower.ti.com (tower.ti.com [192.94.94.5])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2TKd6M11060
	for <linux-mips@oss.sgi.com>; Thu, 29 Mar 2001 12:39:06 -0800
Received: from dlep8.itg.ti.com ([157.170.134.88])
	by tower.ti.com (8.11.1/8.11.1) with ESMTP id f2TKd0r26234
	for <linux-mips@oss.sgi.com>; Thu, 29 Mar 2001 14:39:00 -0600 (CST)
Received: from dlep8.itg.ti.com (localhost [127.0.0.1])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id OAA03927
	for <linux-mips@oss.sgi.com>; Thu, 29 Mar 2001 14:39:00 -0600 (CST)
Received: from dlep3.itg.ti.com (dlep3-maint.itg.ti.com [157.170.133.16])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id OAA03885
	for <linux-mips@oss.sgi.com>; Thu, 29 Mar 2001 14:38:59 -0600 (CST)
Received: from ti.com (IDENT:bbrown@bbrowndt.sc.ti.com [158.218.100.126])
	by dlep3.itg.ti.com (8.9.3/8.9.3) with ESMTP id OAA19263
	for <linux-mips@oss.sgi.com>; Thu, 29 Mar 2001 14:38:58 -0600 (CST)
Message-ID: <3AC39EC4.BB1E24B8@ti.com>
Date: Thu, 29 Mar 2001 13:44:52 -0700
From: Brady Brown <bbrown@ti.com>
Organization: Texas Instruments
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: SGI news group <linux-mips@oss.sgi.com>
Subject: Tip build error
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I pulled the CVS tip yesterday and had problems building it for ATLAS because of
the changes to the set_cp0_config arguments. Patch below to
arch/mips/mm/mips32.c of how I fixed this. I think this is the intended new use?



--- mips32.c.orig       Thu Mar 29 13:29:29 2001
+++ mips32.c    Thu Mar 29 13:34:36 2001
@@ -1051,10 +1051,11 @@

        printk("CPU revision is: %08x\n", read_32bit_cp0_register(CP0_PRID));

+       clear_cp0_config(CONF_CM_CMASK);
 #ifdef CONFIG_MIPS_UNCACHED
-       set_cp0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
+       set_cp0_config(CONF_CM_UNCACHED);
 #else
-       set_cp0_config(CONF_CM_CMASK, CONF_CM_CACHABLE_NONCOHERENT);
+       set_cp0_config(CONF_CM_CACHABLE_NONCOHERENT);
 #endif

        probe_icache(config);

--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Brady Brown (bbrown@ti.com)       Work:(801)619-6103
Texas Instruments: Broadband Access Group
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Feb 2003 12:30:33 +0000 (GMT)
Received: from r-bu.iij4u.or.jp ([IPv6:::ffff:210.130.0.89]:1016 "EHLO
	r-bu.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225193AbTBJMac>;
	Mon, 10 Feb 2003 12:30:32 +0000
Received: from pudding.montavista.co.jp (gatekeeper.montavista.co.jp [202.232.97.130])
	by r-bu.iij4u.or.jp (8.11.6+IIJ/8.11.6) with SMTP id h1ACUTN18391;
	Mon, 10 Feb 2003 21:30:29 +0900 (JST)
Date: Mon, 10 Feb 2003 21:24:57 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: ralf@linux-mips.org
Cc: yoichi_yuasa@montavista.co.jp, linux-mips@linux-mips.org
Subject: [patch] Keep Machine selection alphabetically sorted
Message-Id: <20030210212457.52128de1.yoichi_yuasa@montavista.co.jp>
Organization: MontaVista Software Japan, Inc.
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Mon__10_Feb_2003_21:24:57_+0900_0824d1a0"
Return-Path: <yoichi_yuasa@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@montavista.co.jp
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart_Mon__10_Feb_2003_21:24:57_+0900_0824d1a0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Ralf,

Machine selection is sorted alphabetically by this patch.
Would you apply this patch to CVS on linux_2_4 tag of ftp.linux-mips.org?

Best Regards,

Yoichi

--Multipart_Mon__10_Feb_2003_21:24:57_+0900_0824d1a0
Content-Type: text/plain;
 name="config-shared.in.diff"
Content-Disposition: attachment;
 filename="config-shared.in.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/config-shared.in linux/arch/mips/config-shared.in
--- linux.orig/arch/mips/config-shared.in	Mon Feb 10 12:26:33 2003
+++ linux/arch/mips/config-shared.in	Mon Feb 10 21:10:14 2003
@@ -30,74 +30,6 @@
 dep_bool 'Support for Alchemy PB1100 board' CONFIG_MIPS_PB1100 $CONFIG_MIPS32
 dep_bool 'Support for Alchemy PB1500 board' CONFIG_MIPS_PB1500 $CONFIG_MIPS32
 dep_bool 'Support for BAGET MIPS series (EXPERIMENTAL)' CONFIG_BAGET_MIPS $CONFIG_MIPS32 $CONFIG_EXPERIMENTAL
-bool 'Support for CASIO CASSIOPEIA E-10/15/55/65' CONFIG_CASIO_E55
-dep_bool 'Support for Cobalt Server (EXPERIMENTAL)' CONFIG_MIPS_COBALT $CONFIG_EXPERIMENTAL
-if [ "$CONFIG_MIPS32" = "y" ]; then
-   bool 'Support for DECstations' CONFIG_DECSTATION
-else
-   dep_bool 'Support for DECstations (EXPERIMENTAL)' CONFIG_DECSTATION $CONFIG_EXPERIMENTAL
-fi
-dep_bool 'Support for Galileo EV64120 Evaluation board (EXPERIMENTAL)' CONFIG_MIPS_EV64120 $CONFIG_EXPERIMENTAL
-if [ "$CONFIG_MIPS_EV64120" = "y" ]; then
-   bool '  Enable Second PCI (PCI1)' CONFIG_EVB_PCI1
-   choice '  Galileo Chip Clock' \
-	"75	CONFIG_SYSCLK_75 \
-	 83.3	CONFIG_SYSCLK_83 \
-	 100	CONFIG_SYSCLK_100" 83.3
-fi
-dep_bool 'Support for Galileo EV96100 Evaluation board (EXPERIMENTAL)' CONFIG_MIPS_EV96100 $CONFIG_EXPERIMENTAL
-bool 'Support for Globespan IVR board' CONFIG_MIPS_IVR
-bool 'Support for Hewlett Packard LaserJet board' CONFIG_HP_LASERJET
-bool 'Support for IBM WorkPad z50' CONFIG_IBM_WORKPAD
-bool 'Support for LASAT Networks platforms' CONFIG_LASAT
-if [ "$CONFIG_LASAT" = "y" ]; then
-   tristate '  PICVUE LCD display driver' CONFIG_PICVUE
-   dep_tristate '   PICVUE LCD display driver /proc interface' CONFIG_PICVUE_PROC $CONFIG_PICVUE
-   bool '  DS1603 RTC driver' CONFIG_DS1603
-   bool '  LASAT sysctl interface' CONFIG_LASAT_SYSCTL
-fi
-bool 'Support for ITE 8172G board' CONFIG_MIPS_ITE8172
-if [ "$CONFIG_MIPS_ITE8172" = "y" ]; then
-   bool '  Support for older IT8172 (Rev C)' CONFIG_IT8172_REVC
-fi
-bool 'Support for MIPS Atlas board' CONFIG_MIPS_ATLAS
-bool 'Support for MIPS Magnum 4000' CONFIG_MIPS_MAGNUM_4000
-bool 'Support for MIPS Malta board' CONFIG_MIPS_MALTA
-dep_bool 'Support for MIPS SEAD board (EXPERIMENTAL)' CONFIG_MIPS_SEAD $CONFIG_EXPERIMENTAL
-bool 'Support for Momentum Ocelot board' CONFIG_MOMENCO_OCELOT
-bool 'Support for Momentum Ocelot-G board' CONFIG_MOMENCO_OCELOT_G
-dep_bool 'Support for NEC DDB Vrc-5074 (EXPERIMENTAL)' CONFIG_DDB5074 $CONFIG_EXPERIMENTAL
-bool 'Support for NEC DDB Vrc-5476' CONFIG_DDB5476
-bool 'Support for NEC DDB Vrc-5477' CONFIG_DDB5477
-if [ "$CONFIG_DDB5477" = "y" ]; then
-   int '   bus frequency (in kHZ, 0 for auto-detect)' CONFIG_DDB5477_BUS_FREQUENCY 0
-fi
-bool 'Support for NEC Osprey board' CONFIG_NEC_OSPREY
-bool 'Support for NEC Eagle/Hawk board' CONFIG_NEC_EAGLE
-if [ "$CONFIG_NEC_EAGLE" = "y" ]; then
-   tristate '  NEC VRC4173 support' CONFIG_VRC4173
-fi
-bool 'Support for Olivetti M700-10' CONFIG_OLIVETTI_M700
-dep_bool 'Support for Philips Nino (EXPERIMENTAL)' CONFIG_NINO $CONFIG_MIPS32 $CONFIG_EXPERIMENTAL
-if [ "$CONFIG_NINO" = "y" ]; then
-   choice 'Nino Model Number' \
-	"Model-300/301/302/319			CONFIG_NINO_4MB \
-	 Model-200/210/312/320/325/350/390	CONFIG_NINO_8MB \
-	 Model-500/510				CONFIG_NINO_16MB" Model-200
-fi
-bool 'Support for SGI IP22 (Indy/Indigo2)' CONFIG_SGI_IP22
-dep_bool 'Support for SGI-IP27 (Origin200/2000)' CONFIG_SGI_IP27 $CONFIG_MIPS64
-if [ "$CONFIG_SGI_IP27" = "y" ]; then
-   bool '  IP27 N-Mode' CONFIG_SGI_SN0_N_MODE
-   bool '  Discontiguous Memory Support' CONFIG_DISCONTIGMEM
-   bool '  NUMA Support' CONFIG_NUMA
-   bool '  Mapped kernel support' CONFIG_MAPPED_KERNEL
-   bool '  Kernel text replication support' CONFIG_REPLICATE_KTEXT
-   bool '  Exception handler replication support' CONFIG_REPLICATE_EXHANDLERS
-   define_bool CONFIG_SMP_CAPABLE y
-   #bool '  IP27 XXL' CONFIG_SGI_SN0_XXL
-fi
-dep_bool 'Support for SGI-IP32 (O2) (EXPERIMENTAL)' CONFIG_SGI_IP32 $CONFIG_EXPERIMENTAL
 dep_bool 'Support for Broadcom BCM1xxx SOCs (EXPERIMENTAL)' CONFIG_SIBYTE_SB1xxx_SOC $CONFIG_EXPERIMENTAL
 if [ "$CONFIG_SIBYTE_SB1xxx_SOC" = "y" ]; then
    choice '   BCM1xxx SOC-based board' \
@@ -191,14 +123,82 @@
       fi
    fi
 fi
+dep_bool 'Support for CASIO CASSIOPEIA E-10/15/55/65' CONFIG_CASIO_E55 $CONFIG_MIPS32
+dep_bool 'Support for Cobalt Server (EXPERIMENTAL)' CONFIG_MIPS_COBALT $CONFIG_EXPERIMENTAL
+if [ "$CONFIG_MIPS32" = "y" ]; then
+   bool 'Support for DECstations' CONFIG_DECSTATION
+else
+   dep_bool 'Support for DECstations (EXPERIMENTAL)' CONFIG_DECSTATION $CONFIG_EXPERIMENTAL
+fi
+dep_bool 'Support for Galileo EV64120 Evaluation board (EXPERIMENTAL)' CONFIG_MIPS_EV64120 $CONFIG_EXPERIMENTAL
+if [ "$CONFIG_MIPS_EV64120" = "y" ]; then
+   bool '  Enable Second PCI (PCI1)' CONFIG_EVB_PCI1
+   choice '  Galileo Chip Clock' \
+	"75	CONFIG_SYSCLK_75 \
+	 83.3	CONFIG_SYSCLK_83 \
+	 100	CONFIG_SYSCLK_100" 83.3
+fi
+dep_bool 'Support for Galileo EV96100 Evaluation board (EXPERIMENTAL)' CONFIG_MIPS_EV96100 $CONFIG_EXPERIMENTAL
+bool 'Support for Globespan IVR board' CONFIG_MIPS_IVR
+bool 'Support for Hewlett Packard LaserJet board' CONFIG_HP_LASERJET
+dep_bool 'Support for IBM WorkPad z50' CONFIG_IBM_WORKPAD $CONFIG_MIPS32
+bool 'Support for ITE 8172G board' CONFIG_MIPS_ITE8172
+if [ "$CONFIG_MIPS_ITE8172" = "y" ]; then
+   bool '  Support for older IT8172 (Rev C)' CONFIG_IT8172_REVC
+fi
+bool 'Support for LASAT Networks platforms' CONFIG_LASAT
+if [ "$CONFIG_LASAT" = "y" ]; then
+   tristate '  PICVUE LCD display driver' CONFIG_PICVUE
+   dep_tristate '   PICVUE LCD display driver /proc interface' CONFIG_PICVUE_PROC $CONFIG_PICVUE
+   bool '  DS1603 RTC driver' CONFIG_DS1603
+   bool '  LASAT sysctl interface' CONFIG_LASAT_SYSCTL
+fi
+bool 'Support for MIPS Atlas board' CONFIG_MIPS_ATLAS
+bool 'Support for MIPS Magnum 4000' CONFIG_MIPS_MAGNUM_4000
+bool 'Support for MIPS Malta board' CONFIG_MIPS_MALTA
+dep_bool 'Support for MIPS SEAD board (EXPERIMENTAL)' CONFIG_MIPS_SEAD $CONFIG_EXPERIMENTAL
+bool 'Support for Momentum Ocelot board' CONFIG_MOMENCO_OCELOT
+bool 'Support for Momentum Ocelot-G board' CONFIG_MOMENCO_OCELOT_G
+dep_bool 'Support for NEC DDB Vrc-5074 (EXPERIMENTAL)' CONFIG_DDB5074 $CONFIG_EXPERIMENTAL
+bool 'Support for NEC DDB Vrc-5476' CONFIG_DDB5476
+bool 'Support for NEC DDB Vrc-5477' CONFIG_DDB5477
+if [ "$CONFIG_DDB5477" = "y" ]; then
+   int '   bus frequency (in kHZ, 0 for auto-detect)' CONFIG_DDB5477_BUS_FREQUENCY 0
+fi
+dep_bool 'Support for NEC Eagle/Hawk board' CONFIG_NEC_EAGLE $CONFIG_MIPS32
+if [ "$CONFIG_NEC_EAGLE" = "y" ]; then
+   tristate '  NEC VRC4173 support' CONFIG_VRC4173
+fi
+dep_bool 'Support for NEC Osprey board' CONFIG_NEC_OSPREY $CONFIG_MIPS32
+bool 'Support for Olivetti M700-10' CONFIG_OLIVETTI_M700
+dep_bool 'Support for Philips Nino (EXPERIMENTAL)' CONFIG_NINO $CONFIG_MIPS32 $CONFIG_EXPERIMENTAL
+if [ "$CONFIG_NINO" = "y" ]; then
+   choice 'Nino Model Number' \
+	"Model-300/301/302/319			CONFIG_NINO_4MB \
+	 Model-200/210/312/320/325/350/390	CONFIG_NINO_8MB \
+	 Model-500/510				CONFIG_NINO_16MB" Model-200
+fi
+bool 'Support for SGI IP22 (Indy/Indigo2)' CONFIG_SGI_IP22
+dep_bool 'Support for SGI-IP27 (Origin200/2000)' CONFIG_SGI_IP27 $CONFIG_MIPS64
+if [ "$CONFIG_SGI_IP27" = "y" ]; then
+   bool '  IP27 N-Mode' CONFIG_SGI_SN0_N_MODE
+   bool '  Discontiguous Memory Support' CONFIG_DISCONTIGMEM
+   bool '  NUMA Support' CONFIG_NUMA
+   bool '  Mapped kernel support' CONFIG_MAPPED_KERNEL
+   bool '  Kernel text replication support' CONFIG_REPLICATE_KTEXT
+   bool '  Exception handler replication support' CONFIG_REPLICATE_EXHANDLERS
+   define_bool CONFIG_SMP_CAPABLE y
+   #bool '  IP27 XXL' CONFIG_SGI_SN0_XXL
+fi
+dep_bool 'Support for SGI-IP32 (O2) (EXPERIMENTAL)' CONFIG_SGI_IP32 $CONFIG_EXPERIMENTAL
 bool 'Support for SNI RM200 PCI' CONFIG_SNI_RM200_PCI
-bool 'Support for TANBAC TB0226 (Mbase)' CONFIG_TANBAC_TB0226
+dep_bool 'Support for TANBAC TB0226 (Mbase)' CONFIG_TANBAC_TB0226 $CONFIG_MIPS32
 dep_bool 'Support for Toshiba JMR-TX3927 board' CONFIG_TOSHIBA_JMR3927 $CONFIG_MIPS32
-bool 'Support for Victor MP-C303/304' CONFIG_VICTOR_MPC30X
+dep_bool 'Support for Victor MP-C303/304' CONFIG_VICTOR_MPC30X $CONFIG_MIPS32
 if [ "$CONFIG_VICTOR_MPC30X" = "y" ]; then
    tristate '  NEC VRC4173 support' CONFIG_VRC4173
 fi
-bool 'Support for ZAO Networks Capcella' CONFIG_ZAO_CAPCELLA
+dep_bool 'Support for ZAO Networks Capcella' CONFIG_ZAO_CAPCELLA $CONFIG_MIPS32
 
 dep_bool 'High Memory Support' CONFIG_HIGHMEM $CONFIG_MIPS32
 

--Multipart_Mon__10_Feb_2003_21:24:57_+0900_0824d1a0--

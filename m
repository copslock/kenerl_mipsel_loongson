Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Nov 2004 09:40:18 +0000 (GMT)
Received: from fw01.bwg.de ([IPv6:::ffff:213.69.156.2]:12708 "EHLO fw01.bwg.de")
	by linux-mips.org with ESMTP id <S8225267AbUKTJkO>;
	Sat, 20 Nov 2004 09:40:14 +0000
Received: from fw01.bwg.de (localhost [127.0.0.1])
	by fw01.bwg.de (8.11.6p2G/8.11.6) with ESMTP id iAK9eCR15962
	for <linux-mips@linux-mips.org>; Sat, 20 Nov 2004 10:40:12 +0100 (CET)
Received: (from localhost) by fw01.bwg.de (MSCAN) id 3/fw01.bwg.de/smtp-gw/mscan; Sat Nov 20 10:40:12 2004
From: =?iso-8859-1?Q?Ralf_R=F6sch?= <ralf.roesch@rw-gmbh.de>
To: <linux-mips@linux-mips.org>
Subject: [PATCH] Fix for Toshiba  tx4297.h 
Date: Sat, 20 Nov 2004 10:40:20 +0100
Message-ID: <NHBBLBCCGMJFJIKAMKLHEEHGCCAA.ralf.roesch@rw-gmbh.de>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0023_01C4CEED.5579E780"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Return-Path: <ralf.roesch@rw-gmbh.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf.roesch@rw-gmbh.de
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_0023_01C4CEED.5579E780
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

This patch fixes wrong address registers for the TX4927.
I have checked against the TMPR4927A data sheet and 
tested with some of the registers.

The patch included is against 2.6.
Could anyone review and apply please?

Thanks and regards
  Ralf Roesch


------=_NextPart_000_0023_01C4CEED.5579E780
Content-Type: application/octet-stream;
	name="tx4927.h-2004-11-18-rnw.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="tx4927.h-2004-11-18-rnw.patch"

Index: include/asm-mips/tx4927/tx4927.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvs/linux/include/asm-mips/tx4927/tx4927.h,v=0A=
retrieving revision 1.2=0A=
diff -u -r1.2 tx4927.h=0A=
--- include/asm-mips/tx4927/tx4927.h	11 Apr 2003 17:28:35 -0000	1.2=0A=
+++ include/asm-mips/tx4927/tx4927.h	18 Nov 2004 22:19:20 -0000=0A=
@@ -88,8 +88,8 @@=0A=
 =0A=
 =0A=
 /* TX4927 Configuration registers (64-bit registers) */=0A=
-#define TX4927_CONFIG_BASE                       0xe300=0A=
-#define TX4927_CONFIG_CCFG                       0xe300=0A=
+#define TX4927_CONFIG_BASE                       0xe000=0A=
+#define TX4927_CONFIG_CCFG                       0xe000=0A=
 #define TX4927_CONFIG_CCFG_RESERVED_42_63                BM_63_42=0A=
 #define TX4927_CONFIG_CCFG_WDRST                         BM_41_41=0A=
 #define TX4927_CONFIG_CCFG_WDREXEN                       BM_40_40=0A=
@@ -124,14 +124,14 @@=0A=
 #define TX4927_CONFIG_CCFG_ENDIAN                        BM_02_02=0A=
 #define TX4927_CONFIG_CCFG_ARMODE                        BM_01_01=0A=
 #define TX4927_CONFIG_CCFG_ACEHOLD                       BM_00_00=0A=
-#define TX4927_CONFIG_REVID                      0xe308 =0A=
+#define TX4927_CONFIG_REVID                      0xe008 =0A=
 #define TX4927_CONFIG_REVID_RESERVED_32_63               BM_32_63=0A=
 #define TX4927_CONFIG_REVID_PCODE                        BM_16_31=0A=
 #define TX4927_CONFIG_REVID_MJERREV                      BM_12_15=0A=
 #define TX4927_CONFIG_REVID_MINEREV                      BM_08_11=0A=
 #define TX4927_CONFIG_REVID_MJREV                        BM_04_07=0A=
 #define TX4927_CONFIG_REVID_MINREV                       BM_00_03=0A=
-#define TX4927_CONFIG_PCFG                       0xe310 =0A=
+#define TX4927_CONFIG_PCFG                       0xe010 =0A=
 #define TX4927_CONFIG_PCFG_RESERVED_57_63                BM_57_63=0A=
 #define TX4927_CONFIG_PCFG_DRVDATA                       BM_56_56=0A=
 #define TX4927_CONFIG_PCFG_DRVCB                         BM_55_55=0A=
@@ -197,10 +197,10 @@=0A=
 #define TX4927_CONFIG_PCFG_DMASEL0_SIO1                  BM_00_00=0A=
 #define TX4927_CONFIG_PCFG_DMASEL0_ACLC0                 BM_01_01=0A=
 #define TX4927_CONFIG_PCFG_DMASEL0_ACLC2                 BM_00_01=0A=
-#define TX4927_CONFIG_TOEA                       0xe318 =0A=
+#define TX4927_CONFIG_TOEA                       0xe018 =0A=
 #define TX4927_CONFIG_TOEA_RESERVED_36_63                BM_36_63=0A=
 #define TX4927_CONFIG_TOEA_TOEA                          BM_00_35=0A=
-#define TX4927_CONFIG_CLKCTR                     0xe320 =0A=
+#define TX4927_CONFIG_CLKCTR                     0xe020 =0A=
 #define TX4927_CONFIG_CLKCTR_RESERVED_26_63              BM_26_63=0A=
 #define TX4927_CONFIG_CLKCTR_ACLCKD                      BM_25_25=0A=
 #define TX4927_CONFIG_CLKCTR_PIOCKD                      BM_24_24=0A=
@@ -223,7 +223,7 @@=0A=
 #define TX4927_CONFIG_CLKCTR_TM2RST                      BM_02_02=0A=
 #define TX4927_CONFIG_CLKCTR_SIO0RST                     BM_01_01=0A=
 #define TX4927_CONFIG_CLKCTR_SIO1RST                     BM_00_00=0A=
-#define TX4927_CONFIG_GARBC                      0xe330 =0A=
+#define TX4927_CONFIG_GARBC                      0xe030 =0A=
 #define TX4927_CONFIG_GARBC_RESERVED_10_63               BM_10_63=0A=
 #define TX4927_CONFIG_GARBC_SET_09                       BM_09_09=0A=
 #define TX4927_CONFIG_GARBC_ARBMD                        BM_08_08=0A=
@@ -243,7 +243,7 @@=0A=
 #define TX4927_CONFIG_GARBC_PRIORITY_H3_PDMAC            BM_00_00=0A=
 #define TX4927_CONFIG_GARBC_PRIORITY_H3_DMAC             BM_01_01=0A=
 #define TX4927_CONFIG_GARBC_PRIORITY_H3_BAD_VALUE        BM_00_01=0A=
-#define TX4927_CONFIG_RAMP                       0xe348 =0A=
+#define TX4927_CONFIG_RAMP                       0xe048 =0A=
 #define TX4927_CONFIG_RAMP_RESERVED_20_63                BM_20_63=0A=
 #define TX4927_CONFIG_RAMP_RAMP                          BM_00_19=0A=
 #define TX4927_CONFIG_LIMIT                      0xefff=0A=
@@ -456,7 +456,7 @@=0A=
 #define TX4927_ACLC_ACINTSTS            0xf710=0A=
 #define TX4927_ACLC_ACINTMSTS           0xf714=0A=
 #define TX4927_ACLC_ACINTEN             0xf718=0A=
-#define TX4927_ACLC_ACINTDIS            0xfR71c=0A=
+#define TX4927_ACLC_ACINTDIS            0xf71c=0A=
 #define TX4927_ACLC_ACSEMAPH            0xf720=0A=
 #define TX4927_ACLC_ACGPIDAT            0xf740=0A=
 #define TX4927_ACLC_ACGPODAT            0xf744=0A=

------=_NextPart_000_0023_01C4CEED.5579E780--

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2005 21:37:29 +0000 (GMT)
Received: from port535.ds1-van.adsl.cybercity.dk ([IPv6:::ffff:217.157.140.228]:37994
	"EHLO valis.murphy.dk") by linux-mips.org with ESMTP
	id <S8225550AbVCQVg6>; Thu, 17 Mar 2005 21:36:58 +0000
Received: from brian.localnet (root@[10.0.0.2])
	by valis.murphy.dk (8.13.2/8.13.2/Debian-1) with ESMTP id j2HLancW028515;
	Thu, 17 Mar 2005 22:36:49 +0100
Received: from brian.localnet (brm@localhost [127.0.0.1])
	by brian.localnet (8.12.11/8.12.11/Debian-5) with ESMTP id j2HLanHd006214;
	Thu, 17 Mar 2005 22:36:49 +0100
Received: (from brm@localhost)
	by brian.localnet (8.12.11/8.12.11/Debian-5) id j2HLanro006213;
	Thu, 17 Mar 2005 22:36:49 +0100
Date:	Thu, 17 Mar 2005 22:36:49 +0100
From:	Brian Murphy <brm@murphy.dk>
Message-Id: <200503172136.j2HLanro006213@brian.localnet>
To:	ralf@linux-mips.org
Subject: [PATCH 2.6] Lasat pci assignment fixup (pci-lasat.c) (dependant on previous cleanup patch)
Cc:	linux-mips@linux-mips.org
Return-Path: <brm@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brm@murphy.dk
Precedence: bulk
X-list: linux-mips

Hi Ralf,
	this fixes Lasat pci to work with multi-function devices by
assigning the correct values based on pin number (instead of ignoring
them). And this is of course the real reason for the patches.

Please apply.

/Brian

--- pci-lasat.c	2005-03-17 22:20:56.000000000 +0100
+++ arch/mips/pci/pci-lasat.c	2005-03-17 22:21:21.000000000 +0100
@@ -64,11 +64,9 @@
 {
 	switch (slot) {
 	case 1:
-		return LASATINT_PCIA;
 	case 2:
-		return LASATINT_PCIB;
 	case 3:
-		return LASATINT_PCIC;
+		return LASATINT_PCIA + (((slot-1) + (pin-1)) % 4);
 	case 4:
 		return LASATINT_ETH1;   /* Ethernet 1 (LAN 2) */
 	case 5:

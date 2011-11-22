Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2011 00:15:29 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:47746 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903832Ab1KVXO6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Nov 2011 00:14:58 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 2E88A140584;
        Wed, 23 Nov 2011 00:14:53 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RsJUtGTSP6Mv; Wed, 23 Nov 2011 00:14:51 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 85F9714057D;
        Wed, 23 Nov 2011 00:14:51 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        =?UTF-8?q?Ren=C3=A9=20Bolldorf?= <xsecute@googlemail.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 02/12] MIPS: ath79: fix broken ar724x_pci_{read,write} functions
Date:   Wed, 23 Nov 2011 00:14:20 +0100
Message-Id: <1322003670-8797-3-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1322003670-8797-1-git-send-email-juhosg@openwrt.org>
References: <1322003670-8797-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 31933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19225

The current ar724x_pci_{read,write} functions are
broken. Due to that, pci_read_config_byte returns
with bogus values, and pci_write_config_{byte,word}
unconditionally clears the accessed PCI configuration
registers instead of changing the value of them.

The patch fixes the broken functions, thus the PCI
configuration space can be accessed correctly.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
Output of 'lspci -vv' without the patch:

00:00.0 Network controller: Atheros Communications Inc. AR9285 Wireless
Network Adapter (PCI-Express) (rev 01)
        Subsystem: Atheros Communications Inc. Device a091
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 10000000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA PME(D0+,D1+,D2-,D3hot+,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [60] Express (v2) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM unknown, Latency L0 <512ns, L1 <64us
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB

Output of 'lspci -vv' with the patch:

00:00.0 Network controller: Atheros Communications Inc. AR9285 Wireless
Network Adapter (PCI-Express) (rev 01)
        Subsystem: Atheros Communications Inc. Device a091
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 48
        Region 0: Memory at 10000000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA PME(D0+,D1+,D2-,D3hot+,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [60] Express (v2) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM unknown, Latency L0 <512ns, L1 <64us
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
        Capabilities: [140 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending- InProgress-
        Capabilities: [160 v1] Device Serial Number 00-15-17-ff-ff-24-14-12
        Capabilities: [170 v1] Power Budgeting <?>
---
 arch/mips/pci/pci-ar724x.c |   52 ++++++++++++++++++++++----------------------
 1 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
index 342bf4a..bb4f216 100644
--- a/arch/mips/pci/pci-ar724x.c
+++ b/arch/mips/pci/pci-ar724x.c
@@ -22,8 +22,9 @@ static void __iomem *ar724x_pci_devcfg_base;
 static int ar724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
 			    int size, uint32_t *value)
 {
-	unsigned long flags, addr, tval, mask;
+	unsigned long flags;
 	void __iomem *base;
+	u32 data;
 
 	if (devfn)
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -31,24 +32,22 @@ static int ar724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
 	base = ar724x_pci_devcfg_base;
 
 	spin_lock_irqsave(&ar724x_pci_lock, flags);
+	data = __raw_readl(base + (where & ~3));
 
 	switch (size) {
 	case 1:
-		addr = where & ~3;
-		mask = 0xff000000 >> ((where % 4) * 8);
-		tval = __raw_readl(base + addr);
-		tval = tval & ~mask;
-		*value = (tval >> ((4 - (where % 4))*8));
+		if (where & 1)
+			data >>= 8;
+		if (where & 2)
+			data >>= 16;
+		data &= 0xff;
 		break;
 	case 2:
-		addr = where & ~3;
-		mask = 0xffff0000 >> ((where % 4)*8);
-		tval = __raw_readl(base + addr);
-		tval = tval & ~mask;
-		*value = (tval >> ((4 - (where % 4))*8));
+		if (where & 2)
+			data >>= 16;
+		data &= 0xffff;
 		break;
 	case 4:
-		*value = __raw_readl(base + where);
 		break;
 	default:
 		spin_unlock_irqrestore(&ar724x_pci_lock, flags);
@@ -57,6 +56,7 @@ static int ar724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
 	}
 
 	spin_unlock_irqrestore(&ar724x_pci_lock, flags);
+	*value = data;
 
 	return PCIBIOS_SUCCESSFUL;
 }
@@ -64,8 +64,10 @@ static int ar724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
 static int ar724x_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 			     int size, uint32_t value)
 {
-	unsigned long flags, tval, addr, mask;
+	unsigned long flags;
 	void __iomem *base;
+	u32 data;
+	int s;
 
 	if (devfn)
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -73,26 +75,21 @@ static int ar724x_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 	base = ar724x_pci_devcfg_base;
 
 	spin_lock_irqsave(&ar724x_pci_lock, flags);
+	data = __raw_readl(base + (where & ~3));
 
 	switch (size) {
 	case 1:
-		addr = where & ~3;
-		mask = 0xff000000 >> ((where % 4)*8);
-		tval = __raw_readl(base + addr);
-		tval = tval & ~mask;
-		tval |= (value << ((4 - (where % 4))*8)) & mask;
-		__raw_writel(tval, base + addr);
+		s = ((where & 3) * 8);
+		data &= ~(0xff << s);
+		data |= ((value & 0xff) << s);
 		break;
 	case 2:
-		addr = where & ~3;
-		mask = 0xffff0000 >> ((where % 4)*8);
-		tval = __raw_readl(base + addr);
-		tval = tval & ~mask;
-		tval |= (value << ((4 - (where % 4))*8)) & mask;
-		__raw_writel(tval, base + addr);
+		s = ((where & 2) * 8);
+		data &= ~(0xffff << s);
+		data |= ((value & 0xffff) << s);
 		break;
 	case 4:
-		__raw_writel(value, (base + where));
+		data = value;
 		break;
 	default:
 		spin_unlock_irqrestore(&ar724x_pci_lock, flags);
@@ -100,6 +97,9 @@ static int ar724x_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
 
+	__raw_writel(data, base + (where & ~3));
+	/* flush write */
+	__raw_readl(base + (where & ~3));
 	spin_unlock_irqrestore(&ar724x_pci_lock, flags);
 
 	return PCIBIOS_SUCCESSFUL;
-- 
1.7.2.1

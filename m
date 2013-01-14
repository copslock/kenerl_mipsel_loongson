Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2013 17:09:53 +0100 (CET)
Received: from mms1.broadcom.com ([216.31.210.17]:4921 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831938Ab3ANQJsHnmzF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Jan 2013 17:09:48 +0100
Received: from [10.9.200.133] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 14 Jan 2013 08:07:36 -0800
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Mon, 14 Jan 2013 08:09:21 -0800
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id C7ECE40FE7; Mon, 14
 Jan 2013 08:09:30 -0800 (PST)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 03/10] MIPS: PCI: Byteswap not needed in little-endian
 mode
Date:   Mon, 14 Jan 2013 21:41:55 +0530
Message-ID: <1358179922-26663-4-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1358179922-26663-1-git-send-email-jchandra@broadcom.com>
References: <1358179922-26663-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7CEAF2C21ZS6640570-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Wrap the xlp_enable_pci_bswap() function and its call with
'#ifdef __BIG_ENDIAN'. On Netlogic XLP, the PCIe initialization code
to setup to byteswap is needed only in big-endian mode.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/pci/pci-xlp.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/pci/pci-xlp.c b/arch/mips/pci/pci-xlp.c
index 140557a..fe435fc 100644
--- a/arch/mips/pci/pci-xlp.c
+++ b/arch/mips/pci/pci-xlp.c
@@ -191,6 +191,7 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 	return 0;
 }
 
+#ifdef __BIG_ENDIAN
 static int xlp_enable_pci_bswap(void)
 {
 	uint64_t pciebase, sysbase;
@@ -224,6 +225,7 @@ static int xlp_enable_pci_bswap(void)
 	}
 	return 0;
 }
+#endif
 
 static int __init pcibios_init(void)
 {
@@ -235,7 +237,9 @@ static int __init pcibios_init(void)
 	ioport_resource.start =  0;
 	ioport_resource.end   = ~0;
 
+#ifdef __BIG_ENDIAN
 	xlp_enable_pci_bswap();
+#endif
 	set_io_port_base(CKSEG1);
 	nlm_pci_controller.io_map_base = CKSEG1;
 
-- 
1.7.9.5

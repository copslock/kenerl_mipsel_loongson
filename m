Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Dec 2004 13:27:03 +0000 (GMT)
Received: from mo01.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:51147 "EHLO
	mo01.iij4u.or.jp") by linux-mips.org with ESMTP id <S8224933AbULKN05>;
	Sat, 11 Dec 2004 13:26:57 +0000
Received: MO(mo01)id iBBDQsem020077; Sat, 11 Dec 2004 22:26:54 +0900 (JST)
Received: MDO(mdo01) id iBBDQrAP004057; Sat, 11 Dec 2004 22:26:53 +0900 (JST)
Received: 4UMRO00 id iBBDQq21005847; Sat, 11 Dec 2004 22:26:52 +0900 (JST)
	from stratos (localhost [127.0.0.1]) (authenticated)
Date: Sat, 11 Dec 2004 22:26:49 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6.10-rc3] fixed pci_ids.h
Message-Id: <20041211222649.13895ef3.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

Some PCI IDs are defined doubly.
Please apply this patch.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/include/linux/pci_ids.h a/include/linux/pci_ids.h
--- a-orig/include/linux/pci_ids.h	Sun Dec  5 21:25:04 2004
+++ a/include/linux/pci_ids.h	Sat Dec 11 22:11:59 2004
@@ -1452,11 +1452,6 @@
 #define PCI_DEVICE_ID_TOSHIBA_TC35815CF	0x0030
 #define PCI_DEVICE_ID_TOSHIBA_TX4927	0x0180
 
-#define PCI_VENDOR_ID_TOSHIBA_2		0x102f
-#define PCI_DEVICE_ID_TOSHIBA_TX3927	0x000a
-#define PCI_DEVICE_ID_TOSHIBA_TC35815CF	0x0030
-#define PCI_DEVICE_ID_TOSHIBA_TX4927	0x0180
-
 #define PCI_VENDOR_ID_RICOH		0x1180
 #define PCI_DEVICE_ID_RICOH_RL5C465	0x0465
 #define PCI_DEVICE_ID_RICOH_RL5C466	0x0466

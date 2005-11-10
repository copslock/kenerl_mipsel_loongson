Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2005 13:41:32 +0000 (GMT)
Received: from mo01.iij4u.or.jp ([210.130.0.20]:37342 "EHLO mo01.iij4u.or.jp")
	by ftp.linux-mips.org with ESMTP id S3457885AbVKJNlN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 10 Nov 2005 13:41:13 +0000
Received: MO(mo01)id jAADgd0f005664; Thu, 10 Nov 2005 22:42:39 +0900 (JST)
Received: MDO(mdo00) id jAADgctM002449; Thu, 10 Nov 2005 22:42:39 +0900 (JST)
Received: from stratos (h057.p117.iij4u.or.jp [210.130.117.57])
	by mbox.iij4u.or.jp (4U-MR/mbox01) id jAADgbwi000760
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Thu, 10 Nov 2005 22:42:38 +0900 (JST)
Date:	Thu, 10 Nov 2005 22:42:36 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] add GT64111 PCI ID
Message-Id: <20051110224236.68937a9a.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

Cobalt needs GT641111 PCI ID.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -Npru -X dontdiff a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	2005-11-10 22:02:04.000000000 +0900
+++ b/include/linux/pci_ids.h	2005-11-10 22:11:51.000000000 +0900
@@ -1393,6 +1393,7 @@
 #define PCI_SUBDEVICE_ID_KEYSPAN_SX2	0x5334
 
 #define PCI_VENDOR_ID_MARVELL		0x11ab
+#define PCI_DEVICE_ID_MARVELL_GT64111	0x4146
 #define PCI_DEVICE_ID_MARVELL_GT64260	0x6430
 #define PCI_DEVICE_ID_MARVELL_MV64360	0x6460
 #define PCI_DEVICE_ID_MARVELL_MV64460	0x6480

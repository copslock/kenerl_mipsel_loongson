Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2003 20:01:35 +0000 (GMT)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:61082 "EHLO
	powerpuff.evo1.pas.lab") by linux-mips.org with ESMTP
	id <S8225346AbTKQUBX>; Mon, 17 Nov 2003 20:01:23 +0000
Received: from powerpuff.evo1.pas.lab (localhost.localdomain [127.0.0.1])
	by powerpuff.evo1.pas.lab (8.12.8/8.12.8) with ESMTP id hAHK1Kcg016682
	for <linux-mips@linux-mips.org>; Mon, 17 Nov 2003 12:01:20 -0800
Received: (from baitisj@localhost)
	by powerpuff.evo1.pas.lab (8.12.8/8.12.8/Submit) id hAHK1JoV016678
	for linux-mips@linux-mips.org; Mon, 17 Nov 2003 12:01:19 -0800
X-Authentication-Warning: powerpuff.evo1.pas.lab: baitisj set sender to baitisj@evolution.com using -f
Subject: Patch against drivers/ide/pci/it8172.c branch linux_2_4
From: Jeffrey Baitis <baitisj@evolution.com>
Reply-To: baitisj@evolution.com
To: linux-mips@linux-mips.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1069099279.1830.109.camel@powerpuff.evo1.pas.lab>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Nov 2003 12:01:19 -0800
Return-Path: <baitisj@evolution.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

Here's a patch to make this compile...
-Jeff


Index: drivers/ide/pci/it8172.c
===================================================================
RCS file: /home/cvs/linux/drivers/ide/pci/it8172.c,v
retrieving revision 1.4.2.2
diff -u -r1.4.2.2 it8172.c
--- drivers/ide/pci/it8172.c    5 Jul 2003 03:23:36 -0000       1.4.2.2
+++ drivers/ide/pci/it8172.c    17 Nov 2003 19:58:32 -0000
@@ -57,7 +57,7 @@
 {
        ide_hwif_t *hwif        = HWIF(drive);
        struct pci_dev *dev     = hwif->pci_dev;
-       int is_slave            = (hwif->drives[1] == drive);
+       int is_slave            = (&HWIF(drive)->drives[1] == drive);
        unsigned long flags;
        u16 drive_enables;
        u32 drive_timing;
@@ -95,7 +95,7 @@
        }
 
        pci_write_config_word(dev, 0x40, drive_enables);
-       spin_unlock_irqrestore(&ide_lock, flags)
+       spin_unlock_irqrestore(&ide_lock, flags);
 }



-- 
Jeffrey Baitis <baitisj@evolution.com>

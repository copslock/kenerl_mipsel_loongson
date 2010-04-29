Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Apr 2010 11:57:50 +0200 (CEST)
Received: from mx1.moondrake.net ([212.85.150.166]:41337 "EHLO
        mx1.mandriva.com" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S1492407Ab0D2J4z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Apr 2010 11:56:55 +0200
Received: by mx1.mandriva.com (Postfix, from userid 501)
        id 8610427C005; Thu, 29 Apr 2010 11:56:54 +0200 (CEST)
Received: from office-abk.mandriva.com (unknown [195.7.104.248])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.mandriva.com (Postfix) with ESMTP id 8E1EF274012
        for <linux-mips@linux-mips.org>; Thu, 29 Apr 2010 11:56:53 +0200 (CEST)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
        by office-abk.mandriva.com (Postfix) with ESMTP id C132184250
        for <linux-mips@linux-mips.org>; Thu, 29 Apr 2010 12:14:34 +0200 (CEST)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
        by anduin.mandriva.com (Postfix) with ESMTP id 04405FF855
        for <linux-mips@linux-mips.org>; Thu, 29 Apr 2010 11:58:47 +0200 (CEST)
From:   Arnaud Patard <apatard@mandriva.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH] arch/mips/loongson/common/mem.c: fix find_vga_mem_init()
Organization: Mandriva
Date:   Thu, 29 Apr 2010 11:58:47 +0200
Message-ID: <m3wrvqwpew.fsf@anduin.mandriva.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

--=-=-=


This patchis patch allows to use all display device for instance
DISPLAY_OTHER like SM501.

From: Richard LIU <richard.liu@st.com>
Signed-off-by: Arnaud Patard <apatard@mandriva.com>
---

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline;
 filename=GB49_tlb_uncached_for_all_display_pci_devices.patch

---
 arch/mips/loongson/common/mem.c |    2 	1 +	1 -	0 !
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/arch/mips/loongson/common/mem.c
===================================================================
--- linux-2.6.orig/arch/mips/loongson/common/mem.c
+++ linux-2.6/arch/mips/loongson/common/mem.c
@@ -96,7 +96,7 @@ static int __init find_vga_mem_init(void
 		return 0;
 
 	for_each_pci_dev(dev) {
-		if ((dev->class >> 8) == PCI_CLASS_DISPLAY_VGA) {
+		if ((dev->class >> 16) == PCI_BASE_CLASS_DISPLAY) {
 			for (idx = 0; idx < PCI_NUM_RESOURCES; idx++) {
 				r = &dev->resource[idx];
 				if (!r->start && r->end)

--=-=-=--

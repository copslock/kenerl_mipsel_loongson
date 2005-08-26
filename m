Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2005 16:13:24 +0100 (BST)
Received: from clock-tower.bc.nu ([IPv6:::ffff:81.2.110.250]:48055 "EHLO
	lxorguk.ukuu.org.uk") by linux-mips.org with ESMTP
	id <S8224974AbVHZPNG>; Fri, 26 Aug 2005 16:13:06 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.4/8.13.4) with ESMTP id j7QFlX6Q007340;
	Fri, 26 Aug 2005 16:47:34 +0100
Received: (from alan@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id j7QFlXad007339;
	Fri, 26 Aug 2005 16:47:33 +0100
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: RE: custom ide driver causes "Badness in smp_call_function"
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Bryan Althouse <bryan.althouse@3phoenix.com>
Cc:	linux-mips@linux-mips.org, "'Ralf Baechle'" <ralf@linux-mips.org>
In-Reply-To: <20050826145303Z8224974-3678+7581@linux-mips.org>
References: <20050826145303Z8224974-3678+7581@linux-mips.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Fri, 26 Aug 2005 16:47:24 +0100
Message-Id: <1125071244.7298.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Gwe, 2005-08-26 at 10:58 -0400, Bryan Althouse wrote: 
> Ralf,
> 
> The patch doesn't seem to make any difference. :(

Assuming your hardware is sane another approach might be to force
drive->unmask = 1. That will mean that PIO mode is running with
interrupts enabled which should avoid the problem.

Add a .fixup handler to your driver (assuming you are using a recent
2.6.x) and in the handler do something like this:

+void ide_unmask_interrupts(ide_hwif_t *hwif)
+{
+       int i;
+       for (i = 0; i < 2; i++) {
+               ide_drive_t *drive = &hwif->drives[i];
+               if(drive->present)
+                       drive->unmask = 1;
+       }
+}

hopefully that will be early enough.

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2005 19:12:20 +0100 (BST)
Received: from laf31-5-82-235-130-100.fbx.proxad.net ([IPv6:::ffff:82.235.130.100]:23548
	"EHLO lexbox.fr") by linux-mips.org with ESMTP id <S8224984AbVHZSMB>;
	Fri, 26 Aug 2005 19:12:01 +0100
Received: from mail pickup service by lexbox.fr with Microsoft SMTPSVC;
	 Fri, 26 Aug 2005 20:16:10 +0200
From:	"Bryan Althouse" <bryan.althouse@3phoenix.com>
Cc:	<linux-mips@linux-mips.org>
Subject: RE: custom ide driver causes "Badness in smp_call_function"
Message-ID: <000501c5aa6a$3beadc30$0300a8c0@intra.lexbox.org>
Date:	Fri, 26 Aug 2005 20:16:09 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
thread-index: AcWqUXV7nhNPHZleS2iU5erhy9yRrQAFfx5g
In-Reply-To: <1125071244.7298.2.camel@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.181
To:	<unlisted-recipients:>,
	<no To-header on input>,
	"IMB Recipient 1" <mspop3connector.david.sanchez@lexbox.fr>
X-archive-position: 8827
X-ecartis-version: Ecartis v1.0.0
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
X-original-sender: bryan.althouse@3phoenix.com
Precedence: bulk
X-list:	linux-mips
X-OriginalArrivalTime: 26 Aug 2005 18:16:10.0343 (UTC) FILETIME=[3C372770:01C5AA6A]
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bryan.althouse@3phoenix.com
Precedence: bulk
X-list: linux-mips

Alan,

Thanks for your suggestion.
I'm not sure how to write a .fixup handler.  I did some Googling, but got
nowhere.  I looked through drivers/ide to see what drive->unmask was doing.
I found this in ide-io.c:
     if (drive->unmask)
          local_irq_enable();
And this in ide-taskfile.c:
     if (!drive->unmask)
          local_irq_disable();
I modified both of these files so that execution would be as if unmask = 1.
This resulted in no change of behavior.

Bryan  

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
Sent: Friday, August 26, 2005 11:47 AM
To: Bryan Althouse
Cc: linux-mips@linux-mips.org; 'Ralf Baechle'
Subject: RE: custom ide driver causes "Badness in smp_call_function"

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

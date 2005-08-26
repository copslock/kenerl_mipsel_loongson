Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2005 19:00:26 +0100 (BST)
Received: from rwcrmhc11.comcast.net ([IPv6:::ffff:204.127.198.35]:30854 "EHLO
	rwcrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8224984AbVHZSAI>; Fri, 26 Aug 2005 19:00:08 +0100
Received: from ba3pi (pcp0010731669pcs.howard01.md.comcast.net[69.243.71.130])
          by comcast.net (rwcrmhc11) with SMTP
          id <200508261805440130060joce>; Fri, 26 Aug 2005 18:05:44 +0000
From:	"Bryan Althouse" <bryan.althouse@3phoenix.com>
Cc:	<linux-mips@linux-mips.org>
Subject: RE: custom ide driver causes "Badness in smp_call_function"
Date:	Fri, 26 Aug 2005 14:05:43 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWqUXV7nhNPHZleS2iU5erhy9yRrQAFfx5g
In-Reply-To: <1125071244.7298.2.camel@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Message-Id: <20050826180008Z8224984-3678+7604@linux-mips.org>
To:	unlisted-recipients:; (no To-header on input)
Return-Path: <bryan.althouse@3phoenix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8827
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

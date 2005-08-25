Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Aug 2005 22:12:33 +0100 (BST)
Received: from rwcrmhc12.comcast.net ([IPv6:::ffff:204.127.198.43]:14753 "EHLO
	rwcrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8225471AbVHYVMS>; Thu, 25 Aug 2005 22:12:18 +0100
Received: from ba3pi (pcp0010731669pcs.howard01.md.comcast.net[69.243.71.130])
          by comcast.net (rwcrmhc12) with SMTP
          id <2005082521174901400kkekge>; Thu, 25 Aug 2005 21:17:50 +0000
From:	"Bryan Althouse" <bryan.althouse@3phoenix.com>
To:	"'Ralf Baechle'" <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
Subject: RE: custom ide driver causes "Badness in smp_call_function"
Date:	Thu, 25 Aug 2005 17:17:48 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWpi6yG5OnXfWlpRq2rlFKyrGwD5AALSfIg
In-Reply-To: <20050825154249.GC2731@linux-mips.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Message-Id: <20050825211218Z8225471-3678+7505@linux-mips.org>
Return-Path: <bryan.althouse@3phoenix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bryan.althouse@3phoenix.com
Precedence: bulk
X-list: linux-mips


Here are some observations...  

If I change the line "hwif->irq = 0" in my driver to "hwif->irq = 5", my SMP
kernel no longer experiences SMP badness.  Instead, I get many lines like
"hda: lost interrupt", and the drive is not usable.  If I compile the kernel
without SMP, the drive works properly as before.  I tried irq = 5 because I
noticed that /proc/interrupts indicated that ide0 was being probed at 5.
With the SMP kernel, /proc/interrupts shows a count of 0 for ide0.  My
non-SMP kernel shows a count that increments when the drive is being used
(as expected).

Bryan  

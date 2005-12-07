Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Dec 2005 21:49:47 +0000 (GMT)
Received: from mail.ivivity.com ([64.238.111.98]:53219 "EHLO thoth.ivivity.com")
	by ftp.linux-mips.org with ESMTP id S8133723AbVLGVt2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Dec 2005 21:49:28 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: pci_iomap issues?
Date:	Wed, 7 Dec 2005 16:49:09 -0500
Message-ID: <0F31272A2BCBBE4FA01344C6E69DBF501EAACE@thoth.ivivity.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: pci_iomap issues?
Thread-Index: AcX7Vj52JPN4FMGVTq69MT//Y0p1EAAIJlxQ
From:	"Marc Karasek" <marck@ivivity.com>
To:	"Scott Ashcroft" <scott.ashcroft@talk21.com>,
	"Mark Mason" <mason@broadcom.com>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <marck@ivivity.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marck@ivivity.com
Precedence: bulk
X-list: linux-mips

By multiple buses do you mean physical buses off of the CPU/companion chip or one PCI bus then a bridge chip then next PCI Bus, and so on..

If it is the latter, then the code should be able to automatically take care of it.  The boot code should have already scanned the bus and annotated all of the buses.  The basic procedure is to start at bus 0, find the first bridge, look past this bridge, find next one, until you find the last bridge.  At this point you backtrack and setup each bridge (primary, secondary #'s, etc.).  Thne you go out and do config cycles to find out what devices are available and map them into the address space.  When Linux comes up it should do something similar, minus the setup to find out how many buses it has, and then how many devices it has.  The difference would be if linux finds a device it just reads the BARs to find out where it is mapped.  

If it is the former, then this should be a chip specific operation where Linux would scan again but needs to know to scan on multiple interfaces/PCI buses. The boot code should also be aware of this situation and map things appropriately.    

Any content within this email is provided "AS IS" for informational purposes only. No contract will be formed between the parties by virtue of this email.
<**************************>
Marc Karasek
System Lead Technical Engineer
iVivity Inc.
PH: 678-990-1550 x238
Fax: 678-990-1551
<**************************>



-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Scott Ashcroft
Sent: Wednesday, December 07, 2005 12:46 PM
To: Mark Mason
Cc: Scott Ashcroft; linux-mips@linux-mips.org
Subject: Re: pci_iomap issues?



--- Mark Mason <mason@broadcom.com> wrote:
> 
> Any system based on BCM1480s could have multiple pci
> busses (one PCI-X
> directly, and additional busses through HT/PCI-X
> bridges).  For the
> BCM91480B board, we had to turn on PCI_DOMAINS to
> get this to work
> correctly.

I understand that there are machines with multiple PCI
busses out there but comparing the ppc64 code with the
proposed mips patches I don't see much difference.
Are the ppc64 people just breaking multiple PCI bus
machines, did something happen in the generic PCI code
which fixed the issue or is there just a difference I
can't see?

Cheers,
Scott

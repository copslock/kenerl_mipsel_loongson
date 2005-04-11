Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2005 21:30:45 +0100 (BST)
Received: from spartan.ac.BrockU.CA ([IPv6:::ffff:139.57.65.3]:14746 "EHLO
	spartan.ac.BrockU.CA") by linux-mips.org with ESMTP
	id <S8226144AbVDKUaa>; Mon, 11 Apr 2005 21:30:30 +0100
Received: from paul.dev.brocku.ca ([139.57.69.110])
	by spartan.ac.BrockU.CA (8.12.8/8.12.8) with ESMTP id j3BKUKgc031927
	for <linux-mips@linux-mips.org>; Mon, 11 Apr 2005 16:30:20 -0400
Subject: ip27 PCI devices
From:	Paul Chapman <paul.chapman@BrockU.CA>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Organization: Brock University
Date:	Mon, 11 Apr 2005 16:30:22 -0400
Message-Id: <1113251422.21580.33.camel@paul.dev.brocku.ca>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
Content-Transfer-Encoding: 7bit
Return-Path: <paul.chapman@BrockU.CA>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.chapman@BrockU.CA
Precedence: bulk
X-list: linux-mips

Hello,

I've been experimenting with trying various PCI cards I have lying
around in my Origin 200, to see if I can make any of them work.

So far, I've had no luck: all of them have resource collisions with the
IOC3 (presumably because of its address decoding).  They're detected
fine in /proc/pci.

So: has anyone had any luck with anything they've tried?  In particular,
I'm looking for an ethernet card that works (and is readily available),
since the performance of the IOC3 is pretty wretched.

Thanks,
Paul Chapman

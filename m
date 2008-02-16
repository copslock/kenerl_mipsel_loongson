Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Feb 2008 10:40:24 +0000 (GMT)
Received: from vs166246.vserver.de ([62.75.166.246]:19905 "EHLO
	vs166246.vserver.de") by ftp.linux-mips.org with ESMTP
	id S20033283AbYBPKkV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 16 Feb 2008 10:40:21 +0000
Received: from t5730.t.pppool.de ([89.55.87.48] helo=powermac.local)
	by vs166246.vserver.de with esmtpa (Exim 4.63)
	(envelope-from <mb@bu3sch.de>)
	id 1JQKSy-00038F-Cy; Sat, 16 Feb 2008 10:40:20 +0000
From:	Michael Buesch <mb@bu3sch.de>
To:	ralf@linux-mips.org
Subject: Linux MIPS PCI resource sanity check
Date:	Sat, 16 Feb 2008 11:39:10 +0100
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200802161139.10791.mb@bu3sch.de>
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

Hi,

There's a sanity check in pcibios_enable_resources() that looks like this:

	r = &dev->resource[idx];
	if (!r->start && r->end) {
		printk(KERN_ERR "PCI: Device %s not available because of resource collisions\n", pci_name(dev));
		return -EINVAL;
	}

What is this check actually doing? It triggers for me on a BCM4318 device
which is behind a BCM4710 PCI bridge.
r->start is 0 and r->end is 0x1FFF when this triggers.
If I simply comment out that check the device is detected correctly
and seems to initialize just fine.

-- 
Greetings Michael.

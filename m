Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3E8TI311119
	for linux-mips-outgoing; Sat, 14 Apr 2001 01:29:18 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3E8TGM11112
	for <linux-mips@oss.sgi.com>; Sat, 14 Apr 2001 01:29:16 -0700
Received: from ginger.sonytel.be (ginger.sonytel.be [10.34.16.6])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA19540
	for <linux-mips@oss.sgi.com>; Sat, 14 Apr 2001 10:29:01 +0200 (MET DST)
Received: (from tea@localhost)
	by ginger.sonytel.be (8.9.0/8.8.6) id KAA13622
	for linux-mips@oss.sgi.com; Sat, 14 Apr 2001 10:29:01 +0200 (MET DST)
Date: Sat, 14 Apr 2001 10:29:01 +0200
From: Tom Appermont <tea@sonycom.com>
To: linux-mips@oss.sgi.com
Subject: address translation with TLB
Message-ID: <20010414102901.A13595@ginger.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Howdy,

What are the things to do to use the TLB for access to otherwize
unreachable PCI memory or IO areas? I have used the function
add_wired_entry to add an entry to the TLB, modified the 
functions virt_to_phys, phys_to_virt, virt_to_bus, bus_to_virt,
and ioremap to do the translations I want , but I wonder if there
are other things to do to get this working. Even more so, because
none of the mips boards currently in the tree seem to need TLB
remapping.

Greetz,

Tom

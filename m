Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAP9OD500988
	for linux-mips-outgoing; Sun, 25 Nov 2001 01:24:13 -0800
Received: from holomorphy (mail@holomorphy.com [216.36.33.161])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAP9OBo00979
	for <linux-mips@oss.sgi.com>; Sun, 25 Nov 2001 01:24:11 -0800
Received: from wli by holomorphy with local (Exim 3.31 #1 (Debian))
	id 167uZt-0001vd-00
	for <linux-mips@oss.sgi.com>; Sun, 25 Nov 2001 00:23:53 -0800
Date: Sun, 25 Nov 2001 00:23:52 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-mips@oss.sgi.com
Subject: FPU interrupt handler
Message-ID: <20011125002352.G1048@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Organization: The Domain of Holomorphy
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

        EXPORT(dec_intr_fpu)
dec_intr_fpu:   PANIC("Unimplemented FPU interrupt handler")

I've not encountered this quite yet, but I have an R3K-based
DecStation up and running, and if I understand this properly,
R3K delivers FPU exceptions as interrupts. It looks like
this could take the machine down.


Maciej, I was asked to notify you specifically, but this is
my only known point of contact. If you could look into this,
I would be much obliged.


Thanks,
Bill

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Sep 2003 23:55:50 +0100 (BST)
Received: from www.piratehaven.org ([IPv6:::ffff:204.253.162.40]:9395 "EHLO
	skull.piratehaven.org") by linux-mips.org with ESMTP
	id <S8225545AbTIVWzs>; Mon, 22 Sep 2003 23:55:48 +0100
Received: by skull.piratehaven.org (Postfix, from userid 512)
	id DED4D101DF; Mon, 22 Sep 2003 22:55:42 +0000 (US/East)
Date: Mon, 22 Sep 2003 15:55:41 -0700
From: Brian Pomerantz <bapper@piratehaven.org>
To: linux-mips@linux-mips.org
Subject: virt_to_phys bug?
Message-ID: <20030922225541.GA10469@skull.piratehaven.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-homepage: http://www.piratehaven.org/~bapper/
Return-Path: <bapper@piratehaven.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bapper@piratehaven.org
Precedence: bulk
X-list: linux-mips

Maybe the wrong function is being used here, I'm not sure.  I ran into
a problem with using virt_to_phys.  The acacia driver for the IDT
rc32438 chip uses virt_to_phys to convert from a KSEG1 address to a
physical address.  Somehow this works on their 2.4.18 kernel but does
not in the 2.4.22 tree.  After changing virt_to_phys to this:

	return (unsigned long)address - KSEGX(address);

everything worked just fine.  I guess what I'm wondering is, is this
the correct way to get a physical address for use with DMA?  The note
in io.h above the function says no but fails to tell me what should be
used.  My guess is virt_to_bus is correct but they are identical
functions.  Since I didn't write this driver, I can only assume that
address for the rung descriptors are accessed via KSEG1 so that they
are uncached and don't require flushing after each access.  I had a
lot of dropped packets when I failed to access the ring descriptors
via KSEG1.


BAPper

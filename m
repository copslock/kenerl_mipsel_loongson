Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jun 2004 13:54:46 +0100 (BST)
Received: from hydrogen.boeventronie.net ([IPv6:::ffff:217.114.100.248]:28102
	"EHLO hydrogen.foonet") by linux-mips.org with ESMTP
	id <S8225242AbUFHMyl>; Tue, 8 Jun 2004 13:54:41 +0100
Received: from jorik by hydrogen.foonet with local (Exim 3.36 #1 (Debian))
	id 1BXg7h-0005Hk-00
	for <linux-mips@linux-mips.org>; Tue, 08 Jun 2004 14:54:37 +0200
Date: Tue, 8 Jun 2004 14:54:37 +0200
From: Jorik Jonker <linux-mips@boeventronie.net>
To: Linux MIPS <linux-mips@linux-mips.org>
Subject: VINO
Message-ID: <20040608125437.GC19965@hydrogen.boeventronie.net>
Mail-Followup-To: Linux MIPS <linux-mips@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <jorik@hydrogen.boeventronie.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@boeventronie.net
Precedence: bulk
X-list: linux-mips

Hi,

I have been playing around a bit with my Indycam, but it seems that some work
needs to be done to get a nice picture. I've read that it has something to do
with clipping and that the brightness control register is silently ignored. I
happen to have an IRIX installtion on my Indy as well, and I tried finding
out how to read the VINO registers from IRIX, but with no luck.
I suppose that there must be some kernel-space piece of code to read the GIO
(?) memory around adress 0x00080000, but I am not able to figure out how to
do this in IRIX. Perhaps someone (with al little bit more kernel-hacking
experience) could guide me a little bit on doing this?
Are there other people beside ladis who are attemping to enhance the VINO
driver in the linux kernel, and if so, what are your findings?
I would really like to contribute to VINO development, but it's quite opaque
matter to me, as the VINO spec is quite unclear and I am not certain what's
exactly going wrong in the VINO driver.

regards,
-- 
Jorik Jonker
http://boeventronie.net/

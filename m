Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Apr 2007 10:35:18 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:37133 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20023342AbXDZJfQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Apr 2007 10:35:16 +0100
Received: (qmail 26501 invoked by uid 1000); 26 Apr 2007 11:35:15 +0200
Date:	Thu, 26 Apr 2007 11:35:15 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: MIPS ioport_map and Au1xxx PCMCIA
Message-ID: <20070426093515.GA26434@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hello,

the file arch/mips/lib/iomap.c contains this define
#define PIO_MASK 0x0ffffUL

which prevents pata_pcmcia with the new devres stuff
from attaching to a CF card. (on my Au1200).
The ports-to-be-iomap()'ed are in the 0xc0000000 range
and the ioport_map() function rejects all attempts
of pata_pcmcia to devm_ioport_map() them.

What is this mask used for and can it be removed?

Thanks,

-- 
 Manuel Lauss

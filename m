Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2007 19:25:21 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:3845 "EHLO sorrow.cyrius.com")
	by ftp.linux-mips.org with ESMTP id S20023538AbXIYSZT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Sep 2007 19:25:19 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id F3CBCD8DD; Tue, 25 Sep 2007 18:25:12 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 25250540C4; Tue, 25 Sep 2007 20:24:54 +0200 (CEST)
Date:	Tue, 25 Sep 2007 20:24:54 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Cc:	Ricardo Mendoza <mendoza.ricardo@gmail.com>
Subject: IP32: serial console broken with current git
Message-ID: <20070925182453.GA15749@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

With current git (and 2.6.23-rc1), nothing shows up on the serial
console on IP32.  Ricardo Mendoza commented on this on IRC:

> I think it was that using iobase member in the plat_serial8250_port
> struct was not working, swapping to membase gave console messages
> but kind of stopped printing messages at some point (further in than
> first line of C tho)

He also sent me a patch to test.  With this patch, I get serial
console output - but only until:

| Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
| serial8250.0: ttyS0 at MMIO 0x0 (irq = 53) is a 16550A
| console [ttyS0] enabled

Maybe Ricardo can post his patch for comments and someone can look
into the second issue.
-- 
Martin Michlmayr
http://www.cyrius.com/

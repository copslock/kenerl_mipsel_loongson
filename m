Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2006 17:17:26 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:14549 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039425AbWH2QRY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Aug 2006 17:17:24 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k7TGHoPw018886;
	Tue, 29 Aug 2006 17:17:50 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k7TGHm5r018884;
	Tue, 29 Aug 2006 17:17:48 +0100
Date:	Tue, 29 Aug 2006 17:17:48 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
	linuxppc-embedded@ozlabs.org, paulkf@microgate.com,
	takata@linux-m32r.org, linux-kernel@vger.kernel.org
Subject: Re: [CFT:PATCH] Removing possible wrong asm/serial.h inclusions
Message-ID: <20060829161748.GF29289@linux-mips.org>
References: <20060828085244.GA13544@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060828085244.GA13544@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 28, 2006 at 09:52:44AM +0100, Russell King wrote:

> asm/serial.h is supposed to contain the definitions for the architecture
> specific 8250 ports for the 8250 driver.  It may also define BASE_BAUD,
> but this is the base baud for the architecture specific ports _only_.
> 
> Therefore, nothing other than the 8250 driver should be including this
> header file.  In order to move towards this goal, here is a patch which
> removes some of the more obvious incorrect includes of the file.
> 
> MIPS and PPC has rather a lot of stuff in asm/serial.h, some of it looks
> related to non-8250 ports.  Hence, it's not trivial to conclude that
> these includes are indeed unnecessary, so can mips and ppc people please
> test this patch carefully.

The MIPS bits were just unused leftovers from the days when the arch
code did did register serials & consoles.  So for the MIPS bits:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf

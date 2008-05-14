Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 May 2008 23:46:54 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:46323 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20032031AbYENWqw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 May 2008 23:46:52 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m4EMk7Zg018056;
	Thu, 15 May 2008 00:46:07 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m4EMk6GL018052;
	Wed, 14 May 2008 23:46:06 +0100
Date:	Wed, 14 May 2008 23:46:05 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ben Dooks <ben@fluff.org>
cc:	Jean Delvare <khali@linux-fr.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mips@linux-mips.org, i2c@lm-sensors.org,
	linux-kernel@vger.kernel.org
Subject: Re: [i2c] [PATCH] I2C: SiByte: Convert the driver to make use of
 interrupts
In-Reply-To: <20080514213841.GC16881@fluff.org.uk>
Message-ID: <Pine.LNX.4.55.0805142309190.15223@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0805130353250.535@cliff.in.clinika.pl>
 <20080514213841.GC16881@fluff.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 14 May 2008, Ben Dooks wrote:

> My recollection is that the return of ioremap() was meant to be
> used with read{b,w,l} and not their __raw_xxx() counterparts.

 Well, what would the definition of the cookie passed to these raw MMIO
access calls be then?

 They have to be used here, because SOC on-chip registers are accessed by
the driver and therefore data transferred must never be swapped in any
way.  The internal registers always have the same numerical value (bit
positions) regardless of the endianness configured when the SOC's on-chip
CPU cores are reset.

 For the external buses the arrangement varies, for example the PCI
interface is always little-endian and the Generic Bus is always
big-endian.  To access these, cooked MMIO calls would normally be used
(these without a prefix) which swap bytes as necessary to preserve bit
positions.  The notable exception are PIO-style data transfers, such as
ones used by some IDE drivers (including the GenBus one), where the
ultimate destination is system memory (which is endian-neutral) and thus
bit positions do not matter but addresses of individual bytes do --
__mem_xxx() calls have been defined for this purpose, which swap bytes as
necessary.  See include/asm-mips/mach-generic/mangle-port.h for details.

  Maciej

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Nov 2004 20:20:19 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:7696 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225308AbUK2UUN>; Mon, 29 Nov 2004 20:20:13 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 21490E1C92; Mon, 29 Nov 2004 21:20:07 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 11680-07; Mon, 29 Nov 2004 21:20:07 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id A66FBE1C6D; Mon, 29 Nov 2004 21:20:06 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iATKKLkx022629;
	Mon, 29 Nov 2004 21:20:22 +0100
Date: Mon, 29 Nov 2004 20:20:10 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Brad Larson <Brad_Larson@pmc-sierra.com>
Cc: "'Ralf Baechle'" <ralf@linux-mips.org>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	Manish Lachwani <mlachwani@mvista.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: RE: [PATCH] Synthesize TLB refill handler at runtime
In-Reply-To: <04781D450CFF604A9628C8107A62FCCF013DDA21@sjc1exm01.pmc_nt.nt.pmc-sierra.bc.ca>
Message-ID: <Pine.LNX.4.58L.0411292004320.27863@blysk.ds.pg.gda.pl>
References: <04781D450CFF604A9628C8107A62FCCF013DDA21@sjc1exm01.pmc_nt.nt.pmc-sierra.bc.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/605/Wed Nov 24 15:09:47 2004
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 29 Nov 2004, Brad Larson wrote:

> hmm, the original email left the impression that its desirable for the

 The impression was right -- of course as long as the firmware actually
has something useful to offer.

> firmware to be available after kernel handoff.  Looks like the current
> status is fine for those who need it.

 It depends on what you want to achieve.  For console output (early
printk) support, it's usually only needed till the real console driver is
registered, which is just a handful of lines to be printed.  For debugging
you may want to support console I/O via the firmware during a normal
system use, but then performance is not that important.  Other uses may
include calls to functions for access to firmware configuration, like
environment variables you'd otherwise access from the firmware's operator
interface, or fancy ways of doing a reboot.  These are not
performance-critical, either, so doing some sort of TLB reconfiguration
within the firmware for the duration of callbacks would be acceptable.

  Maciej

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Nov 2004 19:47:38 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:64018 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225304AbUK2TrY>; Mon, 29 Nov 2004 19:47:24 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id B073DF5990; Mon, 29 Nov 2004 20:47:17 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 17423-05; Mon, 29 Nov 2004 20:47:17 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 700EAE1C80; Mon, 29 Nov 2004 20:47:17 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iATJlSC6020170;
	Mon, 29 Nov 2004 20:47:32 +0100
Date: Mon, 29 Nov 2004 19:47:17 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Brad Larson <Brad_Larson@pmc-sierra.com>
Cc: "'Ralf Baechle'" <ralf@linux-mips.org>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	Manish Lachwani <mlachwani@mvista.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: RE: [PATCH] Synthesize TLB refill handler at runtime
In-Reply-To: <04781D450CFF604A9628C8107A62FCCF013DDA1C@sjc1exm01.pmc_nt.nt.pmc-sierra.bc.ca>
Message-ID: <Pine.LNX.4.58L.0411291924160.27863@blysk.ds.pg.gda.pl>
References: <04781D450CFF604A9628C8107A62FCCF013DDA1C@sjc1exm01.pmc_nt.nt.pmc-sierra.bc.ca>
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
X-archive-position: 6494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 29 Nov 2004, Brad Larson wrote:

> Real, not-demo, 32-bit systems are the majority and will typically put
> the io up at 4GB and let it grow down and have the memory grow up from
> zero.  There is a natural dividing line, minimal TLB usage, and
> straightforward access to the first 512MB of memory unmapped.  Which of
> course means moving the boot device at bfc00000 up high as well as
> getting things like discovery at b4000000 out of the way as well.

 So?

> So, for firmware callbacks to do printf the kernel would need to restore
> the mappings the firmware needed before handoff.  Also firmware usually

 If it needs to access anything beyond KSEG0/1 and XKPHYS is unavailable,
then setting up a single wired TLB entry, using a large page if hardware
is scattered (you can have 256MB pages, you know; if you don't implement
that and your largest page size does not cover the whole area, you can
switch mappings), upon entry and removing it upon exit is trivial and
should just work.  Firmware callbacks are not meant to be common -- the
performance loss from an invalidated TLB entry will be negligible; you can 
restore the original TLB entry, too.

> carves out some memory above 1MB for its drivers so either the firmware
> has to stop servicing drivers if the kernel stomps on this memory or the
> kernel needs to get the memory ranges available at handoff which I
> recall doing with netbsd since it accepted non-contiguous memory.

 Everything needed for that is already present (it's been there for a
couple of years already) -- just let Linux know in some way which areas of
RAM are available for general use and which ones are best left untouched.  
It's being done for other systems.  There is a dedicated "ROM data" tag
available for that even in addition to the generic "reserved" one.

  Maciej

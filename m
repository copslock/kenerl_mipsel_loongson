Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Nov 2004 19:58:01 +0000 (GMT)
Received: from father.pmc-sierra.com ([IPv6:::ffff:216.241.224.13]:46266 "HELO
	father.pmc-sierra.bc.ca") by linux-mips.org with SMTP
	id <S8225312AbUK2T54>; Mon, 29 Nov 2004 19:57:56 +0000
Received: (qmail 27966 invoked by uid 101); 29 Nov 2004 19:57:49 -0000
Received: from unknown (HELO ogmios.pmc-sierra.bc.ca) (216.241.226.59)
  by father.pmc-sierra.com with SMTP; 29 Nov 2004 19:57:49 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogmios.pmc-sierra.bc.ca (8.12.9/8.12.7) with ESMTP id iATJvhJv008935;
	Mon, 29 Nov 2004 11:57:49 -0800
Received: by bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <XDTAHNMT>; Mon, 29 Nov 2004 11:57:43 -0800
Message-ID: <04781D450CFF604A9628C8107A62FCCF013DDA21@sjc1exm01.pmc_nt.nt.pmc-sierra.bc.ca>
From: Brad Larson <Brad_Larson@pmc-sierra.com>
To: "'Maciej W. Rozycki'" <macro@linux-mips.org>
Cc: "'Ralf Baechle'" <ralf@linux-mips.org>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	Manish Lachwani <mlachwani@mvista.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: RE: [PATCH] Synthesize TLB refill handler at runtime
Date: Mon, 29 Nov 2004 11:57:39 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Brad_Larson@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Brad_Larson@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

hmm, the original email left the impression that its desirable for the firmware to be available after kernel handoff.  Looks like the current status is fine for those who need it.

--Brad

-----Original Message-----
From: macro@blysk.ds.pg.gda.pl [mailto:macro@blysk.ds.pg.gda.pl]On
Behalf Of Maciej W. Rozycki
Sent: Monday, November 29, 2004 11:47 AM
To: Brad Larson
Cc: 'Ralf Baechle'; Thiemo Seufer; Manish Lachwani; Geert Uytterhoeven;
Linux/MIPS Development
Subject: RE: [PATCH] Synthesize TLB refill handler at runtime


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

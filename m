Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Nov 2004 19:14:55 +0000 (GMT)
Received: from father.pmc-sierra.com ([IPv6:::ffff:216.241.224.13]:40363 "HELO
	father.pmc-sierra.bc.ca") by linux-mips.org with SMTP
	id <S8225302AbUK2TOt>; Mon, 29 Nov 2004 19:14:49 +0000
Received: (qmail 12021 invoked by uid 101); 29 Nov 2004 19:14:40 -0000
Received: from unknown (HELO ogyruan.pmc-sierra.bc.ca) (216.241.226.236)
  by father.pmc-sierra.com with SMTP; 29 Nov 2004 19:14:40 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogyruan.pmc-sierra.bc.ca (8.12.9/8.12.7) with ESMTP id iATJEIVi023158;
	Mon, 29 Nov 2004 11:14:21 -0800
Received: by bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <XDTAHMF4>; Mon, 29 Nov 2004 11:14:16 -0800
Message-ID: <04781D450CFF604A9628C8107A62FCCF013DDA1C@sjc1exm01.pmc_nt.nt.pmc-sierra.bc.ca>
From: Brad Larson <Brad_Larson@pmc-sierra.com>
To: "'Ralf Baechle'" <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	Manish Lachwani <mlachwani@mvista.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: RE: [PATCH] Synthesize TLB refill handler at runtime
Date: Mon, 29 Nov 2004 11:14:14 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Brad_Larson@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Brad_Larson@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Ralf Baechle
Sent: Wednesday, November 24, 2004 2:46 PM
To: Maciej W. Rozycki
Cc: Thiemo Seufer; Manish Lachwani; Geert Uytterhoeven; Linux/MIPS
Development
Subject: Re: [PATCH] Synthesize TLB refill handler at runtime


On Wed, Nov 24, 2004 at 10:39:56PM +0000, Maciej W. Rozycki wrote:

> > It's so easy to implement with serial console.  Best thing since sliced
> > bread :-)
> 
>  Yep, and some systems have an appropriate console output callback in the 
> firmware making it trivial.

Which unfortunately is becoming unusable fairly soon on many systems.
IP27: ARC is dead after the first TLB flush.  IP22: dead after the
external L2 controller was enabled etc.  On average I'm less than
pleased with firmware usability even for simple stuff such as printing ...

  Ralf


Real, not-demo, 32-bit systems are the majority and will typically put the io up at 4GB and let it grow down and have the memory grow up from zero.  There is a natural dividing line, minimal TLB usage, and straightforward access to the first 512MB of memory unmapped.  Which of course means moving the boot device at bfc00000 up high as well as getting things like discovery at b4000000 out of the way as well.

So, for firmware callbacks to do printf the kernel would need to restore the mappings the firmware needed before handoff.  Also firmware usually carves out some memory above 1MB for its drivers so either the firmware has to stop servicing drivers if the kernel stomps on this memory or the kernel needs to get the memory ranges available at handoff which I recall doing with netbsd since it accepted non-contiguous memory.

--Brad

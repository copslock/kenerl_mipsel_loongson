Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2005 21:23:42 +0000 (GMT)
Received: from mother.pmc-sierra.com ([IPv6:::ffff:216.241.224.12]:52728 "HELO
	mother.pmc-sierra.bc.ca") by linux-mips.org with SMTP
	id <S8225400AbVAXVXY>; Mon, 24 Jan 2005 21:23:24 +0000
Received: (qmail 1823 invoked by uid 101); 24 Jan 2005 21:23:17 -0000
Received: from unknown (HELO ogmios.pmc-sierra.bc.ca) (216.241.226.59)
  by mother.pmc-sierra.com with SMTP; 24 Jan 2005 21:23:17 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogmios.pmc-sierra.bc.ca (8.12.9/8.12.7) with ESMTP id j0OLNGAt008045;
	Mon, 24 Jan 2005 13:23:16 -0800
Received: by bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <CPW116N9>; Mon, 24 Jan 2005 13:23:16 -0800
Message-ID: <04781D450CFF604A9628C8107A62FCCF013DDBC4@sjc1exm01.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Brad Larson <Brad_Larson@pmc-sierra.com>
To:	"'Maciej W. Rozycki'" <macro@linux-mips.org>,
	Manish Lachwani <mlachwani@mvista.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org
Subject: RE: [PATCH] TX4927 processor can support different speeds
Date:	Mon, 24 Jan 2005 13:23:13 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Brad_Larson@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Brad_Larson@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

> On Mon, 24 Jan 2005, Manish Lachwani wrote:
> 
> > > > Why is this approach (in the patch) bad?
> [...]
> > > It's fragile because clock frequencies are changing 
> faster in today's
> > > world of electronics than the weather in April.
> [...]
> > So? Can you be a little more clear?
> 
>  Oh well, how can you assure a given binary will be booted on 
> a CPU driven 
> by the right frequency?  Is the clock source inside the chip 
> containing 
> the CPU at least?
> 
>   Maciej

I've seen more boards with slightly, sometimes dramatically, modified cpu clock source for performance and production reliability reasons than not having an external RTC.  External RTC present and one kernel can accurately enough report the cpu frequency for Toshiba "stock" values and others as well.

--Brad

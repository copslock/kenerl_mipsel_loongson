Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2008 17:04:46 +0100 (CET)
Received: from smtp-vbr5.xs4all.nl ([194.109.24.25]:16143 "EHLO
	smtp-vbr5.xs4all.nl") by lappi.linux-mips.net with ESMTP
	id S528876AbYC1QEj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Mar 2008 17:04:39 +0100
Received: from dealogic.nl (a62-251-87-113.adsl.xs4all.nl [62.251.87.113])
	by smtp-vbr5.xs4all.nl (8.13.8/8.13.8) with ESMTP id m2SG40he045506;
	Fri, 28 Mar 2008 17:04:05 +0100 (CET)
	(envelope-from ncoesel@DEALogic.nl)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Alchemy power managment code.
Date:	Fri, 28 Mar 2008 17:03:59 +0100
Message-ID: <19CA9E279FDA5246B7D7A1C91A4AF7F40EF9A2@dealogicserver.DEALogic.nl>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Alchemy power managment code.
thread-index: AciQ5j564zLnauoESYeKcee2Jr0aAQAAFnjQ
From:	"Nico Coesel" <ncoesel@DEALogic.nl>
To:	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>,
	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Cc:	<ralf@linux-mips.org>, <linux-mips@linux-mips.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Return-Path: <ncoesel@DEALogic.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ncoesel@DEALogic.nl
Precedence: bulk
X-list: linux-mips

> -----Oorspronkelijk bericht-----
> Van: Sergei Shtylyov [mailto:sshtylyov@ru.mvista.com] 
> Verzonden: vrijdag 28 maart 2008 16:15
> Aan: Atsushi Nemoto
> CC: ralf@linux-mips.org; linux-mips@linux-mips.org; Nico Coesel
> Onderwerp: Re: Alchemy power managment code.
> 
> Hello.
> 
> Atsushi Nemoto wrote:
> 
> >>>Correct - and cevt-r4k won't be usable either.  I guess that means 
> >>>you leave the user the choice between either these two or 
> using wait.  
> >>>Not nice but ...
> 
> >>    The Alchemy code doesn't even try to use CP0 counter when 
> >>CONFIG_PM=y if you look into 
> arch/mips/au1000/common/time.c... or at 
> >>least it didn't before Atsushi removed do_fast_pm_gettimeoffset().
> 
> > Oh, yes. At that time I tried to implement clocksource drivers for 
> > non-standard timers, but it seems I had missied Alchemy PM=y case.
> 
> > The driver would be something like this?  Completely untested ;-)
> 
> > static cycle_t au1000_hpt_read(void)
> > {
> > 	return au_readl(SYS_TOYREAD);
> > }
> 
> > struct clocksource au1000_clocksource = {
> > 	.name	= "au1000-counter",
> > 	.rating	= 200,
> 
>     Rating should be greater than that of CP0 counter...
> 
> > 	.read	= au1000_hpt_read,
> > 	.mask	= CLOCKSOURCE_MASK(32),
> > 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
> > };
> 
> > void __init au1000_clocksource_init(unsinged long cpu_speed) {
> > 	struct clocksource *cs = &au1000_clocksource;
> > 
> > 	clocksource_set_clock(cs, cpu_speed);
> 
>     Not really, it's clocked by 32768 Hz input, so probably 
> not very good as a clocksource.

Why not? If a 32768Hz watch crystal is connected then you'll have a
stable clocksource. IIRC watch crystals are more precise than the
crystals used to generate the core frequency.
 
Nico Coesel

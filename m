Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2008 09:22:07 +0100 (CET)
Received: from smtp-vbr17.xs4all.nl ([194.109.24.37]:6152 "EHLO
	smtp-vbr17.xs4all.nl") by lappi.linux-mips.net with ESMTP
	id S528153AbYC1IWC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Mar 2008 09:22:02 +0100
Received: from dealogic.nl (a62-251-87-113.adsl.xs4all.nl [62.251.87.113])
	by smtp-vbr17.xs4all.nl (8.13.8/8.13.8) with ESMTP id m2S8LLDJ003013;
	Fri, 28 Mar 2008 09:21:26 +0100 (CET)
	(envelope-from ncoesel@DEALogic.nl)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: FW: Alchemy power managment code.
Date:	Fri, 28 Mar 2008 09:21:22 +0100
Message-ID: <19CA9E279FDA5246B7D7A1C91A4AF7F40EF98E@dealogicserver.DEALogic.nl>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FW: Alchemy power managment code.
thread-index: AciQX5Nu6p3BCSPRTze+CZNOwIqc7AATAj0w
From:	"Nico Coesel" <ncoesel@DEALogic.nl>
To:	"Ralf Baechle" <ralf@linux-mips.org>,
	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Cc:	<linux-mips@linux-mips.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Return-Path: <ncoesel@DEALogic.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ncoesel@DEALogic.nl
Precedence: bulk
X-list: linux-mips


> -----Oorspronkelijk bericht-----
> Van: Ralf Baechle [mailto:ralf@linux-mips.org] 
> Verzonden: donderdag 27 maart 2008 23:33
> Aan: Sergei Shtylyov
> CC: Nico Coesel; linux-mips@linux-mips.org
> Onderwerp: Re: FW: Alchemy power managment code.
> 
> On Wed, Mar 26, 2008 at 07:31:55PM +0300, Sergei Shtylyov wrote:
> 
> >> Funny you ask because I tried this yesterday on a AU1100 
> system with 
> >> the
> >> 2.6.24 kernel (from kernel.org). I'm afraid I must say the kernel 
> >> crashes when I enable power management. The reason I want to use 
> >> power management is because I need to send the CPU to 
> sleep when the 
> >> system shuts down. I hacked power.c and reset.c a bit so 
> au_sleep() 
> >> is called when the system is shut down. Perhaps someone 
> can confirm 
> >> the powermanagement can be made to work with some fixes (it didn't 
> >> work with
> >> 2.6.21-rc4 either).
> >
> >    BTW, for anybody interested in Alchemy PM code, here's the 
> > interesting
> > link: [ftp|http]://ftp.enneenne.com/pub/misc/au1100-patches/linux/.
> >    It contains  a lot of unmerged PM patches by Rodolfo 
> Giometti (and 
> > not only that) from around 2.6.17 time.
> 
> Anybody interested in reviewing these patches and polishing 
> them to be applied to a recent kernel?
> 
>   Ralf

I guess I will have to, but it will probably be somewhere near the end
of April. Also, I'm leaning towards only fixing the TOY timer during
sleep so the clock keeps running. IMHO this should be standard behaviour
which does not depend on power management.

Are diffs against 2.6.24 any good to you guys? The timer stuff Sergei
seems to be working on right now also sounds interesting. Perhaps I'll
patch my kernel with the timer patches from Sergei and apply (some of)
Rodolfo's patches afterwards. I assume there will be quite some overlap
in these patches.

Nico Coesel
 

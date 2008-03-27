Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2008 14:47:33 +0100 (CET)
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:19725 "EHLO
	smtp-vbr8.xs4all.nl") by lappi.linux-mips.net with ESMTP
	id S524439AbYC0Nr2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Mar 2008 14:47:28 +0100
Received: from dealogic.nl (a62-251-87-113.adsl.xs4all.nl [62.251.87.113])
	by smtp-vbr8.xs4all.nl (8.13.8/8.13.8) with ESMTP id m2RDkoJA040254;
	Thu, 27 Mar 2008 14:46:56 +0100 (CET)
	(envelope-from ncoesel@DEALogic.nl)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: FW: Alchemy power managment code.
Date:	Thu, 27 Mar 2008 14:46:50 +0100
Message-ID: <19CA9E279FDA5246B7D7A1C91A4AF7F40EF985@dealogicserver.DEALogic.nl>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FW: Alchemy power managment code.
thread-index: AciPXrXQBHchMZF3Qt6bxoUnhX8xXwAsebgQ
From:	"Nico Coesel" <ncoesel@DEALogic.nl>
To:	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Cc:	<linux-mips@linux-mips.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Return-Path: <ncoesel@DEALogic.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ncoesel@DEALogic.nl
Precedence: bulk
X-list: linux-mips

> -----Oorspronkelijk bericht-----
> Van: Sergei Shtylyov [mailto:sshtylyov@ru.mvista.com] 
> Verzonden: woensdag 26 maart 2008 17:32
> Aan: Nico Coesel
> CC: linux-mips@linux-mips.org
> Onderwerp: Re: FW: Alchemy power managment code.
> 
> Hello all.
> 
> Nico Coesel wrote:
> 
> > Ralf,
> > Funny you ask because I tried this yesterday on a AU1100 
> system with 
> > the
> > 2.6.24 kernel (from kernel.org). I'm afraid I must say the kernel 
> > crashes when I enable power management. The reason I want 
> to use power 
> > management is because I need to send the CPU to sleep when 
> the system 
> > shuts down. I hacked power.c and reset.c a bit so 
> au_sleep() is called 
> > when the system is shut down. Perhaps someone can confirm the 
> > powermanagement can be made to work with some fixes (it didn't work 
> > with
> > 2.6.21-rc4 either).
> 
>     BTW, for anybody interested in Alchemy PM code, here's 
> the interesting
> link: [ftp|http]://ftp.enneenne.com/pub/misc/au1100-patches/linux/.
>     It contains  a lot of unmerged PM patches by Rodolfo 
> Giometti (and not only that) from around 2.6.17 time.
> 

Sergei,
Is there a reason why these patches didn't make it into the official
kernel? IIRC Rodolfo has been quite active on this mailing list.

Nico Coesel

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2006 13:54:14 +0000 (GMT)
Received: from mail.domino-uk.com ([193.131.116.193]:43531 "EHLO
	vMIMEsweeper.dps.local") by ftp.linux-mips.org with ESMTP
	id S8133485AbWAaNx5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Jan 2006 13:53:57 +0000
Received: from dps-exchange1.dps.local (dps-exchange1) by vMIMEsweeper.dps.local
 (Clearswift SMTPRS 5.0.4) with ESMTP id <T762d2b0c80c18374c1a54@vMIMEsweeper.dps.local> for <linux-mips@linux-mips.org>;
 Tue, 31 Jan 2006 13:58:56 +0000
Received: from emea-exchange3.emea.dps.local ([192.168.50.10]) by dps-exchange1.dps.local with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 31 Jan 2006 13:58:56 +0000
Received: from tuxator2.emea.dps.local ([192.168.55.75]) by emea-exchange3.emea.dps.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 31 Jan 2006 14:58:55 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
To:	linux-mips@linux-mips.org
Subject: Re: PCMCIA on AU1200
Date:	Tue, 31 Jan 2006 15:03:52 +0100
User-Agent: KMail/1.8.3
References: <1138703953.7932.36.camel@localhost.localdomain>
In-Reply-To: <1138703953.7932.36.camel@localhost.localdomain>
Organization: Sator Laser GmbH
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601311503.52130.eckhardt@satorlaser.com>
X-OriginalArrivalTime: 31 Jan 2006 13:58:55.0577 (UTC) FILETIME=[79A54490:01C6266E]
Return-Path: <Eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

On Tuesday 31 January 2006 11:39, Matej Kupljen wrote:
> I am trying to use PCMCIA on a DBAU1200 with 16bit card.
>
> From the docs for the board, I see that the PCMCIA interface
> is on CE[3], but the value of the mem_staddr3 is
> 0x1000000.
>
> Looking at the Linux source code, I see that the PCMCIA is
> ioremap-ed to 0xf00000000 (36 bit). It also uses PSEUDO
> addresses for the skt->phys_attr and skt->phys_mem.
>
> At what (physical) address can I find the card's I/O space,
> so I can use tools like devmem2 to see the cards CIS?
> Should I configure mem_stadd3 to same other value?
> To 0xf0000000?

I'm not exactly sure what your problems are, but maybe this helps you achieve 
what you want.

Firstly, 0xf 0000 0000 is the 36 bit physical address. This address is mapped 
by the driver via ioremap() into a 32 bit virtual address. Now, I think there 
are three macros for the PCMCIA memory regions (at least there were for the 
Au1100), which you can ioremap() separately.

Now, what gave me most trouble where two other things that needed to be done 
for my board (they might be different for you):
1. configure the static bus controller
This mainly means selecting the right timing parameters and switching the 
right bits on and off. You definitely need to read the programmer's handbook 
from AMD/Alchemy.
2. turn on power
In my case, power on and card detect were wired to some GPIO pins, so I had to 
switch them to the right level. This might require additional configuration 
in advance, too, but you can check the results using a simple voltmeter.

However: The DB boards are generally supported by Linux, so I wonder why you 
need to do anything at all.

Uli

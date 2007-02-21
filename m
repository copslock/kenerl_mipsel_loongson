Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Feb 2007 08:19:48 +0000 (GMT)
Received: from mail.domino-uk.com ([193.131.116.193]:8199 "EHLO
	UK-HC-PS1.domino-printing.com") by ftp.linux-mips.org with ESMTP
	id S20037604AbXBUITo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Feb 2007 08:19:44 +0000
Received: from emea-exchange3.emea.dps.local (EMEA-EXCHANGE3) by 
    UK-HC-PS1.domino-printing.com (Clearswift SMTPRS 5.2.5) with ESMTP id 
    <T7defcc75dcc18374c18f0@UK-HC-PS1.domino-printing.com> for 
    <linux-mips@linux-mips.org>; Wed, 21 Feb 2007 08:21:06 +0000
Received: from tuxator2.emea.dps.local ([192.168.55.75]) by 
    emea-exchange3.emea.dps.local with Microsoft SMTPSVC(6.0.3790.1830); 
    Wed, 21 Feb 2007 09:21:05 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: Au1000 PCMCIA broken in 2.6.20
Date:	Wed, 21 Feb 2007 09:19:16 +0100
User-Agent: KMail/1.9.5
References: <20070221073848.GA9822@roarinelk.homelinux.net>
In-Reply-To: <20070221073848.GA9822@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200702210919.16930.eckhardt@satorlaser.com>
X-OriginalArrivalTime: 21 Feb 2007 08:21:05.0094 (UTC) 
    FILETIME=[3AF28660:01C75591]
Return-Path: <Eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14186
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

On Wednesday 21 February 2007 08:38, Manuel Lauss wrote:
> PCMCIA is broken on my Au1200 platform. Seems to me that accesses to
> Attribute memory are broken; a dump of the CIS reveals the following:
>
> 1.0: ParseTuple: Bad CIS tuple
> 00000000  01 03 ff ff ff 1c 04 ff  ff ff ff 18 02 ff ff 20 
> 00000010  04 98 00 00 00 15 20 04  ff ff ff ff ff ff ff ff
> 00000020  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff 
> 00000030  ff ff ff ff ff ff ff 21  02 04 01 22 02 ff ff 22
[...]
> it should look like this:
> 00000000  01 03 d9 01 ff 1c 04 03  d9 01 ff 18 02 df 01 20 
> 00000010  04 98 00 00 00 15 20 04  01 54 4f 53 48 49 42 41
> 00000020  20 54 48 4e 43 46 32 35  36 4d 50 47 20 00 00 00

Can you rule out a timing problem, i.e. that the system bus is configured 
correctly? The reason I ask is that some values seem to be read correctly but 
others not. I seem to remember something like that keeping me busy trying to 
get an Au1100 to run. Also, try a different card, too, I experienced hard 
lockups with CF cards of one brand that (on an electronic level) seemed to 
behave badly and cause the system to break.

> Reverting "[PATCH] Generic ioremap_page_range: mips conversion" makes it
> work again:
> http://www.linux-mips.org/git?p=linux.git;a=commitdiff_plain;h=8e087929df88
>4dbb13e383d49d192bdd6928ecbf;hp=62dfb5541a025b47df9405ff0219c7829a97d83b

I see one thing that disturbs me a lot in this code (before but even more 
after this changeset): use of casts in the calls to remap_area_pages or 
ioremap_page_range. Those typically only serve to hide errors and 
specifically on the Au1100 (probably also on Au1200) because there the 
physical addresses are 36 bit while virtual addresses are 32 bit. If there is 
a truncation going on due to wrong datatypes, these casts will disable the 
compiler warnings.

Apropos, the switching between 32 and 36 bit physical addresses was done via a 
configuration setting in 2.4, try toggling that one, too, if it still exists.

Uli

-- 
Sator Laser GmbH
Geschäftsführer: Ronald Boers       Steuernummer: 02/892/02900 
Amtsgericht Hamburg HR B62 932      USt-Id.Nr.: DE183047360

**************************************************************************************
           Visit our website at <http://www.satorlaser.de/>
**************************************************************************************
Diese E-Mail einschließlich sämtlicher Anhänge ist nur für den Adressaten bestimmt und kann vertrauliche Informationen enthalten. Bitte benachrichtigen Sie den Absender umgehend, falls Sie nicht der beabsichtigte Empfänger sein sollten. Die E-Mail ist in diesem Fall zu löschen und darf weder gelesen, weitergeleitet, veröffentlicht oder anderweitig benutzt werden.
E-Mails können durch Dritte gelesen werden und Viren sowie nichtautorisierte Änderungen enthalten. Sator Laser GmbH ist für diese Folgen nicht verantwortlich.

**************************************************************************************

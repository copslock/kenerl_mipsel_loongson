Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Dec 2005 13:10:40 +0000 (GMT)
Received: from laf31-5-82-235-130-100.fbx.proxad.net ([82.235.130.100]:4086
	"EHLO lexbox.fr") by ftp.linux-mips.org with ESMTP id S8133932AbVLANKW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Dec 2005 13:10:22 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: DbAu1550 copy file corruption
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date:	Thu, 1 Dec 2005 14:10:12 +0100
Message-ID: <17AB476A04B7C842887E0EB1F268111E0271AB@xpserver.intra.lexbox.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: DbAu1550 copy file corruption
thread-index: AcX11en5L2oG8EKjREunsxH0TidH0QAj0nAg
From:	"David Sanchez" <david.sanchez@lexbox.fr>
To:	"Sergei Shtylylov" <sshtylyov@ru.mvista.com>,
	<linux-mips@linux-mips.org>
Return-Path: <david.sanchez@lexbox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.sanchez@lexbox.fr
Precedence: bulk
X-list: linux-mips

Hi,

As all my pci sata controllers operate up to 66Mhz, I add a divider to the pci clock in the board_setup.c of the au1550 to obtain 32 Mhz pci clock. But the problem still appear... (More the bus is slow, less the problem appear: maybe because it is a timing issue ?)

I try the HPT371B (which works for us). I try several PCI sata controllers (Promise PDC20779, PDC 20579, SiliconImage Sil3112, etc...). More I try the drivers provided by Promise instead of the libata. But the problem still appear...

Sergei, is the PCI clock frequency issue only for the HPT371N or even for PCI sata controller ? Do you mean that all the users of the dbau1550 needs to set the PCI clock to 32Mhz?
Have you try my script on your board? 

Thanks.

David

-----Message d'origine-----
De : Sergei Shtylylov [mailto:sshtylyov@ru.mvista.com] 
Envoyé : mercredi 30 novembre 2005 18:46
À : Dan Malek
Cc : David Sanchez
Objet : Re: DbAu1550 copy file corruption

Hello.

Dan Malek wrote:

> Have you tested this on an NFS partition?  Does
> the on-board HPT371 work?  I know the latter two
> used to work, but I don't remember testing a 2.6.10
> kernel, I've been using newer ones.

   Do you mean HPT371N? It shouldn't work (and does not work for us) since the 
current driver has severe clocking problems with anything but HPT370/374 on a 
66 MHz PCI. So with the default 64 MHz Au1550 PCI clock the driver just locks 
up; it can only work if you plug in a 33 MHz PCI card to get Au1550 PCI 
clocked at 32 MHz. I was in the process of fixing this but this work is 
currently preempted by more urgent stuff... :-(

WBR, Sergei

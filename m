Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Nov 2004 16:37:56 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:26628 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225251AbUK3Qho>; Tue, 30 Nov 2004 16:37:44 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 70896E1CA8; Tue, 30 Nov 2004 17:37:37 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08787-06; Tue, 30 Nov 2004 17:37:37 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 16CF8E1CA7; Tue, 30 Nov 2004 17:37:37 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iAUGbmfD029852;
	Tue, 30 Nov 2004 17:37:49 +0100
Date: Tue, 30 Nov 2004 16:37:40 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Gilad Rom <gilad@romat.com>
Cc: "'Dominic Sweetman'" <dom@mips.com>, linux-mips@linux-mips.org
Subject: RE: CP0 EntryLo
In-Reply-To: <20041130162659.BA5FAEB2A9@mail.romat.com>
Message-ID: <Pine.LNX.4.58L.0411301635590.31151@blysk.ds.pg.gda.pl>
References: <20041130162659.BA5FAEB2A9@mail.romat.com>
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
X-archive-position: 6508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 30 Nov 2004, Gilad Rom wrote:

> So, what I need to do, if I understand correctly, is to create a fixed
> mapping
> >From a virtual address to a physical address on the tlb, and use this
> Virtual address to change the values of EntryLo to 0xD in order to 
> Access the device on the address range I mapped Chip-select 1 to?
> 
> (Excuse my poor phrasing, I've been googling all day...)
> 
> Any idea on how I might accomplish that from a driver?
> I've found a function called add_wired_entry(...), is this
> What I should be using?

 ioremap()

  Maciej

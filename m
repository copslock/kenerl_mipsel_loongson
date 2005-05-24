Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2005 12:42:06 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:12044 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225206AbVEXLlu>; Tue, 24 May 2005 12:41:50 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 700C0F599D; Tue, 24 May 2005 13:41:45 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 00606-03; Tue, 24 May 2005 13:41:45 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 359BBF5998; Tue, 24 May 2005 13:41:45 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j4OBeL7S018589;
	Tue, 24 May 2005 13:40:22 +0200
Date:	Tue, 24 May 2005 12:40:28 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc:	Richard Sandiford <rsandifo@redhat.com>, linux-mips@linux-mips.org
Subject: Re: Unmatched R_MIPS_HI16/R_MIPS_LO16 on gcc 3.5
In-Reply-To: <Pine.GSO.4.10.10505241242020.25134-100000@helios.et.put.poznan.pl>
Message-ID: <Pine.LNX.4.61L.0505241226400.13738@blysk.ds.pg.gda.pl>
References: <Pine.GSO.4.10.10505241242020.25134-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.83/893/Tue May 24 08:27:20 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 24 May 2005, Stanislaw Skowronek wrote:

> I tried objcopy (it was my first thought), for one reason or another it
> didn't work (internal BFD error something). Reportedly ECOFF is belly-up
> in current GNU binutils - at least it is what I heard.

 And the bug report is...  Well, where?

> My input is elf32-tradbigmips. So I entirely don't care for binutils'
> ECOFF anymore, and I consider this a good thing. As I said, objcopy didn't
> work at all. Fixing BFD is not my job (it's a monster of Frankensteinian
> proportions), I think that it is actually much easier to write my own
> converter (well, I did it, and it works - except that funny HI/LO mismatch
> I'm going to work around).

 Well, you are not required to fix BFD, but if you don't even report 
problems they are going to be left undiscovered forever...

  Maciej

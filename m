Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2005 16:22:50 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:7941 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225008AbVDLPWe>; Tue, 12 Apr 2005 16:22:34 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 95067E1C81; Tue, 12 Apr 2005 17:22:28 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24394-09; Tue, 12 Apr 2005 17:22:28 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 430AEE1C80; Tue, 12 Apr 2005 17:22:28 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j3CFMQIc017271;
	Tue, 12 Apr 2005 17:22:29 +0200
Date:	Tue, 12 Apr 2005 16:22:34 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	Greg Weeks <greg.weeks@timesys.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: another 4kc machine check.
In-Reply-To: <004a01c53ed4$dab12b00$10eca8c0@grendel>
Message-ID: <Pine.LNX.4.61L.0504121610500.18606@blysk.ds.pg.gda.pl>
References: <42553E49.7080004@timesys.com> <4256991C.4020601@timesys.com>
 <20050408161357.GB19166@linux-mips.org> <4256B524.2080509@timesys.com>
 <425AD440.5050600@timesys.com> <004a01c53ed4$dab12b00$10eca8c0@grendel>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.83/822/Tue Apr 12 06:55:55 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 11 Apr 2005, Kevin D. Kissell wrote:

> If the 4KC and 4KEC need it, so does the 4KSC (and 4KSD).

 But that's weird in the first place as 4Kc implements the original 
revision of MIPS32 so it does not implement "ehb".  Therefore it acts just 
as an ordinary "nop", but according to the 4K manual there is no need for 
one -- the hazard between a move to EntryLo0/EntryLo1 and tlbwi/tlbwr is 
explicitly listed as 0 instructions.

  Maciej

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2004 23:13:32 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:64774 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225214AbUKXXN1>; Wed, 24 Nov 2004 23:13:27 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 6467CE1C89; Thu, 25 Nov 2004 00:13:19 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 09750-06; Thu, 25 Nov 2004 00:13:19 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id DB262E1C84; Thu, 25 Nov 2004 00:13:18 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iAONDZEW026992;
	Thu, 25 Nov 2004 00:13:36 +0100
Date: Wed, 24 Nov 2004 23:13:22 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	Manish Lachwani <mlachwani@mvista.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Synthesize TLB refill handler at runtime
In-Reply-To: <20041124224555.GD22439@linux-mips.org>
Message-ID: <Pine.LNX.4.58L.0411242259131.843@blysk.ds.pg.gda.pl>
References: <41A283BD.3080300@mvista.com> <Pine.LNX.4.58L.0411230036310.31113@blysk.ds.pg.gda.pl>
 <41A29DCF.8030308@mvista.com> <Pine.LNX.4.58L.0411232018390.19941@blysk.ds.pg.gda.pl>
 <20041124014057.GE902@rembrandt.csv.ica.uni-stuttgart.de>
 <20041124094423.GB21039@linux-mips.org> <Pine.LNX.4.58L.0411241451290.843@blysk.ds.pg.gda.pl>
 <Pine.LNX.4.58L.0411242138560.843@blysk.ds.pg.gda.pl> <20041124221240.GA24500@linux-mips.org>
 <Pine.LNX.4.58L.0411242237540.843@blysk.ds.pg.gda.pl> <20041124224555.GD22439@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/590/Wed Nov 17 22:03:52 2004
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 24 Nov 2004, Ralf Baechle wrote:

> Which unfortunately is becoming unusable fairly soon on many systems.
> IP27: ARC is dead after the first TLB flush.  IP22: dead after the
> external L2 controller was enabled etc.  On average I'm less than
> pleased with firmware usability even for simple stuff such as printing ...

 Broken firmware...  For DECstations it works until we wipe out RAM
reserved by the firmware, right before running `init'.  Which is not
firmware's fault, of course, and which I plan to get fixed eventually to
be able to access and set firmware environment variables from the
userland, to do a proper halt and reboot (with a command), etc.  I've not
decided whether to rip it away completely or to leave it as a
configuration option for these memory starved.  You can have 4MB of RAM on
some DECstations, you know.

  Maciej

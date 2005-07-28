Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jul 2005 11:11:28 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:32014 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225923AbVG1KLK>; Thu, 28 Jul 2005 11:11:10 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 15E91F596D; Thu, 28 Jul 2005 12:13:46 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 15726-02; Thu, 28 Jul 2005 12:13:45 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id E2827F596C; Thu, 28 Jul 2005 12:13:45 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j6SADlB7007965;
	Thu, 28 Jul 2005 12:13:47 +0200
Date:	Thu, 28 Jul 2005 11:13:53 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Niels Sterrenburg <pulsar@kpsws.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <Pine.LNX.4.62.0507280935040.24391@numbat.sonytel.be>
Message-ID: <Pine.LNX.4.61L.0507281109510.26113@blysk.ds.pg.gda.pl>
References: <20050725213607Z8225534-3678+4335@linux-mips.org>
 <57480.194.171.252.100.1122478386.squirrel@mail.kpsws.com>
 <20050727172427.GB3626@linux-mips.org> <Pine.LNX.4.61L.0507271858050.13819@blysk.ds.pg.gda.pl>
 <20050727192816.GF3626@linux-mips.org> <Pine.LNX.4.62.0507280935040.24391@numbat.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/995/Wed Jul 27 22:13:50 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 28 Jul 2005, Geert Uytterhoeven wrote:

> Maciej meant spaces followed by tabs that do not end a line, e.g.

 Indeed.

> These are a bit more difficult to auto-remove, since simply removing them may
> change indentation (modulo 8).

 I've found it quite efficient to do it with `vim' and conditional regexp 
substitution.  This way you can see what gets changed and if indentation 
needs to be fixed up afterwards, you can do this immediately.

  Maciej

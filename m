Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jan 2006 13:04:19 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:46354 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133560AbWA3NEB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jan 2006 13:04:01 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 3534FF5B11;
	Mon, 30 Jan 2006 14:08:52 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 29239-02; Mon, 30 Jan 2006 14:08:52 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id DEA95E1CA6;
	Mon, 30 Jan 2006 14:08:51 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k0UD8isW030144;
	Mon, 30 Jan 2006 14:08:44 +0100
Date:	Mon, 30 Jan 2006 13:08:53 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Franck <vagabon.xyz@gmail.com>,
	"Kevin D. Kissell" <kevink@mips.com>,
	Nigel Stephens <nigel@mips.com>, linux-mips@linux-mips.org
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
In-Reply-To: <20060129150747.GC3420@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0601301307420.17926@blysk.ds.pg.gda.pl>
References: <43D8F000.9010106@mips.com> <cda58cb80601260831i61167787g@mail.gmail.com>
 <43D8FF16.40107@mips.com> <cda58cb80601261002w6eb02249k@mail.gmail.com>
 <43D93025.9040800@mips.com> <cda58cb80601270103t1419117cq@mail.gmail.com>
 <43DA240F.5070301@mips.com> <cda58cb80601270654jf779622w@mail.gmail.com>
 <00df01c62357$ef9a1fa0$10eca8c0@grendel> <cda58cb80601270932x323e4923j@mail.gmail.com>
 <20060129150747.GC3420@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.87.1/1260/Mon Jan 30 11:41:27 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 29 Jan 2006, Ralf Baechle wrote:

> I think I'm going to start by throwing the insane option selection
> complexity which was needed for support of gcc 2.95 ... 3.1; a few days
> gcc 3.2 became the minimum required to build a 2.6 kernel, then see what
> can nicely be implemented.

 Amen to that!

  Maciej

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2005 21:13:40 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:9231 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225395AbVAXVNZ>; Mon, 24 Jan 2005 21:13:25 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 23EE5F596F; Mon, 24 Jan 2005 22:13:18 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 16157-08; Mon, 24 Jan 2005 22:13:18 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 6DA99E1CBE; Mon, 24 Jan 2005 22:13:17 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j0OLDM3R029414;
	Mon, 24 Jan 2005 22:13:22 +0100
Date:	Mon, 24 Jan 2005 21:13:32 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Manish Lachwani <mlachwani@mvista.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] TX4927 processor can support different speeds
In-Reply-To: <41F55F15.6050107@mvista.com>
Message-ID: <Pine.LNX.4.61L.0501242107040.17587@blysk.ds.pg.gda.pl>
References: <20050123192318.GA22681@prometheus.mvista.com>
 <20050123194140.GL15265@rembrandt.csv.ica.uni-stuttgart.de>
 <20050123195129.GA1806@linux-mips.org> <41F40B8E.2080003@mvista.com>
 <20050124202244.GB2376@linux-mips.org> <41F55F15.6050107@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/661/Tue Jan 11 02:44:13 2005
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7025
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 24 Jan 2005, Manish Lachwani wrote:

> > > Why is this approach (in the patch) bad?
[...]
> > It's fragile because clock frequencies are changing faster in today's
> > world of electronics than the weather in April.
[...]
> So? Can you be a little more clear?

 Oh well, how can you assure a given binary will be booted on a CPU driven 
by the right frequency?  Is the clock source inside the chip containing 
the CPU at least?

  Maciej

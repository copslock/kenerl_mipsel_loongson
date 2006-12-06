Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2006 14:41:59 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:63505 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20037666AbWLFOly (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Dec 2006 14:41:54 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 275A9E1CA2;
	Wed,  6 Dec 2006 15:41:40 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eeFBNBYiwd8R; Wed,  6 Dec 2006 15:41:39 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id B0A6DE1C92;
	Wed,  6 Dec 2006 15:41:39 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id kB6EfmwI000655;
	Wed, 6 Dec 2006 15:41:49 +0100
Date:	Wed, 6 Dec 2006 14:41:45 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
cc:	Ingo Molnar <mingo@redhat.com>, anemo@mba.sphere.ne.jp,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Import updates from i386's i8259.c
In-Reply-To: <4576CB64.2060705@ru.mvista.com>
Message-ID: <Pine.LNX.4.64N.0612061438440.29000@blysk.ds.pg.gda.pl>
References: <20061206.103923.71086192.nemoto@toshiba-tops.co.jp>
 <20061206015818.GB27985@linux-mips.org> <20061206.115602.63741871.nemoto@toshiba-tops.co.jp>
 <20061206.133836.89067271.nemoto@toshiba-tops.co.jp> <4576C2E9.4060900@ru.mvista.com>
 <Pine.LNX.4.64N.0612061337220.29000@blysk.ds.pg.gda.pl> <4576CB64.2060705@ru.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.6/2292/Wed Dec  6 12:00:54 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 6 Dec 2006, Sergei Shtylyov wrote:

> > And with the "IO-APIC-edge" and "IO-APIC-level" alternatives back when the
> > concept of IRQ controllers was introduced, "XT-PIC" rather than "8259A"
> > sounded quite right.
> 
>    I don't follow you here.

 These were the three first names of interrupt controllers introduced back 
in 2.1 and the names chosen looked consistent.

  Maciej

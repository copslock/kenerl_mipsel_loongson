Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2006 13:32:42 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:30471 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20039091AbWLGNcf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Dec 2006 13:32:35 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 7141AFE271;
	Thu,  7 Dec 2006 14:32:20 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z9fdumk-ROr1; Thu,  7 Dec 2006 14:32:20 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id EB90FFE255;
	Thu,  7 Dec 2006 14:32:19 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id kB7DWTMv024230;
	Thu, 7 Dec 2006 14:32:29 +0100
Date:	Thu, 7 Dec 2006 13:32:25 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, vagabon.xyz@gmail.com,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Import updates from i386's i8259.c
In-Reply-To: <20061207115035.GA15386@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0612071329530.22220@blysk.ds.pg.gda.pl>
References: <20061205194907.GA1088@linux-mips.org> <20061205195702.GA2097@linux-mips.org>
 <cda58cb80612060040o17ec40f3x4c2f7d0037d3cd1@mail.gmail.com>
 <20061207.121702.108739943.nemoto@toshiba-tops.co.jp> <20061207115035.GA15386@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.6/2299/Thu Dec  7 08:36:50 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 7 Dec 2006, Ralf Baechle wrote:

> > Also I think most codes in vr41xx/nec-cmbvr4133/irq.c can be removed
> > if we made I8259A_IRQ_BASE customizable, but that would be another
> > story...
> 
> This number is fixed to zero because that's what all the old ISA drivers
> expect, the ISA boards have printed on etc...

 Well, it's probably that nobody has been brave enough to tackle it yet. 
;-)

  Maciej

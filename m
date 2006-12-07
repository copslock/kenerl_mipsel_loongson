Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2006 15:04:02 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:8210 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20027577AbWLGPD4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Dec 2006 15:03:56 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id A5F53FE276;
	Thu,  7 Dec 2006 16:03:42 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6l463pDaGZMj; Thu,  7 Dec 2006 16:03:42 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 42BBAFE272;
	Thu,  7 Dec 2006 16:03:42 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id kB7F3qZ3026535;
	Thu, 7 Dec 2006 16:03:52 +0100
Date:	Thu, 7 Dec 2006 15:03:48 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, vagabon.xyz@gmail.com,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Import updates from i386's i8259.c
In-Reply-To: <45781C70.30405@ru.mvista.com>
Message-ID: <Pine.LNX.4.64N.0612071443250.22220@blysk.ds.pg.gda.pl>
References: <20061205194907.GA1088@linux-mips.org> <20061205195702.GA2097@linux-mips.org>
 <cda58cb80612060040o17ec40f3x4c2f7d0037d3cd1@mail.gmail.com>
 <20061207.121702.108739943.nemoto@toshiba-tops.co.jp> <20061207115035.GA15386@linux-mips.org>
 <45781C70.30405@ru.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.6/2299/Thu Dec  7 08:36:50 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 7 Dec 2006, Sergei Shtylyov wrote:

>    It's not really related as 8259 is programmed to generate vectors 0x20 to
> 0x2F for x86 but the the IRQs start from zero anyway...

 In Linux most platforms define IRQ numbers in the sense of physical lines 
(or wires if you prefer) routed to inputs of interrupt controllers rather 
than vectors which may or may not be used by a given platform (and to 
complicate things further, the presence of which may be 
software-configurable).  Of course if a message passing concept is used 
for interrupt delivery (be it a simple chain or a more complicated 
protocol), then a different numbering scheme may be required and exposing 
vectors may be a necessity.

 Even with the i8259A there is no need to use its vector at all if the 
processor being interrupted does not issue INTA cycles itself.

  Maciej

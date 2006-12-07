Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2006 15:09:36 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:63932 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037433AbWLGPJe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Dec 2006 15:09:34 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kB7F9VPO008090;
	Thu, 7 Dec 2006 15:09:31 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kB7F9TUB008089;
	Thu, 7 Dec 2006 15:09:29 GMT
Date:	Thu, 7 Dec 2006 15:09:29 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, vagabon.xyz@gmail.com,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Import updates from i386's i8259.c
Message-ID: <20061207150929.GA4156@linux-mips.org>
References: <20061205194907.GA1088@linux-mips.org> <20061205195702.GA2097@linux-mips.org> <cda58cb80612060040o17ec40f3x4c2f7d0037d3cd1@mail.gmail.com> <20061207.121702.108739943.nemoto@toshiba-tops.co.jp> <20061207115035.GA15386@linux-mips.org> <45781C70.30405@ru.mvista.com> <Pine.LNX.4.64N.0612071443250.22220@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0612071443250.22220@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 07, 2006 at 03:03:48PM +0000, Maciej W. Rozycki wrote:

> >    It's not really related as 8259 is programmed to generate vectors 0x20 to
> > 0x2F for x86 but the the IRQs start from zero anyway...
> 
>  In Linux most platforms define IRQ numbers in the sense of physical lines 
> (or wires if you prefer) routed to inputs of interrupt controllers rather 
> than vectors which may or may not be used by a given platform (and to 
> complicate things further, the presence of which may be 
> software-configurable).  Of course if a message passing concept is used 
> for interrupt delivery (be it a simple chain or a more complicated 
> protocol), then a different numbering scheme may be required and exposing 
> vectors may be a necessity.
> 
>  Even with the i8259A there is no need to use its vector at all if the 
> processor being interrupted does not issue INTA cycles itself.

The Jazz family and the RM200 have registers to perform interrupt
acknowledge cycles.  Linux doesn't use it on the RM200 because of a funny
PCI ASIC bug which may cause certain interrupts getting lost until the
PIC is fully initialized.  I never looked into the details since the
SNI recommendation was to just avoid that feature.

  Ralf

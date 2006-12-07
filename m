Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2006 11:50:55 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:29583 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039152AbWLGLul (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Dec 2006 11:50:41 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kB7BobPJ017271;
	Thu, 7 Dec 2006 11:50:38 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kB7BoZFd017270;
	Thu, 7 Dec 2006 11:50:35 GMT
Date:	Thu, 7 Dec 2006 11:50:35 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] Import updates from i386's i8259.c
Message-ID: <20061207115035.GA15386@linux-mips.org>
References: <20061205194907.GA1088@linux-mips.org> <20061205195702.GA2097@linux-mips.org> <cda58cb80612060040o17ec40f3x4c2f7d0037d3cd1@mail.gmail.com> <20061207.121702.108739943.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207.121702.108739943.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 07, 2006 at 12:17:02PM +0900, Atsushi Nemoto wrote:

> You mean "adding" ?  I think now we can select
> GENERIC_HARDIRQS_NO__DO_IRQ for all MACH_VR41XX boards.
> 
> Also I think most codes in vr41xx/nec-cmbvr4133/irq.c can be removed
> if we made I8259A_IRQ_BASE customizable, but that would be another
> story...

This number is fixed to zero because that's what all the old ISA drivers
expect, the ISA boards have printed on etc...

  Ralf

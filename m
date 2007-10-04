Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 13:16:02 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:50561 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026000AbXJDMP6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Oct 2007 13:15:58 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l94CFvr7005417;
	Thu, 4 Oct 2007 13:15:58 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l94CFvo2005416;
	Thu, 4 Oct 2007 13:15:57 +0100
Date:	Thu, 4 Oct 2007 13:15:57 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Thiemo Seufer <ths@networkno.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
Message-ID: <20071004121557.GA28928@linux-mips.org>
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl> <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org> <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47049734.6050802@gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 04, 2007 at 09:33:08AM +0200, Franck Bui-Huu wrote:

> Not really, I would say it's just an idea to remove tlbex.c from the
> kernel code and to make it a tool called during compile time to
> generate a handler skeleton which would be finalized by the kernel.

IRIX was assembling its TLB exception handler from a few such skeletons
or rather a few fractions.  That works reasonably well as long as there are
not too many variants - but Linux supports about anything on earth.
Another disadvantage of the IRIX approach was that the fragments are
written in assembler but the tacking together happens in C code so the
code is split in a somewhat unnatural way over a few files.

  Ralf

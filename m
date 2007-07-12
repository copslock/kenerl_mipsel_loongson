Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 15:56:41 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:11218 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022498AbXGLO4j (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jul 2007 15:56:39 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6CEfbV4020113;
	Thu, 12 Jul 2007 15:41:37 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6CEfbAA020112;
	Thu, 12 Jul 2007 15:41:37 +0100
Date:	Thu, 12 Jul 2007 15:41:37 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Workaround for a sparse warning in include/asm-mips/io.h
Message-ID: <20070712144137.GC19674@linux-mips.org>
References: <S20022480AbXGLO2a/20070712142830Z+14663@ftp.linux-mips.org> <Pine.LNX.4.64N.0707121541190.3029@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0707121541190.3029@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 12, 2007 at 03:47:04PM +0100, Maciej W. Rozycki wrote:

> > Author: Atsushi Nemoto <anemo@mba.ocn.ne.jp> Wed Jul 11 23:12:00 2007 +0900
> > Comitter: Ralf Baechle <ralf@linux-mips.org> Thu Jul 12 14:39:44 2007 +0100
> > Commit: 57be612bf3815728ad29f39a09a1c70d71bd279c
> > Gitweb: http://www.linux-mips.org/g/linux/57be612b
> > Branch: master
> > 
> > CKSEG1ADDR() returns unsigned int value on 32bit kernel.  Cast it to
> 
>  This is not true.  With a 32-bit kernel CKSEG1ADDR(), quite 
> intentionally, returns a *signed* int.
> 
>  Since you have decided to fix the symptom rather than the bug I would at 
> least suggest to cast the result to "long" first and only then drop the 
> signedness.  Otherwise it looks misleading to a casual reader.

More a general comment on the use of KSEG0, KSEG1, KSEG1ADDR and similar
macros.  They've been used in about every piece of MIPS UNIX OS kernel
and driver code I ever touched.  But generally we want to abstract such
architecture specific knowledge away from drivers, even platform-specific
drivers.  So Linux code should prefer to use the standard Linux interfaces
such as ioremap, readb, writeb etc. over those old macros.

  Ralf

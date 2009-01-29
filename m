Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2009 18:18:40 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:15332 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21365752AbZA2SSi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2009 18:18:38 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n0TIIbqN005863;
	Thu, 29 Jan 2009 18:18:37 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n0TIIYN1005861;
	Thu, 29 Jan 2009 18:18:34 GMT
Date:	Thu, 29 Jan 2009 18:18:32 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Brian Foster <brian.foster@innova-card.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: Syntax error in include/asm-mips/gdb-stub.h
Message-ID: <20090129181830.GC4135@linux-mips.org>
References: <200901291430.30275.brian.foster@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200901291430.30275.brian.foster@innova-card.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 29, 2009 at 02:30:29PM +0100, Brian Foster wrote:

> apologies for not sending a patch — I'm working with a rather
> old tree (2.6.21-ish vintage) and am uncertain how useful one
> would be — but just collided with a trivial syntax error in
> include/asm-mips/gdb-stub.h
> 
>         long    lo;
> #ifdef CONFIG_CPU_HAS_SMARTMIPS
>         long    acx
> #endif
>         long    cp0_badvaddr;
> 
> there is missing semicolon (‘;’) on the centre line (acx).
> this mistake is seems to exist in at least the following
> (and very probably elsewhere (I'm not a git expert!)):

Or in simpler words, in all -stable branches upto and including 2.6.26.

  Ralf

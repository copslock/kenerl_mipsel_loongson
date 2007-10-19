Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Oct 2007 18:13:20 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:43990 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20044953AbXJSRNS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Oct 2007 18:13:18 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9JHCKYj029398;
	Fri, 19 Oct 2007 18:12:20 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9JHCJmP029397;
	Fri, 19 Oct 2007 18:12:19 +0100
Date:	Fri, 19 Oct 2007 18:12:19 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Kill duplicated setup_irq() for cp0 timer
Message-ID: <20071019171219.GA29142@linux-mips.org>
References: <20071020.012625.63132084.anemo@mba.ocn.ne.jp> <20071019163840.GA28057@linux-mips.org> <20071020.020203.112258960.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071020.020203.112258960.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 20, 2007 at 02:02:03AM +0900, Atsushi Nemoto wrote:

> On Fri, 19 Oct 2007 17:38:40 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > There's light at the end of this time code rewrite tunnel.  And it's not
> > the train :-)
> 
> Yes, I suppose generic parts are almost done.  (except for some
> garbage, and updating Documentation/mips/time.README ...)

The latter file wants Total Compression (TM).

  Ralf

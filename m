Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2006 01:46:16 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:21131 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039115AbWLFBqP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Dec 2006 01:46:15 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kB61jqXD028041;
	Wed, 6 Dec 2006 01:45:52 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kB61jp38028040;
	Wed, 6 Dec 2006 01:45:51 GMT
Date:	Wed, 6 Dec 2006 01:45:51 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] Import updates from i386's i8259.c
Message-ID: <20061206014551.GA27985@linux-mips.org>
References: <20061206.012311.86891097.anemo@mba.ocn.ne.jp> <4575A364.1010703@innova-card.com> <20061206.102833.126141309.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061206.102833.126141309.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 06, 2006 at 10:28:33AM +0900, Atsushi Nemoto wrote:

> > Does your patch make the following patch out of date (I sent
> > it to the list 4 days ago) ?
> > 
> > [PATCH] Compile __do_IRQ() when really needed [take #3]
> 
> Your patch should have no problem as is, but you might be able to add
> more "select GENERIC_HARDIRQS_NO__DO_IRQ" after my patch.

Sure - but why checking in a patch when an updated version is already
almost in flight ...

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2009 07:09:35 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:41411 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20022896AbZDXGJa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Apr 2009 07:09:30 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3O69T0Z025537;
	Fri, 24 Apr 2009 08:09:29 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3O69SlQ025536;
	Fri, 24 Apr 2009 08:09:28 +0200
Date:	Fri, 24 Apr 2009 08:09:28 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] TXx9: micro optimization for clocksource and
	clock_event
Message-ID: <20090424060928.GA25114@linux-mips.org>
References: <1240499436-8246-1-git-send-email-anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1240499436-8246-1-git-send-email-anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 24, 2009 at 12:10:36AM +0900, Atsushi Nemoto wrote:

> Subject: [PATCH] TXx9: micro optimization for clocksource and clock_event
> 
> Use container structure for clocksource, clock_event_device and hold a
> pointer to txx9_tmr_reg in it.
> 
> This saves a few instructions in clocksource and clock_event handlers.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Thanks, queued for 2.6.31.

  Ralf

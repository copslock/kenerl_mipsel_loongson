Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Feb 2007 17:54:34 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:4006 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037679AbXBDRyc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 4 Feb 2007 17:54:32 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l14HsVTg015282;
	Sun, 4 Feb 2007 17:54:31 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l14HsS79015281;
	Sun, 4 Feb 2007 17:54:28 GMT
Date:	Sun, 4 Feb 2007 17:54:28 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix pb1200/irqmap.c and apply some missed patches
Message-ID: <20070204175428.GA12319@linux-mips.org>
References: <20070204.005725.62338494.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070204.005725.62338494.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Feb 04, 2007 at 12:57:25AM +0900, Atsushi Nemoto wrote:

> pb1200/irqmap.c had been broken a while due to non-named initializer
> and had missed some recent IRQ related changes.  Apply these commits
> to this file.

Thanks, applied.

  Ralf

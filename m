Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2006 19:11:34 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:59348 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038715AbWKNTLc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Nov 2006 19:11:32 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kAEJBviq007358;
	Tue, 14 Nov 2006 19:11:57 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kAEJBu15007357;
	Tue, 14 Nov 2006 19:11:56 GMT
Date:	Tue, 14 Nov 2006 19:11:56 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ashlesha Shintre <ashlesha@kenati.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Portmap on the Encore M3
Message-ID: <20061114191156.GA7299@linux-mips.org>
References: <1163443607.6532.9.camel@sandbar.kenati.com> <20061113233802.GA17130@linux-mips.org> <1163469787.6532.26.camel@sandbar.kenati.com> <20061114130503.GB28579@linux-mips.org> <1163528890.6513.4.camel@sandbar.kenati.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163528890.6513.4.camel@sandbar.kenati.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 14, 2006 at 10:28:10AM -0800, Ashlesha Shintre wrote:

> > Use CONFIG_SERIAL_AU1X00.
> 
> --But I want to use standard 16550 compatible serial port, controlled by
> the Super I/O Controller on the VIA Southbridge.. The
> CONFIG_SERIAL_AU1x00 will not be able to drive this port will it?

Ah, no.  But that's an unusual configuration.  In general Alchemy
systems only use the on-chip UART which is 8250-ish but just different
enough that in older Linux versions we used to have a separate
driver for it.

  Ralf

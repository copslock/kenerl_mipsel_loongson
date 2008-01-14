Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2008 13:38:06 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:53660 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029803AbYANNiE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jan 2008 13:38:04 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0EDb2T3016819;
	Mon, 14 Jan 2008 13:37:27 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0EDb1jH016818;
	Mon, 14 Jan 2008 13:37:01 GMT
Date:	Mon, 14 Jan 2008 13:37:01 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] prom_free_prom_memory for QEMU
Message-ID: <20080114133701.GA16555@linux-mips.org>
References: <20080114.212253.126142719.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080114.212253.126142719.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 14, 2008 at 09:22:53PM +0900, Atsushi Nemoto wrote:

> You can get 60kb more memory by this patch.  Note that this patch
> might cause segfault on some intermediate version of qemu 0.9.0 and
> 0.9.1 (For example Debian qemu-0.9.0+20070816-1).

I was actually planning to remove the Qemu platform for 2.6.25.  The
Malta emulation has become so good that there is no more point in having
the underfeatured synthetic platform that CONFIG_QEMU is.

Objections?

  Ralf

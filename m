Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2007 13:30:08 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:46254 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021718AbXIJMaG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Sep 2007 13:30:06 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8ACU5VS010749;
	Mon, 10 Sep 2007 13:30:05 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8ACU5nt010748;
	Mon, 10 Sep 2007 13:30:05 +0100
Date:	Mon, 10 Sep 2007 13:30:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jiri Slaby <jirislaby@gmail.com>
Cc:	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Adrian Bunk <bunk@kernel.org>,
	netdev@vger.kernel.org, rth@twiddle.net, dhowells@redhat.com,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] remove asm/bitops.h includes
Message-ID: <20070910123005.GB10143@linux-mips.org>
References: <30483262301654323266@pripojeni.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30483262301654323266@pripojeni.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Sep 08, 2007 at 09:00:08PM +0100, Jiri Slaby wrote:

> 
> remove asm/bitops.h includes
> 
> including asm/bitops directly may cause compile errors. don't include it
> and include linux/bitops instead. next patch will deny including asm header
> directly.
> 
> Cc: Adrian Bunk <bunk@kernel.org>
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

For the MIPS and hamradio bits:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf

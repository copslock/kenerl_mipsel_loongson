Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2008 00:08:08 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:17294
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20029804AbYG1XIB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 29 Jul 2008 00:08:01 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6SN5flT007812;
	Tue, 29 Jul 2008 00:06:01 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6SN5XkC007811;
	Tue, 29 Jul 2008 00:05:33 +0100
Date:	Tue, 29 Jul 2008 00:05:33 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jiri Slaby <jirislaby@gmail.com>
Cc:	Andrew Morton <akpm@linux-foundation.org>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Char: ds1286, eliminate busy waiting
Message-ID: <20080728230533.GB1430@linux-mips.org>
References: <1217008198-17143-1-git-send-email-jirislaby@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1217008198-17143-1-git-send-email-jirislaby@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 25, 2008 at 07:49:58PM +0200, Jiri Slaby wrote:

> ds1286_get_time(); is not called from atomic context, sleep for 20 ms is
> better choice than a (home-made) busy waiting for such a situation.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>

Looks ok to me I guess.  Though I don't really think it matters ...

Acked-by: Ralf Baechle <ralf@linux-mips.org>

The same condition also appears in drivers/char/rtc.c and maybe a few
others.  Rtc.c has been copies and modified several times.

  Ralf

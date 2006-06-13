Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jun 2006 14:34:46 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:21900 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133784AbWFMNei (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Jun 2006 14:34:38 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k5DDYbIi009745;
	Tue, 13 Jun 2006 14:34:37 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k5DDYb8O009744;
	Tue, 13 Jun 2006 14:34:37 +0100
Date:	Tue, 13 Jun 2006 14:34:37 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Rodolfo Giometti <giometti@linux.it>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] APM (emu) support
Message-ID: <20060613133437.GA9186@linux-mips.org>
References: <20060605154310.GF27426@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060605154310.GF27426@enneenne.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 05, 2006 at 05:43:10PM +0200, Rodolfo Giometti wrote:

> here my proposal to add APM (emu) support into mips tree. It's just
> the one for ARM adapted...
> 
> I have tested it on my au1100 based board with a battery pack. Also
> the command:
> 
>    $ apm --suspend
> 
> works correctly!

Looking good, indeed.

There is a sore spot though.  Your patch creates arch/mips/kernel/apm.c
as an essentially unmodified copy of arch/arch/kernel/apm.c and the
latter as you have found is actually portable code.  So I suggest you
rather move that file to drivers/char/ and use it for both architectures.

  Ralf

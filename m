Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Sep 2007 15:42:39 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:8117 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029381AbXI0Omh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Sep 2007 15:42:37 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8REgbQH010122;
	Thu, 27 Sep 2007 15:42:37 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8REgaKL010121;
	Thu, 27 Sep 2007 15:42:36 +0100
Date:	Thu, 27 Sep 2007 15:42:36 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <fbuihuu@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Don't abort the build process if '-msym32' isn't
	supported
Message-ID: <20070927144236.GA9763@linux-mips.org>
References: <46FBBDA0.4090403@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46FBBDA0.4090403@gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 27, 2007 at 04:26:40PM +0200, Franck Bui-Huu wrote:

> -msym32 and previously the strategy to tell the compiler to generate
> 64-bit code but the assembler to put it into 32-bit ELF was initially
> a hack to get around the lack of proper 64-bit binutils support and
> later turned into a neat optimization with significant code size
> savings.  But it's really just an optimization so there is nothing
> wrong with just dropping the option (and whatever else goes along with
> it, I forgot all the nasty details) on the floor if due to a vintage
> compiler it can't be suported.
> 
> Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
> ---
> 
>  Ralf,
> 
>  This patch is based on your linux-queue repository.
>  Thanks for the commit message ;)

Glad I'm useful for something ;-)

Queued for 2.6.24, thanks!

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2007 13:22:46 +0100 (BST)
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32216 "EHLO
	mailhub.stusta.mhn.de") by ftp.linux-mips.org with ESMTP
	id S20022169AbXGIMWo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jul 2007 13:22:44 +0100
Received: from r063144.stusta.swh.mhn.de (r063144.stusta.swh.mhn.de [10.150.63.144])
	by mailhub.stusta.mhn.de (Postfix) with ESMTP id 7979C181C2B;
	Mon,  9 Jul 2007 14:23:37 +0200 (CEST)
Received: by r063144.stusta.swh.mhn.de (Postfix, from userid 1000)
	id C9B0B3CFF0C; Mon,  9 Jul 2007 14:22:40 +0200 (CEST)
Date:	Mon, 9 Jul 2007 14:22:40 +0200
From:	Adrian Bunk <bunk@stusta.de>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] include/asm-mips/processor.h: "extern inline" ->
	"static inline"
Message-ID: <20070709122240.GY3492@stusta.de>
References: <20070707010330.GY3492@stusta.de> <20070709102754.GB24487@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20070709102754.GB24487@linux-mips.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <bunk@stusta.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@stusta.de
Precedence: bulk
X-list: linux-mips

On Mon, Jul 09, 2007 at 11:27:55AM +0100, Ralf Baechle wrote:
> On Sat, Jul 07, 2007 at 03:03:30AM +0200, Adrian Bunk wrote:
> 
> > "extern inline" will have different semantics with gcc 4.3,
> > and "static inline" is correct here.
> 
> The idea was to have a linker error in case gcc should deciede for some
> reason not to inline this function

If that's the intention, please use __always_inline instead.

> which as I understand will continue
> to be the behaviour of gcc 4.3?

In C99 (and therefore in gcc >= 4.3), "extern inline" means that the 
function should be compiled inline where the inline definition is seen, 
and that the compiler should also emit a copy of the function body with 
an externally visible symbol.

You don't want this.

>   Ralf

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

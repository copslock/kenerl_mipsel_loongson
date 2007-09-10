Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2007 14:03:58 +0100 (BST)
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35224 "EHLO
	mailhub.stusta.mhn.de") by ftp.linux-mips.org with ESMTP
	id S20021761AbXIJNDu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Sep 2007 14:03:50 +0100
Received: from r063144.stusta.swh.mhn.de (r063144.stusta.swh.mhn.de [10.150.63.144])
	by mailhub.stusta.mhn.de (Postfix) with ESMTP id 5A8C1182DC5;
	Mon, 10 Sep 2007 15:06:02 +0200 (CEST)
Received: by r063144.stusta.swh.mhn.de (Postfix, from userid 1000)
	id 1C56F3CE833; Mon, 10 Sep 2007 15:03:52 +0200 (CEST)
Date:	Mon, 10 Sep 2007 15:03:52 +0200
From:	Adrian Bunk <bunk@kernel.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Jiri Slaby <jirislaby@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, rth@twiddle.net,
	hskinnemoen@atmel.com, uclinux-dist-devel@blackfin.uclinux.org,
	dev-etrax@axis.com, dhowells@redhat.com, discuss@x86-64.org,
	linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
	parisc-linux@parisc-linux.org, sparclinux@vger.kernel.org,
	chris@zankel.net
Subject: Re: [PATCH 2/2] forbid asm/bitops.h direct inclusion
Message-ID: <20070910130352.GF3563@stusta.de>
References: <30483262301654323266@pripojeni.net> <276116173913632310@pripojeni.net> <20070910122838.GA10143@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20070910122838.GA10143@linux-mips.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 10, 2007 at 01:28:38PM +0100, Ralf Baechle wrote:
> On Sat, Sep 08, 2007 at 09:00:48PM +0100, Jiri Slaby wrote:
> 
> > forbid asm/bitops.h direct inclusion
> > 
> > Because of compile errors that may occur after bit changes if asm/bitops.h is
> > included directly without e.g. linux/kernel.h which includes linux/bitops.h, forbid
> > direct inclusion of asm/bitops.h. Thanks to Adrian Bunk.
> 
> This is the kind of thing that checkpatch.pl is already checking for and
> I like that idea much more than adding thousands of checks over many of
> the header files under asm.

Checks in the header are only for header files where including only the 
asm header doesn't work which doesn't seem to be the common case.

>   Ralf

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

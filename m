Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 13:34:51 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:26016 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022781AbXCZMeu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Mar 2007 13:34:50 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2QCYkPO012476;
	Mon, 26 Mar 2007 13:34:46 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2QCYjuT012475;
	Mon, 26 Mar 2007 13:34:45 +0100
Date:	Mon, 26 Mar 2007 13:34:45 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Thiemo Seufer <ths@networkno.de>, Kumba <kumba@gentoo.org>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
Message-ID: <20070326123445.GA12447@linux-mips.org>
References: <4603DA74.70707@gentoo.org> <20070324.002440.93023010.anemo@mba.ocn.ne.jp> <46049BAD.1010705@gentoo.org> <20070324.234727.25910303.anemo@mba.ocn.ne.jp> <20070324231602.GP2311@networkno.de> <46062400.8080307@gentoo.org> <20070325144515.GB21439@networkno.de> <Pine.LNX.4.64N.0703261234260.16083@blysk.ds.pg.gda.pl> <20070326115656.GA12086@linux-mips.org> <Pine.LNX.4.64N.0703261257590.16083@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0703261257590.16083@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 26, 2007 at 01:09:37PM +0100, Maciej W. Rozycki wrote:

> 
>  Hmm, from the back of my head I think it should not be a problem -- IIRC 
> the versions of GCC that did not support explicit relocs for 64-bit ELF 
> would force "-mno-explicit-relocs" internally even if asked otherwise.  
> They did not support "-msym32" either, which went in later, and then 
> non-PIC support for 64-bit explicit relocs went in earlier than for PIC -- 
> quite unsurprisingly, as %higher() and %highest() are not necessarily 
> rocket science unlike %disp() and friends.
> 
>  If anybody cares I could probably make the excavations needed to verify 
> the above.

That would be appreciated.  I did that on my side, I also tried to build
a few 64-bit test kernels with gcc 3.3 and 4.1.2 yesterday and did not
find any real reason why we would still need -mno-explicit-relocs.  Thiemo
said there was something like a modern gcc in combination with old
binutils.  That's the comination I haven't tested.

  Ralf

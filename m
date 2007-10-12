Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2007 19:45:55 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:59909 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20031284AbXJLSpr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 12 Oct 2007 19:45:47 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id E9D70D8D8; Fri, 12 Oct 2007 18:45:40 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 7AE2D54585; Fri, 12 Oct 2007 20:45:29 +0200 (CEST)
Date:	Fri, 12 Oct 2007 20:45:29 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	David Daney <ddaney@avtrex.com>, linux-mips@linux-mips.org
Subject: Re: Gcc 4.2.2 broken for kernel builds
Message-ID: <20071012184529.GI3163@deprecation.cyrius.com>
References: <20071012172254.GA10835@linux-mips.org> <470FB386.6080709@avtrex.com> <20071012175317.GB1110@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071012175317.GB1110@linux-mips.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Ralf Baechle <ralf@linux-mips.org> [2007-10-12 18:53]:
> > >  CC      drivers/mtd/mtd_blkdevs.o
> > >mipsel-linux-ld: drivers/mtd/.tmp_mtd_blkdevs.o: Can't find matching LO16 
> > >reloc against `$LC6' for R_MIPS_HI16 at 0x9e0 in section `.text'
> 
> If I had the time I'd have done that.  Short of that posting a warning is
> what I can do.

I cannot reproduce this (using gcc 4.2.2 and linux 2.6.22 with a
Cobalt config).  Can you append V=1 to make, run the gcc command by
hand and append --save-temps.  If you send me the .i file I'll make
sure all information is added to the bug report David opened.
-- 
Martin Michlmayr
http://www.cyrius.com/

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 12:57:03 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:33174 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022767AbXCZL5B (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Mar 2007 12:57:01 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2QBuvTx012123;
	Mon, 26 Mar 2007 12:56:57 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2QBuuNG012122;
	Mon, 26 Mar 2007 12:56:56 +0100
Date:	Mon, 26 Mar 2007 12:56:56 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Thiemo Seufer <ths@networkno.de>, Kumba <kumba@gentoo.org>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
Message-ID: <20070326115656.GA12086@linux-mips.org>
References: <4603DA74.70707@gentoo.org> <20070324.002440.93023010.anemo@mba.ocn.ne.jp> <46049BAD.1010705@gentoo.org> <20070324.234727.25910303.anemo@mba.ocn.ne.jp> <20070324231602.GP2311@networkno.de> <46062400.8080307@gentoo.org> <20070325144515.GB21439@networkno.de> <Pine.LNX.4.64N.0703261234260.16083@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0703261234260.16083@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14685
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 26, 2007 at 12:35:59PM +0100, Maciej W. Rozycki wrote:

> On Sun, 25 Mar 2007, Thiemo Seufer wrote:
> 
> > AFAICS this loses -mno-explicit-relocs completely, but it is needed for
> > all non-ckseg0 CONFIG_64BIT builds.
> 
>  Why?  I reckon GCC should support them just fine these days.

Please remember that we officially only require GCC 3.2 or newer.  3.2
turned out to be too broken to be supported for 64-bit builds but as long
as there is no significant problem I'd like to keep support for these
compiler antiques alive.

  Ralf

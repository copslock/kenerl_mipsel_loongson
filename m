Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2007 12:36:04 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:50626 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021751AbXIMLgC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Sep 2007 12:36:02 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8DBZxP5000345;
	Thu, 13 Sep 2007 12:35:59 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8DBZl7w000344;
	Thu, 13 Sep 2007 12:35:47 +0100
Date:	Thu, 13 Sep 2007 12:35:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	Matteo Croce <technoboy85@gmail.com>, linux-mips@linux-mips.org,
	Eugene Konev <ejka@imfi.kspu.ru>, netdev@vger.kernel.org,
	davem@davemloft.net, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
	jmorris@namei.org, yoshfuji@linux-ipv6.org, kaber@coreworks.de,
	openwrt-devel@lists.openwrt.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH][MIPS][7/7] AR7: ethernet
Message-ID: <20070913113547.GC31940@linux-mips.org>
References: <200709080143.12345.technoboy85@gmail.com> <200709080223.00613.technoboy85@gmail.com> <20070912165029.GG4571@linux-mips.org> <20070913014246.GB15247@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070913014246.GB15247@networkno.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 13, 2007 at 02:42:46AM +0100, Thiemo Seufer wrote:

> > All struct members here are sized such that there is no padding needed, so
> > the packed attribute doesn't buy you anything - unless of course the
> > entire structure is missaligned but I don't see how that would be possible
> > in this driver so the __attribute__ ((packed)) should go - it result in
> > somwhat larger and slower code.
> 
> FWIW, a modern gcc will warn about such superfluous packed attributes,
> that's another reason to remove those.

I doubt it will in this case; the packed structure is dereferenced by a
pointer so no way for gcc to know the alignment.

  Ralf

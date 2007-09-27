Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Sep 2007 01:24:42 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:51153 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20021597AbXI0AYc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Sep 2007 01:24:32 +0100
Received: from lagash (88-106-176-50.dynamic.dsl.as9105.com [88.106.176.50])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 4A600E03AB;
	Thu, 27 Sep 2007 02:24:26 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1IahB0-0006fG-5u; Thu, 27 Sep 2007 01:24:22 +0100
Date:	Thu, 27 Sep 2007 01:24:22 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	fbuihuu@gmail.com
Subject: Re: CONFIG_BUILD_ELF64 broken on IP32 since 2.6.20
Message-ID: <20070927002421.GA18945@networkno.de>
References: <20070925181353.GA15412@deprecation.cyrius.com> <20070926.110814.41629599.nemoto@toshiba-tops.co.jp> <20070926055912.GA3337@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070926055912.GA3337@deprecation.cyrius.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Martin Michlmayr wrote:
> * Atsushi Nemoto <anemo@mba.ocn.ne.jp> [2007-09-26 11:08]:
> > I think this is solved on current git a few weeks ago by this commit
> > (not mainlined yet):
> > > Subject: [MIPS] Fix CONFIG_BUILD_ELF64 kernels with symbols in CKSEG0.
> > > Gitweb: http://www.linux-mips.org/g/linux/db423f6e
> > It is just one liner and can be backported easily.
> 
> I put this into 2.6.22 and it works.  Thanks a lot for the link.
> 
> > I still think CONFIG_BUILD_ELF64=n is best choice.  You can get
> > smaller and faster kernel with this.  Are there any reason to use
> > CONFIG_BUILD_ELF64=y for IP32?
> 
> I don't know.  All I know is that it's enabled in the Debian kernel
> for IP22 and IP32 and has broken the kernel.  Thiemo, do you remember
> why this option is enabled in our kernels?

ISTR we needed this for older toolchains, it should be obsolete now
(for ip32).


Thiemo

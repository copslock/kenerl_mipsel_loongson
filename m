Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2007 07:19:41 +0100 (BST)
Received: from host205-174-dynamic.58-82-r.retail.telecomitalia.it ([82.58.174.205]:34824
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20029243AbXIZGTc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Sep 2007 07:19:32 +0100
Received: from eppesuig3 ([192.168.2.50])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1IaQF2-0000OO-Mt
	for linux-mips@linux-mips.org; Wed, 26 Sep 2007 08:19:26 +0200
Subject: Re: CONFIG_BUILD_ELF64 broken on IP32 since 2.6.20
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
In-Reply-To: <20070926055912.GA3337@deprecation.cyrius.com>
References: <20070925181353.GA15412@deprecation.cyrius.com>
	 <20070926.110814.41629599.nemoto@toshiba-tops.co.jp>
	 <20070926055912.GA3337@deprecation.cyrius.com>
Content-Type: text/plain
Date:	Wed, 26 Sep 2007 08:19:59 +0200
Message-Id: <1190787599.30051.4.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Il giorno mer, 26/09/2007 alle 07.59 +0200, Martin Michlmayr ha scritto:
> * Atsushi Nemoto <anemo@mba.ocn.ne.jp> [2007-09-26 11:08]:
> > I think this is solved on current git a few weeks ago by this commit
> > (not mainlined yet):
> > > Subject: [MIPS] Fix CONFIG_BUILD_ELF64 kernels with symbols in CKSEG0.
> > > Gitweb: http://www.linux-mips.org/g/linux/db423f6e
> > It is just one liner and can be backported easily.
> 
> I put this into 2.6.22 and it works.  Thanks a lot for the link.

I just checked that 2.6.23-rc8 include this patch, so I am going to try
it.

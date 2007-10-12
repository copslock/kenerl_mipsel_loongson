Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2007 20:15:42 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:16912 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20031313AbXJLTPd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 12 Oct 2007 20:15:33 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 5F6A8D8D8; Fri, 12 Oct 2007 19:14:57 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 4E70F54585; Fri, 12 Oct 2007 21:14:46 +0200 (CEST)
Date:	Fri, 12 Oct 2007 21:14:46 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	David Daney <ddaney@avtrex.com>,
	MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: Gcc 4.2.2 broken for kernel builds
Message-ID: <20071012191446.GK3163@deprecation.cyrius.com>
References: <20071012172254.GA10835@linux-mips.org> <470FB386.6080709@avtrex.com> <20071012175317.GB1110@linux-mips.org> <470FBE08.8090004@avtrex.com> <20071012184909.GA4832@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071012184909.GA4832@linux-mips.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Ralf Baechle <ralf@linux-mips.org> [2007-10-12 19:49]:
> > http://gcc.gnu.org/bugzilla/show_bug.cgi?id=33755
> > 
> > As more information becomes available about this feel free to add it to 
> > the GCC bug report.
> 
> For the moment the receipe to reproduce is to checkout
> 7b94a571d6f31ac6303d62c2aafcae40b66f24a3 from the linux-mips.org kernel
> tree (that's on linux-2.6.18-stable) and build malta_defconfig with
> gcc 4.2.2 and binutils 2.17 or 2.18, both configured for mipsel-linux.

Okay, I can see it.  I'll submit a testcase.
-- 
Martin Michlmayr
http://www.cyrius.com/

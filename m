Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2007 20:16:49 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:63423 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20031324AbXJLTQq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 12 Oct 2007 20:16:46 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9CJGk6t023983;
	Fri, 12 Oct 2007 20:16:46 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9CJGjSh023972;
	Fri, 12 Oct 2007 20:16:45 +0100
Date:	Fri, 12 Oct 2007 20:16:45 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	David Daney <ddaney@avtrex.com>,
	MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: Gcc 4.2.2 broken for kernel builds
Message-ID: <20071012191645.GB4832@linux-mips.org>
References: <20071012172254.GA10835@linux-mips.org> <470FB386.6080709@avtrex.com> <20071012175317.GB1110@linux-mips.org> <470FBE08.8090004@avtrex.com> <20071012184909.GA4832@linux-mips.org> <20071012191446.GK3163@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071012191446.GK3163@deprecation.cyrius.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 12, 2007 at 09:14:46PM +0200, Martin Michlmayr wrote:

> > For the moment the receipe to reproduce is to checkout
> > 7b94a571d6f31ac6303d62c2aafcae40b66f24a3 from the linux-mips.org kernel
> > tree (that's on linux-2.6.18-stable) and build malta_defconfig with
> > gcc 4.2.2 and binutils 2.17 or 2.18, both configured for mipsel-linux.
> 
> Okay, I can see it.  I'll submit a testcase.

Thanks :-)

  Ralf

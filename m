Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2009 15:14:20 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:52052 "EHLO
	roarinelk.homelinux.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025425AbZD2OON (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 29 Apr 2009 15:14:13 +0100
Received: (qmail 25946 invoked by uid 1000); 29 Apr 2009 16:14:11 +0200
Date:	Wed, 29 Apr 2009 16:14:11 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: oops in futex_init()
Message-ID: <20090429141411.GA25905@roarinelk.homelinux.net>
References: <20090428124645.GA14347@roarinelk.homelinux.net> <20090429060317.GB15627@linux-mips.org> <20090429082556.GA22844@roarinelk.homelinux.net> <20090429083349.GB26289@linux-mips.org> <20090429114042.GA24576@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090429114042.GA24576@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips


FWIW, I think I fixed it: I have a small area (< 4kB) with a lot of UARTs
and 3 interrupt controllers in it.  An ioremap() was done for each uart and
irq ctl area.  Now there's one ioremap of the whole area and the oops is
gone.  I don't know why, but it seems fixed. (The oops appeared after one
of the remapped areas was touched).

Thanks!
	Manuel Lauss

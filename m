Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2009 15:35:28 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:38065 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S20025457AbZD2Of0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Apr 2009 15:35:26 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3TEZN1B015883;
	Wed, 29 Apr 2009 16:35:24 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3TEZN31015881;
	Wed, 29 Apr 2009 16:35:23 +0200
Date:	Wed, 29 Apr 2009 16:35:23 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: oops in futex_init()
Message-ID: <20090429143523.GA10242@linux-mips.org>
References: <20090428124645.GA14347@roarinelk.homelinux.net> <20090429060317.GB15627@linux-mips.org> <20090429082556.GA22844@roarinelk.homelinux.net> <20090429083349.GB26289@linux-mips.org> <20090429114042.GA24576@roarinelk.homelinux.net> <20090429141411.GA25905@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090429141411.GA25905@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 29, 2009 at 04:14:11PM +0200, Manuel Lauss wrote:

> FWIW, I think I fixed it: I have a small area (< 4kB) with a lot of UARTs
> and 3 interrupt controllers in it.  An ioremap() was done for each uart and
> irq ctl area.  Now there's one ioremap of the whole area and the oops is
> gone.  I don't know why, but it seems fixed. (The oops appeared after one
> of the remapped areas was touched).

That should be benign - especially if the mappings are for physical
addresses < 512MB which would become mapped as KSEG1 addresses.  The
dangerous cases are where multiple mappings alias (can't happen on
Alchemy caches) or where different machines use different cache modes
which also shouldn't hit you because I/O addresses should be mapped
uncachable.  So you may want to try out what Kevin suggested to get to
the root of this.

  Ralf

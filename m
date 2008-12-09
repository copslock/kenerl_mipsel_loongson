Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Dec 2008 18:36:40 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:30379 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S24189510AbYLISgf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 9 Dec 2008 18:36:35 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mB9IaYQ4006402;
	Tue, 9 Dec 2008 18:36:34 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mB9IaYl4006400;
	Tue, 9 Dec 2008 18:36:34 GMT
Date:	Tue, 9 Dec 2008 18:36:34 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Arnaud Patard <apatard@mandriva.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: xorg-server-1.5.2 doesn't work because of missing sysfs pci
	resource files
Message-ID: <20081209183634.GA2418@linux-mips.org>
References: <20081205154339.GA14327@adriano.hkcable.com.hk> <20081206102030.GA9410@linux-mips.org> <m3k5a9kyc6.fsf@anduin.mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3k5a9kyc6.fsf@anduin.mandriva.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 09, 2008 at 07:17:13PM +0100, Arnaud Patard wrote:

> What about things like _CACHE_UNCACHED_ACCELERATED ? Is there a way to
> use this flag ?

That's possible but will require some additional care in the code.
Multiple mappings using different cache modes need to be avoided and
also not all processors support _CACHE_UNCACHED_ACCELERATED.

If you know your software is playing nice and your CPU supports
_CACHE_UNCACHED_ACCELERATED, you can hack the mmap function to use
_CACHE_UNCACHED_ACCELERATED if write_combine is set.  Just for now
and for something which I'm planning to push for 2.6.28 I don't want
anything that's more than trivial.

  Ralf

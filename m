Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jan 2008 16:37:22 +0000 (GMT)
Received: from p549F766A.dip.t-dialin.net ([84.159.118.106]:43161 "EHLO
	lappi.linux-mips.net") by ftp.linux-mips.org with ESMTP
	id S20033271AbYAUQhI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 21 Jan 2008 16:37:08 +0000
Received: from localhost ([127.0.0.1] helo=dl5rb.ham-radio-op.net)
	by lappi.linux-mips.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <ralf@linux-mips.org>)
	id 1JGzdy-0005RF-Sw
	for linux-mips@linux-mips.org; Mon, 21 Jan 2008 17:37:07 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0LGb3nD015664;
	Mon, 21 Jan 2008 16:37:03 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0LGb3J6015663;
	Mon, 21 Jan 2008 16:37:03 GMT
Date:	Mon, 21 Jan 2008 16:37:03 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sunil Amitkumar Janki <devel.sjanki@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Fu Long 2.6.24-rc8 undefined error "pcibios_enable_device" and
	"register_pci_controller" in [drivers/ssb/ssb.ko]
Message-ID: <20080121163703.GA15624@linux-mips.org>
References: <767364c50801210450r7a3e4d23o2c21d4c2cbac15c6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <767364c50801210450r7a3e4d23o2c21d4c2cbac15c6@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 21, 2008 at 01:50:50PM +0100, Sunil Amitkumar Janki wrote:

> I reported this before but I just rebuilt 2.6.24-rc8 for Lemote Fu
> Long and still get the
> same error.
> 
> ERROR: "pcibios_enable_device" [drivers/ssb/ssb.ko] undefined!
> ERROR: "register_pci_controller" [drivers/ssb/ssb.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
> 
> It looks like the ssb driver has been written and tested only for
> Sibyte platforms but
> it's getting included for Fu Long too and there's no easy way to
> disable it in my kernel
> config.
> 
> I'm not up to the task to fix this problem yet, but hopefully when
> I've read some
> kernel programming books, I'll be able to contribute real fixes in the future.

Don't enable the SSB stuff.  It's configuration is fairly foobar'ed;
you should not be able to enable it.

  Ralf

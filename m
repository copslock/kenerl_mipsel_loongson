Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Apr 2009 11:41:39 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:49915 "EHLO
	roarinelk.homelinux.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20026473AbZD3Klc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Apr 2009 11:41:32 +0100
Received: (qmail 1903 invoked by uid 1000); 30 Apr 2009 12:41:30 +0200
Date:	Thu, 30 Apr 2009 12:41:30 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ralf Baechle <ralf@linux-mips.org>,
	"Kevin D. Kissell" <kevink@paralogos.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: oops in futex_init()
Message-ID: <20090430104130.GA1878@roarinelk.homelinux.net>
References: <20090428124645.GA14347@roarinelk.homelinux.net> <20090429060317.GB15627@linux-mips.org> <20090429082556.GA22844@roarinelk.homelinux.net> <20090429083349.GB26289@linux-mips.org> <20090429114042.GA24576@roarinelk.homelinux.net> <20090429141411.GA25905@roarinelk.homelinux.net> <20090429143523.GA10242@linux-mips.org> <20090429153221.GA26387@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090429153221.GA26387@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi,

This is really embarrassing:  The oops is what happens when you
ioremap(0x10) and write 0xffffffff at the resulting address (0xa0000010).

Thanks for your time!
	Manuel Lauss

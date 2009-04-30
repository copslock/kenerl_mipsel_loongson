Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Apr 2009 12:22:51 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:50778 "EHLO
	roarinelk.homelinux.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20026473AbZD3LWo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Apr 2009 12:22:44 +0100
Received: (qmail 2190 invoked by uid 1000); 30 Apr 2009 13:22:43 +0200
Date:	Thu, 30 Apr 2009 13:22:43 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	"Kevin D. Kissell" <kevink@paralogos.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: oops in futex_init()
Message-ID: <20090430112243.GA2164@roarinelk.homelinux.net>
References: <20090428124645.GA14347@roarinelk.homelinux.net> <20090429060317.GB15627@linux-mips.org> <20090429082556.GA22844@roarinelk.homelinux.net> <20090429083349.GB26289@linux-mips.org> <20090429114042.GA24576@roarinelk.homelinux.net> <20090429141411.GA25905@roarinelk.homelinux.net> <20090429143523.GA10242@linux-mips.org> <20090429153221.GA26387@roarinelk.homelinux.net> <20090430104130.GA1878@roarinelk.homelinux.net> <49F98826.3030708@paralogos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49F98826.3030708@paralogos.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Thu, Apr 30, 2009 at 01:14:46PM +0200, Kevin D. Kissell wrote:
> Manuel Lauss wrote:
> > Hi,
> >
> > This is really embarrassing:  The oops is what happens when you
> > ioremap(0x10) and write 0xffffffff at the resulting address (0xa0000010).
> >   
> This pretty much implies that _CACHE_UNCACHED was passed in the flags
> value to ioremap, so it simply returned the kseg1 address.  By any

uncached is default for plain ioremap(), says io.h:

#define ioremap(offset, size)                                           \
        __ioremap_mode((offset), (size), _CACHE_UNCACHED)

Apparently one can ioremap everything on mips except RAM in use at
0x8xxxxxxxx.

	Manuel Lauss

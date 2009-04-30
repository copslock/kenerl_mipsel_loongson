Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Apr 2009 12:51:06 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:51179 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S20026042AbZD3LvE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Apr 2009 12:51:04 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3UBp35b013899;
	Thu, 30 Apr 2009 13:51:03 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3UBp1vH013897;
	Thu, 30 Apr 2009 13:51:01 +0200
Date:	Thu, 30 Apr 2009 13:51:01 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	"Kevin D. Kissell" <kevink@paralogos.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: oops in futex_init()
Message-ID: <20090430115101.GA11656@linux-mips.org>
References: <20090429060317.GB15627@linux-mips.org> <20090429082556.GA22844@roarinelk.homelinux.net> <20090429083349.GB26289@linux-mips.org> <20090429114042.GA24576@roarinelk.homelinux.net> <20090429141411.GA25905@roarinelk.homelinux.net> <20090429143523.GA10242@linux-mips.org> <20090429153221.GA26387@roarinelk.homelinux.net> <20090430104130.GA1878@roarinelk.homelinux.net> <49F98826.3030708@paralogos.com> <20090430112243.GA2164@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090430112243.GA2164@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 30, 2009 at 01:22:43PM +0200, Manuel Lauss wrote:

> uncached is default for plain ioremap(), says io.h:
> 
> #define ioremap(offset, size)                                           \
>         __ioremap_mode((offset), (size), _CACHE_UNCACHED)
> 
> Apparently one can ioremap everything on mips except RAM in use at
> 0x8xxxxxxxx.

Yes, it's GIGO - garbage in, garbage out.

  Ralf

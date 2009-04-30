Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Apr 2009 12:23:29 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:41715 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S20026477AbZD3LXL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Apr 2009 12:23:11 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3UBN9nn012825;
	Thu, 30 Apr 2009 13:23:10 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3UBN6RN012823;
	Thu, 30 Apr 2009 13:23:06 +0200
Date:	Thu, 30 Apr 2009 13:23:06 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	"Kevin D. Kissell" <kevink@paralogos.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: oops in futex_init()
Message-ID: <20090430112305.GA12355@linux-mips.org>
References: <20090428124645.GA14347@roarinelk.homelinux.net> <20090429060317.GB15627@linux-mips.org> <20090429082556.GA22844@roarinelk.homelinux.net> <20090429083349.GB26289@linux-mips.org> <20090429114042.GA24576@roarinelk.homelinux.net> <20090429141411.GA25905@roarinelk.homelinux.net> <20090429143523.GA10242@linux-mips.org> <20090429153221.GA26387@roarinelk.homelinux.net> <20090430104130.GA1878@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090430104130.GA1878@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 30, 2009 at 12:41:30PM +0200, Manuel Lauss wrote:

> This is really embarrassing:  The oops is what happens when you
> ioremap(0x10) and write 0xffffffff at the resulting address (0xa0000010).

That address is the TLB reload handler.  You just overwrote the TLB
exception hander.  0xffffffff is sd $31, -1($31) which is a MIPS III
that is 64-bit instruction which the Alchemy core duly honors with a
reserved instruction exception.  The handler is running with
c0_status.exl=1 so the EPC will point to the LL instruction but the
exception printed in the panic will be the 2nd exception.  Case closed,
I'd say.

  Ralf

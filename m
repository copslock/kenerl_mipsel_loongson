Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jul 2007 19:09:06 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:52959 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022742AbXGWSJE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jul 2007 19:09:04 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6NI93uS001296;
	Mon, 23 Jul 2007 19:09:03 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6NI929I001292;
	Mon, 23 Jul 2007 19:09:02 +0100
Date:	Mon, 23 Jul 2007 19:09:02 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: Silicon Motion framebuffer
Message-ID: <20070723180902.GA1086@linux-mips.org>
References: <20070723155814.GA19111@linux-mips.org> <20070723160555.GA2608@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070723160555.GA2608@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 23, 2007 at 06:05:55PM +0200, Manuel Lauss wrote:

> On Mon, Jul 23, 2007 at 04:58:14PM +0100, Ralf Baechle wrote:
> > So there is this SM501 Voyager sitting in the lmo tree for ages.  So the
> > usual question, is anybody still using / interested in this driver?  Or
> > possibly even interested in taking over maintainership for the thing and
> > pushing it upstream?
> 
> There's already a well-working SM501 MFD and framebuffer driver in upstream
> since about 2.6.21.  I'd say get rid of the mips version and encourage
> people to test the new driver.

So I removed it.

  Ralf

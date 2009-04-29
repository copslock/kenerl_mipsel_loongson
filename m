Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2009 15:20:54 +0100 (BST)
Received: from gateway06.websitewelcome.com ([69.93.154.20]:35545 "HELO
	gateway06.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S20025365AbZD2OUr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 29 Apr 2009 15:20:47 +0100
Received: (qmail 15511 invoked from network); 29 Apr 2009 14:23:59 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway06.websitewelcome.com with SMTP; 29 Apr 2009 14:23:59 -0000
Received: from [217.109.65.213] (port=3977 helo=[127.0.0.1])
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1LzAeO-0006Bx-Sn; Wed, 29 Apr 2009 09:20:41 -0500
Message-ID: <49F8623E.9010807@paralogos.com>
Date:	Wed, 29 Apr 2009 16:20:46 +0200
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: oops in futex_init()
References: <20090428124645.GA14347@roarinelk.homelinux.net> <20090429060317.GB15627@linux-mips.org> <20090429082556.GA22844@roarinelk.homelinux.net> <20090429083349.GB26289@linux-mips.org> <20090429114042.GA24576@roarinelk.homelinux.net> <20090429141411.GA25905@roarinelk.homelinux.net>
In-Reply-To: <20090429141411.GA25905@roarinelk.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Manuel Lauss wrote:
> FWIW, I think I fixed it: I have a small area (< 4kB) with a lot of UARTs
> and 3 interrupt controllers in it.  An ioremap() was done for each uart and
> irq ctl area.  Now there's one ioremap of the whole area and the oops is
> gone.  I don't know why, but it seems fixed. (The oops appeared after one
> of the remapped areas was touched).
By any chance would it be possible for you to revert to the failing
configuration and dump the contents of the TLB at the oops?  Your
description makes it sound like the multiple ioremaps are generating
duplicate or otherwise conflicting TLB entries.  If that's so, there's a
bug in the TLB management code to be hunted down and killed while we
have a test case...

          Regards,

          Kevin K.

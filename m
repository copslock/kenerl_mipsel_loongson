Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jul 2007 17:05:58 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:43025 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20022720AbXGWQF4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jul 2007 17:05:56 +0100
Received: (qmail 2862 invoked by uid 1000); 23 Jul 2007 18:05:55 +0200
Date:	Mon, 23 Jul 2007 18:05:55 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Silicon Motion framebuffer
Message-ID: <20070723160555.GA2608@roarinelk.homelinux.net>
References: <20070723155814.GA19111@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070723155814.GA19111@linux-mips.org>
User-Agent: Mutt/1.5.11
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Mon, Jul 23, 2007 at 04:58:14PM +0100, Ralf Baechle wrote:
> So there is this SM501 Voyager sitting in the lmo tree for ages.  So the
> usual question, is anybody still using / interested in this driver?  Or
> possibly even interested in taking over maintainership for the thing and
> pushing it upstream?

There's already a well-working SM501 MFD and framebuffer driver in upstream
since about 2.6.21.  I'd say get rid of the mips version and encourage
people to test the new driver.

Thanks,
	Manuel Lauss

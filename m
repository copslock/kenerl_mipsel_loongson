Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Feb 2008 04:25:07 +0000 (GMT)
Received: from rs25s3.datacenter.cha.cantv.net ([200.44.33.18]:65413 "EHLO
	rs25s3.datacenter.cha.cantv.net") by ftp.linux-mips.org with ESMTP
	id S20021794AbYBLEY6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Feb 2008 04:24:58 +0000
Received: from [192.168.0.2] (dC9D08FD6.dslam-04-10-6-02-1-01.apr.dsl.cantv.net [201.208.143.214])
	by rs25s3.datacenter.cha.cantv.net (8.13.8/8.13.0/3.0) with ESMTP id m1C4OnCb028417;
	Mon, 11 Feb 2008 23:54:50 -0430
X-Matched-Lists: []
Message-ID: <47B0EA85.4080707@cantv.net>
Date:	Mon, 11 Feb 2008 20:38:29 -0400
From:	Ricardo Mendoza <ricmm@cantv.net>
User-Agent: Thunderbird 2.0.0.0 (X11/20070601)
MIME-Version: 1.0
To:	ben@hodgens.net
CC:	linux-mips@linux-mips.org
Subject: Re: General info on kernel status for vr4121/MobilePro 780
References: <47B0F164.8080401@hodgens.net>
In-Reply-To: <47B0F164.8080401@hodgens.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <ricmm@cantv.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ricmm@cantv.net
Precedence: bulk
X-list: linux-mips

Ben Hodgens wrote:
> I'm attempting build a system around an NEC MobilePro 780, and as there
> does not appear to be full support (ie, can't seem to get a kernel to
> boot) in either the current 2.4 or 2.6 kernel trees.
> 
> Here's what I've found and tried so far:
> 
> * The Linux VR project's "latest" kernel, circa 2001 or something like
> that - linux-vr-0.1.1.tar.bz2. This does not actually have an option for
> the MobilePro 780 in the kernel config, though there is the 770.
> * The kernel on http://www.handhelds.org/moin/moin.cgi/NecMobilePro780.
> This one -appears- to be the most complete I've found with regard to the
> 780; however, the tree is a 2.3 base (2.3.99 or something like that, I
> think), and not only pretty damn old, but I'm having a difficult time
> building it with the MIPS Technologies toolchain as a result. (Nothing I
> think I won't be able to figure out eventually - just makefile issues -
> but I don't want to persue it too much if there's a better alternative
> to start with). Additionally, this page has a binary kernel (and rootfs)
> which boots, but it doesn't boot with either a Debian sarge or etch
> bootstrap-installed rootfs (this is probably related to devfs, Ithink).
> * Both the latest 2.4 and 2.6 kernels don't have explicit support for
> the MP. I don't know where to go from here to where I want to go, though
> if there's nothing current in the current trees, I figure I'll learn to
> port drivers (provided I can figure which is the current latest support
> for the MP).
> 
> So I'm asking: does anyone know where else I might look? If there is no
> current kernel tree which builds, does anyone know where the
> current/most up-to-date device support for the MobilePro is kept, or in
> which kernel it's in?

Current l-m.o tree has vr41xx support thanks to Yoichi, that's the best
starting point. But as you said, support for the board itself is not
there as a whole, there were some drivers for kbd/tpanel/fb around from
an old project (not linux-vr), just gotta look for them.

Afterwards, just mix the ingredients and bake the pie.


     Ricardo

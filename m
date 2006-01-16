Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2006 16:55:21 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:43282 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133509AbWAPQzC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jan 2006 16:55:02 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 0D12064D54; Mon, 16 Jan 2006 16:58:33 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 475AF8517; Mon, 16 Jan 2006 16:58:25 +0000 (GMT)
Date:	Mon, 16 Jan 2006 16:58:25 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	akpm@osdl.org
Cc:	Linux MIPS List <linux-mips@linux-mips.org>,
	grundler@parisc-linux.org
Subject: Re: Tulip RaQ2 64 Bit Fix
Message-ID: <20060116165825.GG5798@deprecation.cyrius.com>
References: <4393CD9F.3090305@jg555.com> <20051205114456.GA2728@linux-mips.org> <20060116160355.GB28383@deprecation.cyrius.com> <43CBC97E.3090800@jg555.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CBC97E.3090800@jg555.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Jim Gifford <maillist@jg555.com> [2006-01-16 08:27]:
> >>>The attached patch allows the tulip driver to work with the RaQ2's
> >>>network adapter. Without the patch under a 64 bit build, it will
> >>>never negotiate and will drop packets. This driver is part of
> >>>Linux Parisc, by Grant Grundler. It's currently in -mm, but Jeff
> >>>Garzick will not apply it to the main tree.
> >>>      
> >>Why?
> Jeff Garzick refuses to apply it do to spinlocks. Andrew Morton is
> including in his tree because it fixes issue with Parisc and with
> MIPS based builds. So it's kinda of what is the right thing to do. I
> also use this driver on my x86 builds, and it actually performs
> better. Here is a little history of how Grant made the driver.
> 
> Grant Grundler is the network maintainer for Parisc Linux.  He
> discovered that the tulip driver didn't perform that well. He
> researched the manufactures documentation and found out how to fix
> the driver to work to its optimum performance. He did this back in
> 2003, has submitted it to Jeff Garzick several times with no
> response. Around late 2004, I started to do test builds on 64 bit on
> my RaQ2 and discovered that the driver would not auto-negotiate
> transfer speeds. Talked to numerous people, then someone put me in
> touch with Grant. I tested the driver for about 2 weeks, ask Grant
> why it wasn't sent upstream, he told me about the spinlock issue. I
> then contacted Andrew Morton, explained everything as I am here, and
> he agreed it was needed and tried to get Jeff to add it. Jeff sends
> back a one liner say doing to it's use of spinlocks it's not
> accepted.

Andrew, do you think that issue will be resolved in some way at some
point?

-- 
Martin Michlmayr
http://www.cyrius.com/

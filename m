Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2006 16:01:36 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:65297 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133495AbWAPQBP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jan 2006 16:01:15 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 3BFB164D54; Mon, 16 Jan 2006 16:04:43 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 856D88517; Mon, 16 Jan 2006 16:03:55 +0000 (GMT)
Date:	Mon, 16 Jan 2006 16:03:55 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Jim Gifford <maillist@jg555.com>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Tulip RaQ2 64 Bit Fix
Message-ID: <20060116160355.GB28383@deprecation.cyrius.com>
References: <4393CD9F.3090305@jg555.com> <20051205114456.GA2728@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051205114456.GA2728@linux-mips.org>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Ralf Baechle <ralf@linux-mips.org> [2005-12-05 11:44]:
> > The attached patch allows the tulip driver to work with the RaQ2's
> > network adapter. Without the patch under a 64 bit build, it will
> > never negotiate and will drop packets. This driver is part of
> > Linux Parisc, by Grant Grundler. It's currently in -mm, but Jeff
> > Garzick will not apply it to the main tree.
> 
> Why?

Jim, I don't think you ever responded to this.

Do you know the status of this patch?
-- 
Martin Michlmayr
http://www.cyrius.com/

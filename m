Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jan 2005 13:49:35 +0000 (GMT)
Received: from pD95620DD.dip.t-dialin.net ([IPv6:::ffff:217.86.32.221]:19262
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225192AbVATNta>; Thu, 20 Jan 2005 13:49:30 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j0KDnSnj003792;
	Thu, 20 Jan 2005 14:49:28 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j0KDnMm7003781;
	Thu, 20 Jan 2005 14:49:22 +0100
Date:	Thu, 20 Jan 2005 14:49:22 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	moreau francis <francis_moreau2000@yahoo.fr>
Cc:	linux-mips@linux-mips.org
Subject: Re: dcache issue...
Message-ID: <20050120134922.GA3684@linux-mips.org>
References: <20050120111543.38076.qmail@web25105.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120111543.38076.qmail@web25105.mail.ukl.yahoo.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 20, 2005 at 12:15:43PM +0100, moreau francis wrote:

> I almost done to run linux in kseg2. But I noticed a
> bug
> related to the cache that I can't explain. Maybe
> you'll
> have an idea...
> 
> I configured kseg2 to map kernel space, and to be
> "uncached". So when accessing kernel space, virtual
> addr > 0xc0000000, I don't use both icache and dcache.
> When kernel maps a user page in user space, it uses
> data cache. In this scenario, some kernel data are
> corrupted. But when I map kernel space and activate
> caches to access it, it seems to work.

Live is tough, use caches ;-)

Mixing different cache modes for results in unspecified behaviour, such
as data corruption.

  Ralf

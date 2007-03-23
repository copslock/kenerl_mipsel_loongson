Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2007 16:23:43 +0000 (GMT)
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:6564 "EHLO
	mail-gw1.sa.eol.hu") by ftp.linux-mips.org with ESMTP
	id S20022388AbXCWQXl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Mar 2007 16:23:41 +0000
Received: from dorka.pomaz.szeredi.hu (245-248.dyn-fa.pool.ew.hu [193.226.245.248])
	by mail-gw1.sa.eol.hu (mu) with ESMTP id l2NGMUd5015351;
	Fri, 23 Mar 2007 17:22:32 +0100
Received: from miko by dorka.pomaz.szeredi.hu with local (Exim 3.36 #1 (Debian))
	id 1HUmX0-0004gd-00; Fri, 23 Mar 2007 17:22:22 +0100
To:	ralf@linux-mips.org
CC:	linux-mips@linux-mips.org, Ravi.Pratap@hillcrestlabs.com
In-reply-to: <20070323141939.GB17311@linux-mips.org> (message from Ralf
	Baechle on Fri, 23 Mar 2007 14:19:39 +0000)
Subject: Re: flush_anon_page for MIPS
References: <E1HUVlw-00034H-00@dorka.pomaz.szeredi.hu> <20070323141939.GB17311@linux-mips.org>
Message-Id: <E1HUmX0-0004gd-00@dorka.pomaz.szeredi.hu>
From:	Miklos Szeredi <miklos@szeredi.hu>
Date:	Fri, 23 Mar 2007 17:22:22 +0100
Return-Path: <miklos@szeredi.hu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miklos@szeredi.hu
Precedence: bulk
X-list: linux-mips

Ralf,

Thanks for looking into this.

> See why such stuff is happening?  Providing a default implemntation may be
> fine for i.e. strcpy() where it's only about providing a better mouse
> trap than the standard one in lib/string.c.  It's an awfully bad idea for
> something that matters for correctness such as flush_anon_page() ...

Well, James Bottomley discussed this approach on linux-arch back then,
so you could have raised objections.

I don't like this whole flush_anon_page() approach, but nobody
(including me) seems to be interested enough in finding a better one ;)

Miklos

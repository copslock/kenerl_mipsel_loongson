Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Oct 2006 11:51:10 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:4110 "EHLO sorrow.cyrius.com")
	by ftp.linux-mips.org with ESMTP id S20039649AbWJXKvG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Oct 2006 11:51:06 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 547C964D3F; Tue, 24 Oct 2006 10:50:52 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 4B50054B37; Tue, 24 Oct 2006 11:50:43 +0100 (BST)
Date:	Tue, 24 Oct 2006 11:50:42 +0100
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Dominique Quatravaux <dom@kilimandjaro.dyndns.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Massive clock drift on Cobalt Raq2 after upgrade to 2.6.18-1-r5k-cobalt
Message-ID: <20061024105042.GG23293@deprecation.cyrius.com>
References: <453DECAD.7070805@kilimandjaro.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453DECAD.7070805@kilimandjaro.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Dominique Quatravaux <dom@kilimandjaro.dyndns.org> [2006-10-24 12:36]:
> The subject line pretty much says it all: between yesterday morning and
> both my system clock and my uptime increased by about 2 days while only
> 10 hours actually elapsed... I was previously using kernel
> 2.4.27-r5k-cobalt (also from Debian) and the clock worked fine.
> 
> How do I go about correcting the problem? I upgraded the kernel without
> powering off, should I power-cycle now?

You need to upgrade to 2.6.18-1-r5k-cobalt version 2.6.18-3 which
contains a fix for this.
-- 
Martin Michlmayr
http://www.cyrius.com/

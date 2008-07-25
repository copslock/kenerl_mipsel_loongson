Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Jul 2008 00:47:47 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:54800 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S28581770AbYGYXrk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 26 Jul 2008 00:47:40 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 9029FD8DB; Fri, 25 Jul 2008 23:47:37 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id B765315100A; Fri, 25 Jul 2008 16:46:05 -0700 (PDT)
Date:	Fri, 25 Jul 2008 16:46:05 -0700
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Glyn Astill <glynastill@yahoo.co.uk>
Cc:	linux-mips@linux-mips.org
Subject: Re: Debian etch on cobalt
Message-ID: <20080725234605.GE2512@deprecation.cyrius.com>
References: <633357.76258.qm@web25808.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <633357.76258.qm@web25808.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Glyn Astill <glynastill@yahoo.co.uk> [2008-07-25 21:45]:
> I tried subscribing to the debian mipsel ilist with no luck.

There's no debian-mipsel list.  debian-mips is used to discuss both
the mips and mipsel ports.

> When I start compiling postgres 8.3.3 it crashes randomly, if I keep
> rebooting I can get it compiled, however theres something seriously
> sh*gged here.
> 
> Are there known problems?

It's not a known problem.  Do you have a serial console?  Is anything
printed on it when the machine crashes, or is it a hard lockup without
anything on the console?
-- 
Martin Michlmayr
http://www.cyrius.com/

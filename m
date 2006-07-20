Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jul 2006 16:36:43 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:35854 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133505AbWGTPge (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Jul 2006 16:36:34 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 5775D64D54; Thu, 20 Jul 2006 15:36:27 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 9CC9366ED2; Thu, 20 Jul 2006 17:36:29 +0200 (CEST)
Date:	Thu, 20 Jul 2006 17:36:29 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	Gary Smith <gary.smith@3phoenix.com>, linux-mips@linux-mips.org
Subject: Re: IDE on Swarm
Message-ID: <20060720153629.GH26731@deprecation.cyrius.com>
References: <000601c6ac09$0c262f30$6dacaac0@3PiGAS> <20060720153208.GC4350@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060720153208.GC4350@networkno.de>
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Thiemo Seufer <ths@networkno.de> [2006-07-20 16:32]:
> > in Linux 2.6 during the late 2004 time-frame.  I'd like to inquire about the
> > current availability of the IDE driver in the kernel.
> The SWARM onboard IDE works for me with the appended patch. (Originally from
> Peter Horton <pdh@colonel-panic.org>.)

I think the problem is that PCMCIA support was never ported to 2.6.
Peter 'p2' De Schrijver wanted to work on this but I've no idea what
the progress is.
-- 
Martin Michlmayr
http://www.cyrius.com/

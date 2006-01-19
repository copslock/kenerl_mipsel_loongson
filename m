Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 21:43:20 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:59405 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8134553AbWASVm5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Jan 2006 21:42:57 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id C1B3A64D54; Thu, 19 Jan 2006 21:46:09 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 3442D854A; Thu, 19 Jan 2006 21:45:47 +0000 (GMT)
Date:	Thu, 19 Jan 2006 21:45:46 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Fix a CPU definition for Cobalt
Message-ID: <20060119214546.GB10040@deprecation.cyrius.com>
References: <20060119192414.GA26798@deprecation.cyrius.com> <20060119210440.GE3398@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119210440.GE3398@linux-mips.org>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Ralf Baechle <ralf@linux-mips.org> [2006-01-19 21:04]:
> > If cpu_icache_snoops_remote_store is not set, Cobalt will crash
> > immediately when starting the kernel.
> That's papering over the actual bug.  The CPU has no scache, so the

Sorry, I just used trial and error to find out which option caused the
problem and changed it...

> scache flushing functions aren't getting initialized and the NULL
> pointer is eventually called as a function.  So I suggest this below.
> Can you test it?

Doesn't work.
-- 
Martin Michlmayr
http://www.cyrius.com/

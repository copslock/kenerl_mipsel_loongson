Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 12:54:54 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:36876 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S3458578AbWAWMyg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jan 2006 12:54:36 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 6000464D3F; Mon, 23 Jan 2006 12:58:31 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 1DA97846B; Mon, 23 Jan 2006 12:58:14 +0000 (GMT)
Date:	Mon, 23 Jan 2006 12:58:14 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Mark Mason <mason@broadcom.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Building the kernel for a Broadcom SB1
Message-ID: <20060123125813.GB27611@deprecation.cyrius.com>
References: <20050915205904.16380.qmail@web31515.mail.mud.yahoo.com> <4329ED24.50506@broadcom.com> <20060116160542.GC28383@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060116160542.GC28383@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Martin Michlmayr <tbm@cyrius.com> [2006-01-16 16:05]:
> > >Anyway, there are a few symbols undefined, which is >causing
> > problems. First off the bat is TO_PHYS_MASK.  >There is no set of
> > definitions in >include/asm-mips/addrspace.h for the SB1 processor.
> Can this patch be applied?

Actually, no, SB1 is defined in addrspace.h already and this leads to
a redefinition.  The values that would've been used with your patch
and the current values are slightly different though; maybe you
can check that.  Current git works though.
-- 
Martin Michlmayr
http://www.cyrius.com/

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Nov 2009 18:01:09 +0100 (CET)
Received: from sorrow.cyrius.com ([65.19.161.204]:36730 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1494039AbZKSRBD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Nov 2009 18:01:03 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 4810AD8C6; Thu, 19 Nov 2009 17:01:02 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id E43E91501E8; Thu, 19 Nov 2009 17:00:51 +0000 (GMT)
Date:	Thu, 19 Nov 2009 17:00:51 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Disable EARLY_PRINTK on IP22 to make the system boot
Message-ID: <20091119170051.GX31954@deprecation.cyrius.com>
References: <20091119164009.GA15038@deprecation.cyrius.com>
 <90edad820911190856m62275563yf610c4a7dcdd1f67@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90edad820911190856m62275563yf610c4a7dcdd1f67@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Dmitri Vorobiev <dmitri.vorobiev@gmail.com> [2009-11-19 18:56]:
> > Some Debian users have reported that the kernel hangs early
> > during boot on some IP22 systems.  Thomas Bogendoerfer found
> > that this is due to a "bad interaction between CONFIG_EARLY_PRINTK
> > and overwritten prom memory during early boot".  Since there's
> > no fix yet, disable CONFIG_EARLY_PRINTK for now.
> 
> Never experienced anything like that, although I'm quite extensively
> using IP22 with recent kernels. Any details on the hangs?

It doesn't happen on all machines.  It has been reported e.g. with an
Indigo2.  See http://bugs.debian.org/507557

Since Thomas Bogendoerfer disagnosed the problem, he should be able to
say more.

-- 
Martin Michlmayr
http://www.cyrius.com/

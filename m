Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2004 01:16:40 +0100 (BST)
Received: from p508B6C63.dip.t-dialin.net ([IPv6:::ffff:80.139.108.99]:18256
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225463AbUERAQj>; Tue, 18 May 2004 01:16:39 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i4I0GcxT011227;
	Tue, 18 May 2004 02:16:38 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i4I0GcH8011226;
	Tue, 18 May 2004 02:16:38 +0200
Date: Tue, 18 May 2004 02:16:38 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Ken Giusti <manwithastinkydog@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: running 2.6 on swarm pass1
Message-ID: <20040518001638.GA10423@linux-mips.org>
References: <20040517150631.13795.qmail@web13301.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040517150631.13795.qmail@web13301.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 17, 2004 at 08:06:31AM -0700, Ken Giusti wrote:

> 2.6.6 from kernel.org doesn't appear to run at all.
> Once I load the image via CFE and type "go" I get
> absolutely no console output - the system just hangs.

There is still plenty of code that needs to be merged into the kernel.org
tree before this will have a chance of working.  For any MIPS system.

> 2.6.5 from linux-mips is a bit better - I get bootup
> console output, then an immediate crash (included
> below).
> 
> Has anyone had any luck getting 2.6 running on swarm
> with pass1?  

I still do have a pass1 board he so I'll eventually look at it.  However
this doesn't look like the fingerprint of the usual pass1 crashes so it's
probably simply a genuine kernel bug.

  Ralf

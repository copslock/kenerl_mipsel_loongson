Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2005 12:09:55 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:34823 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225477AbVFWLJd>; Thu, 23 Jun 2005 12:09:33 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 8F7ABE1CC2; Thu, 23 Jun 2005 13:08:31 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 13881-07; Thu, 23 Jun 2005 13:08:31 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 47B74E1CC1; Thu, 23 Jun 2005 13:08:31 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5NB8Xqn018057;
	Thu, 23 Jun 2005 13:08:33 +0200
Date:	Thu, 23 Jun 2005 12:08:39 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Isaacson <adi@broadcom.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [patch 4/5] SiByte fixes for 2.6.12
In-Reply-To: <20050622230151.GA17970@broadcom.com>
Message-ID: <Pine.LNX.4.61L.0506231208120.17155@blysk.ds.pg.gda.pl>
References: <20050622230151.GA17970@broadcom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/954/Wed Jun 22 21:15:13 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 22 Jun 2005, Andrew Isaacson wrote:

> If the CPU Options get out of sync with the CONFIG_CPU_ options,
> cpu_cache_init() can end up being a noop.  Stop with a useful message
> in that case rather than running on without cache functions.

 Wouldn't a build-time error be a better option?

  Maciej

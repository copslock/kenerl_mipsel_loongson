Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2003 12:44:27 +0000 (GMT)
Received: from p508B6693.dip.t-dialin.net ([IPv6:::ffff:80.139.102.147]:39627
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224827AbTC0Mo0>; Thu, 27 Mar 2003 12:44:26 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h2RCiG526597;
	Thu, 27 Mar 2003 13:44:16 +0100
Date: Thu, 27 Mar 2003 13:44:16 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: sgiserial 1/7: flags are unsigned long
Message-ID: <20030327134416.B26267@linux-mips.org>
References: <m2adfheczs.fsf@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m2adfheczs.fsf@mandrakesoft.com>; from quintela@mandrakesoft.com on Thu, Mar 27, 2003 at 03:53:43AM +0100
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 27, 2003 at 03:53:43AM +0100, Juan Quintela wrote:

> Subject: [PATCH]: sgiserial 1/7: flags are unsigned long

I applied the whole series of sgiserial patches.

I'm tired of maintaining the dead support for running IRIX's X server on
Linux.  It was never working more than marginally and since Miguel de
Icaza has given up working on that in favor of Gnome the code is just a
maintenance pain.  Worse, probably there's haven a dozen bad bugs hidden
in there allowing users to crash the system or do other sinister stuff.
So if you want to continue your cleanup cruzade by eleminating
drivers/sgi/ - I'm all for it :-)

  Ralf

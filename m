Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 21:57:22 +0000 (GMT)
Received: from p508B5DCD.dip.t-dialin.net ([IPv6:::ffff:80.139.93.205]:39337
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225365AbSLRV5W>; Wed, 18 Dec 2002 21:57:22 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gBILvF632418;
	Wed, 18 Dec 2002 22:57:15 +0100
Date: Wed, 18 Dec 2002 22:57:15 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: linux mips mailing list <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: c-r4k.c, new gcc's don't like empty labels
Message-ID: <20021218225715.A32351@linux-mips.org>
References: <m2bs3kqez8.fsf@demo.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m2bs3kqez8.fsf@demo.mitica>; from quintela@mandrakesoft.com on Wed, Dec 18, 2002 at 02:43:07AM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 18, 2002 at 02:43:07AM +0100, Juan Quintela wrote:

>         patch is trivial to eliminate warnings from the compiler

And yet I didn't like it.  The new syntax requirement isn't only ugly code,
it's harder to read than a replacing the gotos with a simple return ...

  Ralf

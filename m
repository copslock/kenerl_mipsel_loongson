Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 May 2003 13:20:22 +0100 (BST)
Received: from p508B5AA9.dip.t-dialin.net ([IPv6:::ffff:80.139.90.169]:31936
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225239AbTEHMUU>; Thu, 8 May 2003 13:20:20 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h48CKHts007310;
	Thu, 8 May 2003 14:20:17 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h48CKC8v007309;
	Thu, 8 May 2003 14:20:12 +0200
Date: Thu, 8 May 2003 14:20:11 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Juan Quintela <quintela@mandrakesoft.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] SGI Seeq cleanup
Message-ID: <20030508122011.GA7210@linux-mips.org>
References: <20030507202851.GA668@kopretinka> <86d6iul7z3.fsf@trasno.mitica> <20030508074308.GB837@kopretinka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508074308.GB837@kopretinka>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 08, 2003 at 09:43:09AM +0200, Ladislav Michl wrote:

> > You are my hero!
> > 
> > [ Removal of Space.c entry ] 

Absolutely, Space.c, RIP - Rot In Pieces.

> Question comes in mind: It's possible to have ISA eth card installed in
> Indigo2. How to ensure that onboard Seeq will be always eth0 without
> using Space.c? (and don't advice me to build driver for ISA card as
> module :))

You just need to make sure sgiseeq.o is linked in before any of the ISA
drivers.

ISA link ordering is sort of emprical rocket science but fortunately
the IP22 Seeq isn't ISA.

  Ralf

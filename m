Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Mar 2003 15:21:32 +0000 (GMT)
Received: from p508B7C79.dip.t-dialin.net ([IPv6:::ffff:80.139.124.121]:9129
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225203AbTCGPVb>; Fri, 7 Mar 2003 15:21:31 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h27FLEg27044;
	Fri, 7 Mar 2003 16:21:14 +0100
Date: Fri, 7 Mar 2003 16:21:14 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: Kip Walker <kwalker@broadcom.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] add CONFIG_DEBUG_INFO
Message-ID: <20030307162114.A26545@linux-mips.org>
References: <20030220113404.E7466@mvista.com> <3E63B047.D3BA2A2C@broadcom.com> <86d6l8fcvv.fsf@trasno.mitica> <3E677B94.AE22C65D@broadcom.com> <86u1efp9rr.fsf@trasno.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <86u1efp9rr.fsf@trasno.mitica>; from quintela@mandrakesoft.com on Fri, Mar 07, 2003 at 02:48:56PM +0100
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 07, 2003 at 02:48:56PM +0100, Juan Quintela wrote:

> I have no idea what the Corelis debugger is, but I assume that putting
> it configuration out of the CONFIG_KGDB is intentional?  It doesn't
> require the -g option?

It's a JTAG debugger.

  Ralf

Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g64BSqRw001061
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 4 Jul 2002 04:28:52 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g64BSqvt001060
	for linux-mips-outgoing; Thu, 4 Jul 2002 04:28:52 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (dialinpool.tiscali.de [62.246.28.123] (may be forged))
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g64BSlRw001051
	for <linux-mips@oss.sgi.com>; Thu, 4 Jul 2002 04:28:48 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g64BWpp27047;
	Thu, 4 Jul 2002 13:32:51 +0200
Date: Thu, 4 Jul 2002 13:32:51 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
Cc: linux-mips@oss.sgi.com
Subject: Re: [PATCH] CVS HEAD mips64 assembler options
Message-ID: <20020704133251.A27007@dea.linux-mips.net>
References: <Pine.LNX.4.21.0207041322570.1601-200000@melkor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.21.0207041322570.1601-200000@melkor>; from vivien.chappelier@enst-bretagne.fr on Thu, Jul 04, 2002 at 01:28:19PM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-3.1 required=5.0 tests=IN_REP_TO,MAY_BE_FORGED version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 04, 2002 at 01:28:19PM +0200, Vivien Chappelier wrote:

> 	There's been some rework on the Makefile for the mips64 target,
> however the line for the assembler options was forgotten, causing
> assembly source code to be wronly compiled, and crashing the linker
> afterwards. This patch fixes it, and also removes a few warnings about
> structures declared in parameter list.

I know those warnings and I simply take them as the proof that our
header are too spaghettiish, so I'm not taking the easy way out ...

  Ralf

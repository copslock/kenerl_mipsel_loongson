Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5HJeYnC029225
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 17 Jun 2002 12:40:34 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5HJeY3L029224
	for linux-mips-outgoing; Mon, 17 Jun 2002 12:40:34 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from nevyn.them.org (01-042.118.popsite.net [66.19.120.42])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5HJeRnC029221;
	Mon, 17 Jun 2002 12:40:28 -0700
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17K2PB-0003m4-00; Mon, 17 Jun 2002 15:43:13 -0400
Date: Mon, 17 Jun 2002 15:43:12 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Justin Carlson <justin@cs.cmu.edu>
Cc: linux-mips@oss.sgi.com, ralf@oss.sgi.com
Subject: Re: system.h asm fixes
Message-ID: <20020617194312.GA14489@nevyn.them.org>
References: <1024338042.1463.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1024338042.1463.21.camel@localhost.localdomain>
User-Agent: Mutt/1.5.1i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 17, 2002 at 11:20:42AM -0700, Justin Carlson wrote:
> Looks to me like we're missing some proper asm clobber markers:

Not really, I think those actually caused a problem at some point but
that might be my imagination.  They certainly aren't necessary.  The
compiler can not use $1 for anything, because it doesn't know what the
assembler might be doing with it.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer

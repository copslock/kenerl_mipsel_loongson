Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f36DSrF27931
	for linux-mips-outgoing; Fri, 6 Apr 2001 06:28:53 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f36DSqM27928
	for <linux-mips@oss.sgi.com>; Fri, 6 Apr 2001 06:28:52 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 5390C7F3; Fri,  6 Apr 2001 15:28:50 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id C063FEE92; Fri,  6 Apr 2001 15:28:36 +0200 (CEST)
Date: Fri, 6 Apr 2001 15:28:36 +0200
From: Florian Lohoff <flo@rfc822.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: debian-mips@lists.debian.org, linux-mips@oss.sgi.com
Subject: Re: first packages for mipsel
Message-ID: <20010406152836.A21459@paradigm.rfc822.org>
References: <20010406130958.A14083@paradigm.rfc822.org> <20010406132214.D14083@paradigm.rfc822.org> <00a401c0be8e$cfc065a0$0deca8c0@Ulysses> <20010406135849.E14083@paradigm.rfc822.org> <00cb01c0be94$7744aac0$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <00cb01c0be94$7744aac0$0deca8c0@Ulysses>; from kevink@mips.com on Fri, Apr 06, 2001 at 02:23:53PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Apr 06, 2001 at 02:23:53PM +0200, Kevin D. Kissell wrote:
> > If there is a working ll/sc emulation fine - Currently there is none
> > so the only way to go TODAY is sysmips.
> 
> I'll work on one in the background.  It should be pretty straightforward
> for the uniprocessor case, but an SMP version will be messier, and
> possibly require a platform-dependent hook.  Of course, the same
> is true of sysmips()...

For SMP versions we could currently just put an "#error" in it. There has
to be machine dependent support as the older SGI Challenge have. So dont
worry on that case.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?

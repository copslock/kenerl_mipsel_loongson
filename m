Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f36Bx2v25265
	for linux-mips-outgoing; Fri, 6 Apr 2001 04:59:02 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f36Bx1M25262
	for <linux-mips@oss.sgi.com>; Fri, 6 Apr 2001 04:59:01 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id AA8D27F3; Fri,  6 Apr 2001 13:58:59 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id A1095EE92; Fri,  6 Apr 2001 13:58:49 +0200 (CEST)
Date: Fri, 6 Apr 2001 13:58:49 +0200
From: Florian Lohoff <flo@rfc822.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: debian-mips@lists.debian.org, linux-mips@oss.sgi.com
Subject: Re: first packages for mipsel
Message-ID: <20010406135849.E14083@paradigm.rfc822.org>
References: <20010406130958.A14083@paradigm.rfc822.org> <20010406132214.D14083@paradigm.rfc822.org> <00a401c0be8e$cfc065a0$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <00a401c0be8e$cfc065a0$0deca8c0@Ulysses>; from kevink@mips.com on Fri, Apr 06, 2001 at 01:43:24PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Apr 06, 2001 at 01:43:24PM +0200, Kevin D. Kissell wrote:

> What advantage would there be to using sysmips() as opposed
> to doing the ll/sc emulation?  It seems to me that the decode path
> in the kernel would be just as fast, and there would be a single
> "ABI" for all programs - the ll/sc instructions themselves.

I dont actually care that much - I want to have a portable way
through all ISAs as debian should be userspace compatible all the way.

If there is a working ll/sc emulation fine - Currently there is none
so the only way to go TODAY is sysmips.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?

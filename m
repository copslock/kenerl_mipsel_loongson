Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4MCXeJ04368
	for linux-mips-outgoing; Tue, 22 May 2001 05:33:40 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4MCXdF04365
	for <linux-mips@oss.sgi.com>; Tue, 22 May 2001 05:33:39 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id ACBCF7F4; Tue, 22 May 2001 14:33:37 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 276BFF212; Tue, 22 May 2001 14:33:30 +0200 (CEST)
Date: Tue, 22 May 2001 14:33:30 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Jun Sun <jsun@mvista.com>
Cc: Pete Popov <ppopov@mvista.com>, George Gensure <werkt@csh.rit.edu>,
   linux-mips@oss.sgi.com
Subject: Re: newest kernel
Message-ID: <20010522143330.B9891@paradigm.rfc822.org>
References: <3B099A91.5030300@csh.rit.edu> <3B09A074.2010809@mvista.com> <3B09A388.8AC77827@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3B09A388.8AC77827@mvista.com>; from jsun@mvista.com on Mon, May 21, 2001 at 04:23:52PM -0700
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, May 21, 2001 at 04:23:52PM -0700, Jun Sun wrote:
> The patch seems to be just a fast implementation of sysmips().  Why would it
> solve an otherwise illegal instruction problem?
> 
> George, what was exactly the error and the faulty instruction?

Wrong - Its not only a "fast" path sysmips. It solves the illegal instruction
case as it carefully doesnt touch registers it should not touch.

The sysmips illegal instruction stuff came from the early exit
needed to skip the -EXXXX case in the scall32.S which did not
restore the modified registers. This needed fixing and there was
no clean way of doing this in C thus i wrote an asm sysmips/MIPS_ATOMIC_SET
and called it "fast_sysmips" which itself would go into the old
sysmips function when not MIPS_ATOMIC_SET.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f35L3eP06602
	for linux-mips-outgoing; Thu, 5 Apr 2001 14:03:40 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f35L3eM06598
	for <linux-mips@oss.sgi.com>; Thu, 5 Apr 2001 14:03:40 -0700
Received: by mail.foobazco.org (Postfix, from userid 1014)
	id 8B875109DD; Thu,  5 Apr 2001 14:03:39 -0700 (PDT)
Date: Thu, 5 Apr 2001 14:03:39 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: RFC: Cleanup/detection patch
Message-ID: <20010405140338.A1508@foobazco.org>
References: <20010401235212.B9737@foobazco.org> <3ACA8A3B.8BBABB11@mvista.com> <20010403203055.A17365@foobazco.org> <3ACB5FD8.6B166BA6@mvista.com> <20010405004618.A30899@foobazco.org> <3ACCD599.1765FCB2@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ACCD599.1765FCB2@mvista.com>; from jsun@mvista.com on Thu, Apr 05, 2001 at 01:29:13PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Apr 05, 2001 at 01:29:13PM -0700, Jun Sun wrote:

> I don't like bc_ops idea.  Usually the external cache capability is still
> integral part of the CPU.

How can it be both an integral part of the CPU and board-specific?
Either it's under the direct control of the cpu or it's not.  If it
is, that's cpu-specific and handled by the regular cacheops.  If it's
not, that's board-specific and is called from a hook into something
which the machine detection has set up.

> I favor the idea where the cache takes care of external cache dynamically,
> based on some parameters set up by board detection routine.

So we end up filling the cache routines with tests for board-specific
stuff?  No way.  The cache routines should be dependent ONLY on the
CPU - two completely different boards with radically different designs
should be able to use the exact same foo-cache.c if they have the same
CPU.  If it's board-specific we can put generic hooks in but testing
for various boards in the cacheops is too expensive and too ugly.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
"I should have crushed his marketing-addled skull with a fucking bat."

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4NIu0v18515
	for linux-mips-outgoing; Wed, 23 May 2001 11:56:00 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4NItuF18508;
	Wed, 23 May 2001 11:55:56 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id B0ACC7F7; Wed, 23 May 2001 20:55:54 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 098F2EFD5; Wed, 23 May 2001 20:55:53 +0200 (CEST)
Date: Wed, 23 May 2001 20:55:53 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Jun Sun <jsun@mvista.com>
Cc: Joe deBlaquiere <jadb@redhat.com>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, ralf@oss.sgi.com,
   Pete Popov <ppopov@mvista.com>, George Gensure <werkt@csh.rit.edu>,
   linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
Message-ID: <20010523205552.B10981@paradigm.rfc822.org>
References: <Pine.GSO.3.96.1010523152429.5196A-100000@delta.ds2.pg.gda.pl> <3B0BF7F8.3050306@redhat.com> <3B0C0475.B9ACE682@mvista.com> <20010523205412.A10981@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010523205412.A10981@paradigm.rfc822.org>; from flo@rfc822.org on Wed, May 23, 2001 at 08:54:12PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 23, 2001 at 08:54:12PM +0200, Florian Lohoff wrote:
> My favourit would be to let the glibc on runtime decide whether
> to use sysmips or ll/sc in the atomic test_and_set stuff. This would
> lead to an common atom op in the userspace which is fast on ll/sc 
> cpus and gives much lesser performance penaltys in the sysmips case
> than emulating ll/sc.

But again - I tried to run this discussion again and again - As long
as there is no code to use there is no point in taking a discussion.
I needed a working sysmips for debian as we compile the glibc with
sysmips (performance penalty but for now works everywhere) thus
i fixed the sysmips.

Let the code speak

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?

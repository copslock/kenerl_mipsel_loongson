Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4O4Qmv04316
	for linux-mips-outgoing; Wed, 23 May 2001 21:26:48 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4O4QhF04310;
	Wed, 23 May 2001 21:26:43 -0700
Received: from galt.foobazco.org (galt.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP
	id B8F29F1A9; Wed, 23 May 2001 21:25:21 -0700 (PDT)
Received: by galt.foobazco.org (Postfix, from userid 1014)
	id 42AF0BBE0; Wed, 23 May 2001 21:25:35 -0700 (PDT)
Date: Wed, 23 May 2001 21:25:35 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Florian Lohoff <flo@rfc822.org>, Jun Sun <jsun@mvista.com>,
   Joe deBlaquiere <jadb@redhat.com>, ralf@oss.sgi.com,
   Pete Popov <ppopov@mvista.com>, George Gensure <werkt@csh.rit.edu>,
   linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
Message-ID: <20010523212535.C10516@foobazco.org>
References: <20010523205412.A10981@paradigm.rfc822.org> <Pine.GSO.3.96.1010523213934.16787C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010523213934.16787C-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, May 23, 2001 at 09:44:36PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 23, 2001 at 09:44:36PM +0200, Maciej W. Rozycki wrote:

> solve a single inefficiency of ISA I code when run on better CPUs.  You
> really want to recompile code to make use of new instructions if you care
> about performance.

I agree.  Therefore I am sure some MIPS I users will be happy to build
special glibcs for their ISA.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"Nothing motivates a man more than to see his boss put
	 in an honest day's work." -- The fortune file

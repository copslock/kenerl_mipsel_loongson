Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3UKQFg24849
	for linux-mips-outgoing; Mon, 30 Apr 2001 13:26:15 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3UKQ1M24844
	for <linux-mips@oss.sgi.com>; Mon, 30 Apr 2001 13:26:02 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f3UKOJY31118;
	Mon, 30 Apr 2001 17:24:19 -0300
Date: Mon, 30 Apr 2001 17:24:19 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Florian Lohoff <flo@rfc822.org>, Pete Popov <ppopov@mvista.com>,
   linux-mips@oss.sgi.com
Subject: Re: Illegal instruction - a workaround or fix ?
Message-ID: <20010430172419.B30998@bacchus.dhis.org>
References: <20010420215841.D15990@paradigm.rfc822.org> <Pine.GSO.3.96.1010430113243.889B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010430113243.889B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Apr 30, 2001 at 11:34:32AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 30, 2001 at 11:34:32AM +0200, Maciej W. Rozycki wrote:

> > A different solution would be to take the usual exit in sysmips via
> > the return at the end (for which the compiler generated a correct
> > epilogue) and modify the return address - This is an very ugly hack
> > and you cant tell where the compiler stores the ra on the stack.
> 
>  It could be doable with __builtin_frame_address().  Haven't investigated
> it further, though. 

MIPS ABI doesn't define that ra gets stored at a constant offset in
the stackframe, so that won't work.

  Ralf

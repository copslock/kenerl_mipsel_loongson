Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f346MKP02612
	for linux-mips-outgoing; Tue, 3 Apr 2001 23:22:20 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f346MJM02609
	for <linux-mips@oss.sgi.com>; Tue, 3 Apr 2001 23:22:19 -0700
Received: from galt.foobazco.org (galt.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP
	id 54C30109DD; Tue,  3 Apr 2001 23:22:18 -0700 (PDT)
Received: by galt.foobazco.org (Postfix, from userid 1014)
	id 387651F429; Tue,  3 Apr 2001 23:22:18 -0700 (PDT)
Date: Tue, 3 Apr 2001 23:22:18 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: jsc6233@ritvax.isc.rit.edu
Cc: linux-mips@oss.sgi.com
Subject: Re: indy R5000 with irix 6.5
Message-ID: <20010403232217.A26443@foobazco.org>
References: <5.0.0.25.0.20010404000235.00ac9c98@vmspop.isc.rit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.0.0.25.0.20010404000235.00ac9c98@vmspop.isc.rit.edu>; from jsc6233@ritvax.isc.rit.edu on Wed, Apr 04, 2001 at 12:03:30AM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Apr 04, 2001 at 12:03:30AM -0700, jsc6233@ritvax.isc.rit.edu wrote:

> I don't mean to be a complete moron but what are the EXACT steps i need to 
> get a compiled kernel. I had downloaded the version 2.4 and attempted to 
> make the kernel and i got syntax errors. Am I missing something??? I have 

You're missing the FAQ from the sound of things.

> gcc version 2.7 and cc version 7.3.

gcc 2.7, while it served Sir Isaac Newton well, isn't going to build
linux 2.4.  In fact, in order to make that compile that far you must
have removed the "my compiler is too old" #error from init/main.c.
Did you think they put it there for fun?

You can use that fancy new cc to build yourself a copy of gcc 3.0.
While that's going on you'll have time to cruise over to
http://www.linuxdoc.org/HOWTO/MIPS-HOWTO.html and read the
documentation.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
"I should have crushed his marketing-addled skull with a fucking bat."

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAFFsU716371
	for linux-mips-outgoing; Thu, 15 Nov 2001 07:54:30 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fAFFsT016368
	for <linux-mips@oss.sgi.com>; Thu, 15 Nov 2001 07:54:29 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fAFFsKt06620;
	Fri, 16 Nov 2001 02:54:20 +1100
Date: Fri, 16 Nov 2001 02:54:20 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Ivan Hamilton <ivan@chimerical.com.au>
Cc: linux-mips@oss.sgi.com
Subject: Re: Inclusion of rrm.o in export-objs
Message-ID: <20011116025420.C6317@dea.linux-mips.net>
References: <4DF7FE7DA7E47442B859983ABCFBBF627971@chimsvr1.chimerical.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4DF7FE7DA7E47442B859983ABCFBBF627971@chimsvr1.chimerical.com.au>; from ivan@chimerical.com.au on Fri, Nov 16, 2001 at 12:38:46AM +1100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Nov 16, 2001 at 12:38:46AM +1100, Ivan Hamilton wrote:

> My Makefile knowledge is extremely limited to say the least. But are
> there possible side-effects of this particular fix? And how does a fix
> like this, find it's way back into the source tree?

Fixed in CVS.  And yes, your fix was correct.

  Ralf

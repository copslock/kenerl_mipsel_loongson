Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBEJ8n806020
	for linux-mips-outgoing; Fri, 14 Dec 2001 11:08:49 -0800
Received: from woody.ichilton.co.uk (woody.ichilton.co.uk [216.28.122.60])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBEJ8ko06017
	for <linux-mips@oss.sgi.com>; Fri, 14 Dec 2001 11:08:46 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 1000)
	id 7FE887CF5; Fri, 14 Dec 2001 18:08:39 +0000 (GMT)
Date: Fri, 14 Dec 2001 18:08:39 +0000
From: Ian Chilton <ian@ichilton.co.uk>
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: Current Kernel in CVS Broken
Message-ID: <20011214180839.A28794@woody.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
References: <20011214172739.A28669@woody.ichilton.co.uk> <20011214174304.GA7510@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
In-Reply-To: <20011214174304.GA7510@paradigm.rfc822.org>; from flo@rfc822.org on Fri, Dec 14, 2001 at 06:43:04PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

Thanks for the reply!

> You already have the fix in your inbox for a couple of hours which is a
> one liner.

Sorry my mistake.

I found it now:
Dec 14 Florian Lohoff  (  51) [PATCH] complete indy timer fix - one
liner missing


Do I also need both of these as well??:

Dec 13 Florian Lohoff  ( 106) Re: Current CVS on Indigo2 fail
Dec 14 Florian Lohoff  ( 123) [PATCH] use Hit_invalidate in
dma_cache_inv / fix sgiwd93.c


Thanks!

Ian

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8CNVq622828
	for linux-mips-outgoing; Wed, 12 Sep 2001 16:31:52 -0700
Received: from dea.linux-mips.net (u-112-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.112])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8CNVne22825
	for <linux-mips@oss.sgi.com>; Wed, 12 Sep 2001 16:31:49 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f8CNSWu26987;
	Thu, 13 Sep 2001 01:28:32 +0200
Date: Thu, 13 Sep 2001 01:28:32 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Pete Popov <ppopov@pacbell.net>
Cc: Carsten Langgaard <carstenl@mips.com>, linux-mips@oss.sgi.com
Subject: Re: Update for RedHat 7.1
Message-ID: <20010913012832.C26132@dea.linux-mips.net>
References: <20010907230009.A1705@lucon.org> <3B9F21C9.985A1F0F@mips.com> <3B9F319B.E87DC64B@mips.com> <20010912094822.A4491@lucon.org> <3B9F9489.90608@pacbell.net> <3B9FBCB3.FDACFE3E@mips.com> <3B9FBE04.3010304@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B9FBE04.3010304@pacbell.net>; from ppopov@pacbell.net on Wed, Sep 12, 2001 at 12:56:52PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Sep 12, 2001 at 12:56:52PM -0700, Pete Popov wrote:

> > On a Atlas board with a QED RM5261 CPU (little-endian).
> > The kernel is based on 2.4.3.
> 
> I would try the exact same userland and kernel version on a different board, 
> preferably with a different cpu.  Rebuild perl natively 10 times. If it
> works on the other board, there is a very good chance that this is a board
> or CPU problem. Native compiles seem to be very good for stressing the
> hardware.

And software.  You have little chance to find all the little details that
need to be tweaked with crossbuilds.

  Ralf

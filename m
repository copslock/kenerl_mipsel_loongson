Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA6L65B11778
	for linux-mips-outgoing; Tue, 6 Nov 2001 13:06:05 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fA6L64011775
	for <linux-mips@oss.sgi.com>; Tue, 6 Nov 2001 13:06:04 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fA6L5VR30553;
	Tue, 6 Nov 2001 13:05:31 -0800
Date: Tue, 6 Nov 2001 13:05:31 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: James Simmons <jsimmons@transvirtual.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: 1$ clobber bug
Message-ID: <20011106130531.A30219@dea.linux-mips.net>
References: <Pine.LNX.4.10.10111061142510.24062-100000@transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10111061142510.24062-100000@transvirtual.com>; from jsimmons@transvirtual.com on Tue, Nov 06, 2001 at 11:44:20AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Nov 06, 2001 at 11:44:20AM -0800, James Simmons wrote:

> Sorry I got the patch backwards. It seems that the standard 2.4.14 tree
> some how missed the $1 clobber fixes but it merged alot of other things.
> Strange. 
> 
> I believe the ITE generic time code has a 1$ clobber bug in it. Here is a
> patch to fix this.

There is no point in a "$1" clobber.

  Ralf

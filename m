Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g09J3CQ12013
	for linux-mips-outgoing; Wed, 9 Jan 2002 11:03:12 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g09J31g11998
	for <linux-mips@oss.sgi.com>; Wed, 9 Jan 2002 11:03:03 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id g09I2a821833;
	Wed, 9 Jan 2002 16:02:36 -0200
Date: Wed, 9 Jan 2002 16:02:36 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Venkata Rajesh Bikkina <rajeshbv@intotoinc.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Unresolved symbols while inserting a module
Message-ID: <20020109160236.A21705@dea.linux-mips.net>
References: <Pine.LNX.4.21.0201090312450.20962-100000@intotoinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0201090312450.20962-100000@intotoinc.com>; from rajeshbv@intotoinc.com on Wed, Jan 09, 2002 at 03:17:21AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jan 09, 2002 at 03:17:21AM -0800, Venkata Rajesh Bikkina wrote:

> when i am trying to insert my kernel module or any sample test module on
> MIPS 334A board with kernel 2.4.3, insmod is saying _gp_disp unresolved.
> Can anybody point out what i am missing.
> 
> /sbin/insmod igateway.o
> insmod: unresolved symbol _gp_disp

See http://oss.sgi.com/mips/mips-howto.html.

  Ralf

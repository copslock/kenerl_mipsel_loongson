Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0V2YJY32479
	for linux-mips-outgoing; Wed, 30 Jan 2002 18:34:19 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0V2YGd32476
	for <linux-mips@oss.sgi.com>; Wed, 30 Jan 2002 18:34:16 -0800
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g0V1WFB22455;
	Wed, 30 Jan 2002 17:32:15 -0800
Subject: RE: More data: I've made a CVS build that doesn't crash!
From: Pete Popov <ppopov@pacbell.net>
To: Matthew Dharm <mdharm@momenco.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIEECOCFAA.mdharm@momenco.com>
References: <NEBBLJGMNKKEEMNLHGAIEECOCFAA.mdharm@momenco.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 30 Jan 2002 17:35:08 -0800
Message-Id: <1012440909.1442.0.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 2002-01-30 at 17:23, Matthew Dharm wrote:
> Well, I'm closer... and more confused.
> 
> I've managed to make a 2.4.3 build which does not exhibit any of the
> instability or crashing... but I did it by disabling half of the
> memory!
> 
> In linux/arch/mips/gt64120/momenco_ocelot/setup.c is some code to read
> a PLD and add a memory region.  64MByte is already added much earlier,
> and now we're adding the rest.  The board I'm testing on is 128MByte,
> so it tries to add another 64MByte region which is physically
> contiguous to the first region.
> 
> As far as I can tell, all of my memory works perfectly.  I'm going to
> do some more tests, but both vxWorks and OpenBSD run on this board
> without any problems.
> 
> So, can anyone think of some likely culprits for what is wrong here?
> Some piece of code which only works with addresses under 64MByte,
> perhaps?

And 2.4.2 works with all of the memory?

Pete

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0T0sOK30832
	for linux-mips-outgoing; Mon, 28 Jan 2002 16:54:24 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0T0sKP30820
	for <linux-mips@oss.sgi.com>; Mon, 28 Jan 2002 16:54:20 -0800
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g0SNqOB16747;
	Mon, 28 Jan 2002 15:52:24 -0800
Subject: RE: Help with OOPSes, anyone?
From: Pete Popov <ppopov@pacbell.net>
To: Matthew Dharm <mdharm@momenco.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIAEBJCFAA.mdharm@momenco.com>
References: <NEBBLJGMNKKEEMNLHGAIAEBJCFAA.mdharm@momenco.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 28 Jan 2002 15:54:47 -0800
Message-Id: <1012262087.8518.174.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 2002-01-28 at 15:31, Matthew Dharm wrote:
> Well, here's the latest test results...
> 
> The 2.4.0 kernel from MontaVista seems to work just fine.  Of course,
> it doesn't have support for the full range of interrupts, but that's a
> separate matter.  But it doesn't crash under big compiles.

2.4.0 from MontaVista? Do you mean the very first release, which was
2.4.0-test9?
 
> 2.4.17 with CONFIG_MIPS_UNCACHED crashes.  It takes longer, but that
> may just be a function of it running so much slower.  The BogoMIPS
> drops by a factor of 100.  Ouch.
> 
> So it doesn't look like a cache problem after all.  And it does
> suggest that something introduced between 2.4.0 and .17 is what broke
> things.  But what that is, I have no idea.
> 
> I'm going to try Jason's modified cache code just in case, but I doubt
> that will change anything.  We'll have to see, tho.
> 
> Does anyone have any other suggestions to try?  I'm starting to wonder
> if perhaps the PROM isn't setting up the SDRAM properly, but that
> conflicts with the working 2.4.0 kernel -- the PROM is the same in
> both cases, so I would expect a PROM error to affect both versions.
> 
> I'm running out of ideas here... anyone?

If you're absolutely sure 2.4.0-test9 doesn't crash (you ran the test
"enough" times), perhaps you can start testing kernels between 2.4.0 and
2.4.17.   And, you did get rid of the 'wait' instruction in 2.4.17,
right ;-)?

Pete

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0UC3FX21641
	for linux-mips-outgoing; Wed, 30 Jan 2002 04:03:15 -0800
Received: from dea.linux-mips.net (a1as16-p145.stg.tli.de [195.252.192.145])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0UC3Bd21638
	for <linux-mips@oss.sgi.com>; Wed, 30 Jan 2002 04:03:12 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id g0UB2ph03724;
	Wed, 30 Jan 2002 12:02:51 +0100
Date: Wed, 30 Jan 2002 12:02:51 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Matthew Dharm <mdharm@momenco.com>
Cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: Does Linux invalidate TLB entries?
Message-ID: <20020130120250.C3313@dea.linux-mips.net>
References: <NEBBLJGMNKKEEMNLHGAIGECBCFAA.mdharm@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIGECBCFAA.mdharm@momenco.com>; from mdharm@momenco.com on Tue, Jan 29, 2002 at 05:03:42PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jan 29, 2002 at 05:03:42PM -0800, Matthew Dharm wrote:

> I'm still trying to track down the cause of all my problems, so I'm
> going over the RM7000 errata.
> 
> I see one here that I'm not sure if it's a problem or not.  It only
> applies to OSes which invalidate TLB entries and thus will cause TLB
> Invalid exceptions (as opposed to a TLB refill exception, I think).
> 
> So, does Linux invalidate TLBs?  I've been looking at the code, and I
> think the answer is 'no', but I'm not really sure.

Yes, Linux may create TLB entries with V=0.

  Ralf

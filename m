Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Sep 2002 23:54:14 +0200 (CEST)
Received: from gateway-1237.mvista.com ([12.44.186.158]:4604 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S1122958AbSIFVyN>;
	Fri, 6 Sep 2002 23:54:13 +0200
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id g86LgWs01753;
	Fri, 6 Sep 2002 14:42:32 -0700
Date: Fri, 6 Sep 2002 14:42:32 -0700
From: Jun Sun <jsun@mvista.com>
To: Matthew Dharm <mdharm@momenco.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, jsun@mvista.com
Subject: Re: LOADADDR and low physical addresses?
Message-ID: <20020906144232.E1382@mvista.com>
References: <20020906135324.D1382@mvista.com> <NEBBLJGMNKKEEMNLHGAIEENICIAA.mdharm@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIEENICIAA.mdharm@momenco.com>; from mdharm@momenco.com on Fri, Sep 06, 2002 at 02:13:08PM -0700
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, Sep 06, 2002 at 02:13:08PM -0700, Matthew Dharm wrote:
> Yes, the having two devices at the same physical address might be a
> problem, but one I _might_ be able to work around.  Not only do I have
> a large bank of SDRAM, but I also have a small bank of on-chip SRAM.
> 
> So I'm thinking that the map will go (starting from 0) like this:
> on-chip SRAM, control registers, main memory
> 
> And this is where I think the add_memory_region() magic might need to
> happen.  Do I need to add the on-chip SRAM and control registers using
> add_memory_region()?  

I don't think you have to.  I *think* it works if you don't.  Not sure
know if you actuall do add.

> Is it going to be okay to have a large and
> mis-aligned bank of SDRAM?

That should be ok.

Jun

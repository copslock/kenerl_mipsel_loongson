Received:  by oss.sgi.com id <S554100AbRAZTyR>;
	Fri, 26 Jan 2001 11:54:17 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:57850 "EHLO
        orion.mvista.com") by oss.sgi.com with ESMTP id <S554097AbRAZTyC>;
	Fri, 26 Jan 2001 11:54:02 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.9.3/8.9.3) id LAA09389;
	Fri, 26 Jan 2001 11:53:10 -0800
Date:   Fri, 26 Jan 2001 11:53:10 -0800
From:   Jun Sun <jsun@mvista.com>
To:     Michael Shmulevich <michaels@jungo.com>
Cc:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: MIPS/linux compatible PCI network cards
Message-ID: <20010126115310.D9325@mvista.com>
References: <3A70A356.F3CA71F1@jungo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A70A356.F3CA71F1@jungo.com>; from michaels@jungo.com on Fri, Jan 26, 2001 at 12:06:14AM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jan 26, 2001 at 12:06:14AM +0200, Michael Shmulevich wrote:
> Hello all,
> 
> I would like to ask if someone knows some more or less widely available 
> PCI network card that is compatible with MIPS/Linux.
> 
> I have heard of Tulip and AMD's PCnet. I wonder if you heard of others.
> 
> Thanks in advance,
> Sorry if this mail bothered you...
>

Intel eepro100 works on mips too.  What I had to modify is to
1) take care of the non-standard EEPROM
2) set rx_copybreak to 1518 to avoid some cache problem.
3) remove a buggy cpu_to_le32() coversion

I sent a patch to the author.  Hopefully next release it will be
ready for MIPS.

Jun 

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 May 2004 21:27:18 +0100 (BST)
Received: from [IPv6:::ffff:68.118.232.104] ([IPv6:::ffff:68.118.232.104]:12735
	"EHLO gallardo") by linux-mips.org with ESMTP id <S8225617AbUETU1R>;
	Thu, 20 May 2004 21:27:17 +0100
Received: by gallardo (Postfix, from userid 1000)
	id 0C6C6AC2084; Thu, 20 May 2004 16:27:04 -0400 (EDT)
Date: Thu, 20 May 2004 16:27:04 -0400
From: Daniel Walton <dwalton+mips@ddtsm.com>
To: linux-mips@linux-mips.org
Subject: Re: Using more than 256 MB of memory on SB1250 in 32-bit mode
Message-ID: <20040520202703.GA24477@ddtsm.com>
Reply-To: Daniel Walton <dwalton+mips@ddtsm.com>
References: <3F4FCCD5.1000604@tadpole.com> <20030831133434.GA23189@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831133434.GA23189@linux-mips.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <dwalton@ddtsm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dwalton+mips@ddtsm.com
Precedence: bulk
X-list: linux-mips

On Sun, Aug 31, 2003 at 03:34:34PM +0200, Ralf Baechle wrote:
> The explanation you gave isn't exactly right.  A 2GB/2GB split would normally
> support 2GB of low memory.  We don't on MIPS due to the very inconvenient and
> unchangable mappings of KSEG0/KSEG1 - something that may have been sweet
> in '85 when the address map was designed but not today when 32-bit address
> spaces are beginning to be fairly tight.
> 
> Highmem works ok in 2.4 as long as you have a reasonably low ratio of
> highmem to lowmem.  For typical loads that means going beyond 4:1 isn't
> sensible but the actual number may vary much based on exact system
> configuration or workload.
> 
>   Ralf
> 

So what is a practical limit to total memory.

Daniel

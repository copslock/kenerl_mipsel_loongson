Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2003 01:34:51 +0100 (BST)
Received: (from localhost user: 'ralf' uid#501 fake: STDIN
	(ralf@sirjeppe-pt.tunnel.tserv1.fmt.ipv6.he.net)) by linux-mips.org
	id <S8225196AbTEUAet>; Wed, 21 May 2003 01:34:49 +0100
Date: Wed, 21 May 2003 01:34:49 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Gilad Benjamini <yaelgilad@myrealbox.com>,
	linux-mips@linux-mips.org
Subject: Re: lwl-lwr
Message-ID: <20030521013449.A16378@linux-mips.org>
References: <1053455551.996c4860yaelgilad@myrealbox.com> <025401c31f03$0e993370$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <025401c31f03$0e993370$10eca8c0@grendel>; from kevink@mips.com on Tue, May 20, 2003 at 09:07:26PM +0200
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 20, 2003 at 09:07:26PM +0200, Kevin D. Kissell wrote:

> I don't remember the discussion in question, but it's a question
> which comes up from time to time, due to the existence of 
> MIPS-like CPUs which lack the (patented) lwl/lwr mechanism
> for dealing with unaligned data.  The Lexra cores, for example.
> 
> There's really no such thing as "disabling" lwl/lwr.  They are part 
> of the base MIPS instruction set.  If one wants to live without them, 
> one can either rig a compiler to emit multi-instruction sequences instead 
> of lwr/lwl to do the appropriate shifts and masks (which is slower on all 
> targets), or you can rig the OS to emulate them, and hope that the processors 
> lacking support will take clean reserved instruction traps, where the function 
> can be emulated (which is "free" for code running  on CPUs with lwl/lwr, 
> but *really* slow for the guys doing emulation).

Technically you're right ...  In reality lwl/lwr are covered by US patent
4,814,976 which would also cover a software implementation.  So unless MIPS
grants a license for the purpose of emulation in the Linux kernel ...

  Ralf

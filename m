Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2004 14:35:04 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:32874
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225311AbUJNNe7>; Thu, 14 Oct 2004 14:34:59 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CI5kv-0005XW-00; Thu, 14 Oct 2004 15:34:57 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CI5kv-0007gH-00; Thu, 14 Oct 2004 15:34:57 +0200
Date: Thu, 14 Oct 2004 15:34:57 +0200
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Nigel Stephens <nigel@mips.com>, linux-mips@linux-mips.org
Subject: Re: Strange instruction
Message-ID: <20041014133457.GC1398@rembrandt.csv.ica.uni-stuttgart.de>
References: <20041014115304.3edbe141.toch@dfpost.ru> <01d901c4b1c8$996b7b30$10eca8c0@grendel> <20041014121242.GA1398@rembrandt.csv.ica.uni-stuttgart.de> <416E6E32.5080009@mips.com> <20041014123615.GB1398@rembrandt.csv.ica.uni-stuttgart.de> <00ae01c4b1ef$6ca4b450$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ae01c4b1ef$6ca4b450$10eca8c0@grendel>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Kevin D. Kissell wrote:
> > Nigel Stephens wrote:
> > > Thiemo Seufer wrote:
> > > >GNU as has "move" as builtin macro which is expanded differently for
> > > >32 and 64 bit mode. This simplifies the task of writing code for both
> > > >models. Unfortunately the expansion was broken for a while and
> > > >generated always the 64 bit version if the toolchain was 64bit
> > > >_capable_. IIRC this was fixed in the early 2.14 timeframe.
> > > 
> > > Wouldn't it be safer, as Kevin suggests, for the "move" macro to 
> > > generate "or $rd,$0,$rs", since that will work correctly in either mode?
> > 
> > For CPUs with two adders the instruction scheduling is a bit better.
> 
> For CPUs with two adders, only one of which can do ORs, you mean.

Yes.

> Isn't that a pretty small population of MIPS CPUs?

Sure, but there's little reason to deny this optimization.

> > Ther are also many other macros which are expanded in dependence of
> > the 32/64 bit address/register size, a different "move" macro
> > expansion won't help much if the assembler invocation was wrong.
> 
> Perhaps, but it strikes me as being only prudent to remove unnecessarily
> fragile artifacts like this.

It was an assembler bug.


Thiemo

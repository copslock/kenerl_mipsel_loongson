Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Dec 2004 16:30:29 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:46418
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225296AbULaQaW>; Fri, 31 Dec 2004 16:30:22 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CkPfG-0005MQ-00; Fri, 31 Dec 2004 17:30:10 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CkPfF-0001tX-00; Fri, 31 Dec 2004 17:30:09 +0100
Date: Fri, 31 Dec 2004 17:30:09 +0100
To: pf@net.alphadv.de
Cc: linux-mips@linux-mips.org
Subject: Re: Confused assembler
Message-ID: <20041231163009.GB6495@rembrandt.csv.ica.uni-stuttgart.de>
References: <20041225172449.1063A1F123@trashy.coderock.org> <20041227124435.GC26100@linux-mips.org> <Pine.LNX.4.58.0412310201350.455@Indigo2.Peter>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412310201350.455@Indigo2.Peter>
User-Agent: Mutt/1.5.6+20040907i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Peter Fuerst wrote:
> 
> 
> Hello !
> 
> 
> When building 2.6.10, the assembler (2.13.2.1) gets confused by a "b target2"
> (compiler generated) immediately following a "beqzl target1" (inline assembly
> macro), and reorders these instructions (with wrong address calculation too)
> to an infinite loop.
[snip]
> Was this behaviour already observed elsewhere ?  Is it fixed in some newer
> assembler version ?

Fixed in current binutils CVS, IIRC both 2.15 branch and trunk. The
older binutils tarball at linux-mips.org was also fixed.

> Or should i just be content with it and work around
> with appropriate "nop"s in the concerned inline-assembly macros ? ... ?

You should upgrade to something newer than 2.13. :-)

> as -EB -G 0 -mips4 -O2 -g0 -64 -mcpu=r8000 -v -64 -non_shared -64 -march=r8000 -mips4 --trap -o kernel/.tmp_fork.o

Note that those arguments are partially contradicting each other.

-mips4 -64 -mcpu=r8000 -64 -64 -march=r8000 -mips4

is (with 2.15 gas) better expressed as

-mabi=64 -march=mips4

or, more suitable for r10000, with

-mabi=64 -march=r10000


Thiemo

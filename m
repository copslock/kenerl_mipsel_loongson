Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2004 13:12:56 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:34664
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225195AbUJNMMw>; Thu, 14 Oct 2004 13:12:52 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CI4TM-0004Vt-00; Thu, 14 Oct 2004 14:12:44 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CI4TK-0007O4-00; Thu, 14 Oct 2004 14:12:42 +0200
Date: Thu, 14 Oct 2004 14:12:42 +0200
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Dmitriy Tochansky <toch@dfpost.ru>, linux-mips@linux-mips.org
Subject: Re: Strange instruction
Message-ID: <20041014121242.GA1398@rembrandt.csv.ica.uni-stuttgart.de>
References: <20041014115304.3edbe141.toch@dfpost.ru> <01d901c4b1c8$996b7b30$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01d901c4b1c8$996b7b30$10eca8c0@grendel>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Kevin D. Kissell wrote:
> That's a 64-bit add, which is actually being used as a 64-bit move
> of the "sp" register to k1.  Try "objdump -m mips:isa64" (or whatever
> variant gives your version of objdump the right to disassemble the
> MIPS III+/MIPS64 instructions.
> 
> One might suspect that your board monitor ROM was built for a 64-bit CPU.
> This illustrates why, if one want to write portable assembler code for MIPS,
> one should implement "move" operations as OR Target,$0,Source rather than
> using an ADDU or DADDU...

GNU as has "move" as builtin macro which is expanded differently for
32 and 64 bit mode. This simplifies the task of writing code for both
models. Unfortunately the expansion was broken for a while and
generated always the 64 bit version if the toolchain was 64bit
_capable_. IIRC this was fixed in the early 2.14 timeframe.


Thiemo

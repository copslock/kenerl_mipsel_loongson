Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2002 17:42:09 +0200 (CEST)
Received: from iris1.csv.ica.uni-stuttgart.de ([129.69.118.2]:19773 "EHLO
	iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S1122987AbSIQPmI>; Tue, 17 Sep 2002 17:42:08 +0200
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 17rKOt-002h7i-00
	for linux-mips@linux-mips.org; Tue, 17 Sep 2002 17:36:31 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 17rKUD-0003OT-00
	for <linux-mips@linux-mips.org>; Tue, 17 Sep 2002 17:42:01 +0200
Date: Tue, 17 Sep 2002 17:42:01 +0200
To: linux-mips@linux-mips.org
Subject: Re: Delayed jumps and branches
Message-ID: <20020917154201.GA18697@rembrandt.csv.ica.uni-stuttgart.de>
References: <20020917161959.33787757.g.c.bransby-99@student.lboro.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020917161959.33787757.g.c.bransby-99@student.lboro.ac.uk>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Gareth wrote:
> Hi,
> 
> I have been going through my mips architecture book learning about the delay
> slots used in loads, jumps and branches and I am in need of some clarification.
> The instruction just after the jump instruction is always executed wether the
> jump is taken or not, right?

There are no conditional jumps, so you are right. :-)

> So the compiler can re-aarange the assembly to
> take advantage of this, but if no instruction (that can be executed wether the
> jump is taken or not) can be placed after the jump, a nop is used intstead. So
> take this code for example :
> 
>     jal <my_function>
>     li  $s2, 3
>     li  $v0, 2

The register name is either "$2" or "v0".

> If the jump is not taken, it requires 3 cycles to execute these 3 instructions.
> If the jump is taken, it requires 3 cycles to execute the first instruction of
> my_function, and li $s2, 3 is executed.
> 
> Is my reasoning correct?

Yes, if it was e.g.

	beq	t0, zero, <my_function>

instead of jal. Note that the "branch likely" variants don't execute the
delay slot if not taken.


Thiemo

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6R0mOx24000
	for linux-mips-outgoing; Thu, 26 Jul 2001 17:48:24 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6R0mMV23989
	for <linux-mips@oss.sgi.com>; Thu, 26 Jul 2001 17:48:22 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id CAA29081
	for <linux-mips@oss.sgi.com>; Fri, 27 Jul 2001 02:48:21 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.22 #1 (Debian))
	id 15Pvng-0000z6-00
	for <linux-mips@oss.sgi.com>; Fri, 27 Jul 2001 02:48:20 +0200
Date: Fri, 27 Jul 2001 02:48:20 +0200
To: linux-mips@oss.sgi.com
Subject: Re: [patch] fix profiling in glibc for Linux/MIPS
Message-ID: <20010727024820.B27008@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010726103922.A6643@nevyn.them.org>
User-Agent: Mutt/1.3.18i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Daniel Jacobowitz wrote:
> _mcount was doing awful things to its caller's stack frame.

Maybe I'm missing something, but both the old and the new code
add 8 byte more to sp than they subtracted before. How is this
supposed to work?

[snip]
> I think this is close enough; it only adds
> one instruction.  Is this OK?

Why do you save and restore $6, $7, seemingly without using them?

> Do I need a "nop" after the subu?

It works here since it is expanded in an

	addiu $29,$29,-40

which is executed in one cycle. The usual suspects for hazards
to be NOPed are load/store insns and branches.

[snip]
> +        "sw $31,20($29);" \
>          "move $5,$31;" \
>          "jal __mcount;" \
>          "move $4,$1;" \
            ^
Some stylistic issue: In ".set noreorder" assembly it helps to
indent the insns in a branch delay slot by one blank to avoid
confusion about their non-sequential nature.


Thiemo

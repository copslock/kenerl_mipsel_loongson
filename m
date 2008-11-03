Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Nov 2008 17:36:47 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:29927 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S23066161AbYKCRgp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 3 Nov 2008 17:36:45 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mA3HZNvJ030563;
	Mon, 3 Nov 2008 17:35:23 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mA3HZMVk030562;
	Mon, 3 Nov 2008 17:35:22 GMT
Date:	Mon, 3 Nov 2008 17:35:22 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Paul_Koning@Dell.com
Cc:	macro@linux-mips.org, kumba@gentoo.org, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org, rdsandiford@googlemail.com
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
Message-ID: <20081103173522.GC27072@linux-mips.org>
References: <490A90F4.6040601@gentoo.org> <490C05A9.9070707@gentoo.org> <87abcjibsl.fsf@firetop.home> <490CA4C8.40904@gentoo.org> <87tzargrn4.fsf@firetop.home> <490CEDB9.6030600@gentoo.org> <alpine.LFD.1.10.0811021036330.20461@ftp.linux-mips.org> <B135486A342E6244AEE1EB13118903BA01A222DD@ausx3mpc106.aus.amer.dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B135486A342E6244AEE1EB13118903BA01A222DD@ausx3mpc106.aus.amer.dell.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 03, 2008 at 10:51:49AM -0600, Paul_Koning@Dell.com wrote:

> > I believe (but have not checked) that all CPUs/ISAs that are within the 
> >MIPS II - MIPS IV range enable -mbranch-likely by default, 
> 
> Not quite.  sb1 has no-branch-likely.  It actually does implement the instruction but the documentation clearly states that it should be avoided.

For the usual reasons - the CPU micro architects hate branch likely.  It
means having to cancel an instruction from the pipeline rather late, if
the branch was not taken.  So the deprecation just expresses the desparate
wish of the CPU architects to get rid of the instruction.  In practice
that won't happen any time soon - we even still have useless crap like
signed add and sub instructions in the MIPS ISA.  And if the instructions
actually were removed we still could software emulate them in the kernel.

However unlike the R10000 the SB1 and SB1 implement full blown branch
prediction for branch likely so use it where you can for performance.

  Ralf

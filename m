Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Nov 2008 16:59:08 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:16015 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S23063656AbYKCQ7F (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Nov 2008 16:59:05 +0000
Date:	Mon, 3 Nov 2008 16:59:05 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Paul_Koning@Dell.com
cc:	kumba@gentoo.org, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org, rdsandiford@googlemail.com
Subject: RE: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
In-Reply-To: <B135486A342E6244AEE1EB13118903BA01A222DD@ausx3mpc106.aus.amer.dell.com>
Message-ID: <alpine.LFD.1.10.0811031654300.31999@ftp.linux-mips.org>
References: <490A90F4.6040601@gentoo.org> <490C05A9.9070707@gentoo.org> <87abcjibsl.fsf@firetop.home> <490CA4C8.40904@gentoo.org> <87tzargrn4.fsf@firetop.home> <490CEDB9.6030600@gentoo.org> <alpine.LFD.1.10.0811021036330.20461@ftp.linux-mips.org>
 <B135486A342E6244AEE1EB13118903BA01A222DD@ausx3mpc106.aus.amer.dell.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 3 Nov 2008, Paul_Koning@Dell.com wrote:

> > I believe (but have not checked) that all CPUs/ISAs that are within the 
> >MIPS II - MIPS IV range enable -mbranch-likely by default, 
> 
> Not quite.  sb1 has no-branch-likely.  It actually does implement the 
> instruction but the documentation clearly states that it should be 
> avoided.

 Well, the SB-1 is a MIPS architecture processor (a MIPS64 one to be 
exact) and as such not within the MIPS II - MIPS IV ISA range and what you 
say by definition stands for any other MIPS architecture implementation 
too.  This is not relevant though as MIPS64 code won't run on a MIPS IV 
processor such as the R10k anyway.

  Maciej

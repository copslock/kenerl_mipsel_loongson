Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 May 2007 19:58:35 +0100 (BST)
Received: from pasmtpa.tele.dk ([80.160.77.114]:42133 "EHLO pasmtpA.tele.dk")
	by ftp.linux-mips.org with ESMTP id S20022035AbXELS6c (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 May 2007 19:58:32 +0100
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpA.tele.dk (Postfix) with ESMTP id 24D43184DF;
	Sat, 12 May 2007 20:57:58 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 1000)
	id E47C0580D2; Sat, 12 May 2007 20:58:54 +0200 (CEST)
Date:	Sat, 12 May 2007 20:58:54 +0200
From:	Sam Ravnborg <sam@ravnborg.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Run checksyscalls for N32 and O32 ABI
Message-ID: <20070512185854.GA8647@uranus.ravnborg.org>
References: <cda58cb80705110514g1098de81lec547e774eb76482@mail.gmail.com> <20070512.005905.26096031.anemo@mba.ocn.ne.jp> <cda58cb80705111223y5e94eafcy710b878517c48c48@mail.gmail.com> <20070513.014713.74753298.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070513.014713.74753298.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

On Sun, May 13, 2007 at 01:47:13AM +0900, Atsushi Nemoto wrote:
> On Fri, 11 May 2007 21:23:55 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> > Well I'm not sure how revelant are the echos...
> 
> Without the echos, you can get something like this and it seems unlear
> which ABI should be fixed.
> 
>   CALL    /home/git/linux-mips/scripts/checksyscalls.sh
>   ...
>   CALL    /home/git/linux-mips/scripts/checksyscalls.sh
>   ...
>   CALL    /home/git/linux-mips/scripts/checksyscalls.sh
>   ...
> 
> > But I still think that (a) you shouldn't put any command in
> > 'archprepare' multiple rule (b) you should move this rule from the
> > cleaning targets.
> 
> Oh, I missed those points.  Revised again.
> 
> 
> Subject: [PATCH] MIPS: Simplify missing-syscalls for N32 and O32

This is overengineered. The only reason to make the syscall check
for each and every build was that this was easy and the missing syscalls
are easy to spot during a normal build.
But checking all combinations is just not worth it.
The arch responsible are assumed to build for the different architectures
once in a while so a missing syscall are likely to be detected anyway.

We cannot run each and every consistency check in all combinations
for each build - that would end in only build noise.

	Sam

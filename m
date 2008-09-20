Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Sep 2008 16:09:22 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:14050 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S28798051AbYITPJS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 20 Sep 2008 16:09:18 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m8KF9Ggs007746;
	Sat, 20 Sep 2008 17:09:16 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m8KF9EHH007744;
	Sat, 20 Sep 2008 17:09:14 +0200
Date:	Sat, 20 Sep 2008 17:09:14 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	macro@linux-mips.org, u1@terran.org, linux-mips@linux-mips.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] MIPS checksum fix
Message-ID: <20080920150914.GA7725@linux-mips.org>
References: <20080919112304.GB13440@linux-mips.org> <20080919114743.GA19359@linux-mips.org> <20080919120752.GA19877@linux-mips.org> <20080919.230952.128619158.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080919.230952.128619158.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 19, 2008 at 11:09:52PM +0900, Atsushi Nemoto wrote:

> I think it would be better splitting bugfix and optimization.  This
> code is too complex to do many things at a time, isn't it?
> 
> > @@ -53,12 +53,14 @@
> >  #define UNIT(unit)  ((unit)*NBYTES)
> >  
> >  #define ADDC(sum,reg)						\
> > -	.set	push;						\
> > -	.set	noat;						\
> >  	ADD	sum, reg;					\
> >  	sltu	v1, sum, reg;					\
> >  	ADD	sum, v1;					\
> > -	.set	pop
> 
> Is this required?  Just a cleanup?

It papers over potencially important warnings so had to go.  I argue the
caller of ADDC should set noat mode, if at all.

  Ralf

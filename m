Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g61GwQnC011588
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 1 Jul 2002 09:58:26 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g61GwQjV011587
	for linux-mips-outgoing; Mon, 1 Jul 2002 09:58:26 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g61GwInC011571
	for <linux-mips@oss.sgi.com>; Mon, 1 Jul 2002 09:58:19 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA12073;
	Mon, 1 Jul 2002 19:02:39 +0200 (MET DST)
Date: Mon, 1 Jul 2002 19:02:38 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-mips@oss.sgi.com
Subject: Re: [Oops] Indy R4600 Oops(es) w/ 2.4.19-rc1
In-Reply-To: <20020701151359.GR17216@lug-owl.de>
Message-ID: <Pine.GSO.3.96.1020701185152.7601J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 1 Jul 2002, Jan-Benedict Glaw wrote:

> I'm just compiling with my proposed "fix". However, is it really a good
> idea to duplicate so much code? Taking my 2nd idea (having inline
> functions for saveing/restoring flags which are complete no-ops if
> !CONFIG_CPU_R4X00), would it be much overhead for 4400 and 4000 to check
> if we need to shuffle around flags and cut off interrupts?

 No need to duplicate anything -- templates may be used with bits
substituted as needed depending on what file is generated.  See e.g. 
arch/mips64/kernel/binfmt_elf32.c for an example idea. 

> I'm not really familiar w/ cache and interrupt handling/masking, and I
> don't (yet) exactly know how to check for the buggy old R4600, but I
> think I'll have to become an expert around that:-O

 The check is already in place -- see setup_noscache_funcs() in
arch/mips/mm/c-r4k.c, only the implementation is incomplete which started
biting after interrupts became active.

> Any hints for online resources? I've had a look at idt.com (found it in
> ./asm-mips/war.h), but I cannot find the resources there:-(

 I contacted them some time ago, soon after the fix for interrupt masking
went in (someone reported a problem with an old R4600 then). 
Unfortunately my conversation with them was disappointing and currently I
lack incentive to code a workaround for their buggy chips.  Especially as
I have tasks I consider more important to do. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2003 22:33:24 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:10871 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8225194AbTCUWdX>;
	Fri, 21 Mar 2003 22:33:23 +0000
Received: by trasno.mitica (Postfix, from userid 1001)
	id A3F6F720; Fri, 21 Mar 2003 23:33:21 +0100 (CET)
To: Hartvig Ekner <hartvig@ekner.info>
Cc: baitisj@evolution.com,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: Patches for all four au1000 setup.c files
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <3E7B8E39.CC463FEC@ekner.info> (Hartvig Ekner's message of
 "Fri, 21 Mar 2003 23:12:09 +0100")
References: <3E7AD36E.26E2EA94@ekner.info>
	<20030321113940.O26687@luca.pas.lab> <3E7B8E39.CC463FEC@ekner.info>
Date: Fri, 21 Mar 2003 23:33:21 +0100
Message-ID: <86fzpgpcy6.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "hartvig" == Hartvig Ekner <hartvig@ekner.info> writes:


hartvig> I can't see that they are using wbflush in any way. Grepping
hartvig> after wbflush through the entire 2.4 tree, it seems wbflush
hartvig> is something only present on some dec platforms and then the
hartvig> au1000 stuff - which would mean that any driver directly
hartvig> calling __wbflush would be unable to compile/load on the
hartvig> majority of kernels. Or am I missing something? (I haven't
hartvig> been using modules under MIPS at all).

Yes, you missed the definition of mb() :p

quintela$ grep "mb(" drivers/net/8139* | grep -v rmb | grep -v wmb
drivers/net/8139too.c:          mb();
quintela$ 


hartvig> In fact, I can't find a single file including wbflush.h
hartvig> except system.h, and it doesn't look like anybody else should
hartvig> directly be including the wbflush.h file, but only use the
hartvig> macros in system.h:

hartvig> #define wmb()           fast_wmb()
hartvig> #define rmb()           fast_rmb()
hartvig> #define mb()            wbflush();
hartvig> #define iob()           wbflush();

hartvig> (which are differently defined if there is no WB configured).

but WB is configured in :)

quintela$ grep WB arch/mips/defconfig-pb1*
arch/mips/defconfig-pb1000:CONFIG_CPU_HAS_WB=y
arch/mips/defconfig-pb1100:CONFIG_CPU_HAS_WB=y
arch/mips/defconfig-pb1500:CONFIG_CPU_HAS_WB=y
quintela$ 

Other thing is that this machine should be using wbflush at all, but
that is a different story.  I agree with  (/me looks in archive),
*your* patch removing wbflush for that boards.  They are only doing
"sync" ond wbflush, and that is the thing that __sync() already does.

I.e. If I have to chooses wich patch to integrate, the one exporting
__wbflush(), or the one removing it altogether from pb1*, I will
choose removing it.  It looks superflous.

Later, Juan "who don't have that processor, and handwaving is easy".

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2003 22:40:19 +0000 (GMT)
Received: from pasmtp.tele.dk ([IPv6:::ffff:193.162.159.95]:27918 "EHLO
	pasmtp.tele.dk") by linux-mips.org with ESMTP id <S8225194AbTCUWkS>;
	Fri, 21 Mar 2003 22:40:18 +0000
Received: from ekner.info (0x83a4a968.virnxx10.adsl-dhcp.tele.dk [131.164.169.104])
	by pasmtp.tele.dk (Postfix) with ESMTP
	id 41D85B4CD; Fri, 21 Mar 2003 23:40:17 +0100 (CET)
Message-ID: <3E7B9615.FB66BF53@ekner.info>
Date: Fri, 21 Mar 2003 23:45:41 +0100
From: Hartvig Ekner <hartvig@ekner.info>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-19.7.x i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: baitisj@evolution.com,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: Patches for all four au1000 setup.c files
References: <3E7AD36E.26E2EA94@ekner.info>
		<20030321113940.O26687@luca.pas.lab> <3E7B8E39.CC463FEC@ekner.info> <86fzpgpcy6.fsf@trasno.mitica>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <hartvig@ekner.info>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvig@ekner.info
Precedence: bulk
X-list: linux-mips

Hi Juan,

Juan Quintela wrote:

> >>>>> "hartvig" == Hartvig Ekner <hartvig@ekner.info> writes:
>
> hartvig> I can't see that they are using wbflush in any way. Grepping
> hartvig> after wbflush through the entire 2.4 tree, it seems wbflush
> hartvig> is something only present on some dec platforms and then the
> hartvig> au1000 stuff - which would mean that any driver directly
> hartvig> calling __wbflush would be unable to compile/load on the
> hartvig> majority of kernels. Or am I missing something? (I haven't
> hartvig> been using modules under MIPS at all).
>
> Yes, you missed the definition of mb() :p
>
> quintela$ grep "mb(" drivers/net/8139* | grep -v rmb | grep -v wmb
> drivers/net/8139too.c:          mb();
> quintela$
>
> hartvig> In fact, I can't find a single file including wbflush.h
> hartvig> except system.h, and it doesn't look like anybody else should
> hartvig> directly be including the wbflush.h file, but only use the
> hartvig> macros in system.h:
>
> hartvig> #define wmb()           fast_wmb()
> hartvig> #define rmb()           fast_rmb()
> hartvig> #define mb()            wbflush();
> hartvig> #define iob()           wbflush();
>
> hartvig> (which are differently defined if there is no WB configured).
>
> but WB is configured in :)
>

That's the problem! Wb does not need to be configured in, it is a mistake. My patch was missing
the required fixes to the defconfig files, it was only described in the mail.  So I think the only
thing missing is a patch to fix all the pb/db defconfig files to look like this:

# CONFIG_CPU_ADVANCED is not set
CONFIG_CPU_HAS_LLSC=y
# CONFIG_CPU_HAS_LLDSCD is not set
# CONFIG_CPU_HAS_WB is not set
CONFIG_CPU_HAS_SYNC=y

... which is the setting also used by all other MIPS32 CPUs. Then everything should be ok.

/Hartvig

>
> quintela$ grep WB arch/mips/defconfig-pb1*
> arch/mips/defconfig-pb1000:CONFIG_CPU_HAS_WB=y
> arch/mips/defconfig-pb1100:CONFIG_CPU_HAS_WB=y
> arch/mips/defconfig-pb1500:CONFIG_CPU_HAS_WB=y
> quintela$
>
> Other thing is that this machine should be using wbflush at all, but
> that is a different story.  I agree with  (/me looks in archive),
> *your* patch removing wbflush for that boards.  They are only doing
> "sync" ond wbflush, and that is the thing that __sync() already does.
>
> I.e. If I have to chooses wich patch to integrate, the one exporting
> __wbflush(), or the one removing it altogether from pb1*, I will
> choose removing it.  It looks superflous.
>
> Later, Juan "who don't have that processor, and handwaving is easy".
>
> --
> In theory, practice and theory are the same, but in practice they
> are different -- Larry McVoy

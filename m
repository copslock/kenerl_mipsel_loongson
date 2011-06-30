Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2011 13:06:03 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:36170 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491023Ab1F3LFz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Jun 2011 13:05:55 +0200
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx2.suse.de (Postfix) with ESMTP id 391B38A908;
        Thu, 30 Jun 2011 13:05:55 +0200 (CEST)
Date:   Thu, 30 Jun 2011 13:05:54 +0200
Message-ID: <s5h39iry3xp.wl%tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        florian@linux-mips.org, Florian Fainelli <florian@openwrt.org>,
        linux-arch@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: SB16 build error.
In-Reply-To: <20110630105254.GA25732@linux-mips.org>
References: <20110630091754.GA12119@linux-mips.org>
        <s5h8vsjy68z.wl%tiwai@suse.de>
        <20110630105254.GA25732@linux-mips.org>
User-Agent: Wanderlust/2.15.6 (Almost Unreal) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.9 (=?ISO-2022-JP-2?B?R29qGyQoRCtXGyhC?=) APEL/10.7 Emacs/23.2
 (x86_64-suse-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=ISO-2022-JP
X-archive-position: 30564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiwai@suse.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 24827

At Thu, 30 Jun 2011 11:52:54 +0100,
Ralf Baechle wrote:
> 
> On Thu, Jun 30, 2011 at 12:15:56PM +0200, Takashi Iwai wrote:
> 
> > At Thu, 30 Jun 2011 10:17:54 +0100,
> > Ralf Baechle wrote:
> > > 
> > > Found on a MIPS build but certain other architectures will have the same
> > > issue:
> > > 
> > >   CC      sound/isa/sb/sb16_csp.o
> > > sound/isa/sb/sb16_csp.c: In function $B!F(Bsnd_sb_csp_ioctl$B!G(B:
> > > sound/isa/sb/sb16_csp.c:228: error: case label does not reduce to an integer constant
> > > make[1]: *** [sound/isa/sb/sb16_csp.o] Error 1
> > > make: *** [sound/isa/sb/sb16_csp.o] Error 2
> > > 
> > > This error message is caused by the _IOC_TYPECHECK() error check triggering
> > > due to excessive ioctl size on Alpha, PowerPC, MIPS and SPARC which define
> > > _IOC_SIZEBITS as 13.  On all other architectures define it as 14 so struct
> > > snd_sb_csp_microcode with it's little over 12kB will just about fit into
> > > the 16kB limit.
> > 
> > What about the patch below?
> 
> I have no idea how big the soundblaster microcode being loaded actually is,
> that is if the reduced size of 0x1f00 will be sufficient.

The files found in /lib/firmware/sb16 are all under 2kB, thus likely
sufficient.

> Aside of that I
> don't see a problem - I don't see how the old ioctl can possibly have been
> used before so there isn't a compatibility problem.
> 
> Or you could entirely sidestep the problem and use request_firmware() but
> I guess that's more effort than you want to invest.

Yeah, that's another option I thought of.  But it's too intrusive for
3.0-rc6, so I'd like waive it for 3.1.

> > This is an old ISA driver, so the impact must be very low.
> 
> True.  I notice that sort of stuff in automated mass builds - not
> necessarily the sort of kernels one would actually use.  Still build errors
> are annoying :)

Right, better to fix it up quickly.


thanks,

Takashi

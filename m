Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2004 16:23:56 +0000 (GMT)
Received: from mx5.Informatik.Uni-Tuebingen.De ([IPv6:::ffff:134.2.12.32]:10900
	"EHLO mx5.informatik.uni-tuebingen.de") by linux-mips.org with ESMTP
	id <S8225437AbUATQXz>; Tue, 20 Jan 2004 16:23:55 +0000
Received: from localhost (loopback [127.0.0.1])
	by mx5.informatik.uni-tuebingen.de (Postfix) with ESMTP
	id A3883128; Tue, 20 Jan 2004 17:23:45 +0100 (NFT)
Received: from mx5.informatik.uni-tuebingen.de ([127.0.0.1])
 by localhost (mx5 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 43238-03; Tue, 20 Jan 2004 17:23:44 +0100 (NFT)
Received: from dual (semeai.Informatik.Uni-Tuebingen.De [134.2.15.66])
	by mx5.informatik.uni-tuebingen.de (Postfix) with ESMTP
	id 62AC9113; Tue, 20 Jan 2004 17:23:43 +0100 (NFT)
Received: from mrvn by dual with local (Exim 3.36 #1 (Debian))
	id 1AiyfE-0001Qo-00; Tue, 20 Jan 2004 17:23:40 +0100
To: Guido Guenther <agx@debian.org>
Cc: linux-mips@linux-mips.org, debian-mips@lists.debian.org
Subject: Re: Need .config files for Debians kernel-image-2.4.24-mips(el)
References: <878yk21z7p.fsf@mrvn.homelinux.org>
	<20040120144212.GA7046@bogon.ms20.nix>
From: Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de>
Date: 20 Jan 2004 17:23:39 +0100
In-Reply-To: <20040120144212.GA7046@bogon.ms20.nix>
Message-ID: <874quq1tdg.fsf@mrvn.homelinux.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Reasonable Discussion)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Virus-Scanned: by amavisd-new (McAfee AntiVirus) at informatik.uni-tuebingen.de
Return-Path: <brederlo@informatik.uni-tuebingen.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brederlo@informatik.uni-tuebingen.de
Precedence: bulk
X-list: linux-mips

Guido Guenther <agx@debian.org> writes:

> On Tue, Jan 20, 2004 at 03:17:30PM +0100, Goswin von Brederlow wrote:
> > I'm putting together a kernel image package for debian mips and
> > mipsel.
> We already have that (we're at 2.4.22 currently, look for
> kernel-patch-2.4.X-mips). Please don't add new packages, you're welcome
> to take over the current packages however.
>  -- Guido

I saw that and am updating it. I was planing of sending you a patch
when its done and working. If you feel your time is running short
(when isn't it) I would rather do a comaintainership then taking it
over completly. Since I'm not a DD yet, still in the NM queue, I would
need a sponsor for the package anyway. Something as important as the
kernel should be cared for my more than one person to minimize
reaction times to security exploits.


While working on the upgrade I came across some questions:

Is the kernel-patch-2.4.22-mips relative to the debian kernel source
or the vanilla source? And is the result (after patching) the mips cvs
or cvs merged with the debian patch? And should that be done that way
again?

I tried a dry run on the debian patch on top of the mips cvs and saw a
few conflicts. Merging the two would be some more work.

Apart from updating the patch (vanila->mips cvs, testing if it gives
any conflicts now) I added my own system XXS1500 board from MyCable to
the configs and added the kernel-image deb and udebs to the control
file. No major changes yet.

Have you thought about dropping the udebs and letting debian-installer
build -di udebs the way it does for several other arches now?

[
1 out of 17 hunks FAILED -- saving rejects to file arch/mips64/kernel/ioctl32.c.rej

So I guess the source to patch from includes the debian patch. Now I
only need to know what the result should be, i.e. pure cvs or merged?
]

MfG
        Goswin

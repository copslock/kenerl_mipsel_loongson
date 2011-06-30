Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2011 14:32:30 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:59983 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491023Ab1F3Mc1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Jun 2011 14:32:27 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p5UCWFs7009041;
        Thu, 30 Jun 2011 13:32:15 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5UCWCKm009031;
        Thu, 30 Jun 2011 13:32:12 +0100
Date:   Thu, 30 Jun 2011 13:32:12 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Takashi Iwai <tiwai@suse.de>
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
Message-ID: <20110630123212.GA6690@linux-mips.org>
References: <20110630091754.GA12119@linux-mips.org>
 <s5h8vsjy68z.wl%tiwai@suse.de>
 <20110630105254.GA25732@linux-mips.org>
 <s5h39iry3xp.wl%tiwai@suse.de>
 <s5hy60jwocc.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hy60jwocc.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 24876

On Thu, Jun 30, 2011 at 01:28:03PM +0200, Takashi Iwai wrote:

> > > I have no idea how big the soundblaster microcode being loaded actually is,
> > > that is if the reduced size of 0x1f00 will be sufficient.
> > 
> > The files found in /lib/firmware/sb16 are all under 2kB, thus likely
> > sufficient.
> 
> Too shortly answered.  It turned out that some CSP codes (like Qsound)
> can be above that size, it's almost 12kB.  So the size in the original
> code is really the necessary requirement, and the patch breaks for
> such a case.
> 
> An ugly workaround would be to fake the ioctl size.  But this is
> certainly to be avoided, since it has been broken on the specific
> platforms for ages, thus breaking for them would be mostly harmless,
> too.
> 
> > > Aside of that I
> > > don't see a problem - I don't see how the old ioctl can possibly have been
> > > used before so there isn't a compatibility problem.
> > > 
> > > Or you could entirely sidestep the problem and use request_firmware() but
> > > I guess that's more effort than you want to invest.
> > 
> > Yeah, that's another option I thought of.  But it's too intrusive for
> > 3.0-rc6, so I'd like waive it for 3.1.
> 
> Actually the request_firmware() was implemented for some auto-loadable
> CSP codes.  Others need the manual loading, so it is via ioctl.  It
> can be converted, but I don't think it makes sense for such old
> stuff.  After all, it still works with x86-ISA as is.

In userland an empty definition will be used for _IOC_TYPECHECK so there
won't be an error.  So userland already is already using the existing
value for SNDRV_SB_CSP_IOCTL_LOAD_CODE ...

With a crude hack like

#define SNDRV_SB_CSP_IOCTL_LOAD_CODE				\
	_IOC(_IOC_WRITE,'H', 0x11, sizeof(struct snd_sb_csp_microcode))

error checking can be bypassed and all will be fine as long as the
resulting value doesn't result in in a a duplicate case value - which it
doesn't, at least not in my testing.

Should work but isn't nice.

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2011 09:43:52 +0200 (CEST)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38716 "EHLO
        caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491063Ab1FOHnq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2011 09:43:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=caramon;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=w973z0Fa/80PLH5FFIiMGPYsqUQMlNp2jjMb8hfv48s=;
        b=N7aEnoGdIiSKK3w7v9v+vtwCqJ/fQgPGYHTkKFZZeO2VzLom9px/0Oql9n6IPeeN+vyqBisFFz8NB6nx3oOaihss3e/v77NfqrHrnUdV2gN9+Q5SwuTaxu584ETCIgjQGSXZx9sMxWxhNVCYMJXCfAg3HpANcxVIp8TykHZfAic=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
        by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1QWkhO-0003Kt-6M; Wed, 15 Jun 2011 08:39:38 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.72)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1QWkhM-0003PG-2h; Wed, 15 Jun 2011 08:39:36 +0100
Date:   Wed, 15 Jun 2011 08:39:35 +0100
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Chris Zankel <chris@zankel.net>,
        "David S. Miller" <davem@davemloft.net>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Kyle McMartin <kyle@mcmartin.ca>,
        Lennox Wu <lennox.wu@gmail.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Mikael Starvik <starvik@axis.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Richard Henderson <rth@twiddle.net>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "microblaze-uclinux@itee.uq.edu.au" 
        <microblaze-uclinux@itee.uq.edu.au>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-m68k@vger.kernel.org" <linux-m68k@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
Message-ID: <20110615073935.GA28989@n2100.arm.linux.org.uk>
References: <20110614190850.GA13526@linux-mips.org> <987664A83D2D224EAE907B061CE93D5301E7281306@orsmsx505.amr.corp.intel.com> <4DF8359F.10809@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DF8359F.10809@zytor.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-archive-position: 30397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12150

On Tue, Jun 14, 2011 at 09:31:27PM -0700, H. Peter Anvin wrote:
> On 06/14/2011 03:08 PM, Luck, Tony wrote:
> > I took a look at the back of all my ia64 systems - none of them
> > have a parallel port.  It seems unlikely that new systems will
> > start adding parallel ports :-)
> > 
> > So even if I had a printer (or other device) that used a parallel
> > port, I have no way to test it.
> 
> If it has PCI slots, it can have a parallel port.

Is that a clue about where a select statement should be?

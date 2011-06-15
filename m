Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2011 16:46:22 +0200 (CEST)
Received: from imr3.ericy.com ([198.24.6.13]:40961 "EHLO imr3.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491098Ab1FOOqS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jun 2011 16:46:18 +0200
Received: from eusaamw0712.eamcs.ericsson.se ([147.117.20.181])
        by imr3.ericy.com (8.13.8/8.13.8) with ESMTP id p5FEaWC5017071
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 15 Jun 2011 09:36:35 -0500
Received: from localhost (147.117.20.214) by eusaamw0712.eamcs.ericsson.se
 (147.117.20.182) with Microsoft SMTP Server id 8.3.137.0; Wed, 15 Jun 2011
 10:36:34 -0400
Date:   Wed, 15 Jun 2011 07:36:34 -0700
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     "H. Peter Anvin" <hpa@zytor.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Chris Zankel <chris@zankel.net>,
        "David S. Miller" <davem@davemloft.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
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
        Russell King <linux@arm.linux.org.uk>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
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
Message-ID: <20110615143634.GA12757@ericsson.com>
References: <20110614190850.GA13526@linux-mips.org>
 <4DF7C3CA.9050902@zytor.com>
 <20110614223404.GA30057@linux-mips.org>
 <4DF8329C.7000904@zytor.com>
 <20110615083437.GA32624@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20110615083437.GA32624@linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 30411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12402

On Wed, Jun 15, 2011 at 04:34:37AM -0400, Ralf Baechle wrote:
> On Tue, Jun 14, 2011 at 09:18:36PM -0700, H. Peter Anvin wrote:
> 
> > On 06/14/2011 03:34 PM, Ralf Baechle wrote:
> > > 
> > > There is no point in offering to build something that couldn't possibly be
> > > used.  It just makes the kernel harder to configure and inflates the test
> > > matrix for no good reason.
> > > 
> > 
> > I see... that's why a bunch of devices that only exist on ARM and MIPS
> > SoCs are offered on x86 platforms?
> 
> Well, if you notice one of those, yell.  Or send patches.  Most of those
> have been fixed.
> 
I think he was being sarcastic, and wanted to say that it should be that way.

Guenter

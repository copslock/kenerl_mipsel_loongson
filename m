Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jul 2013 08:52:30 +0200 (CEST)
Received: from ozlabs.org ([203.10.76.45]:59309 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817545Ab3GBGw2jfg0Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Jul 2013 08:52:28 +0200
Received: from concordia (ibmaus65.lnk.telstra.net [165.228.126.9])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (Client did not present a certificate)
        by ozlabs.org (Postfix) with ESMTPSA id A542A2C009F;
        Tue,  2 Jul 2013 16:52:22 +1000 (EST)
Date:   Tue, 2 Jul 2013 16:52:20 +1000
From:   Michael Ellerman <michael@ellerman.id.au>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Lior Amsalem <alior@marvell.com>, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Chris Metcalf <cmetcalf@tilera.com>,
        linux-arm-kernel@lists.infradead.org,
        Tony Luck <tony.luck@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maen Suleiman <maen@marvell.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCHv4 02/11] pci: use weak functions for MSI arch-specific
 functions
Message-ID: <20130702065220.GA20521@concordia>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372726396.17904.1.camel@concordia>
 <20130702073037.55a53642@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130702073037.55a53642@skate>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <michael@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael@ellerman.id.au
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Tue, Jul 02, 2013 at 07:30:37AM +0200, Thomas Petazzoni wrote:
> Dear Michael Ellerman,
> 
> On Tue, 02 Jul 2013 10:53:16 +1000, Michael Ellerman wrote:
> > On Mon, 2013-07-01 at 15:42 +0200, Thomas Petazzoni wrote:
> > > Until now, the MSI architecture-specific functions could be overloaded
> > > using a fairly complex set of #define and compile-time
> > > conditionals. In order to prepare for the introduction of the msi_chip
> > > infrastructure, it is desirable to switch all those functions to use
> > > the 'weak' mechanism. This commit converts all the architectures that
> > > were overidding those MSI functions to use the new strategy.
> > 
> > The MSI code used to use weak functions, until we discovered they were
> > being miscompiled on some toolchains (11df1f0). I assume these days
> > we're confident they work correctly.
> 
> Hum, interesting. I see from your commit that gcc 4.3.2 was apparently
> affected, and gcc 4.3.x is not /that/ old. Bjorn, what's your point of
> view on this?

Stop press.

I went back and found the old threads on this, it's been a while. It
looks like it was only gcc 4.1.[01] that miscompiled. The reference to
gcc 4.3.2 was WRT ellision of the unused code, which is a separate
issue.

The kernel blacklists gcc 4.1.[01] (see f9d1425), so weak should be
safe to use.

We merged the change to the PCI code anyway because we thought it was
nicer and it also avoided any problems with weak.

So pretend I never said anything :)

cheers

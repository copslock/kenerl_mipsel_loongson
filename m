Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 22:10:12 +0100 (CET)
Received: from gate.crashing.org ([63.228.1.57]:48261 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
	id S1493578AbZKXVKH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Nov 2009 22:10:07 +0100
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id nAOL9Dbn023474;
	Tue, 24 Nov 2009 15:09:13 -0600
Subject: Re: Time to make PCI_MSI default y ?
From:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Michael Ellerman <michael@ellerman.id.au>,
	linux-pci <linux-pci@vger.kernel.org>, linux@arm.linux.org.uk,
	"tony.luck" <tony.luck@intel.com>, fenghua.yu@intel.com,
	"David S.Miller" <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
	Peter Anvin <hpa@zytor.com>, linux-mips@linux-mips.org,
	David Daney <ddaney@caviumnetworks.com>
In-Reply-To: <20091124125309.GB5749@linux-mips.org>
References: <1259030388.20596.5.camel@concordia>
	 <20091124125309.GB5749@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Date:	Wed, 25 Nov 2009 08:09:12 +1100
Message-ID: <1259096952.16367.134.camel@pasglop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <benh@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benh@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

On Tue, 2009-11-24 at 12:53 +0000, Ralf Baechle wrote:
> On Tue, Nov 24, 2009 at 01:39:48PM +1100, Michael Ellerman wrote:
> 
> > Having just hit a build-break caused by a distro building with
> > PCI_MSI=n, I set out to make it default y for powerpc. Unfortunately
> > that's not possible, because it's in drivers/pci/Kconfig.
> > 
> > So is it time to make it default y for everyone? It seems to me having
> > it off is more likely to cause problems than having it on these days,
> > though I'm not sure if that is true for all archs.
> > 
> > An arch that really didn't want it default y could conditionally select
> > ARCH_SUPPORTS_MSI, like x86 does already.
> 
> On MIPS the age of MSI only recently started; once single platform (Cavium)
> out of all the many uses it.  Cavium does a "select ARCH_SUPPORTS_MSI" but
> not "select PCI_MSI" because not all platform variants actually have PCI.
> 
> We should  not give a user a chance to select something wrong in kconfig
> thus automatically as many options for a platform as possible is a good
> thing - after all the kconfig dialog for any given platfrom has become
> painfully long.  And we really should have to avoid users having to know
> that the Frobnic 2000 they're trying to upgrade the kernel for requires
> MSI to work ...

Still... select has nasty issues. I think default y is fine here. For
platforms that don't need it, make sure their defconfigs don't have it
set...

Or maybe default y if (X86 || PPC)

Cheers,
Ben.

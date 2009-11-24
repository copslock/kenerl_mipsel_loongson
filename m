Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 13:53:52 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:57012 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
	id S1492366AbZKXMxs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Nov 2009 13:53:48 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAOCrE1K027246;
	Tue, 24 Nov 2009 12:53:14 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAOCr9YD027244;
	Tue, 24 Nov 2009 12:53:09 GMT
Date:	Tue, 24 Nov 2009 12:53:09 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Michael Ellerman <michael@ellerman.id.au>
Cc:	linux-pci <linux-pci@vger.kernel.org>, linux@arm.linux.org.uk,
	"tony.luck" <tony.luck@intel.com>, fenghua.yu@intel.com,
	"David S.Miller" <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
	Peter Anvin <hpa@zytor.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: Re: Time to make PCI_MSI default y ?
Message-ID: <20091124125309.GB5749@linux-mips.org>
References: <1259030388.20596.5.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1259030388.20596.5.camel@concordia>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 24, 2009 at 01:39:48PM +1100, Michael Ellerman wrote:

> Having just hit a build-break caused by a distro building with
> PCI_MSI=n, I set out to make it default y for powerpc. Unfortunately
> that's not possible, because it's in drivers/pci/Kconfig.
> 
> So is it time to make it default y for everyone? It seems to me having
> it off is more likely to cause problems than having it on these days,
> though I'm not sure if that is true for all archs.
> 
> An arch that really didn't want it default y could conditionally select
> ARCH_SUPPORTS_MSI, like x86 does already.

On MIPS the age of MSI only recently started; once single platform (Cavium)
out of all the many uses it.  Cavium does a "select ARCH_SUPPORTS_MSI" but
not "select PCI_MSI" because not all platform variants actually have PCI.

We should  not give a user a chance to select something wrong in kconfig
thus automatically as many options for a platform as possible is a good
thing - after all the kconfig dialog for any given platfrom has become
painfully long.  And we really should have to avoid users having to know
that the Frobnic 2000 they're trying to upgrade the kernel for requires
MSI to work ...

  Ralf

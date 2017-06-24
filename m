Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jun 2017 11:14:45 +0200 (CEST)
Received: from pandora.armlinux.org.uk ([IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6]:46614
        "EHLO pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991726AbdFXJOgCUF0a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jun 2017 11:14:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=armlinux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=6Wbk1wQDnzPkE9RpZB1N/FF/IUGUf8+InP7DtSIYWUQ=;
        b=SIWC8dnMkXljKbDKw77Ea5gK24WIII/oxh0bqulBPxPV6itGsDCWejw62pQ7a/QtVQWSibBbTKm6Nx9ePfwEDtHtqMFfGXEmEtPdDybs4aCNSIv84JZCziv/tIDupLH2TcxOSFMb/X9eQjp5jXPcB+mfaF1b0KDVkTAFgKRLoQs=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:52507)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@armlinux.org.uk>)
        id 1dOh8y-0007Jj-0M; Sat, 24 Jun 2017 10:14:16 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1dOh8r-0005JG-Ak; Sat, 24 Jun 2017 10:14:09 +0100
Date:   Sat, 24 Jun 2017 10:14:07 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com,
        catalin.marinas@arm.com, will.deacon@arm.com, geert@linux-m68k.org,
        ralf@linux-mips.org, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, cmetcalf@mellanox.com, gxt@mprc.pku.edu.cn,
        bhelgaas@google.com, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-pci@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH] pci:  Add and use PCI_GENERIC_SETUP Kconfig entry
Message-ID: <20170624091406.GZ4902@n2100.armlinux.org.uk>
References: <20170623214538.25967-1-palmer@dabbelt.com>
 <20170623220104.GE31455@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170623220104.GE31455@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@armlinux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@armlinux.org.uk
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

On Fri, Jun 23, 2017 at 11:01:04PM +0100, James Hogan wrote:
> On Fri, Jun 23, 2017 at 02:45:38PM -0700, Palmer Dabbelt wrote:
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 4c1a35f15838..86872246951c 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -96,6 +96,7 @@ config ARM
> >  	select PERF_USE_VMALLOC
> >  	select RTC_LIB
> >  	select SYS_SUPPORTS_APM_EMULATION
> > +	select PCI_GENERIC_SETUP
> >  	# Above selects are sorted alphabetically; please add new ones
> >  	# according to that.  Thanks.
> 
> This comment seems to suggest PCI_GENERIC_SETUP should be added a few
> lines up to preserve the alphabetical sorting.

Indeed it should.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2008 21:15:39 +0100 (BST)
Received: from outbound-mail-124.bluehost.com ([67.222.38.24]:5803 "HELO
	outbound-mail-124.bluehost.com") by ftp.linux-mips.org with SMTP
	id S20031207AbYF0UPb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 27 Jun 2008 21:15:31 +0100
Received: (qmail 24979 invoked by uid 0); 27 Jun 2008 20:15:23 -0000
Received: from unknown (HELO box128.bluehost.com) (69.89.22.128)
  by outboundproxy4.bluehost.com with SMTP; 27 Jun 2008 20:15:23 -0000
Received: from [75.111.27.49] (helo=[192.168.1.157])
	by box128.bluehost.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <jbarnes@virtuousgeek.org>)
	id 1KCKLr-0002Jl-75; Fri, 27 Jun 2008 14:15:23 -0600
From:	Jesse Barnes <jbarnes@virtuousgeek.org>
To:	Adrian Bunk <bunk@kernel.org>
Subject: Re: [2.6 patch] remove pcibios_update_resource() functions
Date:	Fri, 27 Jun 2008 13:14:59 -0700
User-Agent: KMail/1.9.9
Cc:	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dhowells@redhat.com, gerg@uclinux.org, ralf@linux-mips.org,
	linux-mips@linux-mips.org, lethal@linux-sh.org,
	linux-sh@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>
References: <20080617223332.GM25911@cs181133002.pp.htv.fi>
In-Reply-To: <20080617223332.GM25911@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200806271315.01148.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 75.111.27.49 authed with jbarnes@virtuousgeek.org}
DomainKey-Status: no signature
Return-Path: <jbarnes@virtuousgeek.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbarnes@virtuousgeek.org
Precedence: bulk
X-list: linux-mips

On Tuesday, June 17, 2008 3:33 pm Adrian Bunk wrote:
> Russell King did the following back in 2003:
>
> <--  snip  -->
>
>     [PCI] pci-9: Kill per-architecture pcibios_update_resource()
>
>     Kill pcibios_update_resource(), replacing it with
> pci_update_resource(). pci_update_resource() uses pcibios_resource_to_bus()
> to convert a resource to a device BAR - the transformation should be
> exactly the same as the transformation used for the PCI bridges.
>
>     pci_update_resource "knows" about 64-bit BARs, but doesn't attempt to
>     set the high 32-bits to anything non-zero - currently no architecture
>     attempts to do something different.  If anyone cares, please fix; I'm
>     going to reflect current behaviour for the time being.
>
>     Ivan pointed out the following architectures need to examine their
>     pcibios_update_resource() implementation - they should make sure that
>     this new implementation does the right thing.  #warning's have been
>     added where appropriate.
>
>         ia64
>         mips
>         mips64
>
>     This cset also includes a fix for the problem reported by AKPM where
>     64-bit arch compilers complain about the resource mask being placed
>     in a u32.
>
> <--  snip  -->
>
>
> This patch removes the unused pcibios_update_resource() functions the
> kernel gained since.
>
>
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

Applied to my linux-next tree, thanks Adrian and everyone for your acks.

Jesse

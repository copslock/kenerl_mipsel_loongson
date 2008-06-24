Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2008 04:50:49 +0100 (BST)
Received: from mta23.gyao.ne.jp ([125.63.38.249]:40333 "EHLO mx.gate01.com")
	by ftp.linux-mips.org with ESMTP id S20023413AbYFXDum (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2008 04:50:42 +0100
Received: from [124.34.33.190] (helo=master.linux-sh.org)
	by smtp31.isp.us-com.jp with esmtp (Mail 4.41)
	id 1KAzY8-0002tX-AO; Tue, 24 Jun 2008 12:50:32 +0900
Received: from localhost (unknown [127.0.0.1])
	by master.linux-sh.org (Postfix) with ESMTP id 0955763754;
	Tue, 24 Jun 2008 03:48:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at linux-sh.org
Received: from master.linux-sh.org ([127.0.0.1])
	by localhost (master.linux-sh.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nlPPHhKYs3AU; Tue, 24 Jun 2008 12:48:06 +0900 (JST)
Received: by master.linux-sh.org (Postfix, from userid 500)
	id 8872F63758; Tue, 24 Jun 2008 12:48:06 +0900 (JST)
Date:	Tue, 24 Jun 2008 12:48:06 +0900
From:	Paul Mundt <lethal@linux-sh.org>
To:	Adrian Bunk <bunk@kernel.org>
Cc:	jbarnes@virtuousgeek.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, dhowells@redhat.com, gerg@uclinux.org,
	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-sh@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [2.6 patch] remove pcibios_update_resource() functions
Message-ID: <20080624034806.GA22526@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Adrian Bunk <bunk@kernel.org>, jbarnes@virtuousgeek.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dhowells@redhat.com, gerg@uclinux.org, ralf@linux-mips.org,
	linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
	Russell King <rmk+lkml@arm.linux.org.uk>
References: <20080617223332.GM25911@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080617223332.GM25911@cs181133002.pp.htv.fi>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <lethal@linux-sh.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lethal@linux-sh.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 18, 2008 at 01:33:32AM +0300, Adrian Bunk wrote:
> Russell King did the following back in 2003:
> 
> <--  snip  -->
> 
>     [PCI] pci-9: Kill per-architecture pcibios_update_resource()
>     
>     Kill pcibios_update_resource(), replacing it with pci_update_resource().
>     pci_update_resource() uses pcibios_resource_to_bus() to convert a
>     resource to a device BAR - the transformation should be exactly the
>     same as the transformation used for the PCI bridges.
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
> 
sh parts -

Acked-by: Paul Mundt <lethal@linux-sh.org>

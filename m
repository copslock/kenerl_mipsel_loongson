Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2003 11:53:27 +0100 (BST)
Received: from carisma.slowglass.com ([IPv6:::ffff:195.224.96.167]:5641 "EHLO
	phoenix.infradead.org") by linux-mips.org with ESMTP
	id <S8225073AbTE0KxZ>; Tue, 27 May 2003 11:53:25 +0100
Received: from hch by phoenix.infradead.org with local (Exim 4.10)
	id 19Kc54-0001r1-00; Tue, 27 May 2003 11:53:22 +0100
Date: Tue, 27 May 2003 11:53:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: ralf@linux-mips.org, wgowcher@yahoo.com, linux-mips@linux-mips.org
Subject: Re: pci_alloc_consistent usage
Message-ID: <20030527115322.A7124@infradead.org>
References: <20030523215935.71373.qmail@web11901.mail.yahoo.com> <20030527091740.GA23296@linux-mips.org> <20030527.190749.39150100.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030527.190749.39150100.nemoto@toshiba-tops.co.jp>; from anemo@mba.ocn.ne.jp on Tue, May 27, 2003 at 07:07:49PM +0900
Return-Path: <hch@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@infradead.org
Precedence: bulk
X-list: linux-mips

On Tue, May 27, 2003 at 07:07:49PM +0900, Atsushi Nemoto wrote:
> >>>>> On Tue, 27 May 2003 11:17:40 +0200, Ralf Baechle <ralf@linux-mips.org> said:
> ralf> Use the value returned by pci_alloc_consistent in *dma_handle
> ralf> instead of trying to do any conversions with of
> ralf> pci_alloc_consistent's return value.
> 
> How about virt_to_page()?
> 
> Currently, many sound drivers (including ALSA) pass a
> pci_alloc_consistent's return value to virt_to_page.

You are not allow to do so.  Any driver doing this is broken.

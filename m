Received:  by oss.sgi.com id <S553824AbQKWWB2>;
	Thu, 23 Nov 2000 14:01:28 -0800
Received: from [207.81.221.34] ([207.81.221.34]:32371 "EHLO relay")
	by oss.sgi.com with ESMTP id <S553759AbQKWWBL>;
	Thu, 23 Nov 2000 14:01:11 -0800
Received: from vcubed.com ([207.81.96.153])
	by relay (8.8.7/8.8.7) with ESMTP id RAA20861;
	Thu, 23 Nov 2000 17:23:09 -0500
Message-ID: <3A1D946B.CEF85110@vcubed.com>
Date:   Thu, 23 Nov 2000 17:04:27 -0500
From:   Dan Aizenstros <dan@vcubed.com>
Organization: V3 Semiconductor
X-Mailer: Mozilla 4.6 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     linux-mips@oss.sgi.com
Subject: Re: Multiple copies of pci-dma.c file.
References: <3A1BD888.7FB3C6A6@vcubed.com> <20001122165653.A6421@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello Ralf,

Should the dma_cache_inv actually be a dma_cache_wback_inv?

Also, the sni directory contains a dma.c which is they same
as pci-dma.c and should be removed.

Dan Aizenstros
Software Engineer
V3 Semicondutor Corp.

Ralf Baechle wrote:
> 
> On Wed, Nov 22, 2000 at 09:30:32AM -0500, Dan Aizenstros wrote:
> 
> > Is there any reason for having multiple copies of
> > the pci-dma.c file in Linux/MIPS.  The are all
> > doing basically the same thing.  We could have
> > just one copy in the arch/mips/lib directory
> > and have the Makefile build it if CONFIG_PCI
> > is defined.
> 
> Sounds like a plan, done.  Tell me if it breaks something ...
> 
> Some chipsets have a builtin scatter / gather facility, those may need
> special variants of pci-dma.c for better support.
> 
> > Also they appear to have an error in that they
> > convert the pointer that is returned from the
> > __get_free_pages function call into a KSEG1
> > address even if the pointer is NULL.
> 
> Fixed.
> 
>   Ralf

Received:  by oss.sgi.com id <S553786AbQKXBgS>;
	Thu, 23 Nov 2000 17:36:18 -0800
Received: from u-214-21.karlsruhe.ipdial.viaginterkom.de ([62.180.21.214]:25348
        "EHLO u-214-21.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553652AbQKXBgG>; Thu, 23 Nov 2000 17:36:06 -0800
Received: (ralf@lappi) by bacchus.dhis.org id <S868987AbQKXBfp>;
	Fri, 24 Nov 2000 02:35:45 +0100
Date:	Fri, 24 Nov 2000 02:35:45 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Dan Aizenstros <dan@vcubed.com>
Cc:	linux-mips@oss.sgi.com
Subject: Re: Multiple copies of pci-dma.c file.
Message-ID: <20001124023545.A9305@bacchus.dhis.org>
References: <3A1BD888.7FB3C6A6@vcubed.com> <20001122165653.A6421@bacchus.dhis.org> <3A1D946B.CEF85110@vcubed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A1D946B.CEF85110@vcubed.com>; from dan@vcubed.com on Thu, Nov 23, 2000 at 05:04:27PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Nov 23, 2000 at 05:04:27PM -0500, Dan Aizenstros wrote:

> Should the dma_cache_inv actually be a dma_cache_wback_inv?

Conceptually your right and I've therefore changed the kernel.  It wasn't
a bug though because the actual implementation was in both cases
actually doing a dma_cache_wback_inv.

> Also, the sni directory contains a dma.c which is they same as pci-dma.c
> and should be removed.

``He's dead, Jim''.

  Ralf

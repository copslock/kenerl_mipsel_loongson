Received:  by oss.sgi.com id <S553734AbQKVP5V>;
	Wed, 22 Nov 2000 07:57:21 -0800
Received: from u-119-10.karlsruhe.ipdial.viaginterkom.de ([62.180.10.119]:14855
        "EHLO u-119-10.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553696AbQKVP5K>; Wed, 22 Nov 2000 07:57:10 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868489AbQKVP4x>;
	Wed, 22 Nov 2000 16:56:53 +0100
Date:	Wed, 22 Nov 2000 16:56:53 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Dan Aizenstros <dan@vcubed.com>
Cc:	linux-mips@oss.sgi.com
Subject: Re: Multiple copies of pci-dma.c file.
Message-ID: <20001122165653.A6421@bacchus.dhis.org>
References: <3A1BD888.7FB3C6A6@vcubed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A1BD888.7FB3C6A6@vcubed.com>; from dan@vcubed.com on Wed, Nov 22, 2000 at 09:30:32AM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Nov 22, 2000 at 09:30:32AM -0500, Dan Aizenstros wrote:

> Is there any reason for having multiple copies of
> the pci-dma.c file in Linux/MIPS.  The are all
> doing basically the same thing.  We could have
> just one copy in the arch/mips/lib directory
> and have the Makefile build it if CONFIG_PCI
> is defined.

Sounds like a plan, done.  Tell me if it breaks something ...

Some chipsets have a builtin scatter / gather facility, those may need
special variants of pci-dma.c for better support.

> Also they appear to have an error in that they
> convert the pointer that is returned from the
> __get_free_pages function call into a KSEG1
> address even if the pointer is NULL.

Fixed.

  Ralf
